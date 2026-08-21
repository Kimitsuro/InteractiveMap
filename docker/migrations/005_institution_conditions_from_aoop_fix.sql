-- Дополнительные правила по тексту АООП (речь, интеллект)

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
            ('speech_impairment', txt ~ '(тнр|нарушени.*реч|недоразвит.*реч|речев)'),
            ('intellectual_impairment', txt ~ '(интеллект|интеллектуальн|умственн[а-я]*\s+отсталост)')
    ) AS m(condition_code, matched)
    WHERE matched
)
INSERT INTO institution_conditions (institution_id, condition_code)
SELECT DISTINCT institution_id, condition_code
FROM detected
ON CONFLICT (institution_id, condition_code) DO NOTHING;
