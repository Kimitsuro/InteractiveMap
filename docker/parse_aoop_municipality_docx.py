#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Парсер DOCX «Адаптированные программы МУНИЦИПАЛИТЕТЫ» → JSON.
"""
from __future__ import annotations

import json
import re
import sys
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path
from urllib.parse import urlparse

W_NS = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"

DISTRICT_MAP = [
    (r"города?\s+липецка|г\.?\s*липецк", "г. Липецк"),
    (r"елецк", "г. Елец"),  # check before Елецкий округ — prefer city if "города Ельца"
    (r"воло", "Воловский округ"),
    (r"гряз", "Грязинский округ"),
    (r"данков", "Данковский округ"),
    (r"добрин", "Добринский округ"),
    (r"добров", "Добровский округ"),
    (r"долгорук", "Долгоруковский округ"),
    (r"задон", "Задонский округ"),
    (r"измалк", "Измалковский округ"),
    (r"красн", "Краснинский округ"),
    (r"лебедян", "Лебедянский округ"),
    (r"лев[- ]?толстов", "Лев-Толстовский район"),
    (r"липецк(?:ого|ий)\s+(?:муниципал|район|округ)", "Липецкий округ"),
    (r"становлян", "Становлянский округ"),
    (r"тербун", "Тербунский округ"),
    (r"усман", "Усманский округ"),
    (r"хлевен", "Хлевенский округ"),
    (r"чаплыгин", "Чаплыгинский округ"),
]

SECTION_RE = re.compile(
    r"^(?:"
    r"образовательные\s+организации|"
    r"список\s+образовательных\s+организаций|"
    r".*муниципальн(?:ый|ого)\s+округ|"
    r".*муниципальн(?:ый|ого)\s+район|"
    r"овз\s+дошкольных|"
    r"детские\s+сады|"
    r"школы"
    r")",
    re.I,
)

SHORT_NAME_RE = re.compile(
    r"^(?:мбоу|маоу|мбдоу|мадоу|мкоу|гоу|гбоу|мдоу)\b",
    re.I,
)

FULL_NAME_START_RE = re.compile(
    r"^(?:муниципальное|муниципальное\s+автономное|муниципальное\s+бюджетное|"
    r"муниципальное\s+казённое|государственное)\b",
    re.I,
)

EMAIL_RE = re.compile(r"[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-zА-Яа-яЁё]{2,}", re.I)
URL_RE = re.compile(r"https?://[^\s<>\"']+", re.I)
PDF_RE = re.compile(r"\b[\w.\-]+\.pdf\b", re.I)


def normalize_inst_name(text: str | None) -> str:
    if not text:
        return ""
    t = text.lower().replace("ё", "е")
    for ch in "«»\"'":
        t = t.replace(ch, "")
    t = t.replace("№", "n").replace("nº", "n")
    t = re.sub(r"[^a-zа-я0-9]+", "", t, flags=re.I)
    return t


def normalize_email(email: str | None) -> str | None:
    if not email:
        return None
    return email.strip().lower()


def website_host(url: str | None) -> str | None:
    if not url:
        return None
    try:
        host = urlparse(url.strip()).netloc.lower()
    except Exception:
        return None
    if host.startswith("www."):
        host = host[4:]
    return host or None


def read_docx_paragraphs(path: Path) -> list[str]:
    with zipfile.ZipFile(path) as zf:
        root = ET.fromstring(zf.read("word/document.xml"))
    paras: list[str] = []
    for p in root.iter(f"{W_NS}p"):
        text = "".join(n.text or "" for n in p.iter(f"{W_NS}t")).strip()
        if text:
            # normalize weird spaces
            text = text.replace("\xa0", " ").replace("\u200b", "")
            text = re.sub(r"[ \t]+", " ", text)
            paras.append(text)
    return paras


def guess_district(line: str, current: str | None) -> str | None:
    low = line.lower()
    # city Yelets vs Yelets district
    if re.search(r"города?\s+ельц|г\.?\s*елец(?!к)", low):
        return "г. Елец"
    if re.search(r"елецк(?:ого|ий)\s+(?:муниципал|район|округ)", low):
        return "Елецкий округ"
    for pattern, name in DISTRICT_MAP:
        if re.search(pattern, low):
            if name == "г. Елец" and "округ" in low and "город" not in low:
                continue
            return name
    return current


def is_section_header(line: str) -> bool:
    if len(line) > 120:
        return False
    if FULL_NAME_START_RE.match(line) or SHORT_NAME_RE.match(line):
        return False
    if line.lower() in ("школы", "детские сады"):
        return True
    if SECTION_RE.match(line):
        return True
    if "список образовательных" in line.lower():
        return True
    if re.search(r"муниципальн(?:ый|ого)\s+округ", line, re.I) and "учреждение" not in line.lower():
        return True
    return False


def is_address_line(line: str) -> bool:
    low = line.lower()
    if low.startswith(("адрес", "398", "399")):
        return True
    if re.match(r"^\d{6}\b", line):
        return True
    if "липецкая" in low and any(x in low for x in ("ул.", "улица", "д.", "с.", "п.")):
        return True
    return False


def extract_field(line: str, prefixes: tuple[str, ...]) -> str | None:
    low = line.lower()
    for pref in prefixes:
        if low.startswith(pref.lower()):
            val = line[len(pref) :].lstrip(" :\t")
            return val.strip() or None
    return None


def guess_type(name: str, section_kind: str | None) -> str:
    low = (name or "").lower()
    if section_kind == "preschool" or any(x in low for x in ("детский сад", "д/с", "дошкольн", "ясли")):
        return "preschool"
    if any(x in low for x in ("интернат",)):
        return "school_internat"
    if any(x in low for x in ("колледж", "техникум", "училище", "спо")):
        return "spo"
    if any(x in low for x in ("университет", "институт", "академи", "филиал")):
        return "vo"
    return "school"


def parse_institutions(paras: list[str]) -> list[dict]:
    institutions: list[dict] = []
    current_district: str | None = "г. Липецк"
    section_kind: str | None = "school"  # school | preschool

    i = 0
    n = len(paras)
    while i < n:
        line = paras[i]

        if is_section_header(line):
            low = line.lower()
            if low == "школы":
                section_kind = "school"
            elif low == "детские сады" or "дошкольн" in low or "овз дошкольн" in low:
                section_kind = "preschool"
            else:
                current_district = guess_district(line, current_district) or current_district
            i += 1
            continue

        # Start of institution: full legal name, or short name if full missing
        if FULL_NAME_START_RE.match(line) or (
            SHORT_NAME_RE.match(line)
            and i + 1 < n
            and (
                paras[i + 1].lower().startswith(("официальный сайт", "сайт", "адаптирован", "e-mail", "электронная"))
            )
        ):
            name_parts = [line]
            i += 1
            # continue full name if next lines don't look like fields
            while i < n:
                nxt = paras[i]
                if (
                    SHORT_NAME_RE.match(nxt)
                    or FULL_NAME_START_RE.match(nxt)
                    or is_section_header(nxt)
                    or extract_field(nxt, ("Официальный сайт", "Сайт", "Госпаблик")) is not None
                    or nxt.lower().startswith(
                        (
                            "адаптирован",
                            "e-mail",
                            "электронная почта",
                            "телефон",
                            "контактный телефон",
                            "руководитель",
                            "заведующ",
                            "адрес",
                        )
                    )
                    or EMAIL_RE.search(nxt)
                    or URL_RE.search(nxt)
                    or is_address_line(nxt)
                ):
                    break
                # continuation of long title
                if len(nxt) < 200 and not nxt.lower().startswith("мбоу"):
                    name_parts.append(nxt)
                    i += 1
                else:
                    break

            name_full = " ".join(name_parts).strip()
            name_short = None
            if i < n and SHORT_NAME_RE.match(paras[i]):
                name_short = paras[i]
                i += 1

            website = None
            email = None
            emails: list[str] = []
            phones: list[str] = []
            director = None
            addresses: list[str] = []
            aoop: list[dict] = []
            aoop_mode = False
            aoop_none = False
            pending_aoop_name: str | None = None

            def flush_pending_aoop(url: str | None = None) -> None:
                nonlocal pending_aoop_name
                if pending_aoop_name or url:
                    name = (pending_aoop_name or "Адаптированная программа").strip()
                    if len(name) > 255:
                        name = name[:252] + "..."
                    aoop.append({"name": name, "url": url})
                pending_aoop_name = None

            while i < n:
                cur = paras[i]
                if FULL_NAME_START_RE.match(cur) or is_section_header(cur):
                    flush_pending_aoop()
                    break
                # next institution short-only block
                if SHORT_NAME_RE.match(cur) and i > 0:
                    peek = paras[i + 1] if i + 1 < n else ""
                    if peek.lower().startswith(("официальный", "сайт", "адаптирован", "e-mail", "электронная", "адрес")):
                        flush_pending_aoop()
                        break

                site_val = extract_field(cur, ("Официальный сайт", "Сайт"))
                if site_val is not None:
                    flush_pending_aoop()
                    m = URL_RE.search(site_val) or URL_RE.search(cur)
                    if m:
                        website = m.group(0).rstrip(".,);]")
                    aoop_mode = False
                    i += 1
                    continue

                if cur.lower().startswith("госпаблик"):
                    i += 1
                    continue

                if cur.lower().startswith("адаптирован") and (
                    "программ" in cur.lower()[:80] or ":" in cur[:80]
                ) and not aoop_mode:
                    rest = cur.split(":", 1)
                    after = rest[1].strip() if len(rest) > 1 else ""
                    if re.search(r"^нет\.?$", after, re.I) or after.lower() in ("нет", "нет."):
                        aoop_none = True
                        aoop_mode = False
                    elif after and (URL_RE.search(after) or PDF_RE.search(after) or len(after) > 15):
                        aoop_mode = True
                        aoop_none = False
                        _consume_aoop_line(after, aoop, website)
                    else:
                        aoop_mode = True
                        aoop_none = False
                    i += 1
                    continue

                email_prefixes = (
                    "E-Mail", "E-mail", "Email", "Электронная почта",
                    "Е-mail", "Е-Mail", "е-mail",
                )
                email_val = extract_field(cur, email_prefixes)
                low_cur = cur.lower().replace("е-mail", "e-mail")
                if email_val is not None or low_cur.startswith("e-mail") or cur.lower().startswith("электронная почта"):
                    flush_pending_aoop()
                    aoop_mode = False
                    found = EMAIL_RE.findall(cur)
                    emails.extend(found)
                    if found:
                        email = found[0]
                    i += 1
                    while i < n and EMAIL_RE.fullmatch(paras[i].strip()):
                        emails.append(paras[i].strip())
                        i += 1
                    continue

                if EMAIL_RE.fullmatch(cur.strip()) and not aoop_mode:
                    emails.append(cur.strip())
                    email = email or cur.strip()
                    i += 1
                    continue

                phone_val = extract_field(cur, ("Телефон", "Контактный телефон"))
                if phone_val is not None:
                    flush_pending_aoop()
                    aoop_mode = False
                    phones.append(phone_val)
                    i += 1
                    while i < n and re.match(r"^[\d\s\-()+]+$", paras[i]) and len(re.sub(r"\D", "", paras[i])) >= 6:
                        phones.append(paras[i])
                        i += 1
                    continue

                dir_val = extract_field(cur, ("Руководитель", "Заведующая", "Заведующий", "Директор"))
                if dir_val is not None:
                    flush_pending_aoop()
                    aoop_mode = False
                    director = re.sub(r"^и\.?\s*о\.?\s*", "", dir_val, flags=re.I).strip()
                    i += 1
                    continue

                addr_val = extract_field(cur, ("Адрес",))
                if addr_val is not None or is_address_line(cur):
                    flush_pending_aoop()
                    aoop_mode = False
                    addresses.append(addr_val or cur)
                    i += 1
                    continue

                if aoop_mode:
                    urls = URL_RE.findall(cur)
                    pdfs = PDF_RE.findall(cur)
                    if urls:
                        name_part = URL_RE.sub("", cur).strip(" :-–—")
                        if name_part and len(name_part) > 8:
                            if pending_aoop_name:
                                pending_aoop_name = f"{pending_aoop_name} {name_part}".strip()
                            else:
                                pending_aoop_name = name_part
                        flush_pending_aoop(urls[0].rstrip(".,);]"))
                        i += 1
                        continue
                    if pdfs:
                        name_part = PDF_RE.sub("", URL_RE.sub("", cur)).strip(" :-–—")
                        if name_part and len(name_part) > 8:
                            pending_aoop_name = ((pending_aoop_name + " ") if pending_aoop_name else "") + name_part
                        elif not pending_aoop_name:
                            pending_aoop_name = pdfs[0]
                        flush_pending_aoop(None)
                        i += 1
                        continue
                    if cur.lower().startswith("адаптирован") or len(cur) > 20:
                        if pending_aoop_name and cur.lower().startswith("адаптирован"):
                            flush_pending_aoop()
                            pending_aoop_name = cur
                        elif pending_aoop_name:
                            pending_aoop_name = f"{pending_aoop_name} {cur}".strip()
                        else:
                            pending_aoop_name = cur
                        i += 1
                        continue
                    flush_pending_aoop()
                    aoop_mode = False

                i += 1

            flush_pending_aoop()

            display_name = name_short or name_full
            institutions.append(
                {
                    "name_full": name_full,
                    "name_short": name_short,
                    "name": display_name,
                    "district_hint": current_district,
                    "type_code": guess_type(display_name + " " + name_full, section_kind),
                    "website": website,
                    "email": normalize_email(email),
                    "emails": [normalize_email(e) for e in emails if e],
                    "phone": phones[0] if phones else None,
                    "phones": phones,
                    "director": director,
                    "address": "; ".join(addresses) if addresses else None,
                    "aoop_none": aoop_none,
                    "aoop": aoop,
                    "name_key": normalize_inst_name(display_name),
                    "name_key_full": normalize_inst_name(name_full),
                    "website_host": website_host(website),
                }
            )
            continue

        i += 1

    return institutions


def _consume_aoop_line(line: str, aoop: list[dict], website: str | None) -> None:
    line = line.strip()
    if not line or re.search(r"^нет\.?$", line, re.I):
        return
    urls = URL_RE.findall(line)
    pdfs = PDF_RE.findall(line)
    name = URL_RE.sub("", line)
    name = PDF_RE.sub("", name)
    name = re.sub(r"\s+", " ", name).strip(" :-–—")
    url = None
    if urls:
        url = urls[0].rstrip(".,);]")
    elif pdfs and not name:
        name = pdfs[0]

    if not name and not url:
        return
    if not name:
        name = "Адаптированная программа"
    if len(name) > 255:
        name = name[:252] + "..."
    aoop.append({"name": name, "url": url})


def main() -> int:
    root = Path(__file__).resolve().parent
    default_docx = Path(r"c:\Users\dimbo\Downloads")
    docx_candidates = list(default_docx.glob("*МУНИЦИПАЛ*.docx")) + list(default_docx.glob("*муниципал*.docx"))
    if not docx_candidates:
        # any adapted programs docx
        docx_candidates = [p for p in default_docx.glob("*.docx") if "адапт" in p.name.lower() or "Адапт" in p.name]
    if len(sys.argv) > 1:
        docx_path = Path(sys.argv[1])
    elif docx_candidates:
        docx_path = docx_candidates[0]
    else:
        print("DOCX not found", file=sys.stderr)
        return 1

    out_dir = root / "import_data"
    out_dir.mkdir(parents=True, exist_ok=True)
    out_json = out_dir / "aoop_municipality_parsed.json"

    print(f"Reading: {docx_path}")
    paras = read_docx_paragraphs(docx_path)
    print(f"Paragraphs: {len(paras)}")
    institutions = parse_institutions(paras)
    print(f"Institutions parsed: {len(institutions)}")
    with_aoop = sum(1 for x in institutions if x["aoop"])
    print(f"With AOOP programs: {with_aoop}")

    payload = {
        "source": str(docx_path),
        "paragraphs": len(paras),
        "institutions_count": len(institutions),
        "institutions": institutions,
    }
    out_json.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Wrote: {out_json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
