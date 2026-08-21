#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Сверка распарсенного DOCX с БД: email → website → name_key → fuzzy.
Пишет отчёт и (опционально) delta SQL без применения.
"""
from __future__ import annotations

import csv
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from difflib import SequenceMatcher
from pathlib import Path
from urllib.parse import urlparse

# reuse normalize from parser
sys.path.insert(0, str(Path(__file__).resolve().parent))
from parse_aoop_municipality_docx import normalize_inst_name, website_host  # noqa: E402

ROOT = Path(__file__).resolve().parent
PARSED = ROOT / "import_data" / "aoop_municipality_parsed.json"
REPORT_MD = ROOT / "import_data" / "aoop_municipality_reconcile_report.md"
REPORT_CSV = ROOT / "import_data" / "aoop_municipality_reconcile.csv"
DELTA_SQL = ROOT / "import_data" / "aoop_municipality_delta.sql"
FUZZY_THRESHOLD = 0.94
FUZZY_MIN_KEY_LEN = 28


def normalize_host(host: str | None) -> str | None:
    if not host:
        return None
    h = host.lower()
    if h.startswith("www."):
        h = h[4:]
    h = h.replace(".gosweb.gosuslugi.ru", ".gosuslugi.ru")
    return h


def hosts_equal(a: str | None, b: str | None) -> bool:
    na, nb = normalize_host(a), normalize_host(b)
    return bool(na and nb and na == nb)


def run_psql(sql: str) -> str:
    cmd = [
        "docker",
        "exec",
        "-i",
        "lipetsk_postgres",
        "psql",
        "-U",
        "user",
        "-d",
        "lipetsk_institutions_db",
        "-v",
        "ON_ERROR_STOP=1",
        "-t",
        "-A",
        "-F",
        "\t",
        "-c",
        sql,
    ]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if r.returncode != 0:
        raise RuntimeError(r.stderr or r.stdout)
    return r.stdout


def ensure_normalize_fn() -> None:
    sql_path = ROOT / "sql" / "normalize_and_export_institutions.sql"
    # only create function
    fn = """
CREATE OR REPLACE FUNCTION normalize_inst_name(t text)
RETURNS text AS $$
  SELECT regexp_replace(
    replace(
      replace(
        replace(lower(replace(coalesce(t, ''), 'ё', 'е')), '«', ''),
        '»', ''
      ),
      '№', 'n'
    ),
    '[^a-zа-я0-9]+',
    '',
    'g'
  );
$$ LANGUAGE sql IMMUTABLE;
"""
    subprocess.run(
        [
            "docker",
            "exec",
            "-i",
            "lipetsk_postgres",
            "psql",
            "-U",
            "user",
            "-d",
            "lipetsk_institutions_db",
            "-v",
            "ON_ERROR_STOP=1",
        ],
        input=fn,
        text=True,
        encoding="utf-8",
        check=True,
        capture_output=True,
    )


def load_db_institutions() -> list[dict]:
    ensure_normalize_fn()
    sql = r"""
COPY (
  SELECT
    i.id,
    i.name,
    d.name AS district,
    d.id AS district_id,
    i.type_code,
    normalize_inst_name(i.name) AS name_key,
    lower(trim(coalesce(dir.email,''))) AS email,
    coalesce(i.website,'') AS website,
    coalesce(i.address,'') AS address,
    coalesce(dir.full_name,'') AS director_name,
    coalesce(dir.phone,'') AS phone
  FROM institutions i
  JOIN districts d ON d.id = i.district_id
  LEFT JOIN directors dir ON dir.id = i.director_id
  ORDER BY i.id
) TO STDOUT WITH (FORMAT csv, HEADER true);
"""
    # use docker exec with psql -c COPY ... doesn't work well; use query as CSV
    sql2 = """
SELECT i.id::text, i.name, d.name, d.id::text, i.type_code,
       normalize_inst_name(i.name),
       coalesce(lower(trim(dir.email)),''),
       coalesce(i.website,''),
       coalesce(i.address,''),
       coalesce(dir.full_name,''),
       coalesce(dir.phone,'')
FROM institutions i
JOIN districts d ON d.id = i.district_id
LEFT JOIN directors dir ON dir.id = i.director_id
ORDER BY i.id;
"""
    out = run_psql(sql2)
    rows = []
    for line in out.splitlines():
        if not line.strip():
            continue
        parts = line.split("\t")
        if len(parts) < 11:
            continue
        website = parts[7]
        rows.append(
            {
                "id": int(parts[0]),
                "name": parts[1],
                "district": parts[2],
                "district_id": int(parts[3]),
                "type_code": parts[4],
                "name_key": parts[5],
                "email": parts[6] or None,
                "website": website or None,
                "website_host": website_host(website),
                "address": parts[8] or None,
                "director_name": parts[9] or None,
                "phone": parts[10] or None,
            }
        )
    return rows


def load_db_aoop() -> dict[int, list[dict]]:
    sql = """
SELECT ap.institution_id::text, ap.id::text, ap.name, coalesce(ap.url,''),
       normalize_inst_name(ap.name)
FROM aoop_programs ap
ORDER BY ap.institution_id, ap.id;
"""
    out = run_psql(sql)
    by_inst: dict[int, list[dict]] = defaultdict(list)
    for line in out.splitlines():
        if not line.strip():
            continue
        parts = line.split("\t")
        if len(parts) < 5:
            continue
        iid = int(parts[0])
        by_inst[iid].append(
            {
                "id": int(parts[1]),
                "name": parts[2],
                "url": parts[3] or None,
                "name_key": parts[4],
            }
        )
    return by_inst


def load_districts() -> dict[str, int]:
    out = run_psql("SELECT id::text, name FROM districts ORDER BY id;")
    m = {}
    for line in out.splitlines():
        if not line.strip():
            continue
        parts = line.split("\t")
        if len(parts) >= 2:
            m[parts[1]] = int(parts[0])
    return m


def sql_escape(s: str | None) -> str:
    if s is None:
        return "NULL"
    return "'" + s.replace("'", "''") + "'"


def clean_ws(text: str | None) -> str | None:
    """Схлопывает пробелы/nbsp, trim. Пустое → None."""
    if text is None:
        return None
    t = str(text).replace("\xa0", " ").replace("\u200b", "")
    t = re.sub(r"[ \t\r\n]+", " ", t).strip()
    return t or None


def clean_name(text: str | None) -> str:
    """Названия как в БД: без лишних пробелов, №1 / г.Чаплыгина."""
    t = clean_ws(text) or "Без названия"
    t = re.sub(r"№\s*", "№", t)
    # г. Липецка → г.Липецка; с. Волово → с.Волово; п. Добринка → п.Добринка
    t = re.sub(r"\b([гспд])\.\s+", r"\1.", t, flags=re.I)
    t = re.sub(r"\s+,", ",", t)
    t = re.sub(r",\s*", ", ", t)
    t = re.sub(r"\s+", " ", t).strip()
    return t[:255]


def clean_director(text: str | None) -> str:
    t = clean_ws(text) or "Не указан"
    t = re.sub(r"^и\.?\s*о\.?\s*", "", t, flags=re.I).strip()
    return t[:150] or "Не указан"


def clean_phone(phone: str | None) -> str | None:
    """Формат БД: +7XXXXXXXXXX (ровно 10 цифр после +7)."""
    if not phone:
        return None
    digits = re.sub(r"\D", "", phone)
    if len(digits) >= 11 and digits.startswith(("7", "8")):
        digits = digits[-10:]
    elif len(digits) > 10:
        digits = digits[-10:]
    if len(digits) == 10:
        return "+7" + digits
    if len(digits) == 6:
        return digits
    return None


def clean_email(email: str | None) -> str | None:
    t = clean_ws(email)
    return t.lower() if t else None


def clean_website(url: str | None) -> str | None:
    t = clean_ws(url)
    if not t:
        return None
    t = t.rstrip(".,);]")
    if not re.match(r"^https?://", t, re.I):
        t = "https://" + t
    # как в БД — со слешем в конце хоста
    if re.match(r"^https?://[^/]+$", t, re.I):
        t += "/"
    return t[:500]


def clean_address(text: str | None) -> str | None:
    t = clean_ws(text)
    if not t:
        return None
    t = re.sub(r"\s+,", ",", t)
    t = re.sub(r",\s*", ", ", t)
    t = re.sub(r"\s+", " ", t).strip(" ;,")
    return t[:2000] or None


def clean_aoop_name(text: str | None) -> str:
    t = clean_ws(text) or "АООП"
    return t[:255]


def institution_display_name(doc: dict) -> str:
    """Короткое имя предпочтительнее полного юр. названия."""
    short = clean_ws(doc.get("name_short"))
    full = clean_ws(doc.get("name_full"))
    name = clean_ws(doc.get("name"))
    chosen = short or name or full or "Без названия"
    # если в name попало полное юр. название — предпочесть short
    if short and name and name.lower().startswith("муниципальное") and not short.lower().startswith("муниципальное"):
        chosen = short
    return clean_name(chosen)


def match_institution(doc: dict, db_rows: list[dict]) -> tuple[str, list[dict], str]:
    """Returns (status, candidates, method) status: matched|ambiguous|missing"""
    emails = set(filter(None, [doc.get("email")] + (doc.get("emails") or [])))
    by_email = []
    for row in db_rows:
        if row.get("email") and row["email"] in emails:
            by_email.append(row)
    if len(by_email) == 1:
        return "matched", by_email, "email"
    if len(by_email) > 1:
        return "ambiguous", by_email, "email"

    host = doc.get("website_host")
    if host:
        by_host = [r for r in db_rows if hosts_equal(r.get("website_host"), host)]
        if len(by_host) == 1:
            return "matched", by_host, "website"
        if len(by_host) > 1:
            return "ambiguous", by_host, "website"

    keys = {k for k in (doc.get("name_key"), doc.get("name_key_full")) if k and len(k) >= 10}
    by_name = [r for r in db_rows if r.get("name_key") in keys]
    if len(by_name) == 1:
        return "matched", by_name, "name_key"
    if len(by_name) > 1:
        return "ambiguous", by_name, "name_key"

    # fuzzy — только длинные ключи, иначе ложные совпадения с урезанными названиями в БД
    best = []
    doc_keys = [k for k in (doc.get("name_key"), doc.get("name_key_full")) if k and len(k) >= FUZZY_MIN_KEY_LEN]
    for row in db_rows:
        rk = row.get("name_key") or ""
        if len(rk) < FUZZY_MIN_KEY_LEN or not doc_keys:
            continue
        score = max(SequenceMatcher(None, dk, rk).ratio() for dk in doc_keys)
        if score >= FUZZY_THRESHOLD:
            best.append((score, row))
    best.sort(key=lambda x: -x[0])
    if len(best) == 1:
        return "matched", [best[0][1]], f"fuzzy:{best[0][0]:.2f}"
    if len(best) > 1 and best[0][0] - best[1][0] >= 0.03:
        return "matched", [best[0][1]], f"fuzzy:{best[0][0]:.2f}"
    if len(best) > 1:
        return "ambiguous", [b[1] for b in best[:5]], "fuzzy"
    return "missing", [], ""


def aoop_missing(doc_aoop: list[dict], db_aoop: list[dict]) -> list[dict]:
    existing = {a["name_key"] for a in db_aoop}
    missing = []
    for a in doc_aoop:
        key = normalize_inst_name(a.get("name"))
        if key and key not in existing:
            missing.append(a)
            existing.add(key)  # dedupe within doc
    return missing


def generate_delta(
    missing_inst: list[dict],
    matched_aoop_add: list[tuple[dict, dict, list[dict]]],
    districts: dict[str, int],
) -> str:
    lines = [
        "-- AUTO-GENERATED delta from DOCX municipality reconcile",
        "-- Fields normalized to existing DB style (spaces, phones, №, г.).",
        "BEGIN;",
        "",
    ]

    for doc in missing_inst:
        dname = doc.get("district_hint") or "г. Липецк"
        did = districts.get(dname)
        if not did:
            lines.append(f"-- SKIP unknown district {dname!r} for {doc.get('name')!r}")
            continue

        name = institution_display_name(doc)
        director = clean_director(doc.get("director"))
        email = clean_email(doc.get("email"))
        phone_store = clean_phone(doc.get("phone"))
        website = clean_website(doc.get("website"))
        address = clean_address(doc.get("address"))
        type_code = (doc.get("type_code") or "school").strip()

        # check_director_contact: phone OR email required
        if not email and not phone_store:
            email = clean_email((doc.get("emails") or [None])[0])
        if not email and not phone_store:
            lines.append(f"-- SKIP no contact for {name!r}")
            continue

        lines.append(f"-- NEW institution: {name}")
        lines.append("WITH d AS (")
        lines.append(
            f"  INSERT INTO directors (full_name, phone, email) VALUES ({sql_escape(director)}, {sql_escape(phone_store)}, {sql_escape(email)}) RETURNING id"
        )
        lines.append("), ins AS (")
        lines.append(
            "  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) "
            f"SELECT {sql_escape(name)}, {did}, {sql_escape(type_code)}, d.id, "
            f"{sql_escape(website)}, {sql_escape(address)} FROM d RETURNING id"
        )
        lines.append(")")
        aoop = doc.get("aoop") or []
        # дедуп АООП по нормализованному имени
        seen_aoop: set[str] = set()
        aoop_clean = []
        for a in aoop:
            aname = clean_aoop_name(a.get("name"))
            key = normalize_inst_name(aname)
            if not key or key in seen_aoop:
                continue
            seen_aoop.add(key)
            url = clean_website(a.get("url")) if a.get("url") else None
            # AOOP urls often have paths — don't force trailing slash on path URLs oddly
            if a.get("url"):
                url = clean_ws(a.get("url"))
                if url:
                    url = url.rstrip(".,);]")[:500]
            aoop_clean.append((aname, url))

        if aoop_clean:
            lines.append("INSERT INTO aoop_programs (institution_id, name, url)")
            values = [
                f"SELECT id, {sql_escape(aname)}, {sql_escape(url)} FROM ins"
                for aname, url in aoop_clean
            ]
            lines.append("\nUNION ALL\n".join(values) + ";")
        else:
            lines.append("SELECT id FROM ins;  -- no AOOP")
        lines.append("")

    for doc, db_row, missing in matched_aoop_add:
        if not missing:
            continue
        lines.append(f"-- AOOP add for existing id={db_row['id']} {db_row['name']}")
        for a in missing:
            aname = clean_aoop_name(a.get("name"))
            url = clean_ws(a.get("url"))
            if url:
                url = url.rstrip(".,);]")[:500]
            lines.append(
                "INSERT INTO aoop_programs (institution_id, name, url) VALUES ("
                f"{db_row['id']}, {sql_escape(aname)}, {sql_escape(url)}"
                ");"
            )
        lines.append("")

    lines.append("COMMIT;")
    return "\n".join(lines) + "\n"


def main() -> int:
    if not PARSED.exists():
        print("Run parse_aoop_municipality_docx.py first", file=sys.stderr)
        return 1

    data = json.loads(PARSED.read_text(encoding="utf-8"))
    docs = data["institutions"]
    print(f"DOCX institutions: {len(docs)}")

    db_rows = load_db_institutions()
    print(f"DB institutions: {len(db_rows)}")
    db_aoop = load_db_aoop()
    districts = load_districts()

    matched = []
    missing = []
    ambiguous = []
    aoop_to_add: list[tuple[dict, dict, list[dict]]] = []

    csv_rows = []

    for doc in docs:
        status, cands, method = match_institution(doc, db_rows)
        row_base = {
            "doc_name": doc.get("name"),
            "doc_district": doc.get("district_hint"),
            "doc_email": doc.get("email"),
            "doc_website": doc.get("website"),
            "doc_aoop_cnt": len(doc.get("aoop") or []),
            "status": status,
            "method": method,
            "db_id": "",
            "db_name": "",
            "db_aoop_cnt": 0,
            "aoop_missing_cnt": 0,
            "candidates": "",
        }
        if status == "matched":
            db = cands[0]
            miss = aoop_missing(doc.get("aoop") or [], db_aoop.get(db["id"], []))
            matched.append((doc, db, method, miss))
            if miss:
                aoop_to_add.append((doc, db, miss))
            row_base.update(
                {
                    "db_id": db["id"],
                    "db_name": db["name"],
                    "db_aoop_cnt": len(db_aoop.get(db["id"], [])),
                    "aoop_missing_cnt": len(miss),
                }
            )
        elif status == "ambiguous":
            ambiguous.append((doc, cands, method))
            row_base["candidates"] = " | ".join(f"{c['id']}:{c['name']}" for c in cands[:5])
        else:
            missing.append(doc)
        csv_rows.append(row_base)

    # markdown report
    dist_counts = Counter(d.get("district_hint") or "?" for d in missing)
    method_counts = Counter(method for _, _, method, _ in matched)

    lines = [
        "# Сверка DOCX муниципалитетов с БД",
        "",
        f"- Записей в DOCX: **{len(docs)}**",
        f"- Учреждений в БД: **{len(db_rows)}**",
        f"- Совпало (matched): **{len(matched)}**",
        f"- Нет в БД (institution_missing): **{len(missing)}**",
        f"- Неоднозначно (ambiguous): **{len(ambiguous)}**",
        f"- У matched не хватает АООП: **{sum(1 for _,_,_,m in matched if m)}** (программ: **{sum(len(m) for _,_,_,m in matched)}**)",
        "",
        "### Методы совпадения",
        "",
    ]
    if method_counts:
        for m, c in method_counts.most_common():
            lines.append(f"- `{m}`: {c}")
    else:
        lines.append("- совпадений нет (DOCX и текущая БД почти не пересекаются по email/сайту/названию)")

    lines += ["", "### Missing по районам", ""]
    for dname, cnt in dist_counts.most_common():
        lines.append(f"- {dname}: {cnt}")

    lines += [
        "",
        "## SQL для ручной проверки",
        "",
        "Файл: `docker/sql/normalize_and_export_institutions.sql`",
        "",
        "```sql",
        "CREATE OR REPLACE FUNCTION normalize_inst_name(t text)",
        "RETURNS text AS $$",
        "  SELECT regexp_replace(",
        "    replace(replace(replace(lower(replace(coalesce(t,''), 'ё', 'е')), '«', ''), '»', ''), '№', 'n'),",
        "    '[^a-zа-я0-9]+', '', 'g'",
        "  );",
        "$$ LANGUAGE sql IMMUTABLE;",
        "```",
        "",
        "```bash",
        "docker cp docker/sql/normalize_and_export_institutions.sql lipetsk_postgres:/tmp/",
        "docker exec lipetsk_postgres psql -U user -d lipetsk_institutions_db -f /tmp/normalize_and_export_institutions.sql",
        "```",
        "",
        "## Matched (первые 40)",
        "",
    ]
    if not matched:
        lines.append("- нет")
    for doc, db, method, miss in matched[:40]:
        lines.append(
            f"- [{method}] DOCX `{doc.get('name')}` → DB #{db['id']} `{db['name']}` "
            f"(АОП в файле: {len(doc.get('aoop') or [])}, не хватает: {len(miss)})"
        )
    if len(matched) > 40:
        lines.append(f"- … и ещё {len(matched) - 40}")

    lines += ["", "## Institution missing (первые 60)", ""]
    for doc in missing[:60]:
        lines.append(
            f"- `{doc.get('name')}` | {doc.get('district_hint')} | {doc.get('email') or '—'} | "
            f"АОП: {len(doc.get('aoop') or [])}"
        )
    if len(missing) > 60:
        lines.append(f"- … и ещё {len(missing) - 60}")

    lines += ["", "## Ambiguous", ""]
    if not ambiguous:
        lines.append("- нет")
    for doc, cands, method in ambiguous:
        lines.append(f"- [{method}] `{doc.get('name')}` → " + "; ".join(f"#{c['id']} {c['name']}" for c in cands))

    lines += [
        "",
        "## Delta SQL (не применён)",
        "",
        f"Черновик: `docker/import_data/aoop_municipality_delta.sql`",
        f"- новых учреждений: **{len(missing)}**",
        f"- догрузка АООП к matched: **{sum(len(m) for _,_,m in aoop_to_add)}**",
        "",
        "Напишите **«загружай»** / **«применяй»**, если отчёт ок — тогда применим SQL к БД.",
        "",
        "CSV: `docker/import_data/aoop_municipality_reconcile.csv`",
        "",
    ]
    REPORT_MD.write_text("\n".join(lines), encoding="utf-8")

    with REPORT_CSV.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "status",
                "method",
                "doc_name",
                "doc_district",
                "doc_email",
                "doc_website",
                "doc_aoop_cnt",
                "db_id",
                "db_name",
                "db_aoop_cnt",
                "aoop_missing_cnt",
                "candidates",
            ],
        )
        w.writeheader()
        w.writerows(csv_rows)

    delta = generate_delta(missing, aoop_to_add, districts)
    DELTA_SQL.write_text(delta, encoding="utf-8")

    print(f"Report: {REPORT_MD}")
    print(f"CSV: {REPORT_CSV}")
    print(f"Delta SQL (not applied): {DELTA_SQL}")
    print(
        f"Summary matched={len(matched)} missing={len(missing)} ambiguous={len(ambiguous)} "
        f"aoop_adds={sum(len(m) for _,_,m in aoop_to_add)}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
