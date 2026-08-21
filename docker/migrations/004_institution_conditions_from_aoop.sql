-- Заполнить institution_conditions по названиям АООП (только добавление, без удаления существующих)

WITH aoop_agg AS (
    SELECT
        institution_id,
        lower(string_agg(name, ' ')) AS txt
    FROM aoop_programs
    GROUP BY institution_id
),
detected AS (
    SELECT institution_id, condition_code
    FROM aoop_agg
    CROSS JOIN LATERAL (
        VALUES
            ('hearing_impairment', txt ~ '(глух|нарушени[еями\s]*слух|слуха)'),
            ('vision_impairment', txt ~ '(слеп|слабовид|нарушени[еями\s]*зрен)'),
            ('musculoskeletal_impairment', txt ~ '(нода|опорно[\s-]*двигатель|вариант\s*6[\.\)]|вариант\s*6\s)'),
            ('speech_impairment', txt ~ '(тнр|нарушени.*реч|недоразвит.*реч|речев)'),
            ('mental_retardation', txt ~ '(зпр|задержк[а-я]*\s+психическ)'),
            ('intellectual_impairment', txt ~ '(интеллект|интеллектуальн|умственн[а-я]*\s+отсталост)'),
            ('autism', txt ~ '(аутист|расстройств[а-я]*\s+аутист|\mрас\M)'),
            ('multiple_disorders', txt ~ '(множественн|тмнр)')
    ) AS m(condition_code, matched)
    WHERE matched
)
INSERT INTO institution_conditions (institution_id, condition_code)
SELECT DISTINCT institution_id, condition_code
FROM detected
ON CONFLICT (institution_id, condition_code) DO NOTHING;
