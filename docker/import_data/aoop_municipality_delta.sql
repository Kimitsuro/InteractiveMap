-- AUTO-GENERATED delta from DOCX municipality reconcile
-- Fields normalized to existing DB style (spaces, phones, №, г.).
BEGIN;

-- NEW institution: МБОУ «Гимназия №1» г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Тюнина Светлана Валерьевна', '+74742250137', 'sc1lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Гимназия №1» г.Липецка', 186, 'school', d.id, 'https://gimnazia1lip.gosuslugi.ru/', '398001, г. Липецк, улица 8 Марта, д.22/4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №2 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Власова Татьяна Алексеевна', '+74742223676', 'sc2lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №2 г.Липецка', 186, 'school', d.id, 'https://sc2lipetsk.gosuslugi.ru/', '398001, г. Липецк, ул. Первомайская, д. 58' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «Лицей №3 им. К.А. Москаленко» г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Комкова Надежда Васильевна', '+74742480123', 'sc3lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Лицей №3 им. К.А. Москаленко» г.Липецка', 186, 'school', d.id, 'https://sc3lipetsk.gosuslugi.ru/', '398007, г. Липецк, ул. Ушинского, 14' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №4 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Власова Елена Леонидовна', '+74742430224', 'sc4lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №4 г.Липецка', 186, 'school', d.id, 'https://sc4lipetsk.gosuslugi.ru/', '398005, г. Липецк, ул. Парковая, д.5; 398041, г. Липецк, ул. Зои Космодемьянской, д.178' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №5 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Конасова Екатерина Геннадьевна', '+74742724850', 'sc5lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №5 города Липецка', 186, 'school', d.id, 'https://s5litavrina.gosuslugi.ru/', '398002, г. Липецк, ул. им. Семашко, дом № 5' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант) 2', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжёлыми нарушениями речи (вариант 5.2)', NULL FROM ins;

-- NEW institution: МБОУ «Школа №6» г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лебедь Ольга Викторовна', '+74742419650', 'sc6lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Школа №6» г.Липецка', 186, 'school', d.id, 'https://sc6lipetsk.gosuslugi.ru/', '398902, г. Липецк, ул. Детская, 2в' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа ООО для обучающихся с нарушение опорно-двигательного аппарата (вариант 6.1)', 'https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для обучающихся с легкой умственной отсталостью (вариант 1)', 'https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа НОО для обучающихся с задержкой психического развития', 'https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа ООО для обучающихся с задержкой психического развития', 'https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №7 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Воронин Кирилл Николаевич', '+74742431271', 'sc7lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №7 г.Липецка', 186, 'school', d.id, 'https://sc7lipetsk.gosuslugi.ru/', '398005, г. Липецк, пр. Мира, 7' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №8 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мехов Андрей Владимирович', '+74742270051', 'sc8lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №8 г.Липецка', 186, 'school', d.id, 'https://sc8lip.gosuslugi.ru/', '398020, г. Липецк. ул. Елецкая, д.63' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2)', 'https://cloud.mail.ru/public/X86c/cG4FKZABB' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7.2)', 'https://cloud.mail.ru/public/ifn5/jaNkDPksw' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 9.2)', 'https://cloud.mail.ru/public/oh8x/hXCTbdQ11' FROM ins;

-- NEW institution: МБОУ СШ №9 им. М.В. Водопьянова г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Огнева Нина Алексеевна', '+74742272226', 'sc9lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №9 им. М.В. Водопьянова г.Липецка', 186, 'school', d.id, 'https://scl9-lipeck.gosuslugi.ru/', '398020, г. Липецк, ул. Студеновская, д.4А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7.1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа обучающихся умственной отсталостью (интеллектуальными нарушениями) (вариант 2)', NULL FROM ins;

-- NEW institution: МБОУ СШ №10 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бельских Лилия Николаевна', '+74742731224', 'sc10lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №10 г.Липецка', 186, 'school', d.id, 'https://sc10lip.gosuslugi.ru/', '398006, г. Липецк, ул. Краснозаводская, д.8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №11 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кокорева Ольга Николаевна', '+74742438088', 'sc11lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №11 г.Липецка', 186, 'school', d.id, 'https://sh11lipetsk.gosuslugi.ru/', '398011, г. Липецк, ул. Силикатная д. 19' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ гимназия №12 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Уласевич Ольга Николаевна', '+74742277358', 'sc12lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ гимназия №12 города Липецка', 186, 'school', d.id, 'https://gimnasium12.gosuslugi.ru/', '398020, г. Липецк, ул. Гагарина, д.24' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №14 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Слесаренко Анна Николаевна', '+74742350403', 'sc14lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №14 г.Липецка', 186, 'school', d.id, 'https://schkola14.gosuslugi.ru/', '398037, г. Липецк, Боевой проезд, д.24а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) муниципального бюджетного общеобразовательного учреждения средней школы № 14 города Липецка', 'https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) муниципального бюджетного об...', 'https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant_2.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2) муниципального бюджетного общеобразовательного учреждения средней школы № 14 города Липецка', 'https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant_7.2.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)', 'https://schkola14.gosuslugi.ru/netcat_files/33/46/variant_7.pdf' FROM ins;

-- NEW institution: МАОУ СШ №15 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бессонова Рената Сергеевна', '+74742261701', 'sc15lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №15 г.Липецка', 186, 'school', d.id, 'https://sc15lipetsk.gosuslugi.ru/', '398059, г. Липецк, пл. Торговая, 14' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с интеллектуальными нарушениями (вариант 1)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_dlya_uchaschihsya_s_intellektual_nymi_narusheniyami_variant1_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.1)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_dlya_uchaschihsya_s_RAS_variant_8.1_2025_god_1_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.2)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_dlya_uchaschihsya_s_RAS_variant_8.2_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.1_1_4_KL.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.4)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_RAS_8.4_2025_2026g.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.3)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_RAS_varint_8_3_2025god_1_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_OOO_obuchayuschihsya_s_ZPR_variant_7.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.2_1_4_KL_2025_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (вариант 5.2, первое отделение)', 'https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOP_NOO_dlya_uchaschihsya_s_TNR.pdf' FROM ins;

-- NEW institution: МБОУ №16 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Полянская Светлана Викторовна', '+74438345759', 'sc16lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ №16 г.Липецка', 186, 'school', d.id, 'https://lipschool16.gosuslugi.ru/', '398043, г. Липецк, ул. Циолковского, д.34/4' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)', 'https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_NOO_variant_7.1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)', 'https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_NOO_variant_7.2.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7)', 'https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_OOO_ZPR_2023.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_UO_IN_variant_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)', 'https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_UO_IN_variant_2.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная дополнительная общеобразовательная программа - дополнительная общеразвивающая программа художественной направленности «театр «РАМПА»', 'https://sh16-lipeck-r42.gosweb.gosuslugi.ru/netcat_files/33/46/1adop_dop_teatr_rampa..pdf' FROM ins;

-- NEW institution: МАОУ СОШ №17 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Борисова Ирина Ивановна', '+73305479752', 'sc17lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СОШ №17 г.Липецка', 186, 'school', d.id, 'https://sh17-lipeck.gosuslugi.ru/', '398024, г. Липецк, пр. Победы, д.96' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ограниченными возможностями здоровья – нарушение опорно-двигательного аппарата (вариант 6.1.)', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.1end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.2) МАОУ СОШ № 17 г. Липецка', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.2_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.3) МАОУ СОШ № 17 г. Липецка', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.3_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с расстройствами аутистического спектра (РАС) (вариант 8.4)', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_8.4_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования для обучающихся с нарушением интеллекта (вариант 1)', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/Narushenie_intellekta_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ОВЗ (ЗПР) (вариант 7.1) МАОУ СОШ № 17 г. Липецка netcat_files/33/46/AOOP_ZPR_7.1_end.pdf', 'https://sh17-lipeck.gosuslugi.ru/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ОВЗ (ЗПР) (вариант 7.2) МАОУ СОШ № 17 г. Липецка', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_obuchayuschiesya_s_ZPR_variant_7.2_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с нарушениями опорно-двигательного аппарата', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_OOO_NODA_end.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с ЗПР', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/ZPR_5_9_variant_7.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для учащихся с тяжелыми нарушениями речи вариант 5.1', 'https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/5.1_end.pdf' FROM ins;

-- NEW institution: Муниципальное автономное общеобразовательное учреждение средняя общеобразовательная ШКОЛА №18 (МАОУ СОШ №18 г.Липецка)
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шведун Денис Владимирович', '+74742727151', 'sc18lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное общеобразовательное учреждение средняя общеобразовательная ШКОЛА №18 (МАОУ СОШ №18 г.Липецка)', 186, 'school', d.id, 'https://sc18lip.gosuslugi.ru/', '398036, г. Липецк, ул. Кривенкова, д.25' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ гимназия №19 им. Н З. Поповичевой г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Буева Марина Александровна', '+74742276513', 'sc19lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ гимназия №19 им. Н З. Поповичевой г.Липецка', 186, 'school', d.id, 'https://gimnasium19.gosuslugi.ru/', '398002, г. Липецк, ул. Семашко, д.68' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СОШ №20 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пшеничный Алексей Васильевич', '+74742382400', 'sc20lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СОШ №20 г.Липецка', 186, 'school', d.id, 'https://sc20lip.gosuslugi.ru/', '398004, г. Липецк, пер. Учебный, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №21 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лежнев Сергей Алексеевич', '+74742413080', 'sc21lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №21 города Липецка', 186, 'school', d.id, 'https://sc21-lipetsk.gosuslugi.ru/', '398058, г. Липецк, 15 микрорайон, д.5/2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СОШ №23 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зыкова Галина Владимировна', '+78977408284', 'sc23lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СОШ №23 г.Липецка', 186, 'school', d.id, 'https://sc23lipetsk.gosuslugi.ru/', '398902, г. Липецк, ул. Ударников, д.21' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)', 'https://sc23lipetsk.gosuslugi.ru/netcat_files/33/46/_OU_23_AOOP_OOO_ZPR_ispr_sayt_podpis_.pdf' FROM ins;

-- NEW institution: МБОУ СОШ №24 им. М.Б. Раковского г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Стрельников Антон Борисович', '+74742345630', 'sc24lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №24 им. М.Б. Раковского г.Липецка', 186, 'school', d.id, 'https://sc24lip.gosuslugi.ru/', '398016, г. Липецк, ул. Гагарина, д.84' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ОШ №25 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Архипова Галина Алексеевна', '+74742731569', 'sc25lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ОШ №25 г.Липецка', 186, 'school', d.id, 'https://sc25lipeck.gosuslugi.ru/', '398013, г. Липецк, ул. Ильича, д.31' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ школа информационных технологий №26 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Цапенко Марина Сергеевна', '+74742727118', 'sc26lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ школа информационных технологий №26 г.Липецка', 186, 'school', d.id, 'https://maoush26it.gosuslugi.ru/', '398027, г. Липецк, ул. Стаханова, д. 75' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.1) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.1_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.2) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.2_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.3) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.3_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.4) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.4_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.2) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_osnovnogo_obschego_obrazovaniya_Variant_8.2._.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования для обучающихся с интеллектуальными нарушениями МАОУ школы информационных технологий № 26 г. Липецка (вариант 1) 2025-2026 учебный год', 'https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obscheobrazovatel_naya_programma_obrazovaniya_obuchayuschihsya_s_UO_IN_.pdf' FROM ins;

-- NEW institution: МАОУ Инженерно-Технологическая Школа №27 Города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мочалов Александр Владимирович', '+74742370727', 'sc27lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ Инженерно-Технологическая Школа №27 Города Липецка', 186, 'school', d.id, 'https://sc27lip.gosuslugi.ru/', '398008, Липецкая область, город Липецк, улица Лутова, дом 15' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.2)', 'https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_8.2_27_shkola_na_sayt.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.3)', 'https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_83_27_shkola_na_sayt.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.4)', 'https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_84._27_shkola_na_sayt.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_1_9_KLASS_S_UO_NAShA_2024_g_1_podpis_.pdf' FROM ins;

-- NEW institution: МБОУ СШ №28 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Квасова Ирина Николаевна', '+71171481001', 'sc28lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №28 г.Липецка', 186, 'school', d.id, 'https://sh28-lipetsk.gosuslugi.ru/', '398007, г. Липецк, пл. Константиновой, д.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СОШ №29 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зайцева Татьяна Петровна', '+74742540671', 'sc29lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СОШ №29 г.Липецка', 186, 'vo', d.id, 'https://sc29un.gosuslugi.ru/', '398055, г. Липецк, ул.Политехническая, д.9А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования (для обучающихся с тяжелыми нарушениями речи (ТНР))', 'https://sc29un.gosuslugi.ru/netcat_files/68/3280/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_obuchayuschihsya_s_TNR.pdf' FROM ins
UNION ALL
SELECT id, 'Основная адаптированная программа начального общего образования для обучающихся с ограниченными возможностями здоровья муниципального автономного общеобразовательного учреждения средней общеобразовательной школы №29 города Липецка «Университетская» (ва...', 'https://sc29un.gosuslugi.ru/netcat_files/68/3316/Osnovnaya_adaptirovannaya_programma_nachal_nogo_obschego_obrazovaniya_dlya_obuchayuschihsya_s_OVZ_variant_6.4_1_.pdf' FROM ins;

-- NEW institution: МАОУ СШ №30 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ковтонюк Сергей Александрович', '+74742565763', 'sc30lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №30 г.Липецка', 186, 'school', d.id, 'https://sc30lip.gosuslugi.ru/', '398004, г. Липецк, ул. Коцаря С.Л., дом 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №31 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Несмеянова Инна Сергеевна', '+71834731880', 'sc31lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №31 г.Липецка', 186, 'school', d.id, 'https://lipschool31.gosuslugi.ru/', '398006 г. Липецк, ул. Волгоградская, д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ №32 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Томилина Наталья Александровна', '+74742250861', 'sc32lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ №32 г.Липецка', 186, 'school', d.id, 'https://sc32lip.gosuslugi.ru/', '398059, г. Липецк, ул. Октябрьская, д.88а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) муниципального бюджетного общеобразовательного учреждения № 32 г. Липецка', 'https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP_UO_variant_1-polnaya_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) муниципального бюджетного об...', 'https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP_UO_variant_2_05.11..pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.3) муниципального бюджетного общеобра...', 'https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP-8.3.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...', 'https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP-8.4_.pdf' FROM ins;

-- NEW institution: МБОУ СШ №33 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Давыдова Любовь Владимировна', '+74742473116', 'sc33lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №33 г.Липецка', 186, 'school', d.id, 'https://sc33lipetsk.gosuslugi.ru/', '398036, г. Липецк, бульвар П.Шубина, д.15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №34 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Клименко Ольга Сергеевна', '+74742261034', 'sc34lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №34 г.Липецка', 186, 'school', d.id, NULL, '398902, г. Липецк, ул. Минская, д.7в' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №35 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Москалева Светлана Викторовна', '+71126491497', 'sc35lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №35 г.Липецка', 186, 'school', d.id, 'https://sc35lip.gosuslugi.ru/', '398914 г. Липецк, ул. Ракитная, д.2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_UA_var.1_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 7.1)', 'https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_ZPR_var._7.1_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 7.2)', 'https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_ZP_var_7.2_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (Вариант 5.2) (с изменениями на 1.09.2024г.)', 'https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_TNR_var_5.2_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 4.2)', 'https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_dlya_slabovidyaschih.pdf' FROM ins;

-- NEW institution: МБОУ СОШ №36 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зотов Сергей Николаевич', '+71800341845', 'sc36lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №36 г.Липецка', 186, 'school', d.id, 'https://sc36lip.gosuslugi.ru/', '398016, г. Липецк, ул. Гагарина, д.73а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования для обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.1)', 'https://sc36lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) муниципального бюджетного общеобразовательного учреждения № 36 г. Липецка', 'https://sc36lip.gosuslugi.ru/netcat_files/33/46/AOOP_UO_36_shkola.pdf' FROM ins;

-- NEW institution: МБОУ СШ №37 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Найденова Надежда Владимировна', '+78686439020', 'sc37lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №37 г.Липецка', 186, 'school', d.id, 'https://sc37lipetsk.gosuslugi.ru/', '398029, г. Липецк, ул.Писарева, д.37; 398028, г. Липецк, ул.Привокзальная, д.101; 398029, г. Липецк, ул.Пришкольная, д.21' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №38 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Макарова Светлана Валентиновна', '+71686432810', 'sc38lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №38 г.Липецка', 186, 'school', d.id, 'https://sc38lipetsk.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sc38lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №40 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зенкова Ольга Юрьевна 398043, г. Липецк, ул. Гагарина, 123/3 ул., Германа Титова, 9/5, ул.Германа Титова, 9/6', '+74742344061', 'sc40lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №40 г.Липецка', 186, 'school', d.id, 'https://sc40lipschools48.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с нарушением зрения Муниципального бюджетного общеобразовательного учреждения средней общеобразовательной школы №40 г. Липецка', 'https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития (ЗПР) муниципального бюджетного общеобразовательного учреждения средней общеобразовательной школы № 40 г. Липецка', 'https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образова-ния для обучающихся с тяжелыми нарушениями речи (далее – ТНР) Муни-ципального бюджетного общеобразовательного учреждения средней общеобразовательной школы №40 г. Липецка', 'https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ №41 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сошкина Оксана Валентиновна398026, г. Липецк, ул. Арсеньева, д.38а', '+74742480407', 'sc41lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №41 города Липецка', 186, 'school', d.id, 'https://sc41lip.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (вариант 1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжелыми нарушениями речи (вариант 5.2. 1-отделение)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7)', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования муниципального бюджетного общеобразовательного учреждения средней школы № 41 города Липецка для обучающихся с нарушением слуха (вариант 2.2.1)', NULL FROM ins;

-- NEW institution: МБОУ СШ №42 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Малько Сергей Васильевич', '+74742416278', 'sc42lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №42 г.Липецка', 186, 'school', d.id, 'https://sc42lip.gosuslugi.ru/', '398046, г. Липецк, ул. Стаханова, д.15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ "Лицей 44" г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шишкина Ольга Сергеевна', '+74653270463', 'sc44lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ "Лицей 44" г.Липецка', 186, 'school', d.id, 'https://liceum44.gosuslugi.ru/', '398050 г. Липецк, ул. Плеханова, д.51а, д.49' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №45 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Королева Наталья Серафимовна', '+71802283540', 'sc45lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №45 г.Липецка', 186, 'school', d.id, 'https://school45lip.gosuslugi.ru/', '398024, г. Липецк, ул. Папина 4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №46 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сай Пётр Игоревич', '+74742346354', 'sc46lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №46 г.Липецка', 186, 'school', d.id, 'https://school46lipetsk-reg48.gosuslugi.ru/', '398032, г.Липецк, ул.Титова, д.8' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта на дому (4 класс) на 2023-2028 учебные года', 'https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_226.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (5-9 классы)', 'https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_227.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (9 класс) на 2023-2028 учебные года', 'https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_228.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа с нарушением интеллекта (1-4 класс)', 'https://sh46-lipeck-r42.gosweb.gosuslugi.ru/netcat_files/68/3083/AOOP_s_narusheniem_intellekta_1_4.pdf' FROM ins;

-- NEW institution: МБОУ СОШ №47 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Катасонов Игорь Александрович', '+78147340572', 'sc47lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №47 г.Липецка', 186, 'school', d.id, 'https://sc47lip.gosuslugi.ru/', '398043, г. Липецк, ул. Космонавтов, д.11Б' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №48 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шумов Анатолий Ильич', '+74742317869', 'sc48lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №48 г.Липецка', 186, 'school', d.id, 'https://sc48lipetsk.gosuslugi.ru/', '398032, г. Липецк, ул. Космонавтов, д.82, корп.4' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с ТНР 5 – 7 (8) лет', 'https://sc48lipetsk.gosuslugi.ru/netcat_files/33/46/p_AOP_DO_010925.pdf' FROM ins;

-- NEW institution: МБОУ СОШ №49 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Плешков Владимир Викторович', '+73781333549', 'sc49lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №49 г.Липецка', 186, 'school', d.id, 'https://sc49lipetsk.gosuslugi.ru/', '398035, г. Липецк, ул. Звездная, д.12 (корпус А), Вермишева, д.16 (корпус Б)' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №50 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чудин Владимир Геннадьевич', '+72206334492', 'sc50lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №50 г.Липецка', 186, 'school', d.id, 'https://sc50lipetsk.gosuslugi.ru/', '398035, г. Липецк, ул. Звездная, д.6' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №51 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ленкова Татьяна Анатольевна', '+77735317634', 'sc51lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №51 г.Липецка', 186, 'school', d.id, 'https://51lipetsk.gosuslugi.ru/', '398042, г. Липецк, 9 микрорайон, д.42А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с нарушениями речи 5-8 лет Муниципального автономного общеобразовательного учреждения средней школы №51 г. Липецка', 'https://51lipetsk.gosuslugi.ru/netcat_files/33/46/aop_doo_25_26_uch_god.pdf' FROM ins;

-- NEW institution: МБОУ СШ №52 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Крапивина Светлана Николаевна', '+70216340107', 'sc52lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №52 г.Липецка', 186, 'school', d.id, 'https://sc52lip.gosuslugi.ru/', '398043, г. Липецк, ул. Циолковского, д.31' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №54 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Волков Владимир Николаевич', '+79366476754', 'sc54lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №54 г.Липецка', 186, 'school', d.id, 'https://sc54lipetsk.gosuslugi.ru/', '398908, г. Липецк, ул. Моршанская, д.22' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №55 г.Липецка «Лингвист»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Семенов Иван Андреевич', '+74742355202', 'sc55lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №55 г.Липецка «Лингвист»', 186, 'school', d.id, 'https://sc55lip.gosuslugi.ru/', '398016, г.Липецк, ул.Космонавтов, д.16А' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №58 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бедрова Светлана Валерьевна', '+74742200758', 'sc58lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №58 города Липецка', 186, 'school', d.id, 'https://sh58-lipeck-r42.gosweb.gosuslugi.ru/', '398001, г. Липецк, ул. Артемова, д.4, Липецк' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ СШ №59 «Перспектива» г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Гладышев Дмитрий Анатольевич', '+74407316798', 'sc59lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №59 «Перспектива» г.Липецка', 186, 'school', d.id, 'https://progymnasium59.gosuslugi.ru/', '398055 г. Липецк, проезд Сержанта Кувшинова, д. 8 - детский сад; 398020 г. Липецк, улица Шкатова, д.23 – детский сад; 398055 г. Липецк, улица Московская, д. 95 – детский сад; 398055 г. Липецк, проезд Сержанта Кувшинова, д.5 – школа' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи (ТНР) муниципального автономного общеобразовательного учреждения средняя школа № 59 «Перспектива» г. Липецка', 'https://progymnasium59.gosuslugi.ru/netcat_files/33/46/AOP_DO.pdf' FROM ins;

-- NEW institution: МАОУ СШ №60 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Борискина Светлана Александровна', '+74742727475', 'sc60lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ СШ №60 г.Липецка', 186, 'school', d.id, 'https://maoush60.gosuslugi.ru/', '398027, г. Липецк, ул. Осканова, д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ многопрофильный лицей г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Беляев Евгений Владимирович', '+75501250484', 'sc61lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ многопрофильный лицей г.Липецка', 186, 'school', d.id, 'https://sosch61.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №62 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Жбанова Ольга Алексеевна', '+74742731403', 'sc62lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №62 г.Липецка', 186, 'school', d.id, 'https://school62lip.gosuslugi.ru/', '398006 г. Липецк, ул. Ибаррури, 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №63 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Керекелица Сергей Александрович', '+74742415822', 'sc63lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №63 г.Липецка', 186, 'school', d.id, 'https://s63lip.gosuslugi.ru/', '398046, г. Липецк, пр.Сиреневый, д.9' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1) 2023-2027 гг. (в редакции 2025 года)', 'https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_UO_IN_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.1.) (в редакции 2025 года)', 'https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_NODA_NOO_s_podpis_yu.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования обучающихся с ЗПР (вариант 7.1) на 2025-2029 гг.', 'https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.1_s_podpis_yu.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7) на 2023-2027 гг. (в редакции 2025 года)', 'https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_ZPR_OOO.pdf' FROM ins;

-- NEW institution: МБОУ «Гимназия №64» города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кушникова Валерия Петровна', '+74742771360', 'sc64lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Гимназия №64» города Липецка', 186, 'school', d.id, 'https://gimnasium64.gosuslugi.ru/', '398059, г. Липецк, ул. Мичурина, 30; 398059, г. Липецк, пр. Победы, 7А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи (ТНР)', 'https://gimnasium64.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/20252026/AOP_Gimnaziya_641.pdf' FROM ins;

-- NEW institution: МБОУ «СМШ №65 «Спектр» г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Не указан', '+74214324197', 'sc65lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СМШ №65 «Спектр» г.Липецка', 186, 'school', d.id, 'https://scl65lip.gosuslugi.ru/', '398055 г.Липецк, пер.сержанта Кувшинова, д.3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)', 'https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP_NOO_7.1_provereno.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...', 'https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP-8.4_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования обучающихся с тяжелой умственной отсталостью (вариант 9.2)', 'https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP_NOO_9.2.pdf' FROM ins;

-- NEW institution: МБОУ лицей №66 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Иванов Кирилл Викторович', '+74742410601', 'sc66lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ лицей №66 г.Липецка', 186, 'school', d.id, 'https://liceum66.gosuslugi.ru/', '398046, г.Липецк, ул. Меркулова, д.11а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №68 города Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Щукина Ольга Александровна', '+74742415098', 'sc68lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №68 города Липецка', 186, 'school', d.id, 'https://sc68lip.gosuslugi.ru/', '398046 г. Липецк, ул. Стаханова, д.17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАОУ гимназия №69 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попов Виктор Алексеевич', '+74742417826', 'sc69lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАОУ гимназия №69 г.Липецка', 186, 'school', d.id, 'https://gymnasium69.gosuslugi.ru/', '398036, г. Липецк, бульвар Есенина, д.7а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ №70 г.Липецк
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кириенко Анна Владимировна', '+74742460823', NULL) RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №70 г.Липецк', 186, 'school', d.id, 'https://70school.gosuslugi.ru/', '398036, г. Липецк, пр. Победы, д.130, д.122; Меркулова, 51' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с тяжелыми нарушениями речи 5-8 лет', 'https://70school.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_sada_25.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи МБОУ СШ №70 г. Липецка (дошкольные группы)', 'https://70school.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_sada.pdf' FROM ins
UNION ALL
SELECT id, 'Mail: sc70lip@schools48.ru', NULL FROM ins;

-- NEW institution: МБОУ СШ №72 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Андреева Елена Вячеславовна', '+73564479523', 'sc72lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №72 г.Липецка', 186, 'school', d.id, NULL, '398024, г.Липецк, ул. Юных Натуралистов, д.12а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (вариант 5.1)', 'https://sc72lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_variant_5.1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования муниципального бюджетного общеобразовательного учреждения средней школы №72 имени героя Российской Федерации Гануса Феодосия Григорьевича для обучающихся с задержкой…', 'https://sc72lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_variant_7.1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью интеллектуальными нарушениями) МБОУ СШ №72 г. Липецка. Липецка', 'https://sc72lip.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obscheobrazovatel_naya_programma_obrazovaniya.pdf' FROM ins;

-- NEW institution: МБОУ СОШ №77 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Гончарова Елена Николаевна', '+73929473949', 'sc77lip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №77 г.Липецка', 186, 'school', d.id, NULL, '398036, г. Липецк, ул. Хорошавина, д.14' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ ОО ЗЗ №2 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Соболева Ирина Александровна', '+74742730429', 'sc2vlip@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ ОО ЗЗ №2 г.Липецка', 186, 'school', d.id, 'https://mbou-ssch-oozz2-lipetsk.gosuslugi.ru/', '398006, г. Липецк, ул. Коммунистическая, д.17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: Государственное бюджетное общеобразовательное учреждение Липецкой области «Кадетская школа имени майора милиции Коврижных А.П.Кадетской школы Липецкой области имени А.П.Коврижных
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лидия Григорьевна Куцак', '+74742343863', 'integral@inbox.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Государственное бюджетное общеобразовательное учреждение Липецкой области «Кадетская школа имени майора милиции Коврижных А.П.Кадетской школы Липецкой области имени А.П.Коврижных', 186, 'school', d.id, 'https://xn--80aaihokhfog2av5e.xn--p1ai/site_av/', '. 398043, Липецкая обл., г. Липецк, ул. Космонавтов, 36/3; г. Липецк, ул.Прокатная, д.10; 398059 г.Липецк, Торговая пл. д.14' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №1 г.Липецка ДОУ №1 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Гулевская Елена Михайловна', '+72994274419', 'lipetsksadik-1@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №1 г.Липецка ДОУ №1 г.Липецка', 186, 'preschool', d.id, 'https://ds1lip.gosuslugi.ru/', '398050, г.Липецк, ул.Желябова, 19 ул. Желябова, 9 ул. Интернациональная, 26' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи', 'https://ds1lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_105.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №2 г.Липецка ДОУ №2 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чернышов Иван Владимирович', '+74742261901', 'ok2it@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №2 г.Липецка ДОУ №2 г.Липецка', 186, 'preschool', d.id, 'https://oblachnyikit.gosuslugi.ru/', '398004, г.Липецк, ул.Стаханова, 71 А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа для детей с ТНР муниципального автономного дошкольного образовательного учреждения № 2 города Липецка', 'https://oblachnyikit.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-oop-tnr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа для детей с ЗПР муниципального автономного дошкольного образовательного учреждения № 2 города Липецка', 'https://oblachnyikit.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-oop-zpr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №3 г.Липецка ДОУ №3 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зайцева Наталия Викторовна', '+70797773950', 'mdoulip.3@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №3 г.Липецка ДОУ №3 г.Липецка', 186, 'preschool', d.id, 'https://dou3lipetsk.gosuslugi.ru/', '398001, г. Липецк, ул. Советская, 39, 398059 ул. Пушкина, 7а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа для дошкольников с тяжелыми нарушениями речи (ТНР)', 'https://dou3lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для дошкольников с задержкой психического развития (ЗПР)', 'https://dou3lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-rabochaya-obrazovatelnaya-programma-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-zpr-uchitelya-defektologa.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №4 г.Липецка ДОУ №4 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Грибкова Наталья Юрьевна', '+71005261028', 'startum04@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №4 г.Липецка ДОУ №4 г.Липецка', 186, 'preschool', d.id, 'https://dou4lipetsk.gosuslugi.ru/', '398037, г. Липецк, ул. Дмитрия Фурсова, д.1; ул. Дмитрия Фурсова, д.3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с тяжелыми нарушениями речи (ТНР)', 'https://dou4lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-do-dou-4-glipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с задержкой психического развития', 'https://dou4lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №5 г.Липецка ДОУ №5 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Не указан', '+77182437284', 'lipetsksadik-5@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №5 г.Липецка ДОУ №5 г.Липецка', 186, 'preschool', d.id, 'https://dou5lipetsk.gosuslugi.ru/', 'Корпус 1: 398908, г.Липецк, ул. Сельскохозяйственная, 12' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №5 г. Липецка', 'https://dou5lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dou-5-g-lipetska-dlya-detey-s-tnr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №5 г. Липецка', 'https://dou5lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dou-5-g-lipetska-dlya-detey-s-zpr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №6 г.Липецка ДОУ №6 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Иноземцева Ольга Александровна', '+78720457030', 'mdoulip6@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №6 г.Липецка ДОУ №6 г.Липецка', 186, 'preschool', d.id, 'https://dou6-lip.gosuslugi.ru/', '398036, г. Липецк, бульвар Шубина, 16 (основное здание); 398036, г. Липецк, бульвар Шубина, 20 (дополнительное здание)' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования ДОУ № 6', 'https://dou6-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-6-glipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №8 г.Липецка ДОУ №8 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зубкова Наталья Ивановна', '+72155479188', 'dou8lip@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №8 г.Липецка ДОУ №8 г.Липецка', 186, 'preschool', d.id, 'https://dou8lip.gosuslugi.ru/', '398024, г. Липецк, проспект Победы, 92 корп. б' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа дошкольного образования ДОУ № 8 г. Липецка для детей, имеющих нарушения речи (ТНР)', 'https://dou8lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-tnr-2025-2026.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа дошкольного образования ДОУ №8 г. Липецка для детей с нарушением зрения', 'https://dou8lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-zrenie-2025-2026.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №9 г.Липецка ДОУ №9 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попова Анна Андреевна', '+70291335566', 'mdoulip9@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №9 г.Липецка ДОУ №9 г.Липецка', 186, 'preschool', d.id, 'https://ds9lipetsk.gosuslugi.ru/', '398035, г. Липецк, ул. Вермишева, 10, ул. Вермишева, 7а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://ds9lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/proekt-adaptirovannoy-obrazovatelnoy-programmy-dlya-detey-s-tnr-na-2024-2025.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с ЗПР (Адаптированная программа ДОУ 9 для детей с ЗПР по ФАОП)', 'https://ds9lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-dou-9-dlya-detey-s-zpr-po-faop.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №10 г.Липецка ДОУ №10 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мазаева Елена Валентиновна', '+74742732602', 'lipetsksadik-10@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №10 г.Липецка ДОУ №10 г.Липецка', 186, 'preschool', d.id, 'https://doulip10.gosuslugi.ru/', '398006, г. Липецк, ул. Краснознаменная, д.8а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа Муниципального бюджетного дошкольного образовательного учреждения № 10 г. Липецка для детей с тяжелыми нарушениями речи', 'https://doulip10.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-5-8-let.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа Муниципального бюджетного дошкольного образовательного учреждения № 10 г. Липецка для детей с задержкой психического развития', 'https://doulip10.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adapritirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zpr-5-8-let.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №12 г.Липецка ДОУ №12 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Волкова Тамара Александровна', '+74742438753', 'mdoulip12@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №12 г.Липецка ДОУ №12 г.Липецка', 186, 'preschool', d.id, 'https://dou12-lip.gosuslugi.ru/', '398029, г. Липецк, ул. Центральная, 21, ул. Ярославская, 13.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ТНР) 5-8 лет ДОУ № 12 г. Липецка', 'https://dou12-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/osnovnaya-adaptirovannaya-obrazovatelnaya-programma-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ЗПР) ДОУ № 12 г. Липецка', 'https://dou12-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_148.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №14 г.Липецка ДОУ №14 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дубовых Надежда Егоровна', '+72509480680', 'sokolsad14@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №14 г.Липецка ДОУ №14 г.Липецка', 186, 'preschool', d.id, 'https://dou14lip.gosuslugi.ru/', '398007, г. Липецк, ул. Кутузова, строение 5' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с нарушениями речи 4-8 лет Муниципального автономного дошкольного образовательного учреждения детского сада № 14 г. Липецка', 'https://dou14lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-raboty-dlya-detey-s-narusheniem-rechi-obschim-nedorazvitiem-rechi-4-8-let-dou-14-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с задержкой психического развития 5-8 лет Муниципального автономного дошкольного образовательного учреждения детского сада № 14 г. Липецка', 'https://dou14lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-raboty-v-kompensiruyuschey-gruppe-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-5-8-let-dou-14-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №15 г.Липецка ДОУ №15 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лазарева Галина Валентиновна', '+75353385377', 'dou15lipetsk@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №15 г.Липецка ДОУ №15 г.Липецка', 186, 'preschool', d.id, 'https://dou15lipetsk.gosuslugi.ru/', '398004, г.Липецк, ул.Шуминского, 19' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа 2025-2026 учебный год (группа комбинированной направленности)', 'https://dou15lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-2025-2026-uchebnyy-god-proekt.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа 2025-2026 учебный год. Логопедическая группа (для обучающихся с тяжелыми нарушениями речи (ТНР))', 'https://dou15lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-2025-2026-uchebnyy-god-proekt.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №18 г.Липецка ДОУ №18 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Найденкова Анна Евгеньевна', '+70150349396', 'mdoulip18@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №18 г.Липецка ДОУ №18 г.Липецка', 186, 'preschool', d.id, 'https://mdou18lip.gosuslugi.ru/', '398016, г. Липецк, ул. Гагарина, д. 93/2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с умственной отсталостью легкой степени Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка', 'https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-umstvennoy-otstalostyu-legkoy-stepeni-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с умственной отсталостью умеренной и тяжелой степени Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка', 'https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-umstvennoy-otstalostyu-umerennoy-i-tyazheloy-stepeni-mbdou-18-g-lipetska-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста со сложным дефектом Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка', 'https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-so-slozhnym-defektom-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с расстройством аутистического спектра Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка', 'https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-rastroystvom-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с задержкой психического развития Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка', 'https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №19 г.Липецка ДОУ №19 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Страхова Ирина Владимировна', '+77930438007', 'sadik19lipetsk@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №19 г.Липецка ДОУ №19 г.Липецка', 186, 'preschool', d.id, 'https://dou19lipetsk.gosuslugi.ru/', 'Основное здание - 398011, г.Липецк, ул.Астраханская, д.15' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелым нарушением речи 5-8 лет', 'https://dou19lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития 5-8 лет', 'https://dou19lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya-5-8-let.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение №20 г.Липецка ДОУ №20 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Некрасова Мария Александровна', '+71112371115', 'dou.20@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение №20 г.Липецка ДОУ №20 г.Липецка', 186, 'preschool', d.id, 'https://dou20lip.gosuslugi.ru/', '398036, г. Липецк, ул. Мистюкова А.П., д. 7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа ДО для воспитанников с РАС МАДОУ № 20 г. Липецка на 2025-2026 уч. год', 'https://dou20lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-do-dlya-vospitannikov-s-ras-madou-20-g-lipetska-na-2025-2026-uch-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа ДО МАДОУ № 20 г. Липецка для детей с ТНР на 2025-2026 уч. год', 'https://dou20lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-20-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №21 г.Липецка ДОУ №21 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дмитрова Елена Евгеньевна', '+77219450315', 'mdoulip21@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №21 г.Липецка ДОУ №21 г.Липецка', 186, 'preschool', d.id, 'https://dou21lip.gosuslugi.ru/', '398036, г. Липецк, бульвар Есенина, 12' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Компенсирующая адаптивная образовательная программа', 'https://dou21lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_55.html' FROM ins
UNION ALL
SELECT id, 'Коррекционнная адаптивная образовательная программа', 'https://dou21lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_57.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №22 г.Липецка ДОУ №22 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ушкова Полина Петровна', '+71083287968', 'dou.22@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №22 г.Липецка ДОУ №22 г.Липецка', 186, 'preschool', d.id, 'https://dou22-lipetsk.gosuslugi.ru/', '398005, г. Липецк, ул. Осипенко, 6а, ул. Невского, 26а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования Муниципального дошкольного образовательного учреждения № 22 города Липецка для обучающихся с ТНР', 'https://dou22-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-ovz.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей со сложным дефектом Муниципального бюджетного дошкольного образовательного учреждения № 22 г. Липецка', 'https://dou22-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-so-slozhnymi-defektami.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №23 г.Липецка ДОУ №23 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Паршикова Тамара Васильевна', '+73583453683', 'detsadskazka23@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №23 г.Липецка ДОУ №23 г.Липецка', 186, 'preschool', d.id, 'https://dou23lipetsk.gosuslugi.ru/', '398046, г. Липецк, ул. Смургиса, д. 3а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи (ТНР)', 'https://dou23lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnoy-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tnr-dou-23-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с нарушениями ОДА ДОУ № 23 г. Липецка', 'https://dou23lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniyami-oda-dou-23-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №25 г.Липецка ДОУ №25 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ворфоломеева Нелли Борисовна', '+76479427983', 'mdoulip25@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №25 г.Липецка ДОУ №25 г.Липецка', 186, 'preschool', d.id, 'https://25doulip.gosuslugi.ru/', '398037, г. Липецк, Боевой проезд, 39а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная программа ЗПР', 'https://25doulip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-zpr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная программа ТНР', 'https://25doulip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-tnr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №29 г.Липецка ДОУ №29 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Золотухина Раиса Дмитриевна', '+74307224847', 'mdoulip29@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №29 г.Липецка ДОУ №29 г.Липецка', 186, 'preschool', d.id, 'https://mdou29lip.gosuslugi.ru/', '398006, г. Липецк, ул. 50 лет НЛМК, 15а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированной образовательной программе дошкольного ДОУ № 29 г. Липецка для детей с тяжелыми нарушениями речи (ТНР) общим недоразвитием речи (ОНР))', 'https://mdou29lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/obrazovatelnaya-programma-2.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования ДОУ № 29 г. Липецка для детей с задержкой психического развития (ЗПР)', 'https://mdou29lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/obrazovatelnaya-programma-1.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №30 г.Липецка ДОУ №30 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Терехова Наталия Александровна', '+77389370302', 'mdoulip30@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №30 г.Липецка ДОУ №30 г.Липецка', 186, 'preschool', d.id, 'https://dou30lip.gosuslugi.ru/', '398036, г. Липецк, ул. Мистюкова А.П. д.1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно - развивающей направленности для детей с тяжелыми нарушениями речи Муниципального автономного дошкольного образовательного учреждения детский сад №30 г. Липецка', 'https://dou30lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №32 г.Липецка ДОУ №32 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Стрельникова Наталья Владиславовна', '+75865575866', 'mdoulip32@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №32 г.Липецка ДОУ №32 г.Липецка', 186, 'preschool', d.id, 'https://dou32lipetsk.gosuslugi.ru/', '398027 ул. Свиридова И.В., д. 8а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)', 'https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра (РАС)', 'https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-rasstroystvami-autisticheskogo-spektra.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)', 'https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №35 г.Липецка ДОУ №35 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Денисова Светлана Валентиновна', '+75036455028', 'mdoulip35@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №35 г.Липецка ДОУ №35 г.Липецка', 186, 'preschool', d.id, 'https://dou35-lip.gosuslugi.ru/', '398006, г. Липецк, ул. Ибаррури, 6а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)', 'https://dou35-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/rabochaya-programma-zpr.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)', 'https://dou35-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_71.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №37 г.Липецка ДОУ №37 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Не указан', '+74742370392', 'mdoulip37@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №37 г.Липецка ДОУ №37 г.Липецка', 186, 'preschool', d.id, 'https://dou37lip.gosuslugi.ru/', '398914, г. Липецк, ул. 300-летия Флота России, владение, 2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с ТНР', 'https://dou37lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-ovz-dou-37-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с ЗПР', 'https://dou37lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-zpr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №38 г.Липецка ДОУ №38 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Казарская Вера Николаевна', '+74742480664', 'mdoulip38@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №38 г.Липецка ДОУ №38 г.Липецка', 186, 'preschool', d.id, 'https://dou38-lipetsk.gosuslugi.ru/', '398007, г. Липецк, ул. Ушинского 15/1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с задержкой психического развития ДОУ № 38 г. Липецка', 'https://dou38-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-dou-38-g-lipetska-1.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе детей с ТНР (ОНР) 5-8 лет ДОУ № 38 г. Липецка', 'https://dou38-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-raboty-v-logopedicheskoy-gruppe-detey-s-tnr-onr-5-8-let-dou-38-g-lipetska-1.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение детский сад №40 г.Липецка ДОУ №40 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сиделева Лилия Викторовна', '+70060450048', 'mdoulip40@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение детский сад №40 г.Липецка ДОУ №40 г.Липецка', 186, 'preschool', d.id, 'https://dou40lipetsk.gosuslugi.ru/', '398036, г. Липецк, бульвар Есенина, д.7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР', 'https://dou40lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №42 г.Липецка ДОУ №42 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Суполкина Людмила Николаевна', '+71019430015', 'doy42@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №42 г.Липецка ДОУ №42 г.Липецка', 186, 'preschool', d.id, 'https://dou42lipetsk.gosuslugi.ru/', '398005, г. Липецк, пр. Осенний, д.6а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения № 42 г. Липецка', 'https://dou42lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tnr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-42-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с ЗПР муниципального бюджетного дошкольного образовательного учреждения № 42 г. Липецка', 'https://dou42lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zpr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-42-g-lipetska-1.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №44 г.Липецка ДОУ №44 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Романова Наталия Николаевна', '+71522732600', 'mdoulip44@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №44 г.Липецка ДОУ №44 г.Липецка', 186, 'preschool', d.id, 'https://dou44-lipetsk.gosuslugi.ru/', '398006, г. Липецк, ул. Юбилейная, 6а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа коррекционно-развивающей работы в логопедической группе детей с ТНР (ОНР) 5-8 лет на 2025-2026 учебный год', 'https://dou44-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-korrektsionno-razvivayuschey-raboty-v-logopedicheskoy-gruppe-detey-s-tnr-onr-5-8-let-na-2024-2025-uchebnyy-god.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение №50 г.Липецка ДОУ №50 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Быкова Тамара Валентиновна', '+77384727503', 'mdoulip50@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение №50 г.Липецка ДОУ №50 г.Липецка', 186, 'preschool', d.id, 'https://mirdetstva50.gosuslugi.ru/', '398055 г.Липецк, ул. Хренникова, д.2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://mirdetstva50.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №62 г.Липецка ДОУ №62 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шевчук Лидия Викторовна', '+72381275138', 'detskiisad622010@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №62 г.Липецка ДОУ №62 г.Липецка', 186, 'preschool', d.id, 'https://ds62lipetsk.gosuslugi.ru/', '398002, г. Липецк, ул. Вавилова, 2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с тяжелыми нарушениями речи Муниципального дошкольного образовательного учреждения № 62 г. Липецка', 'https://ds62lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-62-g-lipetska-1.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №64 г.Липецка ДОУ №64 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дедяева Ольга Викторовна', '+74742728120', 'lipetsksadik-64@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №64 г.Липецка ДОУ №64 г.Липецка', 186, 'preschool', d.id, 'https://dou64lip.gosuslugi.ru/', '398000, г. Липецк, Студеновская, 13а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа ДОУ №64 (2 года обучения) на 2025-2026 учебный год', 'https://dou64lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-64-2-goda-obucheniya-na-2025-2026-uchebnyy-god.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №66 г.Липецка ДОУ №66 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Целых Галина Васильевна', '+77473345794', 'lipetsksadik-66@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №66 г.Липецка ДОУ №66 г.Липецка', 186, 'preschool', d.id, 'https://dou66lip.gosuslugi.ru/', '398016, г. Липецк, ул. Гагарина 73/3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР) муниципального бюджетного дошкольного образовательного учреждения № 66 г. Липецка', 'https://dou66lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-66-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №68 города Липецка ДОУ №68 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бородина Ирина Александровна', '+70329454614', 'mdoulip68@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №68 города Липецка ДОУ №68 г.Липецка', 186, 'preschool', d.id, 'https://dou68-lipetsk.gosuslugi.ru/', '398046, г. Липецк, ул. Водопьянова, 7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи (ТНР) ДОУ № 68 г. Липецка', 'https://dou68-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-dalee-tnr-dou-68-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №76 г.Липецка ДОУ №76 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сидорова Галина Валерьевна', '+74742354443', 'mdoulip76@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №76 г.Липецка ДОУ №76 г.Липецка', 186, 'preschool', d.id, 'https://dou76-lipetsk.gosuslugi.ru/', '398043, г. Липецка, Терешковой, д. 6а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования Муниципального бюджетного дошкольного образовательного учреждения № 76 г. Липецка для обучающихся с задержкой психического развития', 'https://dou76-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-76-g-lipetska-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи', 'https://dou76-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/annotatsiya-k-adaptirovannoy-obrazovatelnoy-programme-dou-76-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №77 г.Липецка ДОУ №77 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кишларь Оксана Георгиевна', '+71401731221', 'dou77lipetsk@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №77 г.Липецка ДОУ №77 г.Липецка', 186, 'preschool', d.id, 'https://dou77-lip.gosuslugi.ru/', '398006, г. Липецк, ул. Волгоградская, 8а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа для детей с ЗПР ДОУ № 77 г. Липецка', 'https://dou77-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-dlya-detey-s-zpr-dou-77-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа для детей с ТНР ДОУ № 77 г. Липецка', 'https://dou77-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-dlya-detey-s-tnr-dou-77-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №78 г.Липецка ДОУ №78 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лиманская Алла Александровна', '+79135233818', 'mdoulip78@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №78 г.Липецка ДОУ №78 г.Липецка', 186, 'preschool', d.id, 'https://dou78lip.gosuslugi.ru/', '398024, г. Липецк, пр. Победы, 47А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с ТНР (ОНР) 5-8 лет', 'https://dou78lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №79 г.Липецка ДОУ №79 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Горяинова Ирина Васильевна', '+71806261206', 'mdoulip79@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №79 г.Липецка ДОУ №79 г.Липецка', 186, 'preschool', d.id, 'https://doulip79.gosuslugi.ru/', '398032, г. Липецк, ул. Циолковского, д. 5/3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи муниципального бюджетного дошкольного образовательного учреждения №79 г. Липецка', 'https://doulip79.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-narusheniem-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-79-glipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №83 г.Липецка ДОУ №83 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Парфенова Ольга Сергеевна', '+74742349459', 'mdoulip83@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №83 г.Липецка ДОУ №83 г.Липецка', 186, 'preschool', d.id, 'https://mdoulip83.gosuslugi.ru/', '398016, г. Липецк, ул. Космонавтов, 20/2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с НОДА', 'https://mdoulip83.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-noda.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР', 'https://mdoulip83.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №85 г.Липецка ДОУ №85 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дымова Юлия Алексеевна', '+74742733321', 'mdoulip85@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №85 г.Липецка ДОУ №85 г.Липецка', 186, 'preschool', d.id, 'https://lipetskdou85.gosuslugi.ru/', '398006, г. Липецк, ул. Коммунистическая, 22а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно - развивающей работы для детей с ОВЗ (ТНР)', 'https://lipetskdou85.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_72.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №91 г.Липецка ДОУ №91 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Коростелева Елена Валерьевна', '+74737276209', 'mdoulip91@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №91 г.Липецка ДОУ №91 г.Липецка', 186, 'preschool', d.id, 'https://mdoulip-91.gosuslugi.ru/', '398000, г. Липецк, ул. Семашко, 12; ул. Липовская, 3/2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР 5-8 лет', 'https://mdoulip-91.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-5-8-let.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №95 г.Липецка ДОУ №95 Г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Брылева Елена Алексеевна', '+70277334030', 'tatiana.bryleva@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №95 г.Липецка ДОУ №95 Г.Липецка', 186, 'preschool', d.id, 'https://dou95lipetsk.gosuslugi.ru/', '398035, г. Липецк, ул. Филипченко, 8' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)', 'https://dou95lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №96 г.Липецка ДОУ №96 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Побежимова Ирина Викторовна', '+75803354700', 'dou-96@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №96 г.Липецка ДОУ №96 г.Липецка', 186, 'preschool', d.id, 'https://dou96lip.gosuslugi.ru/', '398043, г. Липецк, ул. Циолковского, дом 37, строение 4, ул. Космонавтов, д.25, строение 6' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР ДОУ № 96', 'https://dou96lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-dou-97.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР ДОУ № 96', 'https://dou96lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogobrazovaniya-dlya-detey-s-zpr-dou-96.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №98 г.Липецка ДОУ №98 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Беляева Любовь Тихоновна', '+74742261014', 'lipetsksadik-98@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №98 г.Липецка ДОУ №98 г.Липецка', 186, 'preschool', d.id, 'https://dou98lip.gosuslugi.ru/', '398035, г. Липецк, ул. Звездная, д. 6/2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи ДОУ', 'https://dou98lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-dou-kopiya.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №99 г.Липецка ДОУ №99 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сотникова Нина Николаевна', '+73904553903', 'detskiysad99@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №99 г.Липецка ДОУ №99 г.Липецка', 186, 'preschool', d.id, 'https://ds99-lipetsk.gosuslugi.ru/', '398035, г. Липецк, ул. Звёздная, 17' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с тяжелым нарушением речи (общим недоразвитием речи) 5-8 лет ДОУ № 99 г. Липецка', 'https://ds99-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelym-narusheniem-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-99-g-lipetska-1.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №101 г.Липецка ДОУ №101 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шестакова Елена Степановна', '+73632451146', 'dou101lipetsk@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №101 г.Липецка ДОУ №101 г.Липецка', 186, 'preschool', d.id, 'https://detsad101lipetsk.gosuslugi.ru/', '398058, г. Липецк, ул. 15 микрорайон, д.20' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ОВЗ (ТНР) ДОУ № 101 г. Липецка на 2025-2026 учебный год', 'https://detsad101lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-2024-2025-uchebnyy-god.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №103 г.Липецка ДОУ №103 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Еманова Оксана Ивановна', '+71055450005', 'uspex103@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №103 г.Липецка ДОУ №103 г.Липецка', 186, 'preschool', d.id, 'https://dou103lip.gosuslugi.ru/', '398058, г. Липецк, 15 микрорайон, д.2/2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся старшего возраста (5-7 лет) с ОВЗ (ТНР) в группах компенсирующей направленности ДОУ № 103 (логопедические группы)', 'https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся старшего возраста (5-7 лет) с ОВЗ (ТНР) в группах комбинированной направленности ДОУ № 103', 'https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся старшего дошкольного возраста (5-7 лет) с ограниченными возможностями здоровья (ЗПР) ДОУ № 103 на 2025 -2026 учебный год', 'https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №105 г.Липецка ДОУ №105 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Двуреченская Виктория Викторовна', '+73095333745', 'skazka-105-dou@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №105 г.Липецка ДОУ №105 г.Липецка', 186, 'preschool', d.id, 'https://ds105sk48.gosuslugi.ru/', '398035, г. Липецк, ул. Звездная, 5' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №105 г. Липецка', 'https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-tnr-2025-2026.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №105 г.Липецка', 'https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-zpr-2025-2027.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с расстройством аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №105 г.Липецка', 'https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-ras-dou-105-glipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №107 г.Липецка ДОУ №107 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Соболева Ирина Вадимовна', '+70818250122', 'lipetsk.sadik-107@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №107 г.Липецка ДОУ №107 г.Липецка', 186, 'preschool', d.id, 'https://dou107.gosuslugi.ru/', '398059, г. Липецк, ул. 8 Марта д. 20/3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с нарушением интеллекта (синдром Дауна)', 'https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniem-intellekta-sindrom-dauna.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи', 'https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с нарушениями зрения', 'https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniyami-zreniya.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития', 'https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zpr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №110 г.Липецка ДОУ №110 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Емельянова Ирина Владимировна', '+78727493313', 'mdoulip110@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №110 г.Липецка ДОУ №110 г.Липецка', 186, 'preschool', d.id, 'https://dou110lipetsk.gosuslugi.ru/', '398902, г. Липецк, пер. Рудный, 9а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР) Муниципального бюджетного дошкольного образовательного учреждения № 110 г. Липецк', 'https://dou110lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnrmunitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-110-glipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР) Муниципального бюджетного дошкольного образовательного учреждения № 110 г. Липецк', 'https://dou110lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya-zpr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-110-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №112 г.Липецка ДОУ №112 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шацких Ольга Александровна', '+79671439658', 'dou.112@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №112 г.Липецка ДОУ №112 г.Липецка', 186, 'preschool', d.id, 'https://dou112-lipetsk.gosuslugi.ru/', '398908, г. Липецк, ул. Энергостроителей, 8' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования Муниципального бюджетного дошкольного образовательного учреждения №112 г. Липецка', 'https://dou112-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dou-112-g-lipetska1.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №113 г.Липецка ДОУ №113 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Калинина Юлия Ильгизяровна', '+74742775623', 'dou-113-2011@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №113 г.Липецка ДОУ №113 г.Липецка', 186, 'preschool', d.id, 'https://ds113-lipetsk48.gosuslugi.ru/', '398059, г. Липецк, ул. Неделина, 47, ул. Неделина, 33' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа ДОУ №113 г.Липецка (для детей с ТНР)', 'https://ds113-lipetsk48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-113-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования ДОУ №113 г.Липецка (для детей с ЗПР)', 'https://ds113-lipetsk48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-113-g-lipetska-zpr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №114 г.Липецка ДОУ №114 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Серёгина Олеся Юрьевна', '+78302250131', 'dou1142011@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №114 г.Липецка ДОУ №114 г.Липецка', 186, 'preschool', d.id, 'https://dou114-lipetsk.gosuslugi.ru/', '398001, г. Липецк, ул. 8 Марта, 24/3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи Муниципального бюджетного дошкольного образовательного учреждения № 114 г. Липецка', 'https://dou114-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_140.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития Муниципального бюджетного дошкольного образовательного учреждения № 114 г. Липецка', 'https://dou114-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_142.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №116 г.Липецка ДОУ №116 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бунеева Марина Геннадьевна', '+77071455452', 'dou116@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №116 г.Липецка ДОУ №116 г.Липецка', 186, 'preschool', d.id, 'https://ds116lipetsk.gosuslugi.ru/', '398006, г. Липецк, ул. Жуковского, 11А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования муниципального бюджетного дошкольного образовательного учреждения №116 г.Липецка', 'https://ds116lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-116-glipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для воспитанников с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №116 г. Липецка', 'https://ds116lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-vospitannikov-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-116-glipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №119 г.Липецка ДОУ №119 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Наумова Наталья Николаевна', '+77195261102', 'mdoulip119@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №119 г.Липецка ДОУ №119 г.Липецка', 186, 'preschool', d.id, 'https://dou119lip.gosuslugi.ru/', 'Корпус №1: 398024, г. Липецк, ул. Айвазовского, д.7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР ДОУ №119 г. Липецка', 'https://dou119lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/metodicheskoe-obespechenie-aop-dou-119-g-lipetska-s-tnr-1.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР ДОУ №119 г. Липецка', 'https://dou119lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-zpr-2024-2025-dou-119.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №123 г.Липецка ДОУ №119 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Васина Галина Николаевна', '+74742330034', 'mdoulip123@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №123 г.Липецка ДОУ №119 г.Липецка', 186, 'preschool', d.id, 'https://ds123lip.gosuslugi.ru/', '398035, г. Липецк, ул. Звёздная, 10/4' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения № 123 г. Липецка', 'https://ds123lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-123-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения № 123 г. Липецка', 'https://ds123lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №124 г.Липецка ДОУ №124 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Соболев Вадим Владимирович', '+74742340019', 'lipetsksadik-124@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №124 г.Липецка ДОУ №124 г.Липецка', 186, 'preschool', d.id, 'https://ds124-lip.gosuslugi.ru/', '398002, г. Липецк, ул.Терешковой, д.23' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования ДОУ № 124 г. Липецка', 'https://ds124-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/kopiya-adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dou-124-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное автономное дошкольное образовательное учреждение №126 г.Липецка ДОУ №126 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Белоусова Ольга Анатольевна', '+71739571749', 'mdoulip126@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное автономное дошкольное образовательное учреждение №126 г.Липецка ДОУ №126 г.Липецка', 186, 'preschool', d.id, 'https://dou126lip.gosuslugi.ru/', '398036, г. Липецк, пр. 60-летия СССР, 14' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи Муниципального автономного дошкольного образовательного учреждения детского сада №126 г. Липецка на 2025-2026 уч.г.', 'https://dou126lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-avtonomnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-detskogo-sada-126-g-lipetska-na-2024-2025-uchg.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №127 г.Липецка ДОУ №127 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шувайкина Инга Валентиновна', '+72994492966', 'mdoulip127@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №127 г.Липецка ДОУ №127 г.Липецка', 186, 'preschool', d.id, 'https://dou127-lipetsk.gosuslugi.ru/', '398902, г. Липецк, ул. Юношеская, 12' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная программа', 'https://dou127-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-ovz-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-127-g-lipetska-razrabotannaya-dlya-detey-s-tyazhelymi-narusheniyami-rechi.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №128 г.Липецка ДОУ №128 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Не указан', '+76661450282', 'iisadraduga128@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №128 г.Липецка ДОУ №128 г.Липецка', 186, 'preschool', d.id, 'https://ds128-lip.gosuslugi.ru/', '398046, г. Липецк, проспект 60 лет СССР, д. 8' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи', 'https://ds128-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_263.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития', 'https://ds128-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_264.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №130 г.Липецка ДОУ №130 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бутова Татьяна Петровна', '+78433226157', 'mdoulip130@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №130 г.Липецка ДОУ №130 г.Липецка', 186, 'preschool', d.id, 'https://dou130-lipetsk.gosuslugi.ru/', '398059, г. Липецк, проспект Победы, д.15' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования муниципального бюджетного дошкольного образовательного учреждения № 130 города Липецка (группа компенсирующей направленности (логопедическая))', 'https://dou130-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №133 г.Липецка ДОУ №133 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Будюкина Елена Александровна', '+70113450161', 'lipetsksadik-133@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №133 г.Липецка ДОУ №133 г.Липецка', 186, 'preschool', d.id, 'https://ds133.gosuslugi.ru/', '398046, г. Липецк, ул. П.Смородина, д. 26' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №134 г.Липецка ДОУ №134 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Вепренцева Юлия Васильевна', '+70130431757', 'mdoulip134@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №134 г.Липецка ДОУ №134 г.Липецка', 186, 'preschool', d.id, 'https://ds134-lipeck.gosuslugi.ru/', '398005, г. Липецк, ул. Степана Разина, 1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения № 134 г. Липецка', 'https://ds134-lipeck.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-134-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения № 134 г. Липецка', 'https://ds134-lipeck.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-134-g-lipetska-1.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №135 г.Липецка ДОУ №135 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Полянская Татьяна Ивановна', '+74784416210', 'lipetsksadik135@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №135 г.Липецка ДОУ №135 г.Липецка', 186, 'preschool', d.id, 'https://lipetsksadik135.gosuslugi.ru/', '398046, г. Липецк, ул. П. Смородина, 4а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи', 'https://lipetsksadik135.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-tyazhelymi-narusheniyami-rechi-tnr.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №136 г.Липецка ДОУ №136 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бирюкова Наталья Михайловна', '+74742417232', 'mdoulip136@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №136 г.Липецка ДОУ №136 г.Липецка', 186, 'preschool', d.id, 'https://dou136lipetsk.gosuslugi.ru/', '398036, г. Липецк, проспект 60 лет СССР, д.29' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка', 'https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка', 'https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с расстройством аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка', 'https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-rasstroystvom-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html' FROM ins
UNION ALL
SELECT id, 'Коррекционно-развивающая программа "СенсориУМ" для детей дошкольного возраста с расстройствами аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка', 'https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/korrektsionno-razvivayuschaya-programma-sensorium-dlya-detey-doshkolnogo-vozrasta-s-rasstroystvami-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №137 г.Липецка ДОУ №137 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Фомичева Ирина Михайловна', '+74742416883', 'mdoulip137@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №137 г.Липецка ДОУ №137 г.Липецка', 186, 'preschool', d.id, 'https://mdoulip137.gosuslugi.ru/', '398046, г. Липецк, ул.Стаханова, д.31 а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для обучающихся с тяжелыми нарушениями речи', 'https://mdoulip137.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №138 г.Липецка ДОУ №138 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Краснова Елена Валентиновна', '+76685460104', 'mdoulip138@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №138 г.Липецка ДОУ №138 г.Липецка', 186, 'preschool', d.id, 'https://mdou138-lip.gosuslugi.ru/', '398036, г. Липецк, ул. Проспект 60 лет СССР, д. 13' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования в группах компенсирующей направленности для детей ТНР', 'https://mdou138-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_78.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования в группах комбинированной направленности для детей ЗПР', 'https://mdou138-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_79.html' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение №139 г.Липецка ДОУ №139 г.Липецка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Полянская Алла Вячеславовна', '+70235720264', 'mdoulip139@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение №139 г.Липецка ДОУ №139 г.Липецка', 186, 'preschool', d.id, 'https://dou139-lipetsk.gosuslugi.ru/', '398050, г. Липецк, ул. Нижняя логовая, 1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ОВЗ Муниципального бюджетного дошкольного образовательного учреждения № 139 г. Липецка', 'https://dou139-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ им. А.М. Селищева с.Волово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Подоприхина Татьяна Алексеевна', '+74747321003', 'sc-volovo@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ им. А.М. Селищева с.Волово', 188, 'vo', d.id, 'https://sh-volovskaya.gosuslugi.ru/', '399580, Российская Федерация, Центральный федеральный округ, Липецкая обл., Воловский район, с. Волово, ул. Советская, дом 122' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с легкой УО (интеллектуальными нарушениями)', 'https://sh-volovskaya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Захаровка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Митрохина Наталья Александровна', '+74747323425', 'sc-zakharovka@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Захаровка', 188, 'school', d.id, 'https://sh-zaxarovskaya-r42.gosweb.gosuslugi.ru/', '399591, Липецкая область, Воловский район, село Захаровка, улица Школьная, дом 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ им. И. А. Солдатова с.Нижнее Большое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пикалов Сергей Александрович', '+74747324197', 'bolhoe123@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ им. И. А. Солдатова с.Нижнее Большое', 188, 'school', d.id, 'https://sh-bolshovskaya-r42.gosweb.gosuslugi.ru/', 'Липецкая область Воловский район с. Нижнее Большое ул. Школьная д.91' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ им. В.Т. Чернова д.Верхнее Чесночное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сомова Ольга Павловна', '+74747325413', NULL) RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ им. В.Т. Чернова д.Верхнее Чесночное', 188, 'school', d.id, 'https://sh-vchesnochnoe.gosuslugi.ru/', '399573, Липецкая область, Воловский район, д. Верхнее Чесночное, ул. В. Чернова, д. 24' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Искорка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Семкина Ольга Александровна', '+74747321143', 'iskorka_48@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Искорка»', 188, 'preschool', d.id, 'https://iskorka48.gosuslugi.ru/', '399580 Липецкая область, Воловский район, с. Волово, ул. Почтовая, д.2;; 399580 Липецкая область, Воловский район, с. Волово, ул. Советская, д.97' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Захаровка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Митрохина Наталья Александровна', '+74747323425', 'antipov4862@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Захаровка', 188, 'preschool', d.id, 'https://sh-zaxarovskaya-r42.gosweb.gosuslugi.ru/', '399581 Липецкая область, Воловский район, с.Захаровка, ул. Школьная, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №1 г.Данкова
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Блинова Наталья Александровна', '+77465662341', 'mousosh01@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №1 г.Данкова', 190, 'school', d.id, 'https://mousosh01-dankov.gosuslugi.ru/', '399850, Липецкая область, г. Данков, ул. Энгельса, д.7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 7.2.)', 'http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с ОВЗ (вариант 7.2.)', 'http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)', 'http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ лицей №6 г.Данкова
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Карих Татьяна Ивановна', '+74746561011', 'dankov.liceum6@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ лицей №6 г.Данкова', 190, 'school', d.id, 'https://sh6-dankov-r42.gosweb.gosuslugi.ru/', '399852, РФ, Липецкая область, г. Данков, ул. Мичурина, д. 7/1.; Липецкая область, Данковский район, с. Спешнево-Ивановское, ул. Куйбышева, д.6., ; Липецкая область, Данковский район, с. Березовка, ул. Парковая, д. 3/1, ; Липецкая область, Данковский район, с. Барятино, ул. Школьная, д. 12, ; Липецкая область, Данковский район, с. Воскресенское (Октябрьский с/с), ул. Мира, д. 12' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://lyceum6-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития', 'https://lyceum6-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Баловнево
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Никонов Сергей Александрович', '+74746553249', 'dvschoolbal@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Баловнево', 190, 'school', d.id, 'https://balschl.gosuslugi.ru/', '399830 Липецкая область Данковский район с. Баловнево ул. Школьная д.43' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Бигильдино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Синельникова Анна Александровна', '+74746548190', 'schoolbigildino@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Бигильдино', 190, 'school', d.id, 'https://sh-bigildino-r42.gosweb.gosuslugi.ru/', '399841, Липецкая область, Данковский район, с. Бигильдино, ул. Центральная, д.59' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Ивановка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Карнюшина Ирина Вячеславовна', '+74746543135', 'ivanovkaschola@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Ивановка', 190, 'school', d.id, 'https://sh-ivanovka-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ лицей №4 г.Данкова
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Коротких Тамара Анатольевна', '+74746564020', 'dvschool4@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ лицей №4 г.Данкова', 190, 'school', d.id, 'https://sh4-dankov-r42.gosweb.gosuslugi.ru/', '399852, Липецкая область, Данковский район, город Данков, улица Мичурина, дом 8; 399852, Липецкая область, Данковский район, город Данков, улица Молодежная, дом 2;; Филиал МБОУ лицей №4 г. Данкова в с. Политово по адресу:399800 Липецкая область, Данковский район, ж/д ст. Политово, улица Школьная, дом 1А;399801 Липецкая область, Данковский район, с. Кудрявщино, улица Зеленая, дом 21.Телефон: (847465) 57-1-41' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с легкой умственной отсталостью (вариант 1)', 'https://dankovliceum4.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)', 'https://dankovliceum4.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ №1 «Солнышко»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дементьева Любовь Дмитриевна', '+74746566408', 'dou.solnyshko@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ №1 «Солнышко»', 190, 'preschool', d.id, 'https://ds1dankov.gosuslugi.ru/', '399850, РФ, Липецкая обл., г. Данков, ул. Урицкого, д.34/1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с №2 «Ромашка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пинаева Нина Николаевна', '+74746564061', 'dsromawka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с №2 «Ромашка»', 190, 'preschool', d.id, 'https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/', '399851, Липецкая область, г. Данков, ул. Мичурина, д.11/1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ТНР)', 'https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ЗПР)', 'https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение детский сад комбинированного вида №3 города Данкова Липецкой области Детский сад №3 г.Данков
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Солдатова Анна Михайловна', '+74746562277', 'dankovdetsad3@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение детский сад комбинированного вида №3 города Данкова Липецкой области Детский сад №3 г.Данков', 190, 'preschool', d.id, 'https://detsad3.gosuslugi.ru/', '399852, РФ, Липецкая область, г. Данков, ул. Мичурина, д.5, корпус 1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с задержкой психического развития (ЗПР)', 'https://detsad3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с тяжелыми нарушениями речи (ТНР)', 'https://detsad3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ №4 «Ягодка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Полетаева Оксана Николаевна', '+74746561253', 'dou.yagodka4@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ №4 «Ягодка»', 190, 'preschool', d.id, 'https://dou4yagodka.gosuslugi.ru/', '399852, Россия, Липецкая область, город Данков, ул. Молодежная, д.3; ул. Свердлова, д.14' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи', 'https://dou4yagodka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МАДОУ №7 «Сказка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кожемякина Татьяна Михайловна', '+74746562355', 'mdouskazka7@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ №7 «Сказка»', 190, 'preschool', d.id, 'https://madou7dankov.gosuslugi.ru/', '399852, Липецкая область, г. Данков, ул. Мира, д.40' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАДОУ №8 Данковского муниципального района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Михайлова Галина Викторовна', '+74746562249', 'detskiisad.8marta@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ №8 Данковского муниципального района Липецкой области', 190, 'preschool', d.id, 'https://ds-8ulybka-dankov-r42.gosweb.gosuslugi.ru/', '399851, Липецкая обл., г. Данков, ул Мичурина, д 11/1 (№51, 56);; 399850, Липецкая обл., г. Данков, ул. Мира, д.5, к.1 (№35, 38, 41, 45); 399852, Липецкая обл.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://ds-8ulybka-dankov-r42.gosweb.gosuslugi.ru/netcat_files/19/8/adaptirovannaya_programma_novaya_1_.pdf' FROM ins;

-- NEW institution: МБДОУ детский сад с.Спешнево-Ивановское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Волкова Светлана Владимировна', '+74746555185', 'ds.sp-iv.maltseva@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Спешнево-Ивановское', 190, 'preschool', d.id, 'https://ds-speshnevoivanovskoe-r42.gosweb.gosuslugi.ru/', '399824, Липецкая область Данковский район с. Спешнево-Ивановское ул. Куйбышева д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Ягодное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лаухина Татьяна Алексеевна', '+74746549191', 'yashkola@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Ягодное', 190, 'preschool', d.id, 'https://sh-yagodnoe-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Данковский район, с. Ягодное, ул. Школьная, д.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «Лицей №1» п.Добринка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Селиванова Татьяна Михайловна', '+74746221161', 'sc1dobr@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Лицей №1» п.Добринка', 191, 'school', d.id, 'https://lic1dobrinka.gosuslugi.ru/', '399431; Липецкая область, Добринский район, п. Добринка, ул. Ленинская, дом 3.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №2 п.Добринка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Каширская Надежда Сергеевна', '+74746223758', 'sc2dobr@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №2 п.Добринка', 191, 'school', d.id, 'https://sh2dobrinka.gosuslugi.ru/', '399430, Липецкая область, Добринский район, п. Добринка, ул. Октябрьская, д. 79' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжелыми нарушениями речи (вариант 5.1)', 'https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с лёгкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) (1 - 9 классы)', 'https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)', 'https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с задержкой психического развития (основное общее образование)', 'https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ «Гимназия им. И.М.Макаренкова» с.Ольговка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Беляева Алена Валерьевна', '+74746238030', 'olgovskaja2022@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Гимназия им. И.М.Макаренкова» с.Ольговка', 191, 'school', d.id, 'https://olggimnaziya.gosuslugi.ru/nasha-shkola/o-shkole/', '399420, Липецкая область, Добринский район, ж.-д. ст. Плавица, ул. Школьная, 1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта, (вариант 1)', 'https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта, (вариант 2)', 'https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа НОО для слабовидящих обучающихся (вариант 4.2)', 'https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа ООО для обучающихся с задержкой психического развития, (5-9 классы)', 'https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа ООО для обучающихся с расстройствами аутистического спектра (вариант 8.1), (5-9 классы)', 'https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Дубовое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пригородова Людмила Михайловна', '+74746241332', 'sc-dubovoe@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Дубовое', 191, 'school', d.id, 'https://dubovoe-dobrinka.gosuslugi.ru/', '399418, Липецкая область, Добринский район, с. Дубовое, ул. Лермонтова, 2 "А"' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Мазейка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Афанасьев Иван Иванович', '+74647230312', 'moumazeyka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Мазейка', 191, 'school', d.id, 'https://sc-mazeyka.gosuslugi.ru/', '399434, Липецкая обл., Добринский р-н, с. Мазейка, ул. Центральная, д.79' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Нижняя Матренка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бирюкова Анастасия Викторовна', '+78474253361', 'sc-nmatrenka@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Нижняя Матренка', 191, 'school', d.id, 'https://nmatrenka.gosuslugi.ru/', '399412, Липецкая область, Добринский район, с. Нижняя Матренка, ул. Центральная, д.50' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с лёгкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) (1 - 9 классы)', 'https://nmatrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)', 'https://nmatrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Верхняя Матренка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Перова Любовь Васильевна', '+79155574833', 'sc-vmatrenka@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Верхняя Матренка', 191, 'school', d.id, 'https://v-matrenka.gosuslugi.ru/', '399455 Липецкая обл., Добринский район, с. Верхняя Матренка, ул. Центральная д.32.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (ФГОС, 1 вариант) на 2024 – 2027 гг. (в соответствии с ФАООП УО (ИН))', 'https://v-matrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для учащихся с задержкой психического развития (вариант 7.1) на 2024-26 учебный год', 'https://v-matrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ п.Петровский
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Исаева Елена Александровна', '+74746245348', NULL) RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ п.Петровский', 191, 'school', d.id, 'https://petrowskiyschool.gosuslugi.ru/', '399446 Липецкая область Добринский район п. совхоза Петровский ул. Победы дом 3' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с ЗПР', 'https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой УО (ИН) вариант 1', 'https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'АООП с УО (ИН) вариант 1 (2024г)', 'https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'АООП НОО обучающихся с НОДА вариант 6.2', 'https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ с.Пушкино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Яров Виктор Владимирович', '+74746242431', 'sc-pushkino@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Пушкино', 191, 'school', d.id, 'https://sh-pushkino.gosuslugi.ru/', '399441 Липецкая область, Добринский район, с. Пушкино, ул. Мира, д. 29 Б' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ ст. Хворостянка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Насонова Маргарита Игоревна', '+74746257395', 'mouxvorostanka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ ст. Хворостянка', 191, 'school', d.id, 'https://xvorostanka48.gosuslugi.ru/', '399410, Липецкая область, Добринский район, ст. Хворостянка, ул. Октябрьская, д.14.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Талицкий Чамлык Добринского муниципального района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Нестерова Наталия Николаевна', '+74746246346', 'shcolatalica@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Талицкий Чамлык Добринского муниципального района Липецкой области', 191, 'school', d.id, 'https://shc0-latalica.gosuslugi.ru/', '399450 Липецкая область, Добринский район, с. Талицкий Чамлык, ул. Советская, д. 41' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАДОУ д/с №2 п.Добринка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Зимина Оксана Юрьевна', '+74746221275', 'detskiy_sad2@bk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ д/с №2 п.Добринка', 191, 'preschool', d.id, 'https://ds2dobrinka48.gosuslugi.ru/', '399431 Липецкая область, п. Добринка, ул. Воронского, дом 49' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра (РАС и УО)', 'https://ds2dobrinka48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МАДОУ д/с №4 п.Добринка Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Орлова Екатерина Сергеевна', '+74746221242', 'dbrkdetsad4@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ д/с №4 п.Добринка Липецкой области', 191, 'preschool', d.id, 'https://dobrinka4sad.gosuslugi.ru/', '399431, Липецкая область, Добринский округ, п. Добринка, ул. Кирова, д.6' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с с.Демшинка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дорофеева Елена Николаевна', '+79205135768', 'ds-demshinka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с с.Демшинка', 191, 'preschool', d.id, 'https://ds-demshinka-r42.gosweb.gosuslugi.ru/', '399458 Липецкая область Добринский район с. Демшинка ул.Школьная, д.10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАДОУ д.сад ст. Плавица
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бахтина Наталия Александровна', '+74746238182', 'madou-plavica80@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ д.сад ст. Плавица', 191, 'preschool', d.id, 'https://ds-demshinka-r42.gosweb.gosuslugi.ru/', '399420 Липецкая область, Добринский район, ж/д ст. Плавица, ул. Строителей, д.17' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР', 'https://ds-plavica.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №1 им. А.И. Левитова С.Доброе
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Раздобарина Марина Олеговна', '+74746321208', 'dbe08@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №1 им. А.И. Левитова С.Доброе', 192, 'school', d.id, 'https://sc1dobroe.gosuslugi.ru/', '399140, Липецкая область, Добровский район, с. Доброе, ул. Победы, д. 13' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа начального общего образования для обучающихся с ЗПР (вариант 7.2)', 'https://sc1dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1, вариант 2)', 'https://sc1dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №2 с.Доброе им. М.И. Третьяковой
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ильин Евгений Алексеевич', '+74746323005', 'sch02dobroe@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №2 с.Доброе им. М.И. Третьяковой', 192, 'school', d.id, 'https://sch02dobroe.gosuslugi.ru/', '399140, Липецкая область, Добровский район, с. Доброе, ул. Ленина, д. 39' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Большой Хомутец Добровского муниципального округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Храброва Вера Николаевна', '+74746343280', 'sc-bhomutets@scools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Большой Хомутец Добровского муниципального округа Липецкой области', 192, 'school', d.id, 'https://bh-school.gosuslugi.ru/', '399170, Липецкая область, Добровский район, с. Большой Хомутец, ул. Советская, д.47' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №2 с.Каликино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Прилепина Оксана Яковлевна', '+74746336173', 'skalikino@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №2 с.Каликино', 192, 'school', d.id, 'https://sc2kalikino.gosuslugi.ru/', '399162, Липецкая область, Добровский район, с. Каликино, ул. Советская, д. 100.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями, (вариант 2)', 'https://sh-2kalikino-kalikino-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №1 с.Каликино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Рекутина Елена Николаевна', '+74746336179', 'dbe06@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №1 с.Каликино', 192, 'school', d.id, 'https://sc1-kalikino.gosuslugi.ru/', '399162 Липецкая область Добровский район, с.Каликино, пл.Ленина, д. 31' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Крутое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Окунев Сергей Иванович', '+74746337144', 'sch.krutoe@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Крутое', 192, 'school', d.id, 'https://sh-krutoe-r42.gosweb.gosuslugi.ru/', '399145, Липецкая область, Добровский район, с. Крутое, ул. Комсомольская, д. 21' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР', 'https://ds-plavica.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Кореневщино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кузнецова Надежда Николаевна', '+74746331123', 'korenevshino@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Кореневщино', 192, 'school', d.id, 'https://sh-korenevshhino-r42.gosweb.gosuslugi.ru/', '399171 Липецкая область, Добровский район, с. Коренёвщино, ул. Центральная, д. 5' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Махоново
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кирина Валентина Ивановна', '+74746334153', 'maxonovo@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Махоново', 192, 'school', d.id, 'https://schkola-s-mahonovo.gosuslugi.ru/', '399161 Липецкая область Добровский район село Махоново ул. Ленина д.37' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Панино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Крючкова Елена Викторовна', '+74746342149', 'paninoschool@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Панино', 192, 'school', d.id, 'https://paninoschool.gosuslugi.ru/', '399148 Липецкая область Добровский район с.Панино, ул.Молодёжная, д.5' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Порой
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чиликина Татьяна Сергеевна', '+74746344222', 'scporoj@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Порой', 192, 'school', d.id, 'https://porojshkola.gosuslugi.ru/', '399155, Липецкая область, Добровский район, с. Порой, ул. Советская, д. 31' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Преображеновка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сухова Римма Анатольевна', '+74746347197', 'preobragenovka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Преображеновка', 192, 'school', d.id, 'https://sh-preobragenovka.gosuslugi.ru/', '399175 Липецкая область, Добровский район, с.Преображеновка, ул. Центральная, д. 8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ им. Н. Ф. Пономарева с.Трубетчино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чиликина Ольга Владимировна', '+74746340589', 'trubetchino-school@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ им. Н. Ф. Пономарева с.Трубетчино', 192, 'school', d.id, 'https://sh-trubetchino-r42.gosweb.gosuslugi.ru/', '399151 Липецкая обл, Добровский район, с. Трубетчино, ул. Почтовая, д. 17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Екатериновка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Саввин Алексей Юрьевич', '+74746332146', 'ekaterinovka-school@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Екатериновка', 192, 'school', d.id, 'https://ekaterinovka-school.gosuslugi.ru/', '399152, Россия, Липецкая область, Добровский район, с. Екатериновка, ул. Черёмушки, д. 2.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями)', 'https://ekaterinovka-school.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Золотой петушок» села Доброе Добровского муниципального округа Липецкой области ДОУ детский сад «Золотой петушок» с.Доброе
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Татаринова Наталья Валерьевна', '+74746321685', 'zolotoipetushokdsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Золотой петушок» села Доброе Добровского муниципального округа Липецкой области ДОУ детский сад «Золотой петушок» с.Доброе', 192, 'preschool', d.id, 'https://petushok-dobroe.gosuslugi.ru/', '399140, Россия, Липецкая область, село Доброе, улица Калинина, д. 45 А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для обучающихся с ТНР', 'https://petushok-dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ «Малыш» с.Ратчино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Никулина Ирина Анатольевна', '+74746335199', 'nikulinairina2011@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Малыш» с.Ратчино', 192, 'preschool', d.id, 'https://ds-malysh-ratchino-r42.gosweb.gosuslugi.ru/', '399147, Липецкая обл, Добровский р-н, Ратчино с, ул. Ленина д. 11' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Малышок» с.Доброе
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пупышева Лилия Александровна', '+74746322005', 'dobroe.malyshok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Малышок» с.Доброе', 192, 'preschool', d.id, 'https://ds-malyshok-dobroe-r42.gosweb.gosuslugi.ru/', '399140, Россия, Липецкая область, с.Доброе, ул. Победы, д.12а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелым нарушениями речи', 'https://ds-malyshok-dobroe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/#adaptirovannye-obrazovatelnye-programmy' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение «Теремок» с.Большой Хомутец Добровского муниципального округа Липецкой области ДОУ «Теремок» с.Б. Хомутец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Плешкова Елена Алексеевна', '+74746343254', 'pleshkova.elena.teremok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение «Теремок» с.Большой Хомутец Добровского муниципального округа Липецкой области ДОУ «Теремок» с.Б. Хомутец', 192, 'preschool', d.id, 'https://ds-teremok-b-xomutec.gosuslugi.ru/', '399170, Россия, Липецкая область, Добровский район, с. Большой Хомутец, ул. Центральная, дом 43' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Берёзка» с.Каликино Добровского муниципального округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чичикина Ольга Ивановна', '+74746336222', 'lodobroesadik@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Берёзка» с.Каликино Добровского муниципального округа Липецкой области', 192, 'preschool', d.id, 'https://ds-beryozka-kalikino-r42.gosweb.gosuslugi.ru/', 'Липецкая область Добровский район с. Каликино площадь Ленина, 38' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи', 'https://ds-beryozka-kalikino-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ «Колосок» с.Крутое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ломова Ольга Викторовна', '+74746337175', 'olyalomowa@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Колосок» с.Крутое', 192, 'preschool', d.id, 'https://ds-kolosok-r42.gosweb.gosuslugi.ru/', '399145 Липецкая область Добровский район с. Крутое ул. Комсомольская д.24' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Малышок» с.Панино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Берникова Ольга Владимировна', '+74746342183', 'paninosad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Малышок» с.Панино', 192, 'preschool', d.id, 'https://paninosad31.gosuslugi.ru/', '399148, Липецкая область, Добровский район, с. Панино, ул. Молодежная, д.31' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Солнышко» с.Трубетчино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Войнова Елена Александровна', '+74746340156', 'mdoy.solnischcko@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Солнышко» с.Трубетчино', 192, 'preschool', d.id, 'https://ds-solnyshko-trubetchino.gosuslugi.ru/', '399151, Липецкая область, Добровский район, с.Трубетчино, ул. Почтовая, д.33' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа муниципального бюджетного дошкольного образовательного учреждения детского сада «Солнышко» с.Трубетчино Добровского муниципального района Липецкой области', 'https://ds-solnyshko-trubetchino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ «Сказка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Герасимова Светлана Ивановна', '+74746330121', 'skazka.borisovka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Сказка»', 192, 'preschool', d.id, 'https://ds-skazka-borisovka-r42.gosweb.gosuslugi.ru/', '399173, Липецкая область, Добровский район, с. Борисовка, ул. Новая д.1/1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Солнышко» с.Волчье
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Татаринова Галина Александровна', '+74746339234', 'galia.tatarinowa@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Солнышко» с.Волчье', 192, 'preschool', d.id, 'https://ds-solnyshko-volche-r42.gosweb.gosuslugi.ru/', '399154, Липецкая обл, Добровский р-н, Волчье с, Центральная ул, 6' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с расстройством аутистического спектра', 'https://ds-solnyshko-volche-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-rastroystvom-autisticheskogo-spektra.html' FROM ins;

-- NEW institution: МБДОУ «Родничок» с.Замартынье
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Крысанова Марина Александровна', '+74746341120', 'rodnichokzam@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Родничок» с.Замартынье', 192, 'preschool', d.id, 'https://ds-rodnichok-zamartyne-r42.gosweb.gosuslugi.ru/', '399150 Липецкая область, Добровский район, село Замартынье, улица Советская, 18' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Теремок» с.Кривец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кирина Вера Васильевна', '+74746333322', 'krivec.detsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Теремок» с.Кривец', 192, 'preschool', d.id, 'https://ds-teremok-krivec.gosuslugi.ru/', '399174 Липецкая обл, Добровский округ с. Кривец, ул. Песчановка д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Колобок» с.Путятино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Терёшина Лидия Ивановна', '+74746338185', 'detsadkolobok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Колобок» с.Путятино', 192, 'preschool', d.id, 'https://ds-kolobok-putyatino-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Добровский район, с. Путятино, ул. Костикова, д. 29' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ лицей с.Долгоруково
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Барабанова Елена Александровна', '+74746821403', 'sch_dlg@dolgorukovo.lipetsk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ лицей с.Долгоруково', 193, 'school', d.id, 'https://lic-dolgorukovo-r42.gosweb.gosuslugi.ru/', '399510, Липецкая область, с.Долгоруково, ул.Терешковой, д.19' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа (для обучающихся с умственной отсталостью (интеллектуальными нарушениями) вариант 1,2)', 'https://lic-dolgorukovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Братовщина имени Героя Советского Союза В.С.Севрина
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ефимова Валентина Михайловна', '+74746821500', 'dolgorukovo@admlr.lipetsk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Братовщина имени Героя Советского Союза В.С.Севрина', 193, 'school', d.id, 'https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/', '399510, Липецкая область, с. Долгоруково, ул. Тимирязева, 6.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа (вариант 1)', 'https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа (вариант 2)', 'https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Верхний Ломовец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Карева Елена Юрьевна', '+74746823222', 'v-lomovets@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Верхний Ломовец', 193, 'school', d.id, 'https://sh-verxnij-lomovec-r42.gosweb.gosuslugi.ru/', '399525, Липецкая область, Долгоруковский район, с. Верхний Ломовец, ул. Школьная, д. 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Войсковая Казинка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Малютина Галина Анатольевна', '+74746825749', 'v-kazinka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Войсковая Казинка', 193, 'school', d.id, 'https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/', '399504 Липецкая область Долгоруковский район с. Войсковая Казинка ул. Центральная д.18' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 1)', 'https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)', 'https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ ООШ д.Веселая
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кособокова Людмила Михайловна', '+74746824317', 'sc-veselaya@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ д.Веселая', 193, 'school', d.id, 'https://veselaya.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Стегаловка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Уразов Александр Александрович', '+74746823535', 'stegschool@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Стегаловка', 193, 'school', d.id, 'https://stegschool.gosuslugi.ru/', '399500 с. Стегаловка Долгоруковского округа Липецкой области, улица Школьная, д.5' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа обучающихся с легкой умственной отсталостью', NULL FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с НОДА (ФГОС вариант 6.3)', 'https://stegschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад «Солнышко» с.Долгоруково
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Павлова Алена Владимировна', '+74746822747', 'dousolnce2015@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Долгоруково', 193, 'preschool', d.id, 'https://dousolnce-dolgor.gosuslugi.ru/', '399510, область Липецкая, р-н Долгоруковский, с.Долгоруково, ул. Ивана Ермолова, д.2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с нарушениями опорно-двигательного аппарата', 'https://dousolnce-dolgor.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад «Теремок» с.Грызлово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Фомина Светлана Николаевна', '+74746823469', 'grizlovo.detsckisad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Теремок» с.Грызлово', 193, 'preschool', d.id, 'https://ds-teremok-gryzlovo-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Карамелька» с.Дубовец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Парахина Марина Александровна', '+74746824745', 'dubovez@inbox.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Карамелька» с.Дубовец', 193, 'preschool', d.id, 'https://dscaramelkadubovets.gosuslugi.ru/', '399512, Липецкая область, Долгоруковский район, с. Дубовец, ул. Центральная, дом 15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад "Радуга» д.Екатериновка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Топорова Татьяна Вячеславовна', '+74746823908', 'detsadekaterinovka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад "Радуга» д.Екатериновка', 193, 'preschool', d.id, 'https://ds-raduga-ekaterinovka-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Долгоруковского округа, д.Екатериновка, ул. Центральная, 10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Каменское им. Г.Н.Елецких
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Назарова Елена Викторовна', '+74746791152', 'kamenskoe1@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Каменское им. Г.Н.Елецких', 194, 'school', d.id, 'https://sckamenskoe.gosuslugi.ru/', '399760 Липецкая область Елецкий район с.Каменское ул.Школьная, зд.25' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №2 с.Казаки
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Логвиненко Валерий Викторович', '+74746796339', 'elrsc17@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №2 с.Казаки', 194, 'school', d.id, 'https://sckazaki.gosuslugi.ru/', '399746, Липецкая область, Елецкий район, село Казаки, ул. Мира, д.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ п.Ключ жизни
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Астапенко Алёна Сергеевна', '+74746790471', 'klych-gizni@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ п.Ключ жизни', 194, 'school', d.id, 'https://sc-klychgizni.gosuslugi.ru/', '399770, Россия, Липецкая область, г. Елец, ул. 9-ое Декабря, 54' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Талица им. С.А. Бутова
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Милованова Оксана Николаевна', '+74746793310', 'school_talitsa@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Талица им. С.А. Бутова', 194, 'school', d.id, 'https://schooltalitsa.gosuslugi.ru/', '399761, Липецкая область, Елецкий район, с. Талица, ул. Советская, д. 152Б' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ п.Солидарность
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мяликова Елена Викторовна', '+74746798524', 'sc-solidarnost@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ п.Солидарность', 194, 'school', d.id, 'https://solshk.gosuslugi.ru/', '399750, Липецкая область, Елецкий район, п. Солидарность, ул. Школьная, д. 2 А.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обу­чающихся с легкой умственной отсталостью (интеллектуальными нарушениями)', 'https://solshk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития', 'https://solshk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ ООШ с.Лавы
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Фролова Лариса Ивановна', '+74746795095', 'lavschool2008@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Лавы', 194, 'school', d.id, 'https://sh-lavy.gosuslugi.ru/', '399780, Липецкая область, Елецкий район, с.Лавы, ул.Северная, д. 3' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ НОШ д.Ивановка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Саранцева Екатерина Александровна', '+74746791116', 'ivanovkaelr@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ НОШ д.Ивановка', 194, 'school', d.id, 'https://schoolivanovka.gosuslugi.ru/', '399760, Липецкая область, Елецкий район, деревня Ивановка, улица Рабочая, дом 45' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад п.Елецкий
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Воробьева Ольга Александровна', '+74746797749', 'sad-eletskiy2013@ya.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад п.Елецкий', 194, 'preschool', d.id, 'https://detsadeletskiy.gosuslugi.ru/', '399774, Липецкая область, Елецкий район, п. Елецкий, ул. 50 лет Октября, д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» п.Газопровод
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кустова Алена Андреевна', '+74746790496', 'ds.gazoprovod@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» п.Газопровод', 194, 'preschool', d.id, 'https://detsadsolnischko.gosuslugi.ru/', '399742, Липецкая область, Елецкий район, п.Газопровод, ул.Мирная д.5' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования муниципального дошкольного бюджетного образовательного учреждения детского сада «Солнышко» п.Газопровод для детей с тяжелыми нарушениями речи', 'https://detsadsolnischko.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад «Солнышко» села Казаки комбинированного вида
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Малявина Светлана Владимировна', '+74746796001', 'dousolnyshkokazaki@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» села Казаки комбинированного вида', 194, 'preschool', d.id, 'https://ds-kazakisol.gosuslugi.ru/', '399746, Липецкая область, Елецкий район, село Казаки, улица Мира, д. 28' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа дошкольного образования для обучающихся с ТНР', 'https://ds-kazakisol.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Тополёк» с.Казаки
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бабушкина Юлия Сергеевна', '+74746796200', 'mbdoutopolek@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Тополёк» с.Казаки', 194, 'preschool', d.id, NULL, '399747 Липецкая область, Елецкий район, село Казаки, улица Заводская, 78' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения детского сада «Тополёк» села Казаки Елецкого муниципального района Липецкой области', 'https://ds-topolyok-kazaki.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад д.Казинка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Овсянникова Альбина Владимировна', '+74746797241', 'detsad2014@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад д.Казинка', 194, 'preschool', d.id, 'https://doukazinka.gosuslugi.ru/', '399759 Липецкая область Елецкий район д.Казинка ул. Совхозная д.4' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения детского сада деревни Казинка Елецкого муниципального района Липецкой области', 'https://doukazinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад с.Каменское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Данилкина Татьяна Николаевна', '+74746791112', 'sad.kamenskoe@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Каменское', 194, 'preschool', d.id, 'https://dskamenskoe.gosuslugi.ru/', '399760, Липецкая область, Елецкий район, село Каменское, улица Школьная, дом 23' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад п.Ключ жизни
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пасмарнова Татьяна Александровна', '+74746790123', 'detsadkl@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад п.Ключ жизни', 194, 'preschool', d.id, 'https://ds-klyuch.gosuslugi.ru/', 'Липецкая область, Елецкий район, пос. Ключ жизни, ул. 1-ая Садовая, д.9' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи', 'https://ds-klyuch.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад п.Маяк
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сидорова Елена Николаевна', '+74746797428', 'dsmayak@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад п.Маяк', 194, 'preschool', d.id, 'https://dsmayak.gosuslugi.ru/', '399749, Липецкая область, Елецкий район, п. Маяк, ул. Садовая, д.10.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад п.Солидарность
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Борисова Татьяна Ивановна', '+74746798522', 'detskiisad.solidarnost@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад п.Солидарность', 194, 'preschool', d.id, 'https://solsadik.gosuslugi.ru/', '399750, Липецкая обл., Елецкий район, п. Солидарность, ул. Школьная, д. 6а, 6б' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://solsadik.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Коррекционная программа дошкольного образования для детей с ЗПР', 'https://solsadik.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад посёлок Соколье
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Романихина Елена Николаевна', '+74746795206', 'sokolieds@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад посёлок Соколье', 194, 'preschool', d.id, 'https://sokolieds.gosuslugi.ru/', '399753, Липецкая область, Елецкий район, поселок Соколье, улица Лорха, д.9' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Талица
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Наталья Ивановна Степаненкова', '+74746793395', 'detsadtalisa@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Талица', 194, 'preschool', d.id, 'https://dstalisa.gosuslugi.ru/', '399761 Липецкая область Елецкий район село Талица улица Советская дом 146А' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад "Сказка" д.Хмелинец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Белых Елена Юрьевна', '+74746799622', 'hmelinecdou@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад "Сказка" д.Хмелинец', 194, 'preschool', d.id, 'https://douhmelinec.gosuslugi.ru/', 'Липецкая область, Елецкий район, деревня Хмелинец, переулок Новый, д.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Афанасьево Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пашкова Ирина Витальевна', '+74747843376', 'sc-afanasyevo@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Афанасьево Измалковского округа Липецкой области', 196, 'school', d.id, 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (вариант 1)', 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/netcat_files/33/46/AOOP_NI_1_variant_2025_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (2 вариант)', 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/netcat_files/33/46/AOOP_s_NI_2_variant_.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.2)', 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с НОДА (вариант 6.2)', 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)', 'https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №1 с.Измалково Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кузнецова Татьяна Викторовна', '+74747833251', 'izmchol@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №1 с.Измалково Измалковского округа Липецкой области', 196, 'school', d.id, 'https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Учебный план АООП (вариант 1) 2025-26', 'https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Учебный план АООП (вариант 2) 2025-26', 'https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Преображенье Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Марахова Валентина Николаевна', '+74747836234', 'preobrajnie@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Преображенье Измалковского округа Липецкой области', 196, 'school', d.id, 'https://preobrajnie.gosuslugi.ru/', '399012, Россия, Липецкая область, Измалковский район, с.Преображенье, ул. Стаханова, д.10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Чернава Измалковского округа
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кирюхина Надежда Александровна', '+74747838182', 'sc-chernava@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Чернава Измалковского округа', 196, 'school', d.id, 'https://sh-chernava-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Измалково Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Коротин Александр Валерьевич', '+74747822998', 'izmalkovo2@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Измалково Измалковского округа Липецкой области', 196, 'school', d.id, 'http://ms2.my.ru/', '399000, Россия, Липецкая обл, Измалковский р-н, Измалково с, Советская ул, 53.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Лебяжье Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шлеева Юлия Сергеевна', '+74747839251', 'lebiaje2007@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Лебяжье Измалковского округа Липецкой области', 196, 'school', d.id, 'https://lebiaje.gosuslugi.ru/', '399003, Липецкая область, Измалковский округ, с. Лебяжье, ул. Школьная, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Полевые Локотцы
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Насонова Валентина Николаевна', '+74747831215', 'polev1elokoti@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Полевые Локотцы', 196, 'school', d.id, 'https://polevie.gosuslugi.ru/', '399002, Липецкая область, Измалковский, 2 Лебяженский сельсовет, с Полевые Локотцы, Д. 24' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ Д.Сухой Семенек Измалковского округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Барабан Татьяна Петровна', '+74747834282', 'ssemenyok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ Д.Сухой Семенек Измалковского округа Липецкой области', 196, 'school', d.id, NULL, '399007, Липецкая область, Измалковский р-н, д Сухой Семенек, Школьная ул, д. 62' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Родничок» С.Слобода Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Анохина Мария Петровна', '+74747833259', 'd-s.sloboda@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Родничок» С.Слобода Измалковского района Липецкой области', 196, 'preschool', d.id, 'https://4250.maam.ru/', '399000, Липецкая область, Измалковский район, село Слобода, ул Мира, д. 23' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Улыбка» с.Пятницкое Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Анисимова Татьяна Евгеньевна', '+74747838134', 'anisimova.ev@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Улыбка» с.Пятницкое Измалковского района Липецкой области', 196, 'preschool', d.id, NULL, '399235, Липецкая область, Измалковский район, село Пятницкое, улица Рабочий поселок, д. 2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Ручеёк» Д.Панкратовка Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Глухова Надежда Ивановна', '+74747841280', 'ru4eek@inbox.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Ручеёк» Д.Панкратовка Измалковского района Липецкой области', 196, 'preschool', d.id, NULL, '399014, Липецкая область, Измалковский район, деревня Панкратовка, Молодежная ул, д. 6' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Светлячок» д.Недоходовка Измалковского района
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Перцева Оксана Николаевна', '+74747822829', 'dsned@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Светлячок» д.Недоходовка Измалковского района', 196, 'preschool', d.id, 'https://www.list-org.com/company/2245115', '399010, Липецкая область, Измалковский район, деревня Недоходовка, улица Центральная, д. 8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Сказка» д.Денисово Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лошкарева Ольга Васильевна', '+74747844233', 'denskazka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Сказка» д.Денисово Измалковского района Липецкой области', 196, 'preschool', d.id, 'https://denskazka.gosuslugi.ru/', '399022, Липецкая область, Измалковский район, д.Денисово, ул.Овражная, д.7' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Теремок» с.Быково Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Куринная Светлана Юрьевна', '+74747837269', 'ter.bikovo2012@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Теремок» с.Быково Измалковского района Липецкой области', 196, 'preschool', d.id, 'https://5286.maam.ru/', '399026, Липецкая область, Измалковский район, с.Быково, ул.Центральная, д.42.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Солнышко» с.Измалково Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ширинкина Ольга Николаевна', '+74747821675', 'sad.solnyshcko@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Солнышко» с.Измалково Измалковского района Липецкой области', 196, 'preschool', d.id, 'https://ds-solnyshko-izmalkovo-r42.gosweb.gosuslugi.ru/titulnaya-stranitsa/text_27.html', '399000, Липецкая область, Измалковский округ, с.Измалково, ул. Мира, дом 6' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Ромашка» с.Афанасьево Измалковского района
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Воронина Оксана Георгиевна', '+74747843546', 'mbdouromashka5@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Ромашка» с.Афанасьево Измалковского района', 196, 'preschool', d.id, NULL, '399020, Липецкая область, Измалковский район, село Афанасьево, улица Рабочая, д. 2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ "Солнышко" с.Чернава Измалковского района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Быкова Елена Александровна', '+74747838331', 'tat9914@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ "Солнышко" с.Чернава Измалковского района Липецкой области', 196, 'preschool', d.id, NULL, '399234, Липецкая область, Измалковский район, село Чернава, улица Первомайская, д. 192' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Сотниково
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чернышова Любовь Васильевна', '+74746961269', 'sotnicowo@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Сотниково', 197, 'school', d.id, 'http://http://sotnicowo.nubex.ru/', '399685 Липецкая область, Краснинский район, с. Сотниково, ул. Лесная, 20' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Решетово-Дуброво
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мешалкин Александр Николаевич', '+74746976243', 'dubravor@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Решетово-Дуброво', 197, 'school', d.id, 'https://sh-reshetovodubrovo-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Краснинский р-н, с.Решетово-Дуброво, ул.Центральная д11, индекс 399683' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Красное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ряполова Оксана Васильевна', '+74746920385', 'kcsh1@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Красное', 197, 'school', d.id, 'https://sh-krasnoe-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)', 'https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.7.) (вариант 1)', 'https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ п.Лески
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Волкова Диана Сергеевна', '+74746964220', 'mazusergej@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ п.Лески', 197, 'school', d.id, 'https://sh-leski-r42.gosweb.gosuslugi.ru/', '399675 Липецкая область, Краснинский район, п. Лески, ул. Октябрьская, д.45.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Верхнедрезгалово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Конаныхин Михаил Иванович', '+74746922123', 'vdsch@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Верхнедрезгалово', 197, 'school', d.id, 'https://sh-verxnedrezgalovo-r42.gosweb.gosuslugi.ru/', '399663 Липецкая область Краснинский район село Верхнедрезгалово улица Центральная дом 60' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Антошка» д.Дегтевая Краснинского муниципального округа Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кузнецов Юрий Николаевич', '+74746966225', 'ds25-antoschka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Антошка» д.Дегтевая Краснинского муниципального округа Липецкой области', 197, 'preschool', d.id, 'https://ds-antoshka-degtevaya-r42.gosweb.gosuslugi.ru/', '399680, Липецкая область, Краснинский район, деревня Дегтевая, Центральная ул., д.25' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Теремок» с.Верхнедрезгалово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Елена Алексеевна Першина', '+74746963337', 'ds.drezgalowo@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Теремок» с.Верхнедрезгалово', 197, 'preschool', d.id, 'https://mbdou-detskiy-sad-teremok-s-vs-xa1.orgs.biz/', '399663, Россия, Липецкая обл, Краснинский р-н, Верхнедрезгалово с, Центральная ул., д. 87' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» с.Ищеино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Надежда Александровна Плоцких', '+74746975211', 'rono@krasnoe.lipetask.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Ищеино', 197, 'preschool', d.id, 'https://www.list-org.com/company/2644434', '399688, Липецкая область, Краснинский район, село Ищеино, Школьная ул., д.10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Малыш» с.Красное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Салихова Елена Николаевна', '+74746920332', 'ya.detsky-sad@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Малыш» с.Красное', 197, 'preschool', d.id, 'https://det-sad.3dn.ru/', '399670, Липецкая область, Краснинский район, село Красное, Коммунальная ул., д.12' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» с.Красное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Гриднева Ольга Борисовна', '+74746920402', 'sdetskiysad@bk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Красное', 197, 'preschool', d.id, 'https://ds-solnyshko-krasnoe-r42.gosweb.gosuslugi.ru/', '399670, Липецкая область, Краснинский район, посeлок Краснинский, улица Газовиков, дом 17' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР (тяжелым нарушением речи) Муниципального бюджетного дошкольного образовательного учреждения детский сад «Солнышко» с. Красное Краснинского района Липецкой области', 'https://ds-solnyshko-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Чебурашка» с.Суходол (МБДОУ Детский Сад «Чебурашка» С.Суходол
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Денисов Григорий Тихонович', '+74746977244', 'rono@krasnoe.lipetsk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Чебурашка» с.Суходол (МБДОУ Детский Сад «Чебурашка» С.Суходол', 197, 'preschool', d.id, 'https://www.list-org.com/company/2644437', '399684, Липецкая область, Краснинский район, село Суходол, Торговая ул., д.5а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» с.Решетово-Дуброво
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Томилина Янна Александровна', '+74746976249', 'koval.jana2015@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Решетово-Дуброво', 197, 'preschool', d.id, 'https://mbdoureshetovodubrovo.ucoz.net/', 'Липецкая область, Краснинский район, село Решетово-Дуброво, ул. Центральная, д. 44' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Ромашка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Заичкина Елена Николаевна', '+74746964306', 'ol.ponarina@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Ромашка»', 197, 'preschool', d.id, 'http://camomile-caduk.ucoz.site/', '399675, Краснинский район, п. Лески, ул. Мира, д.7' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ п.Лев Толстой
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шевлякова Валентина Викторовна', '+74746422070', 'levt@admlr.lipetsk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ п.Лев Толстой', 199, 'school', d.id, 'https://sh-levtolstoj-r42.gosweb.gosuslugi.ru/', '399870 Россия, Липецкая область, п. Лев Толстой, пер. Советский зд.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ п.Свх. им. Льва Толстого
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Хромых Татьяна Николаевна', '+74746424869', 'sc-sltolstoy@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ п.Свх. им. Льва Толстого', 199, 'school', d.id, 'https://ltsvh.gosuslugi.ru/', '399888, Липецкая область, Лев-Толстовский район, п. Свх. им. Льва Толстого, ул. Лесная, д. 3.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ с.Кузовлево
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пантюшин Роман Владимирович', '+74746440145', 'ltshkyzovlevo@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ с.Кузовлево', 199, 'school', d.id, 'https://kuzovlevo.gosuslugi.ru/', '399883, Липецкая область, Лев-Толстовский район, с.Кузовлево, ул.Школьная, д.8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ с.Митягино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Тихонова Татьяна Александровна', '+74746444153', 'sc-mityagino@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ с.Митягино', 199, 'school', d.id, 'https://ltmit24.gosuslugi.ru/', '399881, Липецкая область, Лев-Толстовский район, с.Митягино, ул.Горбатовка д.4 юридический адрес' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ с.Новочемоданово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Наседкина Ольга Анатольевна', '+74746443118', 'n-tschemodanowo@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ с.Новочемоданово', 199, 'school', d.id, 'https://n-tschemodanowo.gosuslugi.ru/', '399880 Липецкая область Лев Толстовский район село Новочемоданово улица Школьная дом 1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)', 'https://n-tschemodanowo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ им. Героя Советского Союза Аулова В.И. с.Первомайское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Белевич Владимир Владимирович', '+74746445195', 'sc-pervomayskoe@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ им. Героя Советского Союза Аулова В.И. с.Первомайское', 199, 'school', d.id, 'https://school-imaulovavi.gosuslugi.ru/', '399884, Липецкая обл., Лев-Толстовский р-он, с. Первомайское, ул. Центральная, д. 12' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ им. Л.Н. Толстого
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пронина Ирина Викторовна', '+74746424554', 'ltschool42@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ им. Л.Н. Толстого', 199, 'school', d.id, 'https://ltschool.gosuslugi.ru/', '399870 Липецкая обл., Лев-Толстовский р-н, п. Лев Толстой, ул. Молодежная, д. 6' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная ООП образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ им. Л.Н. Толстого (вариант 1) (с изменениями и дополнениями)', 'https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная ООП образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ им. Л.Н. Толстого (вариант 2) (с изменениями и дополнениями)', 'https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с задержкой психического развития (ЗПР)', 'https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)', 'https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с расстройствами аутистического спектра', 'https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Колосок» п.Лев Толстой
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мурыгина Светлана Михайловна', '+74746421543', 'lt-kolosok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Колосок» п.Лев Толстой', 199, 'preschool', d.id, NULL, '399870, Россия, Липецкая область, Лев-Толстовский район, п. Лев Толстой, ул. Садовая, д. 40а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР МБДОУ д/с «Колосок» п. Лев Толстой', 'https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР МБДОУ д/с «Колосок» п. Лев Толстой', 'https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с НИ МБДОУ д/с «Колосок» п. Лев Толстой', 'https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Теремок» п.Лев Толстой
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Суховерова Виктория Владимировна', '+74746422226', 'lt-teremok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Теремок» п.Лев Толстой', 199, 'preschool', d.id, 'https://ds-teremok-lt.gosuslugi.ru/', '399870, Липецкая область п. Лев Толстой ул. Коммунистическая, д.30' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Радуга»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Болотова Ирина Сергеевна', '+74746423024', 'lt-ds-1@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Радуга»', 199, 'preschool', d.id, NULL, 'Место нахождения: 399870, Липецкая область, п. Лев Толстой, ул. Володарского д. 47а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР МБДОУ «Радуга»', 'https://ds-raduga.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ЗПР МБДОУ «Радуга»', 'https://ds-raduga.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ гимназия с.Боринское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кудаева Юлия Павловна', '+74742761250', 'sch.borino@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ гимназия с.Боринское', 200, 'school', d.id, 'https://gimn-borinskoe.gosuslugi.ru/', '398510, Липецкая область, Липецкий округ, село Боринское, улица П. Смородина, д.11' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Ильино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ларшин Виктор Викторович', '+74742756189', 'shkolailjno@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Ильино', 200, 'school', d.id, 'https://schoolilyino.gosuslugi.ru/', '398507, Липецкая область, Липецкий район, с. Ильино, ул. Административная д .2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.3)', 'https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.2)', 'https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.2)', 'https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.4)', 'https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа основного общего образования обучающихся с интеллектуальными нарушениями (вариант 1)', 'https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Кузьминские Отвержки
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шишин Иван Игоревич', '+74742766549', 'koschool@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Кузьминские Отвержки', 200, 'school', d.id, 'https://koschool.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ НОШ с.Ленино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Волокитина Оксана Васильевна', '+74742768448', 'lenino_school@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ НОШ с.Ленино', 200, 'school', d.id, 'https://sh-lenino.gosuslugi.ru/', '398531, Липецкая область, Липецкий район, с. Ленино, ул. Молодежная, д.123' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ д.Новая Деревня
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Татьянина Наталия Серафимовна', '+74742758235', 'new-derevnya@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ д.Новая Деревня', 200, 'school', d.id, 'https://sh-novaya-derevnya-r42.gosweb.gosuslugi.ru/', '398503 Липецкая область, Липецкий район, д. Новая Деревня, ул. Первомайская, д.9' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Новодмитриевка Липецкого муниципального района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Фирсова Галина Александровна', '+74742753285', 'n-dmitrievskaia@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Новодмитриевка Липецкого муниципального района Липецкой области', 200, 'school', d.id, 'https://sc-nd48.gosuslugi.ru/', '398550, Липецкая обл., Липецкий р-н, с. Новодмитриевка, ул. Ленина, д. 2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ имени Героя Советского Союза В.М.Игнатьева с.Пружинки
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Беляева Любовь Сергеевна', '+74742754110', 'sc-pruzhinki@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ имени Героя Советского Союза В.М.Игнатьева с.Пружинки', 200, 'school', d.id, 'https://sh48pruzhinki.gosuslugi.ru/', '398541 Липецкая область Липецкий район село Пружинки улица 50 лет Октября дом 201А' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)', 'https://sh48pruzhinki.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ с.Сенцово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лобова Ольга Анатольевна', '+74742752336', 'senchow@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Сенцово', 200, 'school', d.id, 'https://sc-sentsovo.gosuslugi.ru/', '398540, Липецкая область, Липецкий район, село Сенцово, улица 8 Марта, дом 157' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная общеобразовательная программа обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sc-sentsovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Сырское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кожевникова Галина Сергеевна', '+74742489053', 'priem@syrskoe.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Сырское', 200, 'school', d.id, 'https://syrskoe.gosuslugi.ru/', '398533, Россия, Липецкая область, Липецкий район, село Сырское, улица Ленина, д. 7' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)', 'https://syrskoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)', 'https://syrskoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Сухая Лубна имени Мозгунова А.З.
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Орлова Лариса Ивановна', '+74742755537', 'lubna48@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Сухая Лубна имени Мозгунова А.З.', 200, 'school', d.id, 'https://sh-lubna48.gosuslugi.ru/', 'Липецкая область, Липецкий район, село Сухая Лубна, улица Советская, дом 23а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями)', 'https://sh-lubna48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Троицкое им. Героя Советского Союза М.Д.Карасёва
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пашенцева Светлана Ивановна', '+74742759735', 'sch_troiz@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Троицкое им. Героя Советского Союза М.Д.Карасёва', 200, 'school', d.id, 'https://sctroickoe.gosuslugi.ru/', '398530 Липецкая область, Липецкий округ, с. Троицкое, ул. Гагарина, д.78' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с РАС с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), ТМНР (вариант 8.4)', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) 1 – 9 классы', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития 10 – 12 классы (вариант 2)', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа обучающихся с умеренной, тяжелой глубокой, умственной отсталостью (интеллектуальными нарушениями), ТМНР с расстройствами аутистического спектра (вариант 2)', 'https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Хрушевка Липецкого муниципального округа
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попова Лариса Ивановна', '+74742768437', 'sc-hruschevka@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Хрушевка Липецкого муниципального округа', 200, 'school', d.id, 'https://hruschevka48.gosuslugi.ru/', '398532, Липецкая область, Липецкий район, с. Хрущевка, ул. Титова, д. 79' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СШ с.Частая Дубрава имени Героя Советского Союза Е.А. Дьяконова
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Поленникова Людмила Анатольевна', '+74742753744', 'schoolhd@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ с.Частая Дубрава имени Героя Советского Союза Е.А. Дьяконова', 200, 'school', d.id, 'https://sh-chastaya-dubrava-r42.gosweb.gosuslugi.ru/', '398513, Россия, Липецкая область, Липецкий район ул. Московская, 13а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Чебурашка» с.Боринское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кудаева Юлия Павловна', '+74742761116', 'borinosad@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Чебурашка» с.Боринское', 200, 'preschool', d.id, 'https://ds-cheburashka-r42.gosweb.gosuslugi.ru/', '398510 Липецкая область Липецкий район с. Боринское, ул. Салтыкова - Щедрина, д.38' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Липка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Стюфляева Елена Витальевна', '+74742756070', 'doulipka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Липка»', 200, 'preschool', d.id, 'https://dslipka.gosuslugi.ru/', '398507, Липецкая область Липецкий район, село Ильино, Новая улица, 2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей – инвалидов и детей с ОВЗ муниципального бюджетного дошкольного образовательного учреждения детский сад "Липка" села Ильино Липецкого муниципального округа', 'https://dslipka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Ромашка» д.Новая Деревня
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Гурьева Людмила Важевна', '+74742758281', 'romashkalip48@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Ромашка» д.Новая Деревня', 200, 'preschool', d.id, 'https://ds-romashka-r42.gosweb.gosuslugi.ru/', '398503, Липецкая область, Липецкий район, д. Новая Деревня, ул. Первомайская, д. 8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» с.Сенцово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Перфилова Татьяна Александровна', '+74742752393', 'mbdousolnyschko@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Сенцово', 200, 'preschool', d.id, 'https://ds-solsen.gosuslugi.ru/', 'Липецкая область, Липецкий район, село Сенцово, ул.70 лет Октября, дом 1Б' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Ручеек» с.Троицкое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Малютина Оксана Павловна', '+74742759441', 'rucheek.18@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Ручеек» с.Троицкое', 200, 'preschool', d.id, 'https://ds-rucheek-r42.gosweb.gosuslugi.ru/', '398530 Липецкая область, Липецкий район, с. Троицкое, ул. Октябрьская, д.30' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Пчелка» с.Частая Дубрава Липецкого муниципального округа
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Скуридина Татьяна Валерьевна', '+74742753674', 'ya.mbdoupshelka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Пчелка» с.Частая Дубрава Липецкого муниципального округа', 200, 'preschool', d.id, 'https://ds-pchelka-r42.gosweb.gosuslugi.ru/', '398513, Россия, Липецкая область, Липецкий район с. Частая Дубрава ул. Московская, 7а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАДОУ детский сад «Петушок» д.Копцевы Хутора
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Борис Оксана Вячеславовна', '+74742766548', 'mbdou.petushok@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ детский сад «Петушок» д.Копцевы Хутора', 200, 'preschool', d.id, 'https://ds-petushok-r42.gosweb.gosuslugi.ru/', '398501 Липецкая область, Липецкий район, д. Копцевы Хутора, ул. Котовского, д. 1а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа с ТНР', 'https://ds-petushok-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ «СШ с.Становое»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Алисова Любовь Михайловна', '+74747621465', 'stanovoeschool@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СШ с.Становое»', 201, 'school', d.id, 'https://scstanovoe.gosuslugi.ru/', '399710 Липецкая область, Становлянский округ, с. Становое, ул. Советская, д. 89' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «ОШ с.Грунин Воргол»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попов Петр Васильевич', '+74747621638', 'imzstanovoe48@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «ОШ с.Грунин Воргол»', 201, 'school', d.id, 'https://sh-gruninskaya-r42.gosweb.gosuslugi.ru/', '399721 Липецкая область, Становлянский район, с. Грунин Воргол, ул. Советская, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «СШ с.Ламское»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Руднева Анна Васильевна', '+74747624269', 'info044@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СШ с.Ламское»', 201, 'school', d.id, 'https://sh-lamskaya-r42.gosweb.gosuslugi.ru/', '399704, Российская Федерация, Липецкая область, Становлянский округ, село Ламское, улица Школьная, дом 2' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)', 'https://sh-lamskaya-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ «СШ с.Толстая Дубрава»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Огнева Ирина Ивановна', '+74747628344', 'sekretar186@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СШ с.Толстая Дубрава»', 201, 'school', d.id, 'https://sh-tolstodubravskaya-r42.gosweb.gosuslugi.ru/', 'Россия, 399702, Липецкая область, Становлянский округ, с. Толстая Дубрава, ул. 40 лет Победы, д. 5' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «СШ с.Тростное»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ктоян Анжела Кимиковна', '+74747627560', 'stan22trostnoe@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СШ с.Тростное»', 201, 'school', d.id, 'https://sh-trostnovskaya-r42.gosweb.gosuslugi.ru/', '399716, Липецкая область, Становлянский район, с.Тростное, ул.Центральная д.34' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Сказка» с.Становое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лаухина Татьяна Алексеевна', '+74747622825', 'ckazkacad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Сказка» с.Становое', 201, 'preschool', d.id, 'https://ds-skazka-r42.gosweb.gosuslugi.ru/', '399722, Липецкая обл., Становлянский округ, с. Становое, ул. Ватутина, д.24; 399722 Липецкая область становлянский округ, пос.Дружба 1Б' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Теремок» с.Становое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Малютина Светлана Алексеевна', '+74747622826', 'dsteremokstanovoe@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Теремок» с.Становое', 201, 'preschool', d.id, 'https://dsteremokstanovoe.gosuslugi.ru/', '399710, Липецкая обл., Становлянский район, с. Становое, ул Советская, д.33' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с расстройством аутистического спектра (РАС)', 'https://dsteremokstanovoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ «Светлячок» с.Ламское)
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шубина Татьяна Васильевна', '+74747624166', 'lamskoembdou@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Светлячок» с.Ламское)', 201, 'preschool', d.id, 'https://ds-svetlyachok-lamskoe-r42.gosweb.gosuslugi.ru/', '399704, Липецкая область, Становлянский округ, с. Ламское, ул. Победы, д. 5' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Дубравушка» с.Толстая Дубрава
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дятлова Наталья Николаевна', '+74747628222', 'dybravychkasad@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Дубравушка» с.Толстая Дубрава', 201, 'preschool', d.id, 'https://dubravushkasad-48.gosuslugi.ru/', '399702, РФ, Липецкая область, Становлянский округ, село Толстая Дубрава, улица Центральная, д 34' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Малыш» с.Тростное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пиндюрина Елена Олеговна', '+74747627531', 'malysch.detskiisad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Малыш» с.Тростное', 201, 'preschool', d.id, 'https://dstrostnoe.gosuslugi.ru/', '399716, Липецкая область, Становлянский район, село Тростное, Центральная ул, д. 10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Мещерский»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кочетова Нина Сергеевна', '+74747626143', 'nin4kochetova@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Мещерский»', 201, 'preschool', d.id, 'https://ds-meshherskij-barsukovo-r42.gosweb.gosuslugi.ru/', '399707, Липецкая область, Становлянский округ, деревня Барсуково, улица Ленина, дом 18' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Родничок» с.Берёзовка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Серёгина Ирина Евгеньевна', '+74747627702', 'dsrodnichok@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Родничок» с.Берёзовка', 201, 'preschool', d.id, 'https://ds-rodnichok-beryozovka-r42.gosweb.gosuslugi.ru/', '399708, Липецкая область, Становлянский округ, с. Берёзовка, ул. Ю. Тарасова, д.17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» с.Дмитриевка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Антонова Елена Владимировна', '+74747627678', 'dmitrievkasad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» с.Дмитриевка', 201, 'preschool', d.id, 'https://ds-solnyshko-dmitrievka-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Колобок» с.Кириллово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Батанова Татьяна Сергеевна', '+74747628746', 'kirillovo-detsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Колобок» с.Кириллово', 201, 'preschool', d.id, 'https://kirillovodetsad.gosuslugi.ru/', '399713, Российская Федерация, Липецкая область, Становлянский округ, село Кириллово, улица Центральная, дом.11' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Ёлочка» д.Лукьяновка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Панченкова Светлана Николаевна', '+74747628149', 'elka@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Ёлочка» д.Лукьяновка', 201, 'preschool', d.id, 'https://ds-elochka-stan.gosuslugi.ru/', '399700, Липецкая обл., Становлянский округ, д. Лукьяновка, ул Парковая, д.17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Теремок» с.Пальна - Михайловка Становлянского муниципального округа Липецкой области (МБДОУ детский сад «Теремок» с.Пальна-Михайловка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Бурцева Ольга Николаевна', '+74747627333', 'teremok_pm@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Теремок» с.Пальна - Михайловка Становлянского муниципального округа Липецкой области (МБДОУ детский сад «Теремок» с.Пальна-Михайловка', 201, 'preschool', d.id, 'https://ds-teremok-palnamixajlovka-r42.gosweb.gosuslugi.ru/', '399732, Липецкая область, Становлянский округ, с.Пальна-Михайловка, ул.Молодёжная, дом 15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «Ягодка» с.Чернолес
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Прилепская Ольга Викторовна', '+74747626718', 'jagodka.sad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «Ягодка» с.Чернолес', 201, 'preschool', d.id, 'https://ds-yagodka-chernoles-r42.gosweb.gosuslugi.ru/', '399725 Липецкая область, Становлянский округ, с.Чернолес, ул.Центральная, д.18' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Тербуны
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Моргачева Татьяна Николаевна', '+74747429963', 'sc-terbuny@scools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Тербуны', 202, 'school', d.id, 'https://sc-terbuny.gosuslugi.ru/', NULL FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sc-terbuny.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Вторые Тербуны
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Антипов Сергей Александрович', '+74747428185', 'morozov_serg73@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Вторые Тербуны', 197, 'school', d.id, 'https://terbuny2sch.gosuslugi.ru/', '399551, Липецкая область, Тербунский район, с. Вторые Тербуны, ул. Советская. д.37' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МАДОУ детский сад «Солнышко»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Хромых Вера Владимировна', '+74747422740', 'detskiysads@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ детский сад «Солнышко»', 197, 'preschool', d.id, 'https://dssolnyshkoterbuny.gosuslugi.ru/', 'Россия, 399540, Липецкая область, Тербунский район, с. Тербуны, ул. Мира д.3' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Колокольчик»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Караваева Оксана Николаевна', '+74747422661', 'dskolokolchik1967@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Колокольчик»', 197, 'preschool', d.id, 'https://dskolocolchikterbuny.gosuslugi.ru/', 'Россия, 399540, Липецкая область, Тербунский район, с. Тербуны, ул. Коммунальная д.15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Ромашка»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сенюкова Ольга Васильевна', '+74747421436', 'sieniukova77@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Ромашка»', 197, 'preschool', d.id, 'https://romashka48.gosuslugi.ru/', '399 540 Липецкая область, Тербунский район, село Тербуны, ул. Куйбышева, д. 22' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ лицей №1 г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Инна Анатольевна Шепелева', '+74747221138', 'usmsch01@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ лицей №1 г.Усмани', 203, 'school', d.id, 'https://lic1-usman-r42.gosweb.gosuslugi.ru/', '399370 Липецкая область г. Усмань ул. Чернышевского, 118' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №2 г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Прибыткова Галина Андреевна', '+74747223041', '46nadehda@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №2 г.Усмани', 203, 'school', d.id, 'https://sh2-usman-r42.gosweb.gosuslugi.ru/', '399370, Липецкая область, г. Усмань, ул. Радищева, д.50' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования слабовидящих обучающихся (вариант 4.2)', 'https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.2)', 'https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) вариант 1', 'https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)', 'https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ №3 г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Шарапова Надежда Ивановна', '+74747221752', 'uschool03@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №3 г.Усмани', 203, 'school', d.id, 'https://uschool3.gosuslugi.ru/', '399370, Липецкая область, г.Усмань, ул.Шмидта, д.15' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)', 'https://uschool3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://uschool3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ села Девица
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Аринович Владислав Николаевич', '+74747234645', 'devitsa@shcool48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ села Девица', 203, 'school', d.id, 'https://sh-devickaya-r42.gosweb.gosuslugi.ru/', '399361 Липецкая обл., Усманский р-он, с.Девица, ул. Молодежная, д.№6' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ ст.Дрязги
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Петреева Римма Серафимовна', NULL, 'drzschl@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ ст.Дрязги', 203, 'school', d.id, 'https://sc-dryazgi.gosuslugi.ru/', '399330, Липецкая область, Усманский район, ж/д ст.Дрязги, ул. Советская, д.38' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями), с тяжелыми нарушениями речи (вариант 5.2)', 'https://sc-dryazgi.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Завальное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попова Наталия Викторовна', '+74747221044', 'rono@usman.lipetsk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Завальное', 203, 'school', d.id, 'https://zavshkola.gosuslugi.ru/', '399346 Липецкая область, Усманский район, с.Завальное, ул.Школьная 147' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа для обучающихся с УО (интеллектуальными нарушениями) (вариант 1)', 'https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа для обучающихся с УО (интеллектуальными нарушениями) (вариант 2)', 'https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная образовательная программа начального общего образования для обучающихся с РАС (вариант 8.4)', 'https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Октябрьское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Аксенов Владимир Николаевич', '+74747235293', 'mbousosh2012@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Октябрьское', 203, 'school', d.id, 'https://sh-oktyabrskoye.gosuslugi.ru/', '399331 Липецкая область Усманский район с. Октябрьское ул. Базарная, д.1' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная образовательная программа обучающихся с интеллектуальными нарушениями', 'https://sh-oktyabrskoye.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Сторожевое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Коровина Татьяна Сергеевна', '+74747229332', 'shcoolst@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Сторожевое', 203, 'school', d.id, 'https://sh-storozhevoe-r42.gosweb.gosuslugi.ru/', 'З99344, Липецкая область, Усманский район, с. Сторожевое, ул. Школьная, д.46' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Никольское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Киселева Ольга Валентиновна', '+74747239426', 'sc-nikolskoe@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Никольское', 203, 'school', d.id, 'https://sh-nikolskaya-r42.gosweb.gosuslugi.ru/', '399350, Липецкая область, Усманский район, с. Никольское, ул.Советская, 79' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ «ЦРР – д/с «Сказка» г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Глушкова Татьяна Серафимовна', '+74747222049', 'ms.detsadskazka@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ «ЦРР – д/с «Сказка» г.Усмани', 203, 'preschool', d.id, 'https://ds-skazka-usman-r42.gosweb.gosuslugi.ru/', '399370, Липецкая область, г. Усмань, ул. Терешковой, д. 29' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР и ЗПР МБДОУ ЦРР – д/с Сказка г Усмани на 2025-2026 учебный год', 'https://ds-skazka-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Почемучка» г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сосна Людмила Александровна', '+74747223647', 'pochemuchka.usman@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Почемучка» г.Усмани', 203, 'preschool', d.id, 'https://ds-pochemuchka-usman-r42.gosweb.gosuslugi.ru/', '399370, Липецкая область, г. Усмань, ул. Ленина, 28' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи (ТНР) Муниципального бюджетного дошкольного образовательного учреждения детский сад «Почемучка» г. Усмани', 'https://ds-pochemuchka-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/#adaptirovannye-obrazovatelnye-programmy' FROM ins;

-- NEW institution: МБДОУ д/с «Теремок» г.Усмани Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Полянских Елена Юрьевна', '+74747221544', 'usmanteremok@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Теремок» г.Усмани Липецкой области', 203, 'preschool', d.id, 'https://ds-teremok-usman-r42.gosweb.gosuslugi.ru/', '399370 Липецкая область г.Усмань улица Ленина дом 65' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://ds-teremok-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д\с «Журавлёнок» г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Жданова Наталия Владимировна', '+74747222543', 'natalia022012@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д\с «Журавлёнок» г.Усмани', 203, 'preschool', d.id, 'https://ds-zhuravlyonok48.gosuslugi.ru/', 'Липецкая область, г.Усмань, ул.Шмидта, д.2' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Радуга» г.Усмань
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Перова Елена Николаевна', '+74747243045', 'rad.usman@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Радуга» г.Усмань', 203, 'preschool', d.id, 'https://ds-raduga-usman-r42.gosweb.gosuslugi.ru/', 'Липецкая область г. Усмань ул. Воздвиженская д. 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Непоседа» г.Усмани
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Журавлева Вера Ивановна', '+74747241812', 'neposeda-us@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Непоседа» г.Усмани', 203, 'preschool', d.id, 'https://ds-neposeda-usman-r42.gosweb.gosuslugi.ru/', '399341, Липецкая область, Усманский район, город Усмань, улица Матросова, дом 39' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Родничок» с.Девица
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кондрашина Татьяна Николаевна', '+74747234748', 'rodnichok-devitsa@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Родничок» с.Девица', 203, 'preschool', d.id, 'https://ds-rodnichok-devica-r42.gosweb.gosuslugi.ru/', 'Липецкая область Усманский район село Девица улица Советская д 27' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Колобок» с.Завальное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Невзорова Светлана Владимировна', '+74747225595', 'kolobokzavalnoe@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Колобок» с.Завальное', 203, 'preschool', d.id, 'https://ds-kolobok-zavalnoe-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Усманский район, с. Завальное, ул. Ленина, 54' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Тополёк» с.Октябрьское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Китаева Лариса Петровна', '+74747235287', 'dou-topol@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Тополёк» с.Октябрьское', 203, 'preschool', d.id, 'https://ds-topolek-oktyabrskoe-r42.gosweb.gosuslugi.ru/', '399331, Липецкая область, Усманский район с. Октябрьское, проспект Революции, дом 91а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Березка» с.Сторожевое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Иванова Татьяна Владимировна', '+74747229312', 'bereska-usm@rambler.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Березка» с.Сторожевое', 203, 'preschool', d.id, 'https://ds-berezka-storozhevoe-r42.gosweb.gosuslugi.ru/', '399 344, Липецкая обл., Усманский р-он, с.Сторожевое, ул.Школьная д.47' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Мальвинка» с.Никольское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мешкова Елена Николаевна', '+74747239351', 'mbdou-malvinka2013@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Мальвинка» с.Никольское', 203, 'preschool', d.id, 'https://ds-malvinka-nikolskoe-r42.gosweb.gosuslugi.ru/', '399350 Липецкая область, Усманский район, с.Никольское, ул. Чапаева, д.45' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ ООШ с.Поддубровка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Никонов Александр Владимирович', '+74747226723', 'podd_zam@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ ООШ с.Поддубровка', 203, 'preschool', d.id, 'https://beresschkola.gosuslugi.ru/', '399351, Липецкая область, Усманский район, с. Поддубровка, ул. Школьная, д. 31.; 399367 Липецкая область Усманский район, с. Березняговка, ул. Ворошилова, д.103' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sh-poddubr-oosch.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с лёгкой умственной отсталостью (вариант 1)', 'https://beresschkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ д/с «Колокольчик» с.Березняговка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Горина Нина Валентиновна', '+74747233846', 'nina.gorina.59@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Колокольчик» с.Березняговка', 203, 'preschool', d.id, 'https://ds-kolokolchik-bereznyagovka-r42.gosweb.gosuslugi.ru/', '399367 Липецкая область, Усманский район, с.Березняговка, улица Ворошилова. дом 104' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Василек» с.Грачевка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Якимова Галина Васильевна', '+74747225381', 'jkimova69@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Василек» с.Грачевка', 203, 'preschool', d.id, 'https://ds-vasilek-grachevka-r42.gosweb.gosuslugi.ru/', '399366 Липецкая область Усманский район с. Грачевка ул. Советская д. 43' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Ручеёк»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Косых Марина Владимировна', '+74747236918', 'marina.kosykh.68@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Ручеёк»', 203, 'preschool', d.id, 'https://ds-rucheyok-dmitrievka-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Усманский район, с.Дмитриевка, улица Молодежная, д.17 а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Буратино» с.Крутченская Байгора
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Быханова Надежда Владимировна', '+74747233845', 'byhanovanadezhda75@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Буратино» с.Крутченская Байгора', 203, 'preschool', d.id, 'https://ds-buratino-krutchenskaya-bajgora-r42.gosweb.gosuslugi.ru/', '399363, Липецкая область, Усманский район, с.Крутченская Байгора, ул. Центральная, д.17а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Берёзка» с.Новоуглянка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Асташова Наталия Владимировна', '+74747237153', 'nataliya.astashova@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Берёзка» с.Новоуглянка', 203, 'preschool', d.id, 'https://ds-beryozka-usman-r42.gosweb.gosuslugi.ru/', '399360 Липецкая область, Усманский район, с.Новоуглянка, ул.Дзержинского, дом 10' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Искорка» с.Пригородка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Безрядина Елена Михайловна', '+74747231137', 'lena.bezryadina.82@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Искорка» с.Пригородка', 203, 'preschool', d.id, 'https://ds-iskorka-prigorodka.gosuslugi.ru/', '399371 Липецкая область, Усманский район, с. Пригородка, ул. Юбилейная, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Колосок» пос. совхоза «Ударник»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Самойлова Ирина Александровна', '+74747234317', 'kolosok-2013@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Колосок» пос. совхоза «Ударник»', 203, 'preschool', d.id, 'https://ds-kolosok-udarnik-r42.gosweb.gosuslugi.ru/', '399345 Липецкая область Усманский район пос. совхоза "Ударник" ул. Молодёжная д.15' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Аистёнок» с.Стрелецкие Хутора
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Татьяна Дмитриевна Щеглова', '+74747234110', 'tatiana-shcheglova@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Аистёнок» с.Стрелецкие Хутора', 203, 'preschool', d.id, 'https://ds-aistyonok-strelcy.gosuslugi.ru/', '399371, Липецкая обл., Усманский р-он, с. Стрелецкие Хутора, ул. Г. Телегина, 160а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «Лицей села Хлевное»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пожидаев Сергей Александрович', '+74747721895', 'hlevnoeschool@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Лицей села Хлевное»', 204, 'school', d.id, 'https://hlevnoeschool.gosuslugi.ru/', '399260, Липецкая область, Хлевенский район, село Хлевное, ул. Свободы, д.52' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования МБОУ «Лицей села Хлевное» обучающихся с умственной отсталостью (интеллектуальными нарушениями)', 'https://hlevnoeschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СОШ с.Дмитряшевка (МБОУ СОШ С.Дмитряшевка Хлевенского Муниципального района Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дедов Сергей Александрович', '+74747738201', 'sc-dmitr@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Дмитряшевка (МБОУ СОШ С.Дмитряшевка Хлевенского Муниципального района Липецкой области', 204, 'school', d.id, NULL, '399250, Липецкая область, Хлевенский район, с.Дмитряшевка, ул.Октябрьская, д.64' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)', 'https://sh-dmitryashevka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ «СОШ с.Конь-Колодезь»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Тамбовцев Вячеслав Владимирович', '+74747735124', 'sc-kkolodez@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СОШ с.Конь-Колодезь»', 204, 'school', d.id, 'https://sh-konkolodez-r42.gosweb.gosuslugi.ru/', NULL FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «СОШ с.Новое Дубовое»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Болотов Сергей Анатольевич', '+74747730210', 'sc-ndubovoe@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СОШ с.Новое Дубовое»', 204, 'school', d.id, 'https://sh-novoe-dubovoe-r42.gosweb.gosuslugi.ru/', 'Липецкая область, Хлевенский район, село Новое Дубовое, улица Советская, дом 80.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Елецкая Лозовка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Воронина Светлана Ивановна', '+74747731187', 'sc-ellozovka@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Елецкая Лозовка', 204, 'school', d.id, 'https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/', '399263, Липецкая область, Хлевенский район, с. Елецкая Лозовка, ул. Выгонскя-Буторина, д. 20' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 7.2.)', 'https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)', 'https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МАДОУ д/с с.Хлевное
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Плотникова Наталья Николаевна', '+74747722072', 'sadhlevnoe@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ д/с с.Хлевное', 204, 'preschool', d.id, 'https://dshlevnoe48.gosuslugi.ru/', '399260, Липецкая область, Хлевенский район, с. Хлевное, ул. Ленинская д. 10а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Родничок» с.Конь-Колодезь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Татаринцева Елена Владимировна', '+74747735192', 'sadik.kon@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Родничок» с.Конь-Колодезь', 204, 'preschool', d.id, 'https://ds-rodnichok-konkolodez-r42.gosweb.gosuslugi.ru/', '399281 Российская Федерация, Липецкая область, Хлевенский район, село Конь-Колодезь, улица Берёзовая аллея, дом 30' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Федеральна адаптированная образовательная программа дошкольного образования для обучающихся с ограниченными возможностями здоровья', 'https://ds-rodnichok-konkolodez-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_97.html' FROM ins;

-- NEW institution: МБДОУ д/с «Аистёнок» с.Елец-Маланино
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Щербатых Татьяна Георгиевна', '+74747741284', 'mbdoudetsade-malanino@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Аистёнок» с.Елец-Маланино', 204, 'preschool', d.id, 'https://ds-aistyonok-elecmalanino-r42.gosweb.gosuslugi.ru/', '399265 Липецкая область Хлевенский район село Елец-Маланино улица Дорожная дом 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад «Солнышко» села Воробьевка
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Светлана Васильевна Кохан', '+74747733276', 'vobsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Солнышко» села Воробьевка', 204, 'preschool', d.id, 'https://ds-solnyshko-vorobevka-r42.gosweb.gosuslugi.ru/', '399270 Липецкая область Хлевенский район с. Воробьевка ул. Мира дом 4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ д/с «Подрастай-ка!» с.Верхняя Колыбелька
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Каменева Елена Александровна', '+74747740141', 'sadverhn@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ д/с «Подрастай-ка!» с.Верхняя Колыбелька', 204, 'preschool', d.id, 'https://ds-podrastajka-verxnyaya-kolybelka-r42.gosweb.gosuslugi.ru/', '399268 Липецкая область Хлевенский район с. Верхняя Колыбелька ул. Молодежная д.46' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ гимназия «Новое поколение» города Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Красненкова Светлана Алексеевна', '+74747125830', '2zadonsk@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ гимназия «Новое поколение» города Задонска', 195, 'school', d.id, 'https://novoepokolenie.gosuslugi.ru/', 'Липецкая область, Задонский район, город Задонск, улица В.Севастьянова, дом 3' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ гимназия №1 г.Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Первеева Лариса Николаевна', '+74747126499', 'schkool1@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ гимназия №1 г.Задонска', 195, 'school', d.id, 'https://gymnasium1zd.gosuslugi.ru/', '399200 Липецкая область, город Задонск, ул.Свободы 57а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Донское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Селищева Людмила Анатольевна', '+74747133453', 'sc-donskoe@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Донское', 195, 'school', d.id, 'https://doschool.gosuslugi.ru/', '399240, Липецкая область, Задонский район, с. Донское, ул. Новая, д. 1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Ольшанец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Звягина Татьяна Николаевна', '+74747142221', 'sc-olshanets@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Ольшанец', 195, 'school', d.id, 'https://sc-olshanets.gosuslugi.ru/', 'Россия, 399222, Липецкая область, Задонский район, пос. Освобождение, ул. Школьная, д. 6' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа начального общего образования (для 1-4 классов)', 'https://scolshanets.gosuslugi.ru/netcat_files/33/46/AOOP_UO_IN_kopiya.pdf' FROM ins;

-- NEW institution: МБОУ СОШ с.Паниковец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Белокопытова Ирина Викторовна', '+74747147212', 'panicovec@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Паниковец', 195, 'school', d.id, 'https://panikovets.gosuslugi.ru/', 'Липецкая область, Задонский район, с. Пани́ковец, ул. Запрудная, д. 18.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа для обучающихся с интеллектуальными нарушениями', 'https://panikovets.gosuslugi.ru/netcat_files/68/2854/Adaptirovannaya_programma_.pdf' FROM ins;

-- NEW institution: МБОУ СОШ с.Гнилуша
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лысых Алексей Михайлович', '+74747151238', 'sc-gnilusha@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Гнилуша', 195, 'school', d.id, 'https://gnilusha.gosuslugi.ru/', 'Липецкая область, Задонский район, с Гнилуша, ул. Советская д. 84' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Хмелинец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Якунина Марина Леонидовна', '+74747135515', 'hmelinetc@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Хмелинец', 195, 'school', d.id, 'https://hmelinetc.gosuslugi.ru/', 'Липецкая область, Задонский район, с.Хмелинец, ул.Зыкова, д.3' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад №1 г.Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Водопьянова Ольга Сергеевна', '+74747121884', 'ds1zadonsk@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №1 г.Задонска', 195, 'preschool', d.id, 'https://ds1zadonsk.gosuslugi.ru/', '399200 Липецкая область г. Задонск ул. К.Маркса д.56 "А"' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад №3 г.Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Афансаьева Сайрагул', '+74747121445', 'zadonsk-detsad3@bk.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №3 г.Задонска', 195, 'preschool', d.id, 'https://ds3zadonsk.gosuslugi.ru/', '399200, Липецкая область, г. Задонск, ул. М Горькогод.5.Адрес' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад №5 г.Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Коптева Светлана Николаевна', '+74747126077', 'detskysad.5@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №5 г.Задонска', 195, 'preschool', d.id, 'https://ds5zadonsk.gosuslugi.ru/', '399200 Липецкая обл., г. Задонск, ул. Свободы, д. 38 "а"' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад №6 «Сказка» г.Задонска
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Широбокова Елена Николаевна', '+74747121112', 'ds6zadonsk.detskijsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №6 «Сказка» г.Задонска', 195, 'preschool', d.id, 'https://ds6zadonsk.gosuslugi.ru/', '399200, Липецкая область, г.Задонск, ул.Советская д.48' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная ОП 2025-2026 уч.год', 'https://ds6zadonsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-op-2025-2026-uchgod.html' FROM ins;

-- NEW institution: МБДОУ детский сад «Непоседы» с.Бутырки
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Архипова Нина Алексеевна', '+74747121303', 'butyrki.detsad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Непоседы» с.Бутырки', 195, 'preschool', d.id, 'https://butirki11.gosuslugi.ru/', 'Липецкая область, Задонский район, улица Рабочая, дом 11' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Кашары
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Варфоломеева Анна Владимировна', '+74747143245', 'detskisad.kashari@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Кашары', 195, 'preschool', d.id, 'https://ds-kashari48.gosuslugi.ru/', 'Липецкая область Задонский район с.Кашары ул. Рабочая д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- SKIP no contact for 'МБДОУ детский сад с.Уткино'
-- NEW institution: МБДОУ детский сад с.Болховское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Скирда Ирина Николаевна', '+74747132289', 'bolxovskoesad@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Болховское', 195, 'preschool', d.id, 'https://dsbolxovskoe.gosuslugi.ru/', '399241, Липецкая область, Задонский район, с. Болховское, ул. Центральная, д.30' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Гнилуша
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чарикова Наталья Дмитриевна', '+74747151440', 'gnilushadetsad5@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Гнилуша', 195, 'preschool', d.id, 'https://gnilusha-detsad.gosuslugi.ru/', '399214, Липецкая область, Задонский район, с.Гнилуша, ул.Ленина, д.44' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Донское
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кареньких Ираида Ивановна', '+74747133152', 'detsadik48@gmail.com') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Донское', 195, 'preschool', d.id, 'https://donskoe-detsad.gosuslugi.ru/', '399240 Липецкая область Задонский район с.Донское ул.Гагарина д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Ольшанец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Руднева Инна Александровна', '+74747142274', NULL) RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Ольшанец', 195, 'preschool', d.id, 'https://ds-olshanec.gosuslugi.ru/', '399222, Липецкая область, Задонский район, п. Освобождение, ул. Школьная, д.9' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Репец Задонского муниципального района
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Пашенцева Ирина Валерьевна', '+74747136222', 'dsrepets@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Репец Задонского муниципального района', 195, 'preschool', d.id, 'https://ds-repets.gosuslugi.ru/', 'Липецкая область, Задонский район, с.Репец, ул.Павлова, д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Паниковец
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Дмитриева Галина Владимировна', '+74747147290', 'dspanikowets@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Паниковец', 195, 'preschool', d.id, 'https://dspanikowets.gosuslugi.ru/', '399205, Липецкая область, Задонский район, с.Паниковец, ул.Запрудная, д.4' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад с.Скорняково
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ширяева Валентина Тихоновна', '+74747148255', 'ds-skornykovo.shiryaeva2016@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад с.Скорняково', 195, 'preschool', d.id, 'https://dsskornyakovo.gosuslugi.ru/', '399231, Липецкая обл, р-н Задонский, с Скорняково, ул. Центральная, д.11' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ «Гимназия №1 имени Н.И. Борцова» г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Селезнева Ольга Николаевна', '+74746652125', 'sc1leb@schools48.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «Гимназия №1 имени Н.И. Борцова» г.Лебедянь', 198, 'school', d.id, 'https://gimn1lebedyan.gosuslugi.ru/', '399610 Липецкая область, г.Лебедянь, ул. Антонова, дом 14' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ «Гимназия №1 имени Н.И.Борцова» города Лебедянь - 9 лет', 'https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2) - 4 года', 'https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins
UNION ALL
SELECT id, 'Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития - 5 лет', 'https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ СШ №2 г.Лебедяни
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Афанасова Ольга Владимировна', '+74742370218', 'fnv.63@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СШ №2 г.Лебедяни', 198, 'school', d.id, 'https://sh2-lebedyan.gosuslugi.ru/', '399610, Липецкая область, Лебедянский район, город Лебедянь, улица Средняя, здание 29' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ №3 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Хрусталева Елена Николаевна', '+74746664066', 'lebsosch3@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ №3 г.Лебедянь', 198, 'school', d.id, 'https://sc3lebedyan.gosuslugi.ru/', '399611, Липецкая область, Лебедянский район, город Лебедянь, Школьная ул., д. 17' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ п.свх. Агроном
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Солдатова Елена Николаевна', '+74746692395', 'sch.agr@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ п.свх. Агроном', 198, 'school', d.id, 'https://schagronom.gosuslugi.ru/', '399621 Липецкая область, Лебедянский район, п.свх. Агроном, ул. Школьная, д.1' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБОУ СОШ с.Куймань
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Еремин Сергей Михайлович', '+74746691231', 'kuiman@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Куймань', 198, 'school', d.id, 'https://shkuyman.gosuslugi.ru/', '399642 Липецкая область, Лебедянский район, с. Куймань, ул. Школьная, д. 15б' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа образования детей с умственной отсталостью (интеллектуальными нарушениями)', 'https://shkuyman.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБОУ «СОШ с.Ольховец»
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Масякина Елена Юрьевна', '+74746644153', 'masykina-lena@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ «СОШ с.Ольховец»', 198, 'school', d.id, 'https://scolhov.gosuslugi.ru/', '399628, Липецкая область, Лебедянский район, с. Ольховец, ул. Церквянка, д.110в' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с умственной отсталостью 1 вариант', 'https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_105.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с умственной отсталостью 2 вариант', 'https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_106.html' FROM ins
UNION ALL
SELECT id, 'АООП НОО для обучающихся с ЗПР', 'https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_107.html' FROM ins;

-- NEW institution: МБОУ СОШ с.Большое Попово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Миляева Ирина Александровна', '+74746693351', 'irina.milyaeva.72@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Большое Попово', 198, 'school', d.id, 'https://shbpopovo.gosuslugi.ru/', '399 645 Липецкая область Лебедянский район п. Сахарного Завода ул. Октябрьская д. № 5а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) ВАРИАНТ 1', 'https://shbpopovo.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/AOOP/AOOP_variant_1.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) ВАРИАНТ 2', 'https://shbpopovo.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/AOOP/AOOP_VARIANT_2.pdf' FROM ins;

-- NEW institution: МБОУ СОШ с.Мокрое
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Ступина Лариса Ильинична', '+74746632362', 'stupina.lara2016@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБОУ СОШ с.Мокрое', 198, 'school', d.id, 'https://shmokroe.gosuslugi.ru/', '399635 Липецкая область Лебедянский район с. Мокрое ул. Строителей д.82' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями)', 'https://shmokroe.gosuslugi.ru/netcat_files/68/1859/Adaptirovannaya_programma_1.pdf' FROM ins;

-- NEW institution: МБДОУ детский сад №1 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Мария Александровна Оруджева', '+74746652060', 'mbdouds-1@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №1 г.Лебедянь', 198, 'preschool', d.id, 'https://ds1lebedyan.gosuslugi.ru/', '399610 Липецкая обл., г. Лебедянь, ул. Победы, д. 13 А' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад комбинированного вида №2 г.Лебедянь Липецкой области
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Скакун Татьяна Павловна', '+74746655115', 'ds2lebed@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад комбинированного вида №2 г.Лебедянь Липецкой области', 198, 'preschool', d.id, 'https://ds2lebed.gosuslugi.ru/', '399613 Липецкая область, г.Лебедянь, ул. Советская, д. 76' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа для детей с ЗПР', 'https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-zpr-na-2024-2024-uchg.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с УО', 'https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-uo-na-2024-2024-uchg.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с ТНР', 'https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr-na-2024-2024-uchg.html' FROM ins;

-- NEW institution: МБДОУ детский сад комбинированного вида №3 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Жданова Оксана Алексеевна', '+74746664846', 'lebds@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад комбинированного вида №3 г.Лебедянь', 198, 'preschool', d.id, 'https://lebds3.gosuslugi.ru/', '399611 Липецкая обл., г. Лебедянь, ул. Шоссейный проезд, д. 10' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа ЗПР на 2025-2026 учебный год.', 'https://lebds3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-zpr-na-2024-2025-uchebnyy-god.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа для детей с ТНР на 2025-2026 учебный год', 'https://lebds3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-na-2024-2025-uchebnyy-god.html' FROM ins;

-- NEW institution: МБДОУ детский сад комбинированного вида №4 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Лунева Елена Вячеславовна', '+74746664622', 'lebds4@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад комбинированного вида №4 г.Лебедянь', 198, 'preschool', d.id, 'https://lebds4k.gosuslugi.ru/', '399611 Липецкая область, г. Лебедянь, улица Машиностроителей д. 22' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР', 'https://ds-kolobok-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/162/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_detey_s_tyazhelymi_narusheniyami_rechi_na_2025_2026_uchebnyy_god_0.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития', 'https://ds-kolobok-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/162/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_detey_s_zaderzhkoy_psihicheskogo_razvitiya_na_2025_2026_uchebnyy_god_0.pdf' FROM ins;

-- NEW institution: МБДОУ детский сад №5 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Сысоева Татьяна Александровна', '+74746657591', 'mbdou-ds5@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад №5 г.Лебедянь', 198, 'preschool', d.id, 'https://ds5-lebedyan.gosuslugi.ru/', '399610, Липецкая область, г. Лебедянь, ул. Карла Маркса, д. 57' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с тяжёлым нарушением речи', 'https://ds5-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelym-narusheniem-rechi.html' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития', 'https://ds5-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya.html' FROM ins;

-- NEW institution: МБДОУ детский сад комбинированного вида №6 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чупахина Ольга Станиславовна', '+74746652552', 'lebds6@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад комбинированного вида №6 г.Лебедянь', 198, 'preschool', d.id, 'https://mbdou6leb.gosuslugi.ru/', '399610, Липецкая область, г. Лебедянь, улица Тургенева дом 7.' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи', 'https://ds6-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Uchebnyy_plan_po_AOP.pdf' FROM ins;

-- NEW institution: МАДОУ детский сад комбинированного вида №7 г.Лебедянь
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Попова Елена Анатольевна', '+74746657640', 'madouds7@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МАДОУ детский сад комбинированного вида №7 г.Лебедянь', 198, 'preschool', d.id, 'https://cheremushki-lebedyan.gosuslugi.ru/', '399612 Липецкая обл., г. Лебедянь, ул. Советской Армии д.28' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей с ТНР', 'https://ds-cheremushki-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/135/Programma_TNR_2025g.pdf' FROM ins
UNION ALL
SELECT id, 'Адаптированная образовательная программа дошкольного образования для детей детей с задержкой психического развития', 'https://cheremushki-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/' FROM ins;

-- NEW institution: МБДОУ детский сад «Ёлочка» с.Троекурово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Егармина Елена Владимировна', '+74746697184', 'aniaegarmina@yandex.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад «Ёлочка» с.Троекурово', 198, 'preschool', d.id, 'https://elochkatroekyrovo.gosuslugi.ru/', '399626 Липецкая область, Лебедянский район, ул. Садовая, д.16, д.16а' FROM d RETURNING id
)
INSERT INTO aoop_programs (institution_id, name, url)
SELECT id, 'Компенсирующая образовательная адаптированная программа', 'https://elochkatroekyrovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_91.html' FROM ins
UNION ALL
SELECT id, 'Коррекционная образовательная адаптированная программа', 'https://elochkatroekyrovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_93.html' FROM ins;

-- NEW institution: МБДОУ п.свх. Агроном
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Курочкина Анна Станиславовна', '+74746692230', 'agronom.detsad@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ п.свх. Агроном', 198, 'preschool', d.id, 'https://agronomdetsad.gosuslugi.ru/', '399621 ул. Советская, дом 18, п. свх. Агроном, Лебедянский район, Липецкой области' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ с.Докторово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Кондратьева Ангелина Анатольевна', '+74746642433', 'dsaddok@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ с.Докторово', 198, 'preschool', d.id, 'https://agronomdetsad.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/', '399648, Россия, Липецкая область, Лебедянский район, улица Набережная, дом 1А, помещение 3' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ с.Куймань
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Клевцова Оксана Александровна', '+74746691299', 'myssalina93@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ с.Куймань', 198, 'preschool', d.id, 'https://dskyiman.gosuslugi.ru/', 'Липецкая область, Лебедянский район, Село Куймань, ул Садовая, д 13.' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ с.Романово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Чертовских Татьяна Александровна', '+74746699147', 'tatjana.chertovskih@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ с.Романово', 198, 'preschool', d.id, 'https://dsromanovo.gosuslugi.ru/', '399608 с.Романово Лебедянского района Липецкой области, ул.Гусевка, д.3а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ с.Большое Попово
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Клишина Ольга Вячеславовна', '+74746693217', 'dsbpopovo@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ с.Большое Попово', 198, 'preschool', d.id, 'https://dsbpopovo.gosuslugi.ru/', '399645, Липецкая обл, Лебедянский округ, Большое Попово с, Центральная усадьба ул, 8' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- NEW institution: МБДОУ детский сад п.Сахзавода
WITH d AS (
  INSERT INTO directors (full_name, phone, email) VALUES ('Быканов Михаил Михайлович', '+74746693340', 'dssahzavoda@mail.ru') RETURNING id
), ins AS (
  INSERT INTO institutions (name, district_id, type_code, director_id, website, address) SELECT 'МБДОУ детский сад п.Сахзавода', 198, 'preschool', d.id, 'https://dssahzavod.gosuslugi.ru/', '399645, Липецкая область, Лебедянский район, поселок Сахарного Завода, ул.Октябрьская, д.1а; д.2а' FROM d RETURNING id
)
SELECT id FROM ins;  -- no AOOP

-- SKIP no contact for 'МБДОУ детский сад поселка Культура'
COMMIT;
