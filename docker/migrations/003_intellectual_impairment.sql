-- Нарушение интеллекта (отдельно от задержки психического развития)
INSERT INTO condition_types (code, name_ru, description) VALUES
    ('intellectual_impairment', 'Нарушение интеллекта', 'Для детей с интеллектуальными нарушениями')
ON CONFLICT (code) DO UPDATE SET
    name_ru = EXCLUDED.name_ru,
    description = EXCLUDED.description;

-- Актуализировать название НОДА на случай старых данных
UPDATE condition_types
SET name_ru = 'Нарушения опорно-двигательного аппарата',
    description = 'Для детей с НОДА'
WHERE code = 'musculoskeletal_impairment';
