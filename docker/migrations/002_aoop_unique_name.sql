-- Deduplicate AOOP names per institution and add uniqueness
DELETE FROM aoop_programs a
USING aoop_programs b
WHERE a.institution_id = b.institution_id
  AND a.name = b.name
  AND a.id > b.id;

CREATE UNIQUE INDEX IF NOT EXISTS uq_aoop_institution_name
    ON aoop_programs (institution_id, name);
