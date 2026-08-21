-- Три отдельных типа: умственная отсталость, нарушение интеллекта, задержка психического развития (9 ОВЗ всего)

INSERT INTO condition_types (code, name_ru, description) VALUES
    ('psychic_development_delay', 'Задержка психического развития', 'Для детей с задержкой психического развития')
ON CONFLICT (code) DO UPDATE SET
    name_ru = EXCLUDED.name_ru,
    description = EXCLUDED.description;

UPDATE condition_types
SET name_ru = 'Умственная отсталость',
    description = 'Для детей с умственной отсталостью'
WHERE code = 'mental_retardation';

UPDATE condition_types
SET name_ru = 'Расстройство аутистического спектра',
    description = 'Для детей с расстройством аутистического спектра'
WHERE code = 'autism';

UPDATE condition_types
SET name_ru = 'Множественные нарушения',
    description = 'Для детей с тяжёлыми и множественными нарушениями развития'
WHERE code = 'multiple_disorders';

-- Убрать ЗПР, ошибочно записанную как умственная отсталость (только если в АООП нет УО)
WITH aoop_agg AS (
    SELECT institution_id, lower(string_agg(name, ' ')) AS txt
    FROM aoop_programs
    GROUP BY institution_id
)
DELETE FROM institution_conditions ic
USING aoop_agg a
WHERE ic.institution_id = a.institution_id
  AND ic.condition_code = 'mental_retardation'
  AND a.txt ~ '(зпр|задержк[а-я]*\s+психическ|вариант\s*7[\.\)])'
  AND a.txt !~ 'умственн[а-я]*\s+отсталост';

-- Убрать «нарушение интеллекта», если в АООП нет соответствующих формулировок
WITH aoop_agg AS (
    SELECT institution_id, lower(string_agg(name, ' ')) AS txt
    FROM aoop_programs
    GROUP BY institution_id
)
DELETE FROM institution_conditions ic
USING aoop_agg a
WHERE ic.institution_id = a.institution_id
  AND ic.condition_code = 'intellectual_impairment'
  AND a.txt !~ '(интеллектуальн|нарушени.*интеллект)';

-- Пересобрать три типа по тексту АООП
WITH aoop_agg AS (
    SELECT institution_id, lower(string_agg(name, ' ')) AS txt
    FROM aoop_programs
    GROUP BY institution_id
),
detected AS (
    SELECT institution_id, condition_code
    FROM aoop_agg
    CROSS JOIN LATERAL (
        VALUES
            ('psychic_development_delay', txt ~ '(зпр|задержк[а-я]*\s+психическ|вариант\s*7[\.\)])'),
            ('mental_retardation', txt ~ 'умственн[а-я]*\s+отсталост'),
            ('intellectual_impairment', txt ~ '(интеллектуальн|нарушени.*интеллект)')
    ) AS m(condition_code, matched)
    WHERE matched
)
INSERT INTO institution_conditions (institution_id, condition_code)
SELECT DISTINCT institution_id, condition_code
FROM detected
ON CONFLICT (institution_id, condition_code) DO NOTHING;
