-- ============================================================
-- Нормализация названий учреждений и выборка для сверки с DOCX
-- Запуск:
--   docker cp docker/sql/normalize_and_export_institutions.sql lipetsk_postgres:/tmp/
--   docker exec lipetsk_postgres psql -U user -d lipetsk_institutions_db -f /tmp/normalize_and_export_institutions.sql
-- ============================================================

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

\echo '=== Функция normalize_inst_name создана ==='
\echo ''
\echo '=== Примеры нормализации ==='
SELECT
  name,
  normalize_inst_name(name) AS name_key
FROM institutions
ORDER BY id
LIMIT 10;

\echo ''
\echo '=== Учреждения с контактами и числом АООП ==='

SELECT
  i.id,
  i.name,
  d.name AS district,
  i.type_code,
  normalize_inst_name(i.name) AS name_key,
  lower(trim(dir.email)) AS email,
  i.website,
  (SELECT COUNT(*) FROM aoop_programs ap WHERE ap.institution_id = i.id) AS aoop_cnt
FROM institutions i
JOIN districts d ON d.id = i.district_id
LEFT JOIN directors dir ON dir.id = i.director_id
ORDER BY d.name, i.name;

\echo ''
\echo '=== АООП по учреждениям ==='

SELECT
  i.id AS institution_id,
  i.name AS institution_name,
  ap.id AS aoop_id,
  ap.name AS aoop_name,
  ap.url,
  normalize_inst_name(ap.name) AS aoop_name_key
FROM aoop_programs ap
JOIN institutions i ON i.id = ap.institution_id
ORDER BY i.name, ap.name;
