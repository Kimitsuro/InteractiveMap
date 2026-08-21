--
-- PostgreSQL database dump
--

\restrict vydQ7wgyv9liKZhcw1YhQViIJqbud7lotAcvs4agNUg0czXSIyNvc7F3nO2akyu

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO "user";

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON SCHEMA public IS '';


--
-- Name: normalize_inst_name(text); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.normalize_inst_name(t text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
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
$$;


ALTER FUNCTION public.normalize_inst_name(t text) OWNER TO "user";

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_log; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.action_log (
    id integer NOT NULL,
    administrator_id integer NOT NULL,
    action character varying(20) NOT NULL,
    entity character varying(50) NOT NULL,
    record_id integer,
    old_data jsonb,
    new_data jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.action_log OWNER TO "user";

--
-- Name: action_log_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.action_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.action_log_id_seq OWNER TO "user";

--
-- Name: action_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.action_log_id_seq OWNED BY public.action_log.id;


--
-- Name: administrators; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.administrators (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    full_name character varying(150) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.administrators OWNER TO "user";

--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.administrators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrators_id_seq OWNER TO "user";

--
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.administrators_id_seq OWNED BY public.administrators.id;


--
-- Name: admission_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.admission_types (
    code character varying(20) NOT NULL,
    name_ru character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.admission_types OWNER TO "user";

--
-- Name: TABLE admission_types; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.admission_types IS 'Справочник типов документов для приема';


--
-- Name: aoop_programs; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.aoop_programs (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    url character varying(500),
    CONSTRAINT check_aoop_name_not_empty CHECK ((length(TRIM(BOTH FROM name)) > 0))
);


ALTER TABLE public.aoop_programs OWNER TO "user";

--
-- Name: TABLE aoop_programs; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.aoop_programs IS 'АООП программы учреждений';


--
-- Name: aoop_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.aoop_programs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aoop_programs_id_seq OWNER TO "user";

--
-- Name: aoop_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.aoop_programs_id_seq OWNED BY public.aoop_programs.id;


--
-- Name: condition_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.condition_types (
    code character varying(50) NOT NULL,
    name_ru character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.condition_types OWNER TO "user";

--
-- Name: TABLE condition_types; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.condition_types IS 'Справочник типов особых условий обучения';


--
-- Name: directors; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.directors (
    id integer NOT NULL,
    full_name character varying(150) NOT NULL,
    phone character varying(20),
    email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_director_contact CHECK (((phone IS NOT NULL) OR (email IS NOT NULL)))
);


ALTER TABLE public.directors OWNER TO "user";

--
-- Name: TABLE directors; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.directors IS 'Директора образовательных учреждений';


--
-- Name: COLUMN directors.full_name; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON COLUMN public.directors.full_name IS 'ФИО директора';


--
-- Name: directors_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.directors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directors_id_seq OWNER TO "user";

--
-- Name: directors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.directors_id_seq OWNED BY public.directors.id;


--
-- Name: districts; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.districts (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.districts OWNER TO "user";

--
-- Name: TABLE districts; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.districts IS 'Районы Липецкой области';


--
-- Name: districts_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.districts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.districts_id_seq OWNER TO "user";

--
-- Name: districts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.districts_id_seq OWNED BY public.districts.id;


--
-- Name: institution_admission; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.institution_admission (
    institution_id integer NOT NULL,
    admission_code character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.institution_admission OWNER TO "user";

--
-- Name: TABLE institution_admission; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.institution_admission IS 'Связь учреждений с типами документов для приема';


--
-- Name: institution_conditions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.institution_conditions (
    institution_id integer NOT NULL,
    condition_code character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.institution_conditions OWNER TO "user";

--
-- Name: TABLE institution_conditions; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.institution_conditions IS 'Связь учреждений с особыми условиями обучения';


--
-- Name: institution_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.institution_types (
    code character varying(20) NOT NULL,
    name_ru character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.institution_types OWNER TO "user";

--
-- Name: TABLE institution_types; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.institution_types IS 'Справочник типов образовательных учреждений';


--
-- Name: institutions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.institutions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    district_id integer NOT NULL,
    type_code character varying(20) NOT NULL,
    director_id integer,
    description text,
    range_min numeric(3,1),
    range_max numeric(3,1),
    website character varying(500),
    aoop_url character varying(500),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    address text,
    CONSTRAINT check_name_not_empty CHECK ((length(TRIM(BOTH FROM name)) > 0)),
    CONSTRAINT check_range_valid CHECK (((range_min IS NULL) OR (range_max IS NULL) OR (range_min <= range_max)))
);


ALTER TABLE public.institutions OWNER TO "user";

--
-- Name: TABLE institutions; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON TABLE public.institutions IS 'Образовательные учреждения';


--
-- Name: COLUMN institutions.range_min; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON COLUMN public.institutions.range_min IS 'Минимум диапазона (возраст для дошкольных, класс для школ); дробные значения, напр. 1.5';


--
-- Name: COLUMN institutions.range_max; Type: COMMENT; Schema: public; Owner: user
--

COMMENT ON COLUMN public.institutions.range_max IS 'Максимум диапазона (возраст для дошкольных, класс для школ)';


--
-- Name: institutions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.institutions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institutions_id_seq OWNER TO "user";

--
-- Name: institutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.institutions_id_seq OWNED BY public.institutions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.schema_migrations (
    filename character varying(255) NOT NULL,
    applied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.schema_migrations OWNER TO "user";

--
-- Name: action_log id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.action_log ALTER COLUMN id SET DEFAULT nextval('public.action_log_id_seq'::regclass);


--
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.administrators ALTER COLUMN id SET DEFAULT nextval('public.administrators_id_seq'::regclass);


--
-- Name: aoop_programs id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.aoop_programs ALTER COLUMN id SET DEFAULT nextval('public.aoop_programs_id_seq'::regclass);


--
-- Name: directors id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.directors ALTER COLUMN id SET DEFAULT nextval('public.directors_id_seq'::regclass);


--
-- Name: districts id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.districts ALTER COLUMN id SET DEFAULT nextval('public.districts_id_seq'::regclass);


--
-- Name: institutions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institutions ALTER COLUMN id SET DEFAULT nextval('public.institutions_id_seq'::regclass);


--
-- Data for Name: action_log; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.action_log (id, administrator_id, action, entity, record_id, old_data, new_data, created_at) FROM stdin;
\.


--
-- Data for Name: administrators; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.administrators (id, login, password_hash, full_name, created_at, last_login, updated_at) FROM stdin;
6	map_admin	$2y$10$ADkj26YEbzSq.81fE8t/eeSM9szZqb8WSWmhWK8EDtNpQJY1gm20m	Map Administrator	2026-11-14 10:54:59.457582	\N	2026-11-14 10:54:59.457582
\.


--
-- Data for Name: admission_types; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.admission_types (code, name_ru, description, created_at) FROM stdin;
certificate	Свидетельство об обучении	Для детей с ОВЗ, получающих свидетельство	2025-12-02 16:47:37.831964
attestat	Аттестат	Для детей, получающих аттестат государственного образца	2025-12-02 16:47:37.831964
\.


--
-- Data for Name: aoop_programs; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.aoop_programs (id, institution_id, name, created_at, url) FROM stdin;
1	10	Рабочие программы для обучающихся с умственной отсталостью	2026-07-04 20:50:37.25445	https://sh1-elec-r42.gosweb.gosuslugi.ru/netcat_files/33/46/RP_9.1.zip
2	21	Адаптированная программа ТНР на 2025 - 2026 учебный год	2026-07-04 20:50:37.25445	https://sh24elec.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_programma_TNR.pdf
3	21	Адаптированная программа ЗПР на 2025 - 2026 учебный год	2026-07-04 20:50:37.25445	https://sh24elec.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_programma_ZPR.pdf
185	25	Адаптированная основная образовательная программа профессионального обучения по профессии маляр строительный (для лиц с ограниченными возможностями здоровья)	2026-07-04 22:25:16.708377	\N
7	32	Маляр	2026-07-04 20:50:37.25445	https://gtk-gryazi.ru/files/docs/uch_plan/malyar.pdf
8	32	Маляр строительный	2026-07-04 20:50:37.25445	https://gtk-gryazi.ru/files/docs/uch_plan/malyar_stroitelnyj.pdf
9	32	Помощник повара	2026-07-04 20:50:37.25445	https://gtk-gryazi.ru/files/docs/uch_plan/pomoshchnik_povara.pdf
10	33	Маляр	2026-07-04 20:50:37.25445	https://disk.yandex.ru/d/jcjakp5Qt7dkIQ
186	44	13450 Маляр	2026-07-04 22:29:24.669887	\N
187	44	17530 Рабочий зеленого хозяйства	2026-07-04 22:29:24.672975	\N
40	49	Адаптированная основная образовательная программа начального общего образования для обучающихся с ЗПР (вариант 7.2)	2026-07-04 20:50:37.25445	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obrazovatel_naya_programma.pdf
41	49	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) в соответствии с ФГОС обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-07-04 20:50:37.25445	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/podpisan_AOOP_OO_UO_IN_var_1_2024_v10.pdf
42	49	Адаптированная основная образовательная программа основного общего образования обучающихся с ЗПР в соответствии с ФГОС ООО и ФАОП ООО	2026-07-04 20:50:37.25445	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/podpisan_FAOP_OOO_ZPR_2024_v15_TRAEKTORIYa.pdf
43	49	Адаптированная основная программа профессионального обучения программа профессиональной подготовки по профессии рабочего «Швея»	2026-07-04 20:50:37.25445	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/podpisan_AOPPO_shveya_v14_Final_18.07.2023_1_.pdf
44	49	Адаптированная основная программа профессионального обучения - программа профессиональной подготовки по профессии рабочего «Плодоовощевод», «Цветовод»	2026-07-04 20:50:37.25445	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/AOPPO_plodoovoschevod_tsvetovod_v8_konechn_final.pdf_poldpisan.pdf
188	115	Адаптированная образовательная программа дошкольного образования МБДОУ детский сад № 71 г.Ельца обучающихся с тяжёлыми нарушениями речи	2026-07-04 22:44:15.468988	\N
64	91	Адаптированная основная образовательная программа для детей с тяжелыми нарушениями речи (ТНР)	2026-07-04 20:50:37.25445	https://ds1-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOOP_TNR_2025.pdf
65	92	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://ds3-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/aop_do_tnr_0.pdf
66	92	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития	2026-07-04 20:50:37.25445	https://ds3-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/aop_do_zpr.pdf
67	92	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра	2026-07-04 20:50:37.25445	https://ds3-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/aop_do_ras.pdf
68	93	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://detskeisad5elets.gosuslugi.ru/netcat_files/19/8/programma.pdf
69	93	Адаптированная образовательная программа для ребенка с расстройствами аутистического спектра и задержкой психического развития Муниципального бюджетного дошкольного образовательного учреждения «Детский сад № 5 г. Ельца»	2026-07-04 20:50:37.25445	https://detskeisad5elets.gosuslugi.ru/netcat_files/19/8/programma_dlya_detey_s_ras_i_zpr.pdf
70	93	Адаптированная образовательная программа дошкольного образования для обучающихся с нарушением зрения	2026-07-04 20:50:37.25445	https://detskeisad5elets.gosuslugi.ru/netcat_files/19/8/programma_dlya_detey_s_narusheniem_zrenie_FAOP.pdf
71	95	Адаптированная основная образовательная программа дошкольного образования для детей с ТНР	2026-07-04 20:50:37.25445	https://ds10-elec-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-na-2025-2026g.html
72	96	Адаптированная образовательная программа дошкольного образования для работы с детьми, имеющими тяжелые нарушения речи (ТНР)	2026-07-04 20:50:37.25445	https://ds14-elec-r42.gosweb.gosuslugi.ru/netcat_files/userfiles/Adaptirovannaya_programma_doshkolnogo_obrazovaniya1.pdf
416	292	Адаптированная образовательная программа для детей с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://detsad3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
73	96	Адаптированная образовательная программа дошкольного образования для работы с детьми, имеющими расстройства аутистического спектра (РАС)	2026-07-04 20:50:37.25445	https://ds14-elec-r42.gosweb.gosuslugi.ru/netcat_files/userfiles/AOP_RAS_2025.pdf
74	96	Адаптированная образовательная программа дошкольного образования для работы с детьми, имеющими задержку психического развития (ЗПР)	2026-07-04 20:50:37.25445	https://ds14-elec-r42.gosweb.gosuslugi.ru/netcat_files/userfiles/Aop_ZPR_2025.pdf
75	97	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР) Муниципального автономного дошкольного образовательного учреждения «Детский сад № 15 города Ельца»	2026-07-04 20:50:37.25445	https://ds15-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatelnaya_programma_doshkolnogo_obrazovania_dlya_yuschikhsya_s_tyazhelymi_narusheniami_rechi_MADOU_detskiy_sad.pdf
76	98	Адаптированная образовательная программа для детей с ТНР	2026-07-04 20:50:37.25445	https://ds16elets.gosuslugi.ru/netcat_files/19/8/aop_TNR_.pdf
77	98	Адаптированная образовательная программа для детей с РАС	2026-07-04 20:50:37.25445	https://ds16elets.gosuslugi.ru/netcat_files/19/8/AOP_RAS_.pdf
78	99	Адаптированная основная образовательная программа МБДОУ детский сад №17 г. Ельца	2026-07-04 20:50:37.25445	https://ds17-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_osnovnaya_obrazovatel_naya_programma_4_.pdf
79	100	Адаптированная образовательная программа для детей с ТНР	2026-07-04 20:50:37.25445	https://ds21elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr-na-2024-2025-uchebnyy-god.html
80	101	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития МБДОУ детского сада №24 г. Ельца	2026-07-04 20:50:37.25445	https://ds24-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_DO_ZPR_FAOP_0.pdf
81	101	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-07-04 20:50:37.25445	https://ds24-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Programma_dlya_obuchayuschihsya_s_tyazhelymi_narusheniyami_rechi.pdf
82	101	Адаптированная образовательная программа дошкольного образования для обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-07-04 20:50:37.25445	https://ds24-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Programma_dlya_obuchayuschihsya_s_umstvennoy_otstalost_yu.pdf
83	102	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-07-04 20:50:37.25445	https://ds25-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_TNR.pdf
84	102	Адаптированная образовательная программа дошкольного образования для детей с ЗПР	2026-07-04 20:50:37.25445	https://ds25-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_ZPR_25_28.pdf
85	102	Адаптированная образовательная программа дошкольного образования для детей с умственной отсталостью, расстройством аутистического спектра	2026-07-04 20:50:37.25445	https://ds25-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_UO_24_25.pdf
86	103	Адаптированная образовательная программа дошкольного образования	2026-07-04 20:50:37.25445	https://ds27-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_MBDOU_detskogo_sada_27_goroda_El_tsa_pech2.pdf
87	104	Адаптированная образовательная программа дошкольного образования для обучающихся с ограниченными возможностями здоровья (ТНР)	2026-07-04 20:50:37.25445	https://ds30elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_programma_TNR_2025_2026g_kopiya.pdf
88	105	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://ds-skazka-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/adaptirovannaya_magomedh_podpis.pdf
89	106	Адаптированная рабочая программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)	2026-07-04 20:50:37.25445	https://ds-solnyshko-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_obuchayuschihsya_s_tyazhelymi_narusheniyami_rechi_TNR_v_MBDOU_detskiy_sad_32_g.El_tsa_Solnyshko.pdf
90	107	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://ds33-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/2023_AOP_TNR_GOTOVO.pdf
91	108	Адаптированная образовательная программа для воспитанников с задержкой психического развития	2026-07-04 20:50:37.25445	https://ds34elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_54.html
92	108	Адаптированная образовательная программа для воспитанников с расстройством аутистического спектра	2026-07-04 20:50:37.25445	https://ds34elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_58.html
93	108	Адаптированная образовательная программа для воспитанников с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://ds34elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_62.html
94	109	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелым нарушением речи (ТНР)	2026-07-04 20:50:37.25445	https://ds36elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_TNR_.pdf
95	109	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)	2026-07-04 20:50:37.25445	https://ds36elets.gosuslugi.ru/netcat_files/19/8/AOP_zpr_36.pdf
96	109	Адаптированная образовательная программа дошкольного образования для обучающихся с умственной отсталостью (УО)	2026-07-04 20:50:37.25445	https://ds36elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_UO_.pdf
97	110	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)	2026-07-04 20:50:37.25445	https://ds37-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_ZPR_1_.pdf
98	110	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)	2026-07-04 20:50:37.25445	https://ds37-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_TNR_2_.pdf
99	110	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра (РАС)	2026-07-04 20:50:37.25445	https://ds37-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_RAS.pdf
100	111	Адаптированная образовательная программа дошкольного образования коррекционно- развивающей работы для детей с тяжелыми нарушениями речи (ОНР) 5-8 лет	2026-07-04 20:50:37.25445	https://ds39elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_korrektsionno_razvivayuschey_raboty_dlya_detey_s_tyazhelymi_narusheniyami_rechi_5_8_let_MBDOU_detskiy_sad_39_g._El_tsa_na_2025_2026_g_.pdf
101	112	Адаптированная образовательная программа	2026-07-04 20:50:37.25445	https://ds40-elec-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_63.html
102	113	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-07-04 20:50:37.25445	https://ds41-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_programma_2025_2026.pdf
103	114	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи (ТНР)	2026-07-04 20:50:37.25445	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_TNR_MBDOU_ds_46_g._El_tsa_2023_g..pdf
104	114	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)	2026-07-04 20:50:37.25445	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_ZPR_MBDOU_ds_46_g._El_tsa_2023_g..pdf
105	114	Адаптированная образовательная программа дошкольного образования для детей с расстройством аутистического спектра (РАС)	2026-07-04 20:50:37.25445	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_RAS_MBDOU_ds_46_g._El_tsa_2023_g..pdf
106	114	Адаптированная образовательная программа дошкольного образования для детей с нарушением опорно-двигательного аппарата (НОДА)	2026-07-04 20:50:37.25445	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_NODA_2023_2024.pdf
107	114	Адаптированная образовательная программа дошкольного образования для детей с умственной отсталостью (интеллектуальными нарушениями)	2026-07-04 20:50:37.25445	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_UO_MBDOU_ds_46_g._El_tsa_2023_g..pdf
109	116	Адаптированная образовательная программа для обучающихся с нарушением речи	2026-07-04 20:50:37.25445	https://ds84-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_dlya_obuchayuschihsya_s_narusheniem_rechi.pdf
110	116	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития	2026-07-04 20:50:37.25445	https://ds84-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_dlya_obuchayuschihsya_s_ZPR.pdf
111	116	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра	2026-07-04 20:50:37.25445	https://ds84-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_dlya_obuchayuschihsya_s_RAS.pdf
126	52	Адаптированная основная образовательная программа начального общего образования для обучающихся с НОДА с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), ТМНР (вариант 6.4)	2026-07-04 21:47:59.786195	\N
127	52	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-07-04 21:47:59.788506	\N
128	52	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-07-04 21:47:59.790222	\N
129	52	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с РАС с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), ТМНР (вариант 8.4)	2026-07-04 21:47:59.791983	\N
198	152	Адаптированная основная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	https://cloud.mail.ru/public/X86c/cG4FKZABB
130	35	Адаптированная образовательная программа профессиональной подготовки обучающихся с ограниченными возможностями здоровья на базе выпускников специальных (коррекционных) школ VIII вида без получения среднего общего образования по профессии 13459 Рабочий зел	2026-07-04 21:48:50.63702	\N
134	46	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-07-04 21:56:56.584988	\N
135	46	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-07-04 21:56:56.587297	\N
136	46	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с расстройствами аутистического спектра (вариант 8.4)	2026-07-04 21:56:56.58898	\N
137	26	Адаптированная основная образовательная программа профессионального обучения по профессии 13450 Кухонный рабочий	2026-07-04 22:08:17.143771	\N
138	26	Адаптированная основная образовательная программа профессионального обучения по профессии 13450 Рабочий зеленого хозяйства	2026-07-04 22:08:17.146639	\N
139	45	Адаптированная основная общеобразовательная программа начального общего образования глухих обучающихся (вариант 1.2)	2026-07-04 22:09:09.893247	\N
140	45	Адаптированная основная общеобразовательная программа начального общего образования глухих обучающихся (вариант 1.3)	2026-07-04 22:09:09.899495	\N
141	45	Адаптированная основная общеобразовательная программа начального общего образования для слабослышащих и позднооглохших обучающихся (вариант 2.2)	2026-07-04 22:09:09.90308	\N
142	45	Адаптированная основная образовательная программа основного общего образования для обучающихся с нарушениями слуха (вариант 1.2)	2026-07-04 22:09:09.905977	\N
143	45	Адаптированная основная образовательная программа основного общего образования для обучающихся с нарушениями слуха (вариант 2.2.2)	2026-07-04 22:09:09.908892	\N
144	45	программа образования обучающихся с нарушением интеллекта (для 1–9 классов) Вариант 1	2026-07-04 22:09:09.911931	\N
145	45	программа образования обучающихся с нарушением интеллекта (для 1–9 классов) Вариант 2	2026-07-04 22:09:09.914945	\N
146	50	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с расстройствами аутистического спектра (вариант 8.4)	2026-07-04 22:10:34.600075	\N
147	50	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (Вариант 1)	2026-07-04 22:10:34.602829	\N
148	50	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (Вариант 2)	2026-07-04 22:10:34.605578	\N
149	50	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с расстройствами аутистического спектра (вариант 8.3)	2026-07-04 22:10:34.607989	\N
162	51	Адаптированная основная общеобразовательная программа образования обучающихся с лёгкой умственной отсталостью (интеллектуальными нарушениями), (вариант 1), 1-12 классы	2026-07-04 22:21:12.673388	\N
163	51	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжёлой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжёлыми и множественными нарушениями развития (вариант II) 1доп, 1-12 классы	2026-07-04 22:21:12.675397	\N
164	51	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с расстройствами аутистического спектра (вариант 8.4)	2026-07-04 22:21:12.677313	\N
165	51	Адаптированная основная программа профессионального обучения –программа профессиональной подготовки по профессии «Швея»	2026-07-04 22:21:12.679431	\N
166	51	Адаптированная основная программа профессионального обучения – программа профессиональной подготовки по профессии «Рабочий по комплексному обслуживанию и ремонту зданий» 2-го разряда	2026-07-04 22:21:12.681214	\N
167	51	Адаптированная основная программа профессионального обучения – программа профессиональной подготовки по профессии рабочего «Овощевод»	2026-07-04 22:21:12.682896	\N
168	53	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 9.1)	2026-07-04 22:23:28.435825	\N
169	53	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)	2026-07-04 22:23:28.437745	\N
170	53	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 9.1)	2026-07-04 22:23:28.439526	\N
171	53	Адаптированная образовательная программа основного общего образования обучающихся с задержкой психического развития	2026-07-04 22:23:28.442413	\N
172	47	Адаптированная основная образовательная программа дошкольного образования для слепых детей детского сада	2026-07-04 22:24:24.810504	\N
173	47	Адаптированная основная общеобразовательная программа начального общего образования для слепых обучающихся (вариант 3.2)	2026-07-04 22:24:24.81393	\N
174	47	Адаптированная основная общеобразовательная программа начального общего образования для слепых обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями) (вариант 3.4)	2026-07-04 22:24:24.816235	\N
175	47	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.1)	2026-07-04 22:24:24.830276	\N
176	47	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.2)	2026-07-04 22:24:24.832128	\N
177	47	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 4.3)	2026-07-04 22:24:24.833817	\N
178	47	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся с интеллектуальными нарушениями	2026-07-04 22:24:24.835575	\N
179	47	Адаптированная основная общеобразовательная программа основного общего образования для слепых обучающихся (вариант 3.2)	2026-07-04 22:24:24.837241	\N
180	47	Адаптированная основная общеобразовательная программа основного общего образования для слабовидящих детей (вариант 4.2)	2026-07-04 22:24:24.839086	\N
181	47	Адаптированная основная общеобразовательная программа основного общего образования для слабовидящих обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-07-04 22:24:24.840809	\N
182	47	Адаптированная основная общеобразовательная программа основного общего образования для слабовидящих обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)	2026-07-04 22:24:24.843741	\N
183	47	Адаптированная основная общеобразовательная программа среднего общего образования для слепых и слабовидящих детей	2026-07-04 22:24:24.846433	\N
184	47	Государственное Бюджетное Общеобразовательное Учреждение «Специальная школа-интернат г. Ельца»	2026-07-04 22:24:24.848423	\N
189	149	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	\N
190	149	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	\N
191	149	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант) 2	2026-08-21 15:51:15.108635	\N
192	149	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	\N
193	149	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжёлыми нарушениями речи (вариант 5.2)	2026-08-21 15:51:15.108635	\N
194	150	Адаптированная образовательная программа ООО для обучающихся с нарушение опорно-двигательного аппарата (вариант 6.1)	2026-08-21 15:51:15.108635	https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
195	150	Адаптированная образовательная программа для обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
196	150	Адаптированная образовательная программа НОО для обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
197	150	Адаптированная образовательная программа ООО для обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	https://sc6lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
199	152	Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	https://cloud.mail.ru/public/ifn5/jaNkDPksw
200	152	Адаптированная основная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 9.2)	2026-08-21 15:51:15.108635	https://cloud.mail.ru/public/oh8x/hXCTbdQ11
201	153	Адаптированная образовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	\N
202	153	Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	\N
203	153	Адаптированная образовательная программа обучающихся умственной отсталостью (интеллектуальными нарушениями) (вариант 2)	2026-08-21 15:51:15.108635	\N
204	157	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) муниципального бюджетного общеобразовательного учреждения средней школы № 14 города Липецка	2026-08-21 15:51:15.108635	https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant1.pdf
205	157	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) муниципального бюджетного об...	2026-08-21 15:51:15.108635	https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant_2.pdf
206	157	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2) муниципального бюджетного общеобразовательного учреждения средней школы № 14 города Липецка	2026-08-21 15:51:15.108635	https://schkola14.gosuslugi.ru/netcat_files/33/46/Variant_7.2.pdf
207	157	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)	2026-08-21 15:51:15.108635	https://schkola14.gosuslugi.ru/netcat_files/33/46/variant_7.pdf
208	158	Адаптированная основная общеобразовательная программа для обучающихся с интеллектуальными нарушениями (вариант 1)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_dlya_uchaschihsya_s_intellektual_nymi_narusheniyami_variant1_.pdf
209	158	Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.1)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_dlya_uchaschihsya_s_RAS_variant_8.1_2025_god_1_.pdf
210	158	Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.2)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_dlya_uchaschihsya_s_RAS_variant_8.2_.pdf
211	158	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.1_1_4_KL.pdf
212	158	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.4)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_RAS_8.4_2025_2026g.pdf
213	158	Адаптированная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.3)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_RAS_varint_8_3_2025god_1_.pdf
214	158	Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_OOO_obuchayuschihsya_s_ZPR_variant_7.pdf
215	158	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.2_1_4_KL_2025_.pdf
216	158	Адаптированная образовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (вариант 5.2, первое отделение)	2026-08-21 15:51:15.108635	https://sc15lipetsk.gosuslugi.ru/netcat_files/33/46/AOP_NOO_dlya_uchaschihsya_s_TNR.pdf
217	159	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_NOO_variant_7.1.pdf
418	295	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://ds-8ulybka-dankov-r42.gosweb.gosuslugi.ru/netcat_files/19/8/adaptirovannaya_programma_novaya_1_.pdf
218	159	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_NOO_variant_7.2.pdf
219	159	Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7)	2026-08-21 15:51:15.108635	https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_OOO_ZPR_2023.pdf
220	159	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_UO_IN_variant_1.pdf
221	159	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-08-21 15:51:15.108635	https://lipschool16.gosuslugi.ru/netcat_files/userfiles/2025/Obrazovanie/AOOP_UO_IN_variant_2.pdf
222	159	Адаптированная дополнительная общеобразовательная программа - дополнительная общеразвивающая программа художественной направленности «театр «РАМПА»	2026-08-21 15:51:15.108635	https://sh16-lipeck-r42.gosweb.gosuslugi.ru/netcat_files/33/46/1adop_dop_teatr_rampa..pdf
223	160	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ограниченными возможностями здоровья – нарушение опорно-двигательного аппарата (вариант 6.1.)	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.1end.pdf
224	160	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.2) МАОУ СОШ № 17 г. Липецка	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.2_end.pdf
225	160	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.3) МАОУ СОШ № 17 г. Липецка	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/6.3_end.pdf
226	160	Адаптированная основная общеобразовательная программа для обучающихся с расстройствами аутистического спектра (РАС) (вариант 8.4)	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_8.4_end.pdf
227	160	Адаптированная основная общеобразовательная программа образования для обучающихся с нарушением интеллекта (вариант 1)	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/Narushenie_intellekta_end.pdf
228	160	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ОВЗ (ЗПР) (вариант 7.1) МАОУ СОШ № 17 г. Липецка netcat_files/33/46/AOOP_ZPR_7.1_end.pdf	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/
229	160	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с ОВЗ (ЗПР) (вариант 7.2) МАОУ СОШ № 17 г. Липецка	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_obuchayuschiesya_s_ZPR_variant_7.2_end.pdf
230	160	Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с нарушениями опорно-двигательного аппарата	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/AOOP_OOO_NODA_end.pdf
231	160	Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с ЗПР	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/ZPR_5_9_variant_7.pdf
232	160	Адаптированная основная общеобразовательная программа начального общего образования для учащихся с тяжелыми нарушениями речи вариант 5.1	2026-08-21 15:51:15.108635	https://sh17-lipeck.gosuslugi.ru/netcat_files/33/46/5.1_end.pdf
233	165	Адаптированная основная образовательная программа основного общего образования обучающихся с задержкой психического развития (вариант 7)	2026-08-21 15:51:15.108635	https://sc23lipetsk.gosuslugi.ru/netcat_files/33/46/_OU_23_AOOP_OOO_ZPR_ispr_sayt_podpis_.pdf
234	168	Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.1) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.1_.pdf
235	168	Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.2) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.2_.pdf
269	186	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (5-9 классы)	2026-08-21 15:51:15.108635	https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_227.html
236	168	Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.3) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.3_.pdf
237	168	Адаптированная основная образовательная программа начального общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.4) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_nachal_nogo_obschego_obrazovaniya_Variant_8.4_.pdf
238	168	Адаптированная основная образовательная программа основного общего образования МАОУ школы информационных технологий № 26 г. Липецка (вариант 8.2) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_obrazovatel_naya_programma_osnovnogo_obschego_obrazovaniya_Variant_8.2._.pdf
239	168	Адаптированная основная образовательная программа основного общего образования для обучающихся с интеллектуальными нарушениями МАОУ школы информационных технологий № 26 г. Липецка (вариант 1) 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://maoush26it.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obscheobrazovatel_naya_programma_obrazovaniya_obuchayuschihsya_s_UO_IN_.pdf
240	169	Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.2)	2026-08-21 15:51:15.108635	https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_8.2_27_shkola_na_sayt.pdf
241	169	Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.3)	2026-08-21 15:51:15.108635	https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_83_27_shkola_na_sayt.pdf
242	169	Адаптированная основная общеобразовательная программа начального общего образования учащихся с расстройствами аутистического спектра (вариант 8.4)	2026-08-21 15:51:15.108635	https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_84._27_shkola_na_sayt.pdf
243	169	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sc27lip.gosuslugi.ru/netcat_files/33/46/AOOP_1_9_KLASS_S_UO_NAShA_2024_g_1_podpis_.pdf
244	171	Адаптированная образовательная программа дошкольного образования (для обучающихся с тяжелыми нарушениями речи (ТНР))	2026-08-21 15:51:15.108635	https://sc29un.gosuslugi.ru/netcat_files/68/3280/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_obuchayuschihsya_s_TNR.pdf
245	171	Основная адаптированная программа начального общего образования для обучающихся с ограниченными возможностями здоровья муниципального автономного общеобразовательного учреждения средней общеобразовательной школы №29 города Липецка «Университетская» (ва...	2026-08-21 15:51:15.108635	https://sc29un.gosuslugi.ru/netcat_files/68/3316/Osnovnaya_adaptirovannaya_programma_nachal_nogo_obschego_obrazovaniya_dlya_obuchayuschihsya_s_OVZ_variant_6.4_1_.pdf
246	174	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) муниципального бюджетного общеобразовательного учреждения № 32 г. Липецка	2026-08-21 15:51:15.108635	https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP_UO_variant_1-polnaya_1.pdf
247	174	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) муниципального бюджетного об...	2026-08-21 15:51:15.108635	https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP_UO_variant_2_05.11..pdf
248	174	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.3) муниципального бюджетного общеобра...	2026-08-21 15:51:15.108635	https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP-8.3.pdf
249	174	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...	2026-08-21 15:51:15.108635	https://sc32lip.gosuslugi.ru/netcat_files/userfiles/1_Svedeniya_ob_OO/20252026_obrazovanie/AOOP/AOOP-8.4_.pdf
250	177	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_UA_var.1_1.pdf
251	177	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 7.1)	2026-08-21 15:51:15.108635	https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_ZPR_var._7.1_1.pdf
252	177	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 7.2)	2026-08-21 15:51:15.108635	https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_ZP_var_7.2_1.pdf
253	177	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (Вариант 5.2) (с изменениями на 1.09.2024г.)	2026-08-21 15:51:15.108635	https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_TNR_var_5.2_1.pdf
254	177	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся на 2023-2028 учебный год (с изменениями на 1.09.2024г.) (Вариант 4.2)	2026-08-21 15:51:15.108635	https://sc35lip.gosuslugi.ru/netcat_files/userfiles/2025/AOOP_NOO_dlya_slabovidyaschih.pdf
255	178	Адаптированная основная общеобразовательная программа образования для обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.1)	2026-08-21 15:51:15.108635	https://sc36lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
256	178	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) муниципального бюджетного общеобразовательного учреждения № 36 г. Липецка	2026-08-21 15:51:15.108635	https://sc36lip.gosuslugi.ru/netcat_files/33/46/AOOP_UO_36_shkola.pdf
257	180	Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sc38lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
258	181	Адаптированная образовательная программа дошкольного образования для обучающихся с нарушением зрения Муниципального бюджетного общеобразовательного учреждения средней общеобразовательной школы №40 г. Липецка	2026-08-21 15:51:15.108635	https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
259	181	Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития (ЗПР) муниципального бюджетного общеобразовательного учреждения средней общеобразовательной школы № 40 г. Липецка	2026-08-21 15:51:15.108635	https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
260	181	Адаптированная образовательная программа дошкольного образова-ния для обучающихся с тяжелыми нарушениями речи (далее – ТНР) Муни-ципального бюджетного общеобразовательного учреждения средней общеобразовательной школы №40 г. Липецка	2026-08-21 15:51:15.108635	https://sc40lipschools48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
261	182	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (вариант 1)	2026-08-21 15:51:15.108635	\N
262	182	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	\N
263	182	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	\N
264	182	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...	2026-08-21 15:51:15.108635	\N
265	182	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжелыми нарушениями речи (вариант 5.2. 1-отделение)	2026-08-21 15:51:15.108635	\N
266	182	Адаптированная основная общеобразовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7)	2026-08-21 15:51:15.108635	\N
267	182	Адаптированная основная общеобразовательная программа основного общего образования муниципального бюджетного общеобразовательного учреждения средней школы № 41 города Липецка для обучающихся с нарушением слуха (вариант 2.2.1)	2026-08-21 15:51:15.108635	\N
268	186	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта на дому (4 класс) на 2023-2028 учебные года	2026-08-21 15:51:15.108635	https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_226.html
270	186	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (9 класс) на 2023-2028 учебные года	2026-08-21 15:51:15.108635	https://sh46-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-35_228.html
271	186	Адаптированная основная общеобразовательная программа с нарушением интеллекта (1-4 класс)	2026-08-21 15:51:15.108635	https://sh46-lipeck-r42.gosweb.gosuslugi.ru/netcat_files/68/3083/AOOP_s_narusheniem_intellekta_1_4.pdf
272	188	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с ТНР 5 – 7 (8) лет	2026-08-21 15:51:15.108635	https://sc48lipetsk.gosuslugi.ru/netcat_files/33/46/p_AOP_DO_010925.pdf
273	191	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с нарушениями речи 5-8 лет Муниципального автономного общеобразовательного учреждения средней школы №51 г. Липецка	2026-08-21 15:51:15.108635	https://51lipetsk.gosuslugi.ru/netcat_files/33/46/aop_doo_25_26_uch_god.pdf
275	200	Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1) 2023-2027 гг. (в редакции 2025 года)	2026-08-21 15:51:15.108635	https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_UO_IN_.pdf
276	200	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.1.) (в редакции 2025 года)	2026-08-21 15:51:15.108635	https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_NODA_NOO_s_podpis_yu.pdf
277	200	Адаптированная основная образовательная программа начального общего образования обучающихся с ЗПР (вариант 7.1) на 2025-2029 гг.	2026-08-21 15:51:15.108635	https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_ZPR_7.1_s_podpis_yu.pdf
278	200	Адаптированная основная образовательная программа основного общего образования для обучающихся с задержкой психического развития (вариант 7) на 2023-2027 гг. (в редакции 2025 года)	2026-08-21 15:51:15.108635	https://s63lip.gosuslugi.ru/netcat_files/33/46/AOOP_ZPR_OOO.pdf
279	201	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://gimnasium64.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/20252026/AOP_Gimnaziya_641.pdf
280	202	Адаптированная основная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP_NOO_7.1_provereno.pdf
281	202	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными...	2026-08-21 15:51:15.108635	https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP-8.4_.pdf
282	202	Адаптированная основная образовательная программа начального общего образования обучающихся с тяжелой умственной отсталостью (вариант 9.2)	2026-08-21 15:51:15.108635	https://scl65lip.gosuslugi.ru/netcat_files/userfiles/obrazovanie/NOO/AOOP_NOO_9.2.pdf
283	206	Адаптированная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с тяжелыми нарушениями речи 5-8 лет	2026-08-21 15:51:15.108635	https://70school.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_sada_25.pdf
284	206	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи МБОУ СШ №70 г. Липецка (дошкольные группы)	2026-08-21 15:51:15.108635	https://70school.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_sada.pdf
285	206	Mail: sc70lip@schools48.ru	2026-08-21 15:51:15.108635	\N
286	207	Адаптированная основная образовательная программа начального общего образования для обучающихся с тяжелыми нарушениями речи (вариант 5.1)	2026-08-21 15:51:15.108635	https://sc72lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_variant_5.1.pdf
287	207	Адаптированная основная общеобразовательная программа начального общего образования муниципального бюджетного общеобразовательного учреждения средней школы №72 имени героя Российской Федерации Гануса Феодосия Григорьевича для обучающихся с задержкой…	2026-08-21 15:51:15.108635	https://sc72lip.gosuslugi.ru/netcat_files/33/46/AOOP_NOO_variant_7.1.pdf
288	207	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью интеллектуальными нарушениями) МБОУ СШ №72 г. Липецка. Липецка	2026-08-21 15:51:15.108635	https://sc72lip.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obscheobrazovatel_naya_programma_obrazovaniya.pdf
289	211	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://ds1lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_105.html
292	213	Адаптированная основная образовательная программа для дошкольников с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou3lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnr.html
293	213	Адаптированная образовательная программа для дошкольников с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://dou3lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-rabochaya-obrazovatelnaya-programma-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-zpr-uchitelya-defektologa.html
294	214	Адаптированная образовательная программа для детей с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou4lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-do-dou-4-glipetska.html
295	214	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с задержкой психического развития	2026-08-21 15:51:15.108635	https://dou4lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html
296	215	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №5 г. Липецка	2026-08-21 15:51:15.108635	https://dou5lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dou-5-g-lipetska-dlya-detey-s-tnr.html
297	215	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №5 г. Липецка	2026-08-21 15:51:15.108635	https://dou5lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dou-5-g-lipetska-dlya-detey-s-zpr.html
298	216	Адаптированная образовательная программа дошкольного образования ДОУ № 6	2026-08-21 15:51:15.108635	https://dou6-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-6-glipetska.html
299	217	Адаптированная основная образовательная программа дошкольного образования ДОУ № 8 г. Липецка для детей, имеющих нарушения речи (ТНР)	2026-08-21 15:51:15.108635	https://dou8lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-tnr-2025-2026.html
300	217	Адаптированная основная образовательная программа дошкольного образования ДОУ №8 г. Липецка для детей с нарушением зрения	2026-08-21 15:51:15.108635	https://dou8lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-zrenie-2025-2026.html
301	218	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://ds9lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/proekt-adaptirovannoy-obrazovatelnoy-programmy-dlya-detey-s-tnr-na-2024-2025.html
302	218	Адаптированная образовательная программа для детей с ЗПР (Адаптированная программа ДОУ 9 для детей с ЗПР по ФАОП)	2026-08-21 15:51:15.108635	https://ds9lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-dou-9-dlya-detey-s-zpr-po-faop.html
303	219	Адаптированная образовательная программа Муниципального бюджетного дошкольного образовательного учреждения № 10 г. Липецка для детей с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://doulip10.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-5-8-let.html
304	219	Адаптированная образовательная программа Муниципального бюджетного дошкольного образовательного учреждения № 10 г. Липецка для детей с задержкой психического развития	2026-08-21 15:51:15.108635	https://doulip10.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adapritirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zpr-5-8-let.html
305	220	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ТНР) 5-8 лет ДОУ № 12 г. Липецка	2026-08-21 15:51:15.108635	https://dou12-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/osnovnaya-adaptirovannaya-obrazovatelnaya-programma-na-2024-2025-uchebnyy-god.html
417	293	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://dou4yagodka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
306	220	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ЗПР) ДОУ № 12 г. Липецка	2026-08-21 15:51:15.108635	https://dou12-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_148.html
309	222	Адаптированная образовательная программа 2025-2026 учебный год (группа комбинированной направленности)	2026-08-21 15:51:15.108635	https://dou15lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-2025-2026-uchebnyy-god-proekt.html
310	222	Адаптированная образовательная программа 2025-2026 учебный год. Логопедическая группа (для обучающихся с тяжелыми нарушениями речи (ТНР))	2026-08-21 15:51:15.108635	https://dou15lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-2025-2026-uchebnyy-god-proekt.html
311	223	Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с умственной отсталостью легкой степени Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка	2026-08-21 15:51:15.108635	https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-umstvennoy-otstalostyu-legkoy-stepeni-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html
312	223	Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с умственной отсталостью умеренной и тяжелой степени Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка	2026-08-21 15:51:15.108635	https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-umstvennoy-otstalostyu-umerennoy-i-tyazheloy-stepeni-mbdou-18-g-lipetska-na-2024-2025-uchebnyy-god.html
313	223	Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста со сложным дефектом Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка	2026-08-21 15:51:15.108635	https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-so-slozhnym-defektom-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html
314	223	Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с расстройством аутистического спектра Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка	2026-08-21 15:51:15.108635	https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-rastroystvom-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html
315	223	Адаптированная образовательная программа дошкольного образования для обучающихся дошкольного возраста с задержкой психического развития Муниципального бюджетного дошкольного образовательного учреждения №18 города Липецка	2026-08-21 15:51:15.108635	https://mdou18lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/aop-do-dlya-detey-doshkolnogo-vozrasta-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-18-g-lipetska-na-2024-2025-uchebnyy-god.html
316	224	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелым нарушением речи 5-8 лет	2026-08-21 15:51:15.108635	https://dou19lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html
317	224	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития 5-8 лет	2026-08-21 15:51:15.108635	https://dou19lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya-5-8-let.html
318	225	Адаптированная образовательная программа ДО для воспитанников с РАС МАДОУ № 20 г. Липецка на 2025-2026 уч. год	2026-08-21 15:51:15.108635	https://dou20lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-do-dlya-vospitannikov-s-ras-madou-20-g-lipetska-na-2025-2026-uch-god.html
319	225	Адаптированная образовательная программа ДО МАДОУ № 20 г. Липецка для детей с ТНР на 2025-2026 уч. год	2026-08-21 15:51:15.108635	https://dou20lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-20-g-lipetska.html
320	226	Компенсирующая адаптивная образовательная программа	2026-08-21 15:51:15.108635	https://dou21lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_55.html
321	226	Коррекционнная адаптивная образовательная программа	2026-08-21 15:51:15.108635	https://dou21lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_57.html
322	227	Адаптированная образовательная программа дошкольного образования Муниципального дошкольного образовательного учреждения № 22 города Липецка для обучающихся с ТНР	2026-08-21 15:51:15.108635	https://dou22-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-ovz.html
323	227	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей со сложным дефектом Муниципального бюджетного дошкольного образовательного учреждения № 22 г. Липецка	2026-08-21 15:51:15.108635	https://dou22-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-so-slozhnymi-defektami.html
324	228	Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou23lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnoy-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tnr-dou-23-g-lipetska.html
325	228	Адаптированная образовательная программа дошкольного образования для обучающихся с нарушениями ОДА ДОУ № 23 г. Липецка	2026-08-21 15:51:15.108635	https://dou23lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniyami-oda-dou-23-g-lipetska.html
326	229	Адаптированная программа ЗПР	2026-08-21 15:51:15.108635	https://25doulip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-zpr.html
327	229	Адаптированная программа ТНР	2026-08-21 15:51:15.108635	https://25doulip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-tnr.html
328	230	Адаптированной образовательной программе дошкольного ДОУ № 29 г. Липецка для детей с тяжелыми нарушениями речи (ТНР) общим недоразвитием речи (ОНР))	2026-08-21 15:51:15.108635	https://mdou29lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/obrazovatelnaya-programma-2.html
329	230	Адаптированная образовательная программа дошкольного образования ДОУ № 29 г. Липецка для детей с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://mdou29lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/obrazovatelnaya-programma-1.html
331	232	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html
332	232	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра (РАС)	2026-08-21 15:51:15.108635	https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-rasstroystvami-autisticheskogo-spektra.html
333	232	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou32lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html
334	233	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://dou35-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/rabochaya-programma-zpr.html
335	233	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou35-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_71.html
336	234	Адаптированная образовательная программа дошкольного образования для воспитанников с ТНР	2026-08-21 15:51:15.108635	https://dou37lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-ovz-dou-37-g-lipetska.html
337	234	Адаптированная образовательная программа дошкольного образования для воспитанников с ЗПР	2026-08-21 15:51:15.108635	https://dou37lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-zpr.html
338	235	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с задержкой психического развития ДОУ № 38 г. Липецка	2026-08-21 15:51:15.108635	https://dou38-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-dou-38-g-lipetska-1.html
339	235	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе детей с ТНР (ОНР) 5-8 лет ДОУ № 38 г. Липецка	2026-08-21 15:51:15.108635	https://dou38-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-raboty-v-logopedicheskoy-gruppe-detey-s-tnr-onr-5-8-let-dou-38-g-lipetska-1.html
340	236	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-08-21 15:51:15.108635	https://dou40lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html
341	237	Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения № 42 г. Липецка	2026-08-21 15:51:15.108635	https://dou42lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tnr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-42-g-lipetska.html
342	237	Адаптированная образовательная программа дошкольного образования для обучающихся с ЗПР муниципального бюджетного дошкольного образовательного учреждения № 42 г. Липецка	2026-08-21 15:51:15.108635	https://dou42lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zpr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-42-g-lipetska-1.html
343	238	Адаптированная образовательная программа коррекционно-развивающей работы в логопедической группе детей с ТНР (ОНР) 5-8 лет на 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://dou44-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-korrektsionno-razvivayuschey-raboty-v-logopedicheskoy-gruppe-detey-s-tnr-onr-5-8-let-na-2024-2025-uchebnyy-god.html
344	239	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://mirdetstva50.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr.html
345	240	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей направленности для детей с тяжелыми нарушениями речи Муниципального дошкольного образовательного учреждения № 62 г. Липецка	2026-08-21 15:51:15.108635	https://ds62lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-korrektsionno-razvivayuschey-napravlennosti-dlya-detey-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-62-g-lipetska-1.html
346	241	Адаптированная образовательная программа ДОУ №64 (2 года обучения) на 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://dou64lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dou-64-2-goda-obucheniya-na-2025-2026-uchebnyy-god.html
347	242	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР) муниципального бюджетного дошкольного образовательного учреждения № 66 г. Липецка	2026-08-21 15:51:15.108635	https://dou66lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-66-g-lipetska.html
348	243	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи (ТНР) ДОУ № 68 г. Липецка	2026-08-21 15:51:15.108635	https://dou68-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-dalee-tnr-dou-68-g-lipetska.html
349	244	Адаптированная образовательная программа дошкольного образования Муниципального бюджетного дошкольного образовательного учреждения № 76 г. Липецка для обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	https://dou76-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-76-g-lipetska-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya.html
350	244	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://dou76-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/annotatsiya-k-adaptirovannoy-obrazovatelnoy-programme-dou-76-g-lipetska.html
351	245	Адаптированная основная образовательная программа для детей с ЗПР ДОУ № 77 г. Липецка	2026-08-21 15:51:15.108635	https://dou77-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-dlya-detey-s-zpr-dou-77-g-lipetska.html
352	245	Адаптированная основная образовательная программа для детей с ТНР ДОУ № 77 г. Липецка	2026-08-21 15:51:15.108635	https://dou77-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-dlya-detey-s-tnr-dou-77-g-lipetska.html
353	246	Адаптированная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с ТНР (ОНР) 5-8 лет	2026-08-21 15:51:15.108635	https://dou78lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya.html
354	247	Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи муниципального бюджетного дошкольного образовательного учреждения №79 г. Липецка	2026-08-21 15:51:15.108635	https://doulip79.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-narusheniem-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-79-glipetska.html
355	248	Адаптированная образовательная программа дошкольного образования для детей с НОДА	2026-08-21 15:51:15.108635	https://mdoulip83.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-noda.html
356	248	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-08-21 15:51:15.108635	https://mdoulip83.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr.html
357	249	Адаптированная образовательная программа дошкольного образования коррекционно - развивающей работы для детей с ОВЗ (ТНР)	2026-08-21 15:51:15.108635	https://lipetskdou85.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_72.html
358	250	Адаптированная образовательная программа дошкольного образования для детей с ТНР 5-8 лет	2026-08-21 15:51:15.108635	https://mdoulip-91.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-5-8-let.html
359	251	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР)	2026-08-21 15:51:15.108635	https://dou95lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma.html
360	252	Адаптированная образовательная программа дошкольного образования для детей с ТНР ДОУ № 96	2026-08-21 15:51:15.108635	https://dou96lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-dou-97.html
361	252	Адаптированная образовательная программа дошкольного образования для детей с ЗПР ДОУ № 96	2026-08-21 15:51:15.108635	https://dou96lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogobrazovaniya-dlya-detey-s-zpr-dou-96.html
362	253	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи ДОУ	2026-08-21 15:51:15.108635	https://dou98lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-dou-kopiya.html
363	254	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы в логопедической группе для детей с тяжелым нарушением речи (общим недоразвитием речи) 5-8 лет ДОУ № 99 г. Липецка	2026-08-21 15:51:15.108635	https://ds99-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelym-narusheniem-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-99-g-lipetska-1.html
364	255	Адаптированная образовательная программа дошкольного образования для детей с ОВЗ (ТНР) ДОУ № 101 г. Липецка на 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://detsad101lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-2024-2025-uchebnyy-god.html
365	256	Адаптированная образовательная программа дошкольного образования для обучающихся старшего возраста (5-7 лет) с ОВЗ (ТНР) в группах компенсирующей направленности ДОУ № 103 (логопедические группы)	2026-08-21 15:51:15.108635	https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html
366	256	Адаптированная образовательная программа дошкольного образования для обучающихся старшего возраста (5-7 лет) с ОВЗ (ТНР) в группах комбинированной направленности ДОУ № 103	2026-08-21 15:51:15.108635	https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html
367	256	Адаптированная образовательная программа дошкольного образования для обучающихся старшего дошкольного возраста (5-7 лет) с ограниченными возможностями здоровья (ЗПР) ДОУ № 103 на 2025 -2026 учебный год	2026-08-21 15:51:15.108635	https://dou103lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-starshego-doshkolnogo-vozrasta-5-7-let-s-ogranichennymi-vozmozhnostyami-zdorovya-tnr-dou-103-na-2024-2025-uchebnyy-god.html
368	257	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №105 г. Липецка	2026-08-21 15:51:15.108635	https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-tnr-2025-2026.html
369	257	Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №105 г.Липецка	2026-08-21 15:51:15.108635	https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-zpr-2025-2027.html
370	257	Адаптированная образовательная программа дошкольного образования для детей с расстройством аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №105 г.Липецка	2026-08-21 15:51:15.108635	https://ds105-lipeck-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-ras-dou-105-glipetska.html
371	258	Адаптированная образовательная программа дошкольного образования для обучающихся с нарушением интеллекта (синдром Дауна)	2026-08-21 15:51:15.108635	https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniem-intellekta-sindrom-dauna.html
372	258	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html
373	258	Адаптированная образовательная программа дошкольного образования для обучающихся с нарушениями зрения	2026-08-21 15:51:15.108635	https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-narusheniyami-zreniya.html
374	258	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	https://dou107.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zpr.html
375	259	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи (ТНР) Муниципального бюджетного дошкольного образовательного учреждения № 110 г. Липецк	2026-08-21 15:51:15.108635	https://dou110lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-tnrmunitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-110-glipetska.html
376	259	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития (ЗПР) Муниципального бюджетного дошкольного образовательного учреждения № 110 г. Липецк	2026-08-21 15:51:15.108635	https://dou110lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya-zpr-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-110-g-lipetska.html
377	260	Адаптированная образовательная программа дошкольного образования Муниципального бюджетного дошкольного образовательного учреждения №112 г. Липецка	2026-08-21 15:51:15.108635	https://dou112-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dou-112-g-lipetska1.html
378	261	Адаптированная образовательная программа ДОУ №113 г.Липецка (для детей с ТНР)	2026-08-21 15:51:15.108635	https://ds113-lipetsk48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-113-g-lipetska.html
379	261	Адаптированная образовательная программа дошкольного образования ДОУ №113 г.Липецка (для детей с ЗПР)	2026-08-21 15:51:15.108635	https://ds113-lipetsk48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-113-g-lipetska-zpr.html
380	262	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи Муниципального бюджетного дошкольного образовательного учреждения № 114 г. Липецка	2026-08-21 15:51:15.108635	https://dou114-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_140.html
381	262	Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития Муниципального бюджетного дошкольного образовательного учреждения № 114 г. Липецка	2026-08-21 15:51:15.108635	https://dou114-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_142.html
382	263	Адаптированная образовательная программа дошкольного образования муниципального бюджетного дошкольного образовательного учреждения №116 г.Липецка	2026-08-21 15:51:15.108635	https://ds116lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-116-glipetska.html
413	291	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ТНР)	2026-08-21 15:51:15.108635	https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
383	263	Адаптированная образовательная программа для воспитанников с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №116 г. Липецка	2026-08-21 15:51:15.108635	https://ds116lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-vospitannikov-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-116-glipetska.html
384	264	Адаптированная образовательная программа дошкольного образования для детей с ТНР ДОУ №119 г. Липецка	2026-08-21 15:51:15.108635	https://dou119lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/metodicheskoe-obespechenie-aop-dou-119-g-lipetska-s-tnr-1.html
385	264	Адаптированная образовательная программа дошкольного образования для детей с ЗПР ДОУ №119 г. Липецка	2026-08-21 15:51:15.108635	https://dou119lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-programma-zpr-2024-2025-dou-119.html
386	265	Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения № 123 г. Липецка	2026-08-21 15:51:15.108635	https://ds123lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-123-g-lipetska.html
387	265	Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения № 123 г. Липецка	2026-08-21 15:51:15.108635	https://ds123lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya.html
388	266	Адаптированная образовательная программа дошкольного образования ДОУ № 124 г. Липецка	2026-08-21 15:51:15.108635	https://ds124-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/kopiya-adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dou-124-g-lipetska.html
389	267	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи Муниципального автономного дошкольного образовательного учреждения детского сада №126 г. Липецка на 2025-2026 уч.г.	2026-08-21 15:51:15.108635	https://dou126lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-avtonomnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-detskogo-sada-126-g-lipetska-na-2024-2025-uchg.html
390	268	Адаптированная программа	2026-08-21 15:51:15.108635	https://dou127-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-ovz-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-127-g-lipetska-razrabotannaya-dlya-detey-s-tyazhelymi-narusheniyami-rechi.html
391	269	Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи	2026-08-21 15:51:15.108635	https://ds128-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_263.html
392	269	Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития	2026-08-21 15:51:15.108635	https://ds128-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_264.html
393	270	Адаптированная образовательная программа дошкольного образования муниципального бюджетного дошкольного образовательного учреждения № 130 города Липецка (группа компенсирующей направленности (логопедическая))	2026-08-21 15:51:15.108635	https://dou130-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma.html
394	272	Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения № 134 г. Липецка	2026-08-21 15:51:15.108635	https://ds134-lipeck.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-134-g-lipetska.html
395	272	Адаптированная образовательная программа дошкольного образования для воспитанников с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения № 134 г. Липецка	2026-08-21 15:51:15.108635	https://ds134-lipeck.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-134-g-lipetska-1.html
396	273	Адаптированная образовательная программа дошкольного образования для воспитанников с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://lipetsksadik135.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-vospitannikov-s-tyazhelymi-narusheniyami-rechi-tnr.html
414	291	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с ОВЗ (ЗПР)	2026-08-21 15:51:15.108635	https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
397	274	Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка	2026-08-21 15:51:15.108635	https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-zaderzhkoy-psihicheskogo-razvitiya-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html
398	274	Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка	2026-08-21 15:51:15.108635	https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html
399	274	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройством аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка	2026-08-21 15:51:15.108635	https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-rasstroystvom-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html
400	274	Коррекционно-развивающая программа "СенсориУМ" для детей дошкольного возраста с расстройствами аутистического спектра муниципального бюджетного дошкольного образовательного учреждения №136 г. Липецка	2026-08-21 15:51:15.108635	https://dou136lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/korrektsionno-razvivayuschaya-programma-sensorium-dlya-detey-doshkolnogo-vozrasta-s-rasstroystvami-autisticheskogo-spektra-munitsipalnogo-byudzhetnogo-doshkolnogo-obrazovatelnogo-uchrezhdeniya-136-g-lipetska.html
401	275	Адаптированная образовательная программа для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://mdoulip137.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-obuchayuschihsya-s-tyazhelymi-narusheniyami-rechi.html
402	276	Адаптированная образовательная программа дошкольного образования в группах компенсирующей направленности для детей ТНР	2026-08-21 15:51:15.108635	https://mdou138-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_78.html
403	276	Адаптированная образовательная программа дошкольного образования в группах комбинированной направленности для детей ЗПР	2026-08-21 15:51:15.108635	https://mdou138-lip.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_79.html
404	277	Адаптированная образовательная программа дошкольного образования для детей с ОВЗ Муниципального бюджетного дошкольного образовательного учреждения № 139 г. Липецка	2026-08-21 15:51:15.108635	https://dou139-lipetsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
405	278	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с легкой УО (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://sh-volovskaya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
406	284	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 7.2.)	2026-08-21 15:51:15.108635	http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
407	284	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с ОВЗ (вариант 7.2.)	2026-08-21 15:51:15.108635	http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
408	284	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	http://mousosh01-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
409	285	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://lyceum6-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
410	285	Адаптированная основная общеобразовательная программа для обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития	2026-08-21 15:51:15.108635	https://lyceum6-dankov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
411	289	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://dankovliceum4.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
412	289	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://dankovliceum4.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
415	292	Адаптированная образовательная программа для детей с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://detsad3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
419	299	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с тяжелыми нарушениями речи (вариант 5.1)	2026-08-21 15:51:15.108635	https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
420	299	Адаптированная основная общеобразовательная программа образования обучающихся с лёгкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) (1 - 9 классы)	2026-08-21 15:51:15.108635	https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
421	299	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-08-21 15:51:15.108635	https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
422	299	Адаптированная основная общеобразовательная программа для обучающихся с задержкой психического развития (основное общее образование)	2026-08-21 15:51:15.108635	https://sh2dobrinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
423	300	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта, (вариант 1)	2026-08-21 15:51:15.108635	https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
424	300	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта, (вариант 2)	2026-08-21 15:51:15.108635	https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
425	300	Адаптированная основная общеобразовательная программа НОО для слабовидящих обучающихся (вариант 4.2)	2026-08-21 15:51:15.108635	https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
426	300	Адаптированная основная общеобразовательная программа ООО для обучающихся с задержкой психического развития, (5-9 классы)	2026-08-21 15:51:15.108635	https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
427	300	Адаптированная основная общеобразовательная программа ООО для обучающихся с расстройствами аутистического спектра (вариант 8.1), (5-9 классы)	2026-08-21 15:51:15.108635	https://olggimnaziya.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
428	303	Адаптированная основная общеобразовательная программа образования обучающихся с лёгкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1) (1 - 9 классы)	2026-08-21 15:51:15.108635	https://nmatrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
429	303	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-08-21 15:51:15.108635	https://nmatrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
430	304	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (ФГОС, 1 вариант) на 2024 – 2027 гг. (в соответствии с ФАООП УО (ИН))	2026-08-21 15:51:15.108635	https://v-matrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
431	304	Адаптированная основная общеобразовательная программа начального общего образования для учащихся с задержкой психического развития (вариант 7.1) на 2024-26 учебный год	2026-08-21 15:51:15.108635	https://v-matrenka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
432	305	Адаптированная основная общеобразовательная программа для обучающихся с ЗПР	2026-08-21 15:51:15.108635	https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
433	305	Адаптированная основная общеобразовательная программа образования обучающихся с легкой УО (ИН) вариант 1	2026-08-21 15:51:15.108635	https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
434	305	АООП с УО (ИН) вариант 1 (2024г)	2026-08-21 15:51:15.108635	https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
435	305	АООП НОО обучающихся с НОДА вариант 6.2	2026-08-21 15:51:15.108635	https://petrowskiyschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
436	309	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройствами аутистического спектра (РАС и УО)	2026-08-21 15:51:15.108635	https://ds2dobrinka48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
437	312	Адаптированная образовательная программа дошкольного образования для детей с ЗПР	2026-08-21 15:51:15.108635	https://ds-plavica.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
438	313	Адаптированная образовательная программа начального общего образования для обучающихся с ЗПР (вариант 7.2)	2026-08-21 15:51:15.108635	https://sc1dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
439	313	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1, вариант 2)	2026-08-21 15:51:15.108635	https://sc1dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
440	316	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями, (вариант 2)	2026-08-21 15:51:15.108635	https://sh-2kalikino-kalikino-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
441	318	Адаптированная образовательная программа дошкольного образования для детей с ЗПР	2026-08-21 15:51:15.108635	https://ds-plavica.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
442	325	Адаптированная основная общеобразовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://ekaterinovka-school.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
443	326	Адаптированная образовательная программа для обучающихся с ТНР	2026-08-21 15:51:15.108635	https://petushok-dobroe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
444	328	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелым нарушениями речи	2026-08-21 15:51:15.108635	https://ds-malyshok-dobroe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/#adaptirovannye-obrazovatelnye-programmy
445	330	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://ds-beryozka-kalikino-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
446	333	Адаптированная основная образовательная программа муниципального бюджетного дошкольного образовательного учреждения детского сада «Солнышко» с.Трубетчино Добровского муниципального района Липецкой области	2026-08-21 15:51:15.108635	https://ds-solnyshko-trubetchino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
447	335	Адаптированная образовательная программа дошкольного образования для обучающихся с расстройством аутистического спектра	2026-08-21 15:51:15.108635	https://ds-solnyshko-volche-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-rastroystvom-autisticheskogo-spektra.html
448	339	Адаптированная образовательная программа (для обучающихся с умственной отсталостью (интеллектуальными нарушениями) вариант 1,2)	2026-08-21 15:51:15.108635	https://lic-dolgorukovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
449	340	Адаптированная основная общеобразовательная программа (вариант 1)	2026-08-21 15:51:15.108635	https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
450	340	Адаптированная основная общеобразовательная программа (вариант 2)	2026-08-21 15:51:15.108635	https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
451	342	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 1)	2026-08-21 15:51:15.108635	https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
452	342	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
453	344	Адаптированная образовательная программа обучающихся с легкой умственной отсталостью	2026-08-21 15:51:15.108635	\N
454	344	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с НОДА (ФГОС вариант 6.3)	2026-08-21 15:51:15.108635	https://stegschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
455	345	Адаптированная образовательная программа дошкольного образования для детей с нарушениями опорно-двигательного аппарата	2026-08-21 15:51:15.108635	https://dousolnce-dolgor.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
456	353	Адаптированная основная общеобразовательная программа образования обу­чающихся с легкой умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://solshk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
457	353	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития	2026-08-21 15:51:15.108635	https://solshk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
458	357	Адаптированная образовательная программа дошкольного образования муниципального дошкольного бюджетного образовательного учреждения детского сада «Солнышко» п.Газопровод для детей с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://detsadsolnischko.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
459	358	Адаптированная основная образовательная программа дошкольного образования для обучающихся с ТНР	2026-08-21 15:51:15.108635	https://ds-kazakisol.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
480	404	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
460	359	Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения детского сада «Тополёк» села Казаки Елецкого муниципального района Липецкой области	2026-08-21 15:51:15.108635	https://ds-topolyok-kazaki.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
461	360	Адаптированная образовательная программа дошкольного образования для обучающихся с ТНР муниципального бюджетного дошкольного образовательного учреждения детского сада деревни Казинка Елецкого муниципального района Липецкой области	2026-08-21 15:51:15.108635	https://doukazinka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
462	362	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://ds-klyuch.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
463	364	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://solsadik.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
464	364	Коррекционная программа дошкольного образования для детей с ЗПР	2026-08-21 15:51:15.108635	https://solsadik.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
465	368	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (вариант 1)	2026-08-21 15:51:15.108635	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/netcat_files/33/46/AOOP_NI_1_variant_2025_.pdf
466	368	Адаптированная основная общеобразовательная программа для обучающихся с нарушением интеллекта (2 вариант)	2026-08-21 15:51:15.108635	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/netcat_files/33/46/AOOP_s_NI_2_variant_.pdf
467	368	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.2)	2026-08-21 15:51:15.108635	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
468	368	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с НОДА (вариант 6.2)	2026-08-21 15:51:15.108635	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
469	368	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
470	369	Учебный план АООП (вариант 1) 2025-26	2026-08-21 15:51:15.108635	https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
471	369	Учебный план АООП (вариант 2) 2025-26	2026-08-21 15:51:15.108635	https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
472	387	Адаптированная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
473	387	Адаптированная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)	2026-08-21 15:51:15.108635	https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
474	387	Адаптированная образовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.7.) (вариант 1)	2026-08-21 15:51:15.108635	https://sh-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
475	394	Адаптированная образовательная программа дошкольного образования для детей с ТНР (тяжелым нарушением речи) Муниципального бюджетного дошкольного образовательного учреждения детский сад «Солнышко» с. Красное Краснинского района Липецкой области	2026-08-21 15:51:15.108635	https://ds-solnyshko-krasnoe-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
476	402	Адаптированная основная образовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://n-tschemodanowo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
477	404	Адаптированная ООП образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ им. Л.Н. Толстого (вариант 1) (с изменениями и дополнениями)	2026-08-21 15:51:15.108635	https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
478	404	Адаптированная ООП образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ им. Л.Н. Толстого (вариант 2) (с изменениями и дополнениями)	2026-08-21 15:51:15.108635	https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
479	404	Адаптированная основная общеобразовательная программа образования обучающихся с задержкой психического развития (ЗПР)	2026-08-21 15:51:15.108635	https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
481	404	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с расстройствами аутистического спектра	2026-08-21 15:51:15.108635	https://ltschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
482	405	Адаптированная образовательная программа дошкольного образования для детей с ТНР МБДОУ д/с «Колосок» п. Лев Толстой	2026-08-21 15:51:15.108635	https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
483	405	Адаптированная образовательная программа дошкольного образования для детей с ЗПР МБДОУ д/с «Колосок» п. Лев Толстой	2026-08-21 15:51:15.108635	https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
484	405	Адаптированная образовательная программа дошкольного образования для детей с НИ МБДОУ д/с «Колосок» п. Лев Толстой	2026-08-21 15:51:15.108635	https://ltkolosok.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
487	409	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.3)	2026-08-21 15:51:15.108635	https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
488	409	Адаптированная основная общеобразовательная программа начального общего образования для слабовидящих обучающихся (вариант 4.2)	2026-08-21 15:51:15.108635	https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
489	409	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 8.2)	2026-08-21 15:51:15.108635	https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
490	409	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с нарушениями опорно-двигательного аппарата (вариант 6.4)	2026-08-21 15:51:15.108635	https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
491	409	Адаптированная основная образовательная программа основного общего образования обучающихся с интеллектуальными нарушениями (вариант 1)	2026-08-21 15:51:15.108635	https://schoolilyino.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
492	414	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://sh48pruzhinki.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
493	415	Адаптированная общеобразовательная программа обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sc-sentsovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
494	416	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-08-21 15:51:15.108635	https://syrskoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
495	416	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с задержкой психического развития (вариант 7.2)	2026-08-21 15:51:15.108635	https://syrskoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
496	417	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://sh-lubna48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
497	418	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.1)	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
498	418	Адаптированная основная общеобразовательная программа начального общего образования для обучающихся с РАС с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), ТМНР (вариант 8.4)	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
499	418	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
500	418	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2) 1 – 9 классы	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
501	418	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития 10 – 12 классы (вариант 2)	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
502	418	Адаптированная основная общеобразовательная программа обучающихся с умеренной, тяжелой глубокой, умственной отсталостью (интеллектуальными нарушениями), ТМНР с расстройствами аутистического спектра (вариант 2)	2026-08-21 15:51:15.108635	https://sctroickoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
503	422	Адаптированная образовательная программа для детей – инвалидов и детей с ОВЗ муниципального бюджетного дошкольного образовательного учреждения детский сад "Липка" села Ильино Липецкого муниципального округа	2026-08-21 15:51:15.108635	https://dslipka.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
504	427	Адаптированная образовательная программа с ТНР	2026-08-21 15:51:15.108635	https://ds-petushok-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
505	430	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой, глубокой умственной отсталостью (интеллектуальными нарушениями), тяжелыми и множественными нарушениями развития (вариант 2)	2026-08-21 15:51:15.108635	https://sh-lamskaya-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
506	434	Адаптированная образовательная программа дошкольного образования для детей с расстройством аутистического спектра (РАС)	2026-08-21 15:51:15.108635	https://dsteremokstanovoe.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
507	445	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sc-terbuny.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
508	451	Адаптированная основная общеобразовательная программа начального общего образования слабовидящих обучающихся (вариант 4.2)	2026-08-21 15:51:15.108635	https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
509	451	Адаптированная основная образовательная программа начального общего образования для обучающихся с расстройствами аутистического спектра (вариант 8.2)	2026-08-21 15:51:15.108635	https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
510	451	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) вариант 1	2026-08-21 15:51:15.108635	https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
511	451	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)	2026-08-21 15:51:15.108635	https://sh2-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
512	452	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 2)	2026-08-21 15:51:15.108635	https://uschool3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
513	452	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://uschool3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
514	454	Адаптированная основная образовательная программа обучающихся с умственной отсталостью (интеллектуальными нарушениями), с тяжелыми нарушениями речи (вариант 5.2)	2026-08-21 15:51:15.108635	https://sc-dryazgi.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
515	455	Адаптированная основная образовательная программа для обучающихся с УО (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
516	455	Адаптированная основная образовательная программа для обучающихся с УО (интеллектуальными нарушениями) (вариант 2)	2026-08-21 15:51:15.108635	https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
517	455	Адаптированная основная образовательная программа начального общего образования для обучающихся с РАС (вариант 8.4)	2026-08-21 15:51:15.108635	https://zavshkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
518	456	Адаптированная основная образовательная программа обучающихся с интеллектуальными нарушениями	2026-08-21 15:51:15.108635	https://sh-oktyabrskoye.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
519	459	Адаптированная образовательная программа дошкольного образования для детей с ТНР и ЗПР МБДОУ ЦРР – д/с Сказка г Усмани на 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://ds-skazka-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
520	460	Адаптированная образовательная программа дошкольного образования для детей с тяжёлыми нарушениями речи (ТНР) Муниципального бюджетного дошкольного образовательного учреждения детский сад «Почемучка» г. Усмани	2026-08-21 15:51:15.108635	https://ds-pochemuchka-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/#adaptirovannye-obrazovatelnye-programmy
521	461	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://ds-teremok-usman-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
522	470	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sh-poddubr-oosch.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
523	470	Адаптированная основная общеобразовательная программа для обучающихся с лёгкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://beresschkola.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
524	479	Адаптированная основная общеобразовательная программа образования МБОУ «Лицей села Хлевное» обучающихся с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://hlevnoeschool.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
525	480	Адаптированная основная общеобразовательная программа образования обучающихся с легкой умственной отсталостью (интеллектуальными нарушениями) (вариант 1)	2026-08-21 15:51:15.108635	https://sh-dmitryashevka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
526	483	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с ОВЗ (вариант 7.2.)	2026-08-21 15:51:15.108635	https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
527	483	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с легкой умственной отсталостью (вариант 1)	2026-08-21 15:51:15.108635	https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
529	492	Адаптированная образовательная программа начального общего образования (для 1-4 классов)	2026-08-21 15:51:15.108635	https://scolshanets.gosuslugi.ru/netcat_files/33/46/AOOP_UO_IN_kopiya.pdf
530	493	Адаптированная основная общеобразовательная программа для обучающихся с интеллектуальными нарушениями	2026-08-21 15:51:15.108635	https://panikovets.gosuslugi.ru/netcat_files/68/2854/Adaptirovannaya_programma_.pdf
531	499	Адаптированная ОП 2025-2026 уч.год	2026-08-21 15:51:15.108635	https://ds6zadonsk.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-op-2025-2026-uchgod.html
532	509	Адаптированная основная общеобразовательная программа образования обучающихся с умственной отсталостью (интеллектуальными нарушениями) МБОУ «Гимназия №1 имени Н.И.Борцова» города Лебедянь - 9 лет	2026-08-21 15:51:15.108635	https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
533	509	Адаптированная основная общеобразовательная программа начального общего образования обучающихся с задержкой психического развития (вариант 7.2) - 4 года	2026-08-21 15:51:15.108635	https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
534	509	Адаптированная основная общеобразовательная программа основного общего образования обучающихся с задержкой психического развития - 5 лет	2026-08-21 15:51:15.108635	https://gimn1lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
535	513	Адаптированная образовательная программа образования детей с умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://shkuyman.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
536	514	Адаптированная образовательная программа для детей с умственной отсталостью 1 вариант	2026-08-21 15:51:15.108635	https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_105.html
537	514	Адаптированная образовательная программа для детей с умственной отсталостью 2 вариант	2026-08-21 15:51:15.108635	https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_106.html
538	514	АООП НОО для обучающихся с ЗПР	2026-08-21 15:51:15.108635	https://scolhov.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_107.html
539	515	Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) ВАРИАНТ 1	2026-08-21 15:51:15.108635	https://shbpopovo.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/AOOP/AOOP_variant_1.pdf
540	515	Адаптированная образовательная программа для обучающихся с умственной отсталостью (интеллектуальными нарушениями) ВАРИАНТ 2	2026-08-21 15:51:15.108635	https://shbpopovo.gosuslugi.ru/netcat_files/userfiles/Obrazovanie/AOOP/AOOP_VARIANT_2.pdf
541	516	Адаптированная основная общеобразовательная программа образования обучающихся с умеренной, тяжелой и глубокой умственной отсталостью (интеллектуальными нарушениями)	2026-08-21 15:51:15.108635	https://shmokroe.gosuslugi.ru/netcat_files/68/1859/Adaptirovannaya_programma_1.pdf
542	518	Адаптированная образовательная программа для детей с ЗПР	2026-08-21 15:51:15.108635	https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-zpr-na-2024-2024-uchg.html
543	518	Адаптированная образовательная программа для детей с УО	2026-08-21 15:51:15.108635	https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-uo-na-2024-2024-uchg.html
544	518	Адаптированная образовательная программа для детей с ТНР	2026-08-21 15:51:15.108635	https://ds2lebed.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr-na-2024-2024-uchg.html
545	519	Адаптированная образовательная программа ЗПР на 2025-2026 учебный год.	2026-08-21 15:51:15.108635	https://lebds3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-zpr-na-2024-2025-uchebnyy-god.html
546	519	Адаптированная образовательная программа для детей с ТНР на 2025-2026 учебный год	2026-08-21 15:51:15.108635	https://lebds3.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/adaptirovannaya-obrazovatelnaya-programma-na-2024-2025-uchebnyy-god.html
547	520	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-08-21 15:51:15.108635	https://ds-kolobok-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/162/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_detey_s_tyazhelymi_narusheniyami_rechi_na_2025_2026_uchebnyy_god_0.pdf
548	520	Адаптированная образовательная программа дошкольного образования для детей с задержкой психического развития	2026-08-21 15:51:15.108635	https://ds-kolobok-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/162/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_detey_s_zaderzhkoy_psihicheskogo_razvitiya_na_2025_2026_uchebnyy_god_0.pdf
549	521	Адаптированная образовательная программа дошкольного образования для обучающихся с тяжёлым нарушением речи	2026-08-21 15:51:15.108635	https://ds5-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-tyazhelym-narusheniem-rechi.html
550	521	Адаптированная образовательная программа дошкольного образования для обучающихся с задержкой психического развития	2026-08-21 15:51:15.108635	https://ds5-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-obuchayuschihsya-s-zaderzhkoy-psihicheskogo-razvitiya.html
551	522	Адаптированная образовательная программа дошкольного образования для детей с тяжелыми нарушениями речи	2026-08-21 15:51:15.108635	https://ds6-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Uchebnyy_plan_po_AOP.pdf
552	523	Адаптированная образовательная программа дошкольного образования для детей с ТНР	2026-08-21 15:51:15.108635	https://ds-cheremushki-lebedyan-r42.gosweb.gosuslugi.ru/netcat_files/28/135/Programma_TNR_2025g.pdf
553	523	Адаптированная образовательная программа дошкольного образования для детей детей с задержкой психического развития	2026-08-21 15:51:15.108635	https://cheremushki-lebedyan.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/
554	524	Компенсирующая образовательная адаптированная программа	2026-08-21 15:51:15.108635	https://elochkatroekyrovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_91.html
555	524	Коррекционная образовательная адаптированная программа	2026-08-21 15:51:15.108635	https://elochkatroekyrovo.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_93.html
560	196	Адаптированная образовательная программа дошкольного образования для воспитанников с нарушением речи (ТНР) муниципального автономного общеобразовательного учреждения средняя школа № 59 «Перспектива» г. Липецка	2026-08-23 21:22:08.397237	\N
561	221	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с нарушениями речи 4-8 лет Муниципального автономного дошкольного образовательного учреждения детского сада № 14 г. Липецка	2026-08-23 21:50:53.68253	\N
562	221	Адаптированная образовательная программа дошкольного образования коррекционно-развивающей работы для детей с задержкой психического развития 5-8 лет Муниципального автономного дошкольного образовательного учреждения детского сада № 14 г. Липецка	2026-08-23 21:50:53.68253	\N
563	212	Адаптированная основная образовательная программа для детей с ТНР муниципального автономного дошкольного образовательного учреждения № 2 города Липецка	2026-08-23 21:51:25.765832	\N
564	212	Адаптированная основная образовательная программа для детей с ЗПР муниципального автономного дошкольного образовательного учреждения № 2 города Липецка	2026-08-23 21:51:25.765832	\N
565	231	Адаптированная образовательная программа дошкольного образования коррекционно - развивающей направленности для детей с тяжелыми нарушениями речи Муниципального автономного дошкольного образовательного учреждения детский сад №30 г. Липецка	2026-08-23 21:52:06.872532	\N
566	485	Федеральна адаптированная образовательная программа дошкольного образования для обучающихся с ограниченными возможностями здоровья	2026-08-23 21:55:02.852063	\N
569	407	Адаптированная образовательная программа дошкольного образования для детей с ТНР МБДОУ «Радуга»	2026-08-23 21:59:41.427333	\N
570	407	Адаптированная образовательная программа дошкольного образования для детей с ЗПР МБДОУ «Радуга»	2026-08-23 21:59:41.427333	\N
\.


--
-- Data for Name: condition_types; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.condition_types (code, name_ru, description, created_at) FROM stdin;
hearing_impairment	Нарушения слуха	Для детей с нарушениями слуха	2025-12-02 16:47:37.828466
vision_impairment	Нарушения зрения	Для детей с нарушениями зрения	2025-12-02 16:47:37.828466
speech_impairment	Нарушения речи	Для детей с тяжелыми нарушениями речи	2025-12-02 16:47:37.828466
intellectual_impairment	Нарушение интеллекта	Для детей с интеллектуальными нарушениями	2026-08-23 19:34:35.918237
musculoskeletal_impairment	Нарушения опорно-двигательного аппарата	Для детей с НОДА	2025-12-02 16:47:37.828466
psychic_development_delay	Задержка психического развития	Для детей с задержкой психического развития	2026-08-23 19:59:17.338578
mental_retardation	Умственная отсталость	Для детей с умственной отсталостью	2025-12-02 16:47:37.828466
autism	Расстройство аутистического спектра	Для детей с расстройством аутистического спектра	2025-12-02 16:47:37.828466
multiple_disorders	Множественные нарушения	Для детей с тяжёлыми и множественными нарушениями развития	2025-12-02 16:47:37.828466
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.directors (id, full_name, phone, email, created_at, updated_at) FROM stdin;
54	Конопелкина Елена Александровна	\N	malyshok-grz@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
55	Богданова Светлана Сергеевна	\N	ds-raduga-gryazi@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
59	Ли Диана Владимировна	\N	detskijsadv11@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
25	Жуликов Сергей Викторович	+74747735230	k-kol.teh@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:08:17.128255
7	Белкина Галина Владимировна	\N	galyabelckina@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:35:47.011723
9	Аксёнова Вера Николаевна	\N	sc-tupki@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 21:32:04.942256
8	Малявина Елена Анатольевна	\N	narschool2015@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:39:59.733191
5	Толмачева Ирина Александровна	\N	iratolmacheva.1982@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:40:27.738393
4	Еремин Федор Николаевич	\N	sc-troekur@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 21:40:46.326809
1	Подлесных Оксана Анатольевна	\N	shkola158@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:41:23.230596
6	Батищева Ирина Николаевна	\N	batisheva.71@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:41:41.302527
2	Степочкина Ольга Сергеевна	\N	sc2ch@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 21:41:57.586625
3	Яковлева Татьяна Сергеевна	\N	sch4chaplygin@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:42:25.758424
47	Остянко Людмила Александровна	+74746757810	elrsc25@yelets.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
15	Ролдугина Ирина Анатольевна	+74746725500	elschool15@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 12:37:34.974805
16	Демина Оксана Николаевна	+74746759619	sc17el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 12:38:15.989555
58	Субботина Ирина Васильевна	\N	dubravushka10@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 14:31:28.505595
45	Демидов Сергей Николаевич	+74747428384	te2e@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:56:56.554458
33	Шовская Ольга Петровна	+74746651248	pedcol@lebedyan.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:06:20.822713
27	Голикова Светлана Алексеевна	+74746653619	ltpitu@лтпиту.рф	2026-07-04 20:50:37.25445	2026-07-04 22:05:32.603661
14	Феодори Наталия Александровна	+74746757892	sc12el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
44	Левченко Наталия Ивановна	+74747123247	zainternat@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:09:09.858563
37	Дорохин Валерий Владимирович	+74747126459	zakollej@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 22:09:31.265175
49	Самойлова Ольга Николаевна	+74742288598	sc-erilovka@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 22:10:34.554016
50	Аксенова Мария Васильевна	+74746562320	dvkorrsh@rambler.ru	2026-07-04 20:50:37.25445	2026-07-04 22:21:12.614151
22	Халдаров Сергей Сергеевич	+74746566055	goapoudapt@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 22:19:53.468977
38	Шуршуков Юрий Юрьевич	+74742433544	lmk@zdrav48.ru	2026-07-04 20:50:37.25445	2026-07-04 22:22:27.972574
52	Краснобородько Наталья Евгеньевна	+74742438713	sanatorij@lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:23:28.41713
24	Подмарков Роман Валентинович	+74742403754	LKTDH@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:25:16.663577
39	Грязева Наталья Юрьевна	+74742413435	lisk.lipetsk@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:26:05.541331
40	Красникова Любовь Николаевна	+74742745860	lmk@lmk-lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:27:12.44242
35	Сапронов Даниил Сергеевич	+74742413307	Kiimo@admlr.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:28:06.112773
41	Токарев Роман Александрович	+74742577042	ltsd48@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 22:28:42.24618
43	Дворникова Мария Викторовна	+74742412461	icollege@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:29:24.495857
28	Волков Алексей Александрович	+74742430161	lpt-48@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:30:06.32592
29	Веселова Ольга Владимировна	+74742414171	kolledgisskusstv@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 22:30:50.144928
30	Ермолов Юрий Алексеевич	+74747521797	cac@chaplygin.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-05 09:27:00.81202
56	Фалькович Татьяна Николаевна	\N	detsad-rodnichek@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 14:33:31.481051
57	Чурилова Татьяна Александровна	\N	ds9gr48.tchurilowa@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 14:33:52.571454
17	Анчуков Игорь Петрович	+74746767040	sc18el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
48	Терновых Екатерина Анатольевна	+74746126605	centr.t48@xmail.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
21	Пирогова Вера Алексеевна	+74746746536	sc97el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:56:34.996257
23	Меньших Елена Валериевна	+74746759938	el.mk@zdrav48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:56:34.996257
26	Васильев Павел Юрьевич	+74746740336	elpu1@yelets.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-05 09:56:34.996257
10	Гришанова Ольга Васильевна	+74746727346	sc1el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
31	Савишина Ирина Васильевна	+74746122501	info@gtk-gryazi.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
32	Евсеев Роман Юрьевич	+74746726302	epet48@inbox.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
34	Смольянинов Олег Алексеевич	+74747221459	uspk48@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
36	Бабайцева Виктория Юрьевна	+74746746086	egki.uch@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
42	Афанасьев Юрий Владимирович	+74747240516	usmagrokol@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 10:00:25.942917
53	Кочкина Виктория Владимировна	\N	1detskii.sad@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 14:34:30.926328
64	Митьковец Ирина Александровна	\N	detsckiisad.S@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
112	Кочанов Евгений Григорьевич	\N	soh1gr@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
113	Спесивцева Ольга Петровна	\N	shcool2@bk.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
114	Ананских Алексей Михайлович	\N	sc3gr@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
115	Брезицкая Оксана Васильевна	\N	grsk4@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
116	Корнеева Елена Александровна	\N	scool_grazi5@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
117	Алпатова Виктория Александровна	\N	scool_gryazi6@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
118	Соболев Александр Олегович	\N	griazy-sch-9@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
119	Павлова Вера Ивановна	\N	grsk1@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
65	Джавадова Оксана Алексеевна	\N	dskolokolchik2013@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:31:14.852399
83	Гончарова Елена Александровна	+74742272224	lip@ranepa.ru	2026-07-04 20:50:37.25445	2026-07-04 22:31:48.412998
74	Ступа Елена Викторовна	\N	novopolanieds@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:34:31.911177
66	Некрасова Людмила Викторовна	\N	svetlyachek-ds@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:35:36.789204
84	Кузьмин Алексей Михайлович	+74742272224	elec@rgups.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
63	Грушихина Ольга Алексеевна	\N	madou-skazka@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:36:13.346073
62	Ульшина Ирина Ивановна	\N	svetliachek48@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:22:41.727607
71	Кривоносова Ольга Сергеевна	\N	olgakrivonosova@inbox.ru	2026-07-04 20:50:37.25445	2026-07-05 09:30:39.818026
90	Чурсина Елена Анатольевна	\N	nezabudkaelets@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
70	Моисеева Светлана Николаевна	\N	dscheburashka.m@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:26:23.815752
75	Черешнева Ирина Геннадьевна	\N	irina.novoepetelino@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:44:05.359654
68	Седых Марина Михайловна	\N	t.belikova2014@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:29:55.151574
79	Загеева Лилия Александровна	+74742319069	mailbox@stu.lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:34:40.41717
78	Бунеева Раиса Ильинична	+74742724281	director@lki-lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-04 22:35:26.500863
80	Миронов Арсений Станиславович	+74742732201	lipetsk@mgutm.ru	2026-07-04 20:50:37.25445	2026-07-04 22:37:24.446911
81	Гончарова Елена Александровна	+74742279912	lip@ranepa.ru	2026-07-04 20:50:37.25445	2026-07-04 22:38:09.877827
77	Дворников Вячеслав Анатольевич	+74732027335	Postlip@vilec.ru	2026-07-04 20:50:37.25445	2026-07-04 22:45:56.075264
87	Чижова Ольга Анатольевна	+74746764238	ds3oa@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
67	Подлесных Светлана Владимировна	\N	Lana.podlesnyh.75@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 09:26:19.931498
72	Кудряшова Любовь Викторовна	+74747521733	\N	2026-07-04 20:50:37.25445	2026-07-05 09:29:13.032066
73	Григорьева Марина Владимировна	\N	malish-ds@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:32:59.608666
101	Власова Галина Алексеевна	+74746722527	detsky.sad32@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
102	Белых Наталья Александровна	+74746751077	detsad33yelets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
103	Болгова Татьяна Ильинична	+74746724167	detsad34yelets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
104	Меренкова Ирина Михайловна	+74746726609	ds36elets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
105	Минаева Ирина Александровна	+74746767416	zolkey-ru@rambler.ru	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
96	Терехова Оксана Евгеньевна	+74746754380	elds24@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:55:11.121657
97	Сафонова Людмила Васильевна	+74746723459	elets.svetlyachok48@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:55:11.121657
98	Пирогова Наталья Борисовна	+74746724176	detskijsad.berezka@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:55:11.121657
99	Ларина Галина Алексеевна	+74746750331	ds30elets@gmail.com	2026-07-04 20:50:37.25445	2026-07-05 09:55:11.121657
100	Авдеева Марина Васильевна	+74746722345	dou31skazka@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:55:11.121657
82	Яковенко Игорь Юрьевич	+74956096700	info@med-skills.ru	2026-07-04 20:50:37.25445	2026-07-05 10:01:04.897058
85	Щербатых Сергей Викторович	+74746722193	main@elsu.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
86	Христофорова Елена Серафимовна	+74746722453	eshr73@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
88	Демидова Елена Аркадиевна	+74746763118	detskijsad5-elets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
89	Горбенко Татьяна Николаевна	+74746723766	ddo-alenushka8@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
91	Огнева Наталья Васильевна	+74746744486	detskiysad14@gmail.com	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
92	Быткина Людмила Евгеньевна	+74746758401	detsckiisad.15@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
93	Павлова Ирина Алексеевна	+74746750318	ds.stroitel.7@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
76	Федина Нина Владимировна	+74742328303	priem@lspu-lipetsk.ru	2026-07-04 20:50:37.25445	2026-07-05 13:41:36.343953
60	Суринова Елена Константиновна	\N	syrinova79@mail.ru	2026-07-04 20:50:37.25445	2026-07-05 14:33:43.404891
61	Беззубцева Светлана Анатольевна	\N	rodsenyavka@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 14:34:19.385129
120	Митина Наталья Александровна	\N	_school12@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
121	Голышкина Виктория Викторовна	\N	sc-bsamovets@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
122	Кабанова Галина Ивановна	\N	gr-but-sch@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
123	Дегтерева Валентина Михайловна	\N	SC-vteleluy@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
124	Хрюкин Василий Алексеевич	\N	dvu_school@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
125	Бирюкова Антонина Викторовна	\N	shkolakazinka_gr@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
126	Никольский Александр Анатольевич	\N	karamshcool@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
127	Калинина Лилия Валентиновна	\N	kubanschool@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
128	Шептий Елена Михайловна	\N	sc-plehanovo@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
129	Шершнева Оксана Владимировна	\N	sc-pribytkovsky@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
130	Некрасов Эдуард Анатольевич	\N	sc-soshki@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
131	Федерякина Светлана Владимировна	\N	f_skool@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
132	Трушина Таиса Владимировна	\N	sc-korobovka@schols48.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
133	Киселева Наталья Леонидовна	\N	peskovschool@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
134	Малахова Людмила Александровна	\N	petrovkaschool@list.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
135	Зверева Людмила Валерьевна	\N	synjavka@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
136	Сокольских Лариса Николаевна	\N	shkola-yarlukovo@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445
11	Алехина Ирина Юрьевна	+74746724635	sc5el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
12	Позняк Татьяна Владимировна	+74746754671	sc10el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
95	Иванова Галина Александровна	\N	ya.kapelka21@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
108	Урюпина Жанна Александровна	+74746746594	rodnichok41@gmail.com	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
109	Иноземцева Вера Васильевна	+74746772621	ya.mbdou46@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
111	Австриевских Вера Павловна	+74746772314	ds84elets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-04 21:55:49.830689
46	Вишнякова Екатерина Анатольевна	+74742242777	sko34@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:24:24.78283
139	Нестерова Надежда Николаевна	+74742270962	lipetsk@fa.ru	2026-07-04 22:40:31.086569	2026-07-04 22:40:31.086569
110	Капитан Ольга Эдуардовна	+74746775697	kapitan71olga@mail.ru	2026-07-04 20:50:37.25445	2026-07-04 22:44:15.440983
69	Будакова Ирина Николаевна	\N	i.budakova2013@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:28:25.796145
18	Сергеева Алла Александровна	+74746724608	sc19el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
19	Красова Светлана Васильевна	+74746759084	sc23el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
20	Портнова Елена Владимировна	+74746762909	sc24el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
51	Беляева Олеся Анатольевна	+74747223173	sh.internat.usman@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 09:52:00.922407
106	Гнездилова Людмила Николаевна	+74746741283	mbdou39@gmail.com	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
107	Скрипкина Галина Ивановна	+74746741505	mbdou40@gmail.com	2026-07-04 20:50:37.25445	2026-07-05 09:54:09.837998
94	Кириченко Ольга Викторовна	+74746722502	ds17elets@yandex.ru	2026-07-04 20:50:37.25445	2026-07-05 10:03:10.610113
13	Камышанова Татьяна Геннадьевна	+74746740743	sc11el@schools48.ru	2026-07-04 20:50:37.25445	2026-07-05 12:38:36.218946
140	Тюнина Светлана Валерьевна	+74742250137	sc1lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
141	Власова Татьяна Алексеевна	+74742223676	sc2lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
142	Комкова Надежда Васильевна	+74742480123	sc3lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
143	Власова Елена Леонидовна	+74742430224	sc4lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
144	Конасова Екатерина Геннадьевна	+74742724850	sc5lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
145	Лебедь Ольга Викторовна	+74742419650	sc6lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
146	Воронин Кирилл Николаевич	+74742431271	sc7lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
147	Мехов Андрей Владимирович	+74742270051	sc8lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
148	Огнева Нина Алексеевна	+74742272226	sc9lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
149	Бельских Лилия Николаевна	+74742731224	sc10lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
150	Кокорева Ольга Николаевна	+74742438088	sc11lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
151	Уласевич Ольга Николаевна	+74742277358	sc12lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
152	Слесаренко Анна Николаевна	+74742350403	sc14lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
153	Бессонова Рената Сергеевна	+74742261701	sc15lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
154	Полянская Светлана Викторовна	+74438345759	sc16lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
155	Борисова Ирина Ивановна	+73305479752	sc17lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
156	Шведун Денис Владимирович	+74742727151	sc18lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
157	Буева Марина Александровна	+74742276513	sc19lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
158	Пшеничный Алексей Васильевич	+74742382400	sc20lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
159	Лежнев Сергей Алексеевич	+74742413080	sc21lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
160	Зыкова Галина Владимировна	+78977408284	sc23lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
161	Стрельников Антон Борисович	+74742345630	sc24lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
162	Архипова Галина Алексеевна	+74742731569	sc25lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
163	Цапенко Марина Сергеевна	+74742727118	sc26lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
164	Мочалов Александр Владимирович	+74742370727	sc27lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
165	Квасова Ирина Николаевна	+71171481001	sc28lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
166	Зайцева Татьяна Петровна	+74742540671	sc29lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
167	Ковтонюк Сергей Александрович	+74742565763	sc30lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
168	Несмеянова Инна Сергеевна	+71834731880	sc31lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
169	Томилина Наталья Александровна	+74742250861	sc32lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
170	Давыдова Любовь Владимировна	+74742473116	sc33lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
171	Клименко Ольга Сергеевна	+74742261034	sc34lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
172	Москалева Светлана Викторовна	+71126491497	sc35lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
173	Зотов Сергей Николаевич	+71800341845	sc36lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
174	Найденова Надежда Владимировна	+78686439020	sc37lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
175	Макарова Светлана Валентиновна	+71686432810	sc38lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
178	Малько Сергей Васильевич	+74742416278	sc42lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
180	Королева Наталья Серафимовна	+71802283540	sc45lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
181	Сай Пётр Игоревич	+74742346354	sc46lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
182	Катасонов Игорь Александрович	+78147340572	sc47lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
183	Шумов Анатолий Ильич	+74742317869	sc48lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
184	Плешков Владимир Викторович	+73781333549	sc49lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
179	Шишкина Ольга Сергеевна	+74653270463	sc44lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-23 20:11:39.942706
185	Чудин Владимир Геннадьевич	+72206334492	sc50lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
186	Ленкова Татьяна Анатольевна	+77735317634	sc51lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
187	Крапивина Светлана Николаевна	+70216340107	sc52lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
188	Волков Владимир Николаевич	+79366476754	sc54lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
189	Семенов Иван Андреевич	+74742355202	sc55lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
190	Бедрова Светлана Валерьевна	+74742200758	sc58lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
192	Борискина Светлана Александровна	+74742727475	sc60lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
193	Беляев Евгений Владимирович	+75501250484	sc61lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
194	Жбанова Ольга Алексеевна	+74742731403	sc62lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
195	Керекелица Сергей Александрович	+74742415822	sc63lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
196	Кушникова Валерия Петровна	+74742771360	sc64lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
197	Не указан	+74214324197	sc65lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
198	Иванов Кирилл Викторович	+74742410601	sc66lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
199	Щукина Ольга Александровна	+74742415098	sc68lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
200	Попов Виктор Алексеевич	+74742417826	sc69lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
201	Кириенко Анна Владимировна	+74742460823	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
202	Андреева Елена Вячеславовна	+73564479523	sc72lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
203	Гончарова Елена Николаевна	+73929473949	sc77lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
204	Соболева Ирина Александровна	+74742730429	sc2vlip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
206	Гулевская Елена Михайловна	+72994274419	lipetsksadik-1@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
208	Зайцева Наталия Викторовна	+70797773950	mdoulip.3@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
209	Грибкова Наталья Юрьевна	+71005261028	startum04@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
210	Не указан	+77182437284	lipetsksadik-5@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
211	Иноземцева Ольга Александровна	+78720457030	mdoulip6@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
212	Зубкова Наталья Ивановна	+72155479188	dou8lip@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
213	Попова Анна Андреевна	+70291335566	mdoulip9@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
214	Мазаева Елена Валентиновна	+74742732602	lipetsksadik-10@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
215	Волкова Тамара Александровна	+74742438753	mdoulip12@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
217	Лазарева Галина Валентиновна	+75353385377	dou15lipetsk@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
218	Найденкова Анна Евгеньевна	+70150349396	mdoulip18@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
219	Страхова Ирина Владимировна	+77930438007	sadik19lipetsk@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
220	Некрасова Мария Александровна	+71112371115	dou.20@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
221	Дмитрова Елена Евгеньевна	+77219450315	mdoulip21@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
222	Ушкова Полина Петровна	+71083287968	dou.22@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
223	Паршикова Тамара Васильевна	+73583453683	detsadskazka23@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
224	Ворфоломеева Нелли Борисовна	+76479427983	mdoulip25@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
225	Золотухина Раиса Дмитриевна	+74307224847	mdoulip29@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
227	Стрельникова Наталья Владиславовна	+75865575866	mdoulip32@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
228	Денисова Светлана Валентиновна	+75036455028	mdoulip35@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
229	Не указан	+74742370392	mdoulip37@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
230	Казарская Вера Николаевна	+74742480664	mdoulip38@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
231	Сиделева Лилия Викторовна	+70060450048	mdoulip40@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
232	Суполкина Людмила Николаевна	+71019430015	doy42@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
233	Романова Наталия Николаевна	+71522732600	mdoulip44@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
234	Быкова Тамара Валентиновна	+77384727503	mdoulip50@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
235	Шевчук Лидия Викторовна	+72381275138	detskiisad622010@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
236	Дедяева Ольга Викторовна	+74742728120	lipetsksadik-64@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
237	Целых Галина Васильевна	+77473345794	lipetsksadik-66@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
238	Бородина Ирина Александровна	+70329454614	mdoulip68@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
239	Сидорова Галина Валерьевна	+74742354443	mdoulip76@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
240	Кишларь Оксана Георгиевна	+71401731221	dou77lipetsk@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
241	Лиманская Алла Александровна	+79135233818	mdoulip78@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
242	Горяинова Ирина Васильевна	+71806261206	mdoulip79@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
243	Парфенова Ольга Сергеевна	+74742349459	mdoulip83@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
244	Дымова Юлия Алексеевна	+74742733321	mdoulip85@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
191	Гладышев Дмитрий Анатольевич	+74407316798	sc59lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-23 21:22:08.397237
216	Дубовых Надежда Егоровна	+72509480680	sokolsad14@mail.ru	2026-08-21 15:51:15.108635	2026-08-23 21:50:53.68253
207	Чернышов Иван Владимирович	+74742261901	ok2it@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:51:25.765832
226	Терехова Наталия Александровна	+77389370302	mdoulip30@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:52:06.872532
245	Коростелева Елена Валерьевна	+74737276209	mdoulip91@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
246	Брылева Елена Алексеевна	+70277334030	tatiana.bryleva@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
247	Побежимова Ирина Викторовна	+75803354700	dou-96@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
248	Беляева Любовь Тихоновна	+74742261014	lipetsksadik-98@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
249	Сотникова Нина Николаевна	+73904553903	detskiysad99@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
250	Шестакова Елена Степановна	+73632451146	dou101lipetsk@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
251	Еманова Оксана Ивановна	+71055450005	uspex103@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
252	Двуреченская Виктория Викторовна	+73095333745	skazka-105-dou@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
253	Соболева Ирина Вадимовна	+70818250122	lipetsk.sadik-107@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
254	Емельянова Ирина Владимировна	+78727493313	mdoulip110@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
255	Шацких Ольга Александровна	+79671439658	dou.112@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
256	Калинина Юлия Ильгизяровна	+74742775623	dou-113-2011@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
257	Серёгина Олеся Юрьевна	+78302250131	dou1142011@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
258	Бунеева Марина Геннадьевна	+77071455452	dou116@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
259	Наумова Наталья Николаевна	+77195261102	mdoulip119@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
260	Васина Галина Николаевна	+74742330034	mdoulip123@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
261	Соболев Вадим Владимирович	+74742340019	lipetsksadik-124@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
262	Белоусова Ольга Анатольевна	+71739571749	mdoulip126@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
263	Шувайкина Инга Валентиновна	+72994492966	mdoulip127@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
264	Не указан	+76661450282	iisadraduga128@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
265	Бутова Татьяна Петровна	+78433226157	mdoulip130@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
266	Будюкина Елена Александровна	+70113450161	lipetsksadik-133@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
267	Вепренцева Юлия Васильевна	+70130431757	mdoulip134@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
268	Полянская Татьяна Ивановна	+74784416210	lipetsksadik135@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
269	Бирюкова Наталья Михайловна	+74742417232	mdoulip136@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
270	Фомичева Ирина Михайловна	+74742416883	mdoulip137@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
271	Краснова Елена Валентиновна	+76685460104	mdoulip138@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
272	Полянская Алла Вячеславовна	+70235720264	mdoulip139@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
273	Подоприхина Татьяна Алексеевна	+74747321003	sc-volovo@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
274	Митрохина Наталья Александровна	+74747323425	sc-zakharovka@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
275	Пикалов Сергей Александрович	+74747324197	bolhoe123@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
276	Сомова Ольга Павловна	+74747325413	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
279	Блинова Наталья Александровна	+77465662341	mousosh01@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
280	Карих Татьяна Ивановна	+74746561011	dankov.liceum6@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
281	Никонов Сергей Александрович	+74746553249	dvschoolbal@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
282	Синельникова Анна Александровна	+74746548190	schoolbigildino@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
283	Карнюшина Ирина Вячеславовна	+74746543135	ivanovkaschola@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
284	Коротких Тамара Анатольевна	+74746564020	dvschool4@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
285	Дементьева Любовь Дмитриевна	+74746566408	dou.solnyshko@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
286	Пинаева Нина Николаевна	+74746564061	dsromawka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
287	Солдатова Анна Михайловна	+74746562277	dankovdetsad3@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
288	Полетаева Оксана Николаевна	+74746561253	dou.yagodka4@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
289	Кожемякина Татьяна Михайловна	+74746562355	mdouskazka7@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
290	Михайлова Галина Викторовна	+74746562249	detskiisad.8marta@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
291	Волкова Светлана Владимировна	+74746555185	ds.sp-iv.maltseva@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
292	Лаухина Татьяна Алексеевна	+74746549191	yashkola@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
293	Селиванова Татьяна Михайловна	+74746221161	sc1dobr@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
294	Каширская Надежда Сергеевна	+74746223758	sc2dobr@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
295	Беляева Алена Валерьевна	+74746238030	olgovskaja2022@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
296	Пригородова Людмила Михайловна	+74746241332	sc-dubovoe@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
297	Афанасьев Иван Иванович	+74647230312	moumazeyka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
298	Бирюкова Анастасия Викторовна	+78474253361	sc-nmatrenka@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
299	Перова Любовь Васильевна	+79155574833	sc-vmatrenka@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
300	Исаева Елена Александровна	+74746245348	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
301	Яров Виктор Владимирович	+74746242431	sc-pushkino@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
302	Насонова Маргарита Игоревна	+74746257395	mouxvorostanka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
303	Нестерова Наталия Николаевна	+74746246346	shcolatalica@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
278	Митрохина Наталья Александровна	+74747323425	antipov4862@mail.ru	2026-08-21 15:51:15.108635	2026-08-23 21:49:27.053088
304	Зимина Оксана Юрьевна	+74746221275	detskiy_sad2@bk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
305	Орлова Екатерина Сергеевна	+74746221242	dbrkdetsad4@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
306	Дорофеева Елена Николаевна	+79205135768	ds-demshinka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
307	Бахтина Наталия Александровна	+74746238182	madou-plavica80@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
308	Раздобарина Марина Олеговна	+74746321208	dbe08@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
309	Ильин Евгений Алексеевич	+74746323005	sch02dobroe@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
310	Храброва Вера Николаевна	+74746343280	sc-bhomutets@scools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
311	Прилепина Оксана Яковлевна	+74746336173	skalikino@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
312	Рекутина Елена Николаевна	+74746336179	dbe06@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
313	Окунев Сергей Иванович	+74746337144	sch.krutoe@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
314	Кузнецова Надежда Николаевна	+74746331123	korenevshino@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
315	Кирина Валентина Ивановна	+74746334153	maxonovo@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
316	Крючкова Елена Викторовна	+74746342149	paninoschool@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
317	Чиликина Татьяна Сергеевна	+74746344222	scporoj@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
318	Сухова Римма Анатольевна	+74746347197	preobragenovka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
319	Чиликина Ольга Владимировна	+74746340589	trubetchino-school@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
320	Саввин Алексей Юрьевич	+74746332146	ekaterinovka-school@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
321	Татаринова Наталья Валерьевна	+74746321685	zolotoipetushokdsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
322	Никулина Ирина Анатольевна	+74746335199	nikulinairina2011@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
323	Пупышева Лилия Александровна	+74746322005	dobroe.malyshok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
324	Плешкова Елена Алексеевна	+74746343254	pleshkova.elena.teremok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
325	Чичикина Ольга Ивановна	+74746336222	lodobroesadik@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
326	Ломова Ольга Викторовна	+74746337175	olyalomowa@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
327	Берникова Ольга Владимировна	+74746342183	paninosad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
328	Войнова Елена Александровна	+74746340156	mdoy.solnischcko@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
329	Герасимова Светлана Ивановна	+74746330121	skazka.borisovka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
330	Татаринова Галина Александровна	+74746339234	galia.tatarinowa@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
331	Крысанова Марина Александровна	+74746341120	rodnichokzam@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
332	Кирина Вера Васильевна	+74746333322	krivec.detsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
333	Терёшина Лидия Ивановна	+74746338185	detsadkolobok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
334	Барабанова Елена Александровна	+74746821403	sch_dlg@dolgorukovo.lipetsk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
335	Ефимова Валентина Михайловна	+74746821500	dolgorukovo@admlr.lipetsk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
336	Карева Елена Юрьевна	+74746823222	v-lomovets@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
337	Малютина Галина Анатольевна	+74746825749	v-kazinka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
338	Кособокова Людмила Михайловна	+74746824317	sc-veselaya@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
339	Уразов Александр Александрович	+74746823535	stegschool@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
340	Павлова Алена Владимировна	+74746822747	dousolnce2015@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
341	Фомина Светлана Николаевна	+74746823469	grizlovo.detsckisad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
342	Парахина Марина Александровна	+74746824745	dubovez@inbox.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
343	Топорова Татьяна Вячеславовна	+74746823908	detsadekaterinovka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
344	Назарова Елена Викторовна	+74746791152	kamenskoe1@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
345	Логвиненко Валерий Викторович	+74746796339	elrsc17@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
346	Астапенко Алёна Сергеевна	+74746790471	klych-gizni@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
347	Милованова Оксана Николаевна	+74746793310	school_talitsa@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
348	Мяликова Елена Викторовна	+74746798524	sc-solidarnost@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
349	Фролова Лариса Ивановна	+74746795095	lavschool2008@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
350	Саранцева Екатерина Александровна	+74746791116	ivanovkaelr@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
351	Воробьева Ольга Александровна	+74746797749	sad-eletskiy2013@ya.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
352	Кустова Алена Андреевна	+74746790496	ds.gazoprovod@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
353	Малявина Светлана Владимировна	+74746796001	dousolnyshkokazaki@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
354	Бабушкина Юлия Сергеевна	+74746796200	mbdoutopolek@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
355	Овсянникова Альбина Владимировна	+74746797241	detsad2014@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
356	Данилкина Татьяна Николаевна	+74746791112	sad.kamenskoe@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
357	Пасмарнова Татьяна Александровна	+74746790123	detsadkl@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
358	Сидорова Елена Николаевна	+74746797428	dsmayak@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
359	Борисова Татьяна Ивановна	+74746798522	detskiisad.solidarnost@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
360	Романихина Елена Николаевна	+74746795206	sokolieds@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
361	Наталья Ивановна Степаненкова	+74746793395	detsadtalisa@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
362	Белых Елена Юрьевна	+74746799622	hmelinecdou@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
363	Пашкова Ирина Витальевна	+74747843376	sc-afanasyevo@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
364	Кузнецова Татьяна Викторовна	+74747833251	izmchol@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
365	Марахова Валентина Николаевна	+74747836234	preobrajnie@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
366	Кирюхина Надежда Александровна	+74747838182	sc-chernava@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
367	Коротин Александр Валерьевич	+74747822998	izmalkovo2@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
368	Шлеева Юлия Сергеевна	+74747839251	lebiaje2007@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
369	Насонова Валентина Николаевна	+74747831215	polev1elokoti@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
370	Барабан Татьяна Петровна	+74747834282	ssemenyok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
371	Анохина Мария Петровна	+74747833259	d-s.sloboda@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
372	Анисимова Татьяна Евгеньевна	+74747838134	anisimova.ev@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
373	Глухова Надежда Ивановна	+74747841280	ru4eek@inbox.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
374	Перцева Оксана Николаевна	+74747822829	dsned@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
375	Лошкарева Ольга Васильевна	+74747844233	denskazka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
376	Куринная Светлана Юрьевна	+74747837269	ter.bikovo2012@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
377	Ширинкина Ольга Николаевна	+74747821675	sad.solnyshcko@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
378	Воронина Оксана Георгиевна	+74747843546	mbdouromashka5@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
379	Быкова Елена Александровна	+74747838331	tat9914@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
380	Чернышова Любовь Васильевна	+74746961269	sotnicowo@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
381	Мешалкин Александр Николаевич	+74746976243	dubravor@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
382	Ряполова Оксана Васильевна	+74746920385	kcsh1@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
383	Волкова Диана Сергеевна	+74746964220	mazusergej@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
384	Конаныхин Михаил Иванович	+74746922123	vdsch@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
385	Кузнецов Юрий Николаевич	+74746966225	ds25-antoschka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
386	Елена Алексеевна Першина	+74746963337	ds.drezgalowo@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
387	Надежда Александровна Плоцких	+74746975211	rono@krasnoe.lipetask.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
388	Салихова Елена Николаевна	+74746920332	ya.detsky-sad@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
389	Гриднева Ольга Борисовна	+74746920402	sdetskiysad@bk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
390	Денисов Григорий Тихонович	+74746977244	rono@krasnoe.lipetsk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
391	Томилина Янна Александровна	+74746976249	koval.jana2015@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
392	Заичкина Елена Николаевна	+74746964306	ol.ponarina@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
393	Шевлякова Валентина Викторовна	+74746422070	levt@admlr.lipetsk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
394	Хромых Татьяна Николаевна	+74746424869	sc-sltolstoy@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
395	Пантюшин Роман Владимирович	+74746440145	ltshkyzovlevo@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
396	Тихонова Татьяна Александровна	+74746444153	sc-mityagino@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
397	Наседкина Ольга Анатольевна	+74746443118	n-tschemodanowo@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
398	Белевич Владимир Владимирович	+74746445195	sc-pervomayskoe@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
399	Пронина Ирина Викторовна	+74746424554	ltschool42@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
400	Мурыгина Светлана Михайловна	+74746421543	lt-kolosok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
401	Суховерова Виктория Владимировна	+74746422226	lt-teremok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
403	Кудаева Юлия Павловна	+74742761250	sch.borino@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
404	Ларшин Виктор Викторович	+74742756189	shkolailjno@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
405	Шишин Иван Игоревич	+74742766549	koschool@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
406	Волокитина Оксана Васильевна	+74742768448	lenino_school@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
407	Татьянина Наталия Серафимовна	+74742758235	new-derevnya@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
408	Фирсова Галина Александровна	+74742753285	n-dmitrievskaia@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
409	Беляева Любовь Сергеевна	+74742754110	sc-pruzhinki@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
410	Лобова Ольга Анатольевна	+74742752336	senchow@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
411	Кожевникова Галина Сергеевна	+74742489053	priem@syrskoe.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
412	Орлова Лариса Ивановна	+74742755537	lubna48@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
413	Пашенцева Светлана Ивановна	+74742759735	sch_troiz@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
414	Попова Лариса Ивановна	+74742768437	sc-hruschevka@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
415	Поленникова Людмила Анатольевна	+74742753744	schoolhd@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
416	Кудаева Юлия Павловна	+74742761116	borinosad@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
417	Стюфляева Елена Витальевна	+74742756070	doulipka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
418	Гурьева Людмила Важевна	+74742758281	romashkalip48@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
419	Перфилова Татьяна Александровна	+74742752393	mbdousolnyschko@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
420	Малютина Оксана Павловна	+74742759441	rucheek.18@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
421	Скуридина Татьяна Валерьевна	+74742753674	ya.mbdoupshelka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
422	Борис Оксана Вячеславовна	+74742766548	mbdou.petushok@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
423	Алисова Любовь Михайловна	+74747621465	stanovoeschool@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
424	Попов Петр Васильевич	+74747621638	imzstanovoe48@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
425	Руднева Анна Васильевна	+74747624269	info044@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
426	Огнева Ирина Ивановна	+74747628344	sekretar186@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
427	Ктоян Анжела Кимиковна	+74747627560	stan22trostnoe@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
428	Лаухина Татьяна Алексеевна	+74747622825	ckazkacad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
429	Малютина Светлана Алексеевна	+74747622826	dsteremokstanovoe@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
430	Шубина Татьяна Васильевна	+74747624166	lamskoembdou@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
431	Дятлова Наталья Николаевна	+74747628222	dybravychkasad@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
432	Пиндюрина Елена Олеговна	+74747627531	malysch.detskiisad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
433	Кочетова Нина Сергеевна	+74747626143	nin4kochetova@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
434	Серёгина Ирина Евгеньевна	+74747627702	dsrodnichok@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
435	Антонова Елена Владимировна	+74747627678	dmitrievkasad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
436	Батанова Татьяна Сергеевна	+74747628746	kirillovo-detsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
437	Панченкова Светлана Николаевна	+74747628149	elka@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
438	Бурцева Ольга Николаевна	+74747627333	teremok_pm@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
439	Прилепская Ольга Викторовна	+74747626718	jagodka.sad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
440	Моргачева Татьяна Николаевна	+74747429963	sc-terbuny@scools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
441	Антипов Сергей Александрович	+74747428185	morozov_serg73@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
442	Хромых Вера Владимировна	+74747422740	detskiysads@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
443	Караваева Оксана Николаевна	+74747422661	dskolokolchik1967@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
444	Сенюкова Ольга Васильевна	+74747421436	sieniukova77@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
445	Инна Анатольевна Шепелева	+74747221138	usmsch01@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
446	Прибыткова Галина Андреевна	+74747223041	46nadehda@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
447	Шарапова Надежда Ивановна	+74747221752	uschool03@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
448	Аринович Владислав Николаевич	+74747234645	devitsa@shcool48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
449	Петреева Римма Серафимовна	\N	drzschl@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
450	Попова Наталия Викторовна	+74747221044	rono@usman.lipetsk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
451	Аксенов Владимир Николаевич	+74747235293	mbousosh2012@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
452	Коровина Татьяна Сергеевна	+74747229332	shcoolst@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
453	Киселева Ольга Валентиновна	+74747239426	sc-nikolskoe@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
454	Глушкова Татьяна Серафимовна	+74747222049	ms.detsadskazka@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
455	Сосна Людмила Александровна	+74747223647	pochemuchka.usman@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
456	Полянских Елена Юрьевна	+74747221544	usmanteremok@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
457	Жданова Наталия Владимировна	+74747222543	natalia022012@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
458	Перова Елена Николаевна	+74747243045	rad.usman@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
459	Журавлева Вера Ивановна	+74747241812	neposeda-us@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
460	Кондрашина Татьяна Николаевна	+74747234748	rodnichok-devitsa@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
461	Невзорова Светлана Владимировна	+74747225595	kolobokzavalnoe@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
462	Китаева Лариса Петровна	+74747235287	dou-topol@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
463	Иванова Татьяна Владимировна	+74747229312	bereska-usm@rambler.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
464	Мешкова Елена Николаевна	+74747239351	mbdou-malvinka2013@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
465	Никонов Александр Владимирович	+74747226723	podd_zam@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
466	Горина Нина Валентиновна	+74747233846	nina.gorina.59@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
467	Якимова Галина Васильевна	+74747225381	jkimova69@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
468	Косых Марина Владимировна	+74747236918	marina.kosykh.68@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
469	Быханова Надежда Владимировна	+74747233845	byhanovanadezhda75@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
470	Асташова Наталия Владимировна	+74747237153	nataliya.astashova@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
471	Безрядина Елена Михайловна	+74747231137	lena.bezryadina.82@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
472	Самойлова Ирина Александровна	+74747234317	kolosok-2013@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
473	Татьяна Дмитриевна Щеглова	+74747234110	tatiana-shcheglova@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
474	Пожидаев Сергей Александрович	+74747721895	hlevnoeschool@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
475	Дедов Сергей Александрович	+74747738201	sc-dmitr@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
476	Тамбовцев Вячеслав Владимирович	+74747735124	sc-kkolodez@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
477	Болотов Сергей Анатольевич	+74747730210	sc-ndubovoe@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
478	Воронина Светлана Ивановна	+74747731187	sc-ellozovka@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
484	Красненкова Светлана Алексеевна	+74747125830	2zadonsk@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
485	Первеева Лариса Николаевна	+74747126499	schkool1@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
486	Селищева Людмила Анатольевна	+74747133453	sc-donskoe@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
487	Звягина Татьяна Николаевна	+74747142221	sc-olshanets@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
488	Белокопытова Ирина Викторовна	+74747147212	panicovec@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
489	Лысых Алексей Михайлович	+74747151238	sc-gnilusha@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
490	Якунина Марина Леонидовна	+74747135515	hmelinetc@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
491	Водопьянова Ольга Сергеевна	+74747121884	ds1zadonsk@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
492	Афансаьева Сайрагул	+74747121445	zadonsk-detsad3@bk.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
493	Коптева Светлана Николаевна	+74747126077	detskysad.5@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
494	Широбокова Елена Николаевна	+74747121112	ds6zadonsk.detskijsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
495	Архипова Нина Алексеевна	+74747121303	butyrki.detsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
496	Варфоломеева Анна Владимировна	+74747143245	detskisad.kashari@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
497	Скирда Ирина Николаевна	+74747132289	bolxovskoesad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
498	Чарикова Наталья Дмитриевна	+74747151440	gnilushadetsad5@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
499	Кареньких Ираида Ивановна	+74747133152	detsadik48@gmail.com	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
500	Руднева Инна Александровна	+74747142274	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
501	Пашенцева Ирина Валерьевна	+74747136222	dsrepets@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
502	Дмитриева Галина Владимировна	+74747147290	dspanikowets@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
503	Ширяева Валентина Тихоновна	+74747148255	ds-skornykovo.shiryaeva2016@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
504	Селезнева Ольга Николаевна	+74746652125	sc1leb@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
505	Афанасова Ольга Владимировна	+74742370218	fnv.63@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
506	Хрусталева Елена Николаевна	+74746664066	lebsosch3@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
507	Солдатова Елена Николаевна	+74746692395	sch.agr@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
508	Еремин Сергей Михайлович	+74746691231	kuiman@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
509	Масякина Елена Юрьевна	+74746644153	masykina-lena@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
510	Миляева Ирина Александровна	+74746693351	irina.milyaeva.72@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
511	Ступина Лариса Ильинична	+74746632362	stupina.lara2016@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
512	Мария Александровна Оруджева	+74746652060	mbdouds-1@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
513	Скакун Татьяна Павловна	+74746655115	ds2lebed@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
514	Жданова Оксана Алексеевна	+74746664846	lebds@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
515	Лунева Елена Вячеславовна	+74746664622	lebds4@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
516	Сысоева Татьяна Александровна	+74746657591	mbdou-ds5@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
517	Чупахина Ольга Станиславовна	+74746652552	lebds6@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
518	Попова Елена Анатольевна	+74746657640	madouds7@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
519	Егармина Елена Владимировна	+74746697184	aniaegarmina@yandex.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
520	Курочкина Анна Станиславовна	+74746692230	agronom.detsad@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
521	Кондратьева Ангелина Анатольевна	+74746642433	dsaddok@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
522	Клевцова Оксана Александровна	+74746691299	myssalina93@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
523	Чертовских Татьяна Александровна	+74746699147	tatjana.chertovskih@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
524	Клишина Ольга Вячеславовна	+74746693217	dsbpopovo@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
525	Быканов Михаил Михайлович	+74746693340	dssahzavoda@mail.ru	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635
526	Не указан	\N	utkino.zadonsk@no-contact.local	2026-08-21 15:52:53.651883	2026-08-21 15:52:53.651883
527	Не указан	\N	kultura.lebedyan@no-contact.local	2026-08-21 15:52:53.651883	2026-08-21 15:52:53.651883
176	Зенкова Ольга Юрьевна	+74742344061	sc40lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 16:19:53.473421
177	Сошкина Оксана Валентиновна	+74742480407	sc41lip@schools48.ru	2026-08-21 15:51:15.108635	2026-08-21 16:19:53.473421
277	Семкина Ольга Александровна	+74747321143	iskorka_48@mail.ru	2026-08-21 15:51:15.108635	2026-08-23 21:48:25.689411
479	Плотникова Наталья Николаевна	+74747722072	sadhlevnoe@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:53:01.371453
205	Лидия Григорьевна Куцак	+74742343863	integral@inbox.ru	2026-08-21 15:51:15.108635	2026-08-23 20:08:42.79151
481	Щербатых Татьяна Георгиевна	+74747741284	mbdoudetsade-malanino@mail.ru	2026-08-21 15:51:15.108635	2026-08-23 21:53:18.417417
483	Каменева Елена Александровна	+74747740141	sadverhn@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:54:36.583378
480	Татаринцева Елена Владимировна	+74747735192	sadik.kon@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:55:02.852063
482	Светлана Васильевна Кохан	+74747733276	vobsad@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:55:26.568387
402	Болотова Ирина Сергеевна	+74746423024	lt-ds-1@yandex.ru	2026-08-21 15:51:15.108635	2026-08-23 21:59:41.427333
\.


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.districts (id, name, created_at) FROM stdin;
186	г. Липецк	2026-07-04 20:50:37.25445
187	г. Елец	2026-07-04 20:50:37.25445
188	Воловский округ	2026-07-04 20:50:37.25445
189	Грязинский округ	2026-07-04 20:50:37.25445
190	Данковский округ	2026-07-04 20:50:37.25445
191	Добринский округ	2026-07-04 20:50:37.25445
192	Добровский округ	2026-07-04 20:50:37.25445
193	Долгоруковский округ	2026-07-04 20:50:37.25445
194	Елецкий округ	2026-07-04 20:50:37.25445
195	Задонский округ	2026-07-04 20:50:37.25445
196	Измалковский округ	2026-07-04 20:50:37.25445
197	Краснинский округ	2026-07-04 20:50:37.25445
198	Лебедянский округ	2026-07-04 20:50:37.25445
199	Лев-Толстовский район	2026-07-04 20:50:37.25445
200	Липецкий округ	2026-07-04 20:50:37.25445
201	Становлянский округ	2026-07-04 20:50:37.25445
202	Тербунский округ	2026-07-04 20:50:37.25445
203	Усманский округ	2026-07-04 20:50:37.25445
204	Хлевенский округ	2026-07-04 20:50:37.25445
205	Чаплыгинский округ	2026-07-04 20:50:37.25445
\.


--
-- Data for Name: institution_admission; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.institution_admission (institution_id, admission_code, created_at) FROM stdin;
10	certificate	2026-07-04 20:50:37.25445
11	attestat	2026-07-04 20:50:37.25445
12	attestat	2026-07-04 20:50:37.25445
13	attestat	2026-07-04 20:50:37.25445
14	attestat	2026-07-04 20:50:37.25445
15	attestat	2026-07-04 20:50:37.25445
16	attestat	2026-07-04 20:50:37.25445
17	attestat	2026-07-04 20:50:37.25445
18	attestat	2026-07-04 20:50:37.25445
19	attestat	2026-07-04 20:50:37.25445
20	attestat	2026-07-04 20:50:37.25445
21	certificate	2026-07-04 20:50:37.25445
22	attestat	2026-07-04 20:50:37.25445
24	attestat	2026-07-04 20:50:37.25445
27	attestat	2026-07-04 20:50:37.25445
32	attestat	2026-07-04 20:50:37.25445
33	attestat	2026-07-04 20:50:37.25445
37	attestat	2026-07-04 20:50:37.25445
48	certificate	2026-07-04 20:50:37.25445
49	certificate	2026-07-04 20:50:37.25445
55	attestat	2026-07-04 20:50:37.25445
56	attestat	2026-07-04 20:50:37.25445
60	attestat	2026-07-04 20:50:37.25445
65	attestat	2026-07-04 20:50:37.25445
89	attestat	2026-07-04 20:50:37.25445
90	attestat	2026-07-04 20:50:37.25445
91	certificate	2026-07-04 20:50:37.25445
92	certificate	2026-07-04 20:50:37.25445
93	certificate	2026-07-04 20:50:37.25445
94	attestat	2026-07-04 20:50:37.25445
95	certificate	2026-07-04 20:50:37.25445
96	certificate	2026-07-04 20:50:37.25445
97	certificate	2026-07-04 20:50:37.25445
98	certificate	2026-07-04 20:50:37.25445
99	attestat	2026-07-04 20:50:37.25445
100	certificate	2026-07-04 20:50:37.25445
101	certificate	2026-07-04 20:50:37.25445
102	certificate	2026-07-04 20:50:37.25445
103	attestat	2026-07-04 20:50:37.25445
104	certificate	2026-07-04 20:50:37.25445
105	certificate	2026-07-04 20:50:37.25445
106	certificate	2026-07-04 20:50:37.25445
107	certificate	2026-07-04 20:50:37.25445
108	certificate	2026-07-04 20:50:37.25445
109	certificate	2026-07-04 20:50:37.25445
110	certificate	2026-07-04 20:50:37.25445
111	certificate	2026-07-04 20:50:37.25445
112	attestat	2026-07-04 20:50:37.25445
113	certificate	2026-07-04 20:50:37.25445
114	certificate	2026-07-04 20:50:37.25445
116	certificate	2026-07-04 20:50:37.25445
117	attestat	2026-07-04 20:50:37.25445
118	attestat	2026-07-04 20:50:37.25445
119	attestat	2026-07-04 20:50:37.25445
120	attestat	2026-07-04 20:50:37.25445
121	attestat	2026-07-04 20:50:37.25445
122	attestat	2026-07-04 20:50:37.25445
123	attestat	2026-07-04 20:50:37.25445
124	attestat	2026-07-04 20:50:37.25445
125	attestat	2026-07-04 20:50:37.25445
126	attestat	2026-07-04 20:50:37.25445
127	attestat	2026-07-04 20:50:37.25445
128	attestat	2026-07-04 20:50:37.25445
129	attestat	2026-07-04 20:50:37.25445
130	certificate	2026-07-04 20:50:37.25445
131	attestat	2026-07-04 20:50:37.25445
132	attestat	2026-07-04 20:50:37.25445
133	attestat	2026-07-04 20:50:37.25445
134	attestat	2026-07-04 20:50:37.25445
135	attestat	2026-07-04 20:50:37.25445
136	attestat	2026-07-04 20:50:37.25445
137	attestat	2026-07-04 20:50:37.25445
138	attestat	2026-07-04 20:50:37.25445
139	attestat	2026-07-04 20:50:37.25445
140	attestat	2026-07-04 20:50:37.25445
141	attestat	2026-07-04 20:50:37.25445
142	attestat	2026-07-04 20:50:37.25445
143	attestat	2026-07-04 20:50:37.25445
144	attestat	2026-07-04 20:50:37.25445
52	certificate	2026-07-04 21:47:59.78362
43	attestat	2026-07-04 21:48:37.804979
35	attestat	2026-07-04 21:48:50.634797
46	certificate	2026-07-04 21:56:56.582053
28	attestat	2026-07-04 22:05:32.620166
34	attestat	2026-07-04 22:06:20.844794
26	attestat	2026-07-04 22:08:17.139286
45	certificate	2026-07-04 22:09:09.888396
38	attestat	2026-07-04 22:09:31.32371
50	certificate	2026-07-04 22:10:34.57606
23	attestat	2026-07-04 22:19:53.481362
51	certificate	2026-07-04 22:21:12.671141
39	attestat	2026-07-04 22:22:27.991367
53	certificate	2026-07-04 22:23:28.433848
47	certificate	2026-07-04 22:24:24.807209
25	attestat	2026-07-04 22:25:16.705885
40	attestat	2026-07-04 22:26:05.553581
41	attestat	2026-07-04 22:27:12.452677
36	attestat	2026-07-04 22:28:06.153588
42	attestat	2026-07-04 22:28:42.257841
44	attestat	2026-07-04 22:29:24.66627
29	attestat	2026-07-04 22:30:06.363688
30	attestat	2026-07-04 22:30:50.152717
87	attestat	2026-07-04 22:31:48.423482
77	attestat	2026-07-04 22:33:55.971755
81	attestat	2026-07-04 22:34:40.428727
80	attestat	2026-07-04 22:35:26.510632
83	attestat	2026-07-04 22:37:24.474843
84	attestat	2026-07-04 22:38:09.905072
82	attestat	2026-07-04 22:40:31.09913
115	certificate	2026-07-04 22:44:15.466799
79	attestat	2026-07-04 22:45:56.113936
85	attestat	2026-07-04 22:47:34.618514
31	attestat	2026-07-05 09:27:00.827641
\.


--
-- Data for Name: institution_conditions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.institution_conditions (institution_id, condition_code, created_at) FROM stdin;
10	mental_retardation	2026-07-04 20:50:37.25445
21	speech_impairment	2026-07-04 20:50:37.25445
49	mental_retardation	2026-07-04 20:50:37.25445
91	speech_impairment	2026-07-04 20:50:37.25445
92	speech_impairment	2026-07-04 20:50:37.25445
92	autism	2026-07-04 20:50:37.25445
93	vision_impairment	2026-07-04 20:50:37.25445
93	speech_impairment	2026-07-04 20:50:37.25445
93	autism	2026-07-04 20:50:37.25445
95	speech_impairment	2026-07-04 20:50:37.25445
96	speech_impairment	2026-07-04 20:50:37.25445
96	autism	2026-07-04 20:50:37.25445
97	speech_impairment	2026-07-04 20:50:37.25445
98	speech_impairment	2026-07-04 20:50:37.25445
98	autism	2026-07-04 20:50:37.25445
100	speech_impairment	2026-07-04 20:50:37.25445
101	speech_impairment	2026-07-04 20:50:37.25445
101	mental_retardation	2026-07-04 20:50:37.25445
102	speech_impairment	2026-07-04 20:50:37.25445
102	autism	2026-07-04 20:50:37.25445
102	mental_retardation	2026-07-04 20:50:37.25445
104	speech_impairment	2026-07-04 20:50:37.25445
105	speech_impairment	2026-07-04 20:50:37.25445
106	speech_impairment	2026-07-04 20:50:37.25445
107	speech_impairment	2026-07-04 20:50:37.25445
108	speech_impairment	2026-07-04 20:50:37.25445
108	autism	2026-07-04 20:50:37.25445
109	speech_impairment	2026-07-04 20:50:37.25445
109	mental_retardation	2026-07-04 20:50:37.25445
110	speech_impairment	2026-07-04 20:50:37.25445
110	autism	2026-07-04 20:50:37.25445
111	speech_impairment	2026-07-04 20:50:37.25445
113	speech_impairment	2026-07-04 20:50:37.25445
114	speech_impairment	2026-07-04 20:50:37.25445
114	autism	2026-07-04 20:50:37.25445
114	mental_retardation	2026-07-04 20:50:37.25445
114	musculoskeletal_impairment	2026-07-04 20:50:37.25445
116	speech_impairment	2026-07-04 20:50:37.25445
116	autism	2026-07-04 20:50:37.25445
130	speech_impairment	2026-07-04 20:50:37.25445
52	musculoskeletal_impairment	2026-07-04 21:47:59.764429
52	mental_retardation	2026-07-04 21:47:59.768053
52	autism	2026-07-04 21:47:59.778692
52	multiple_disorders	2026-07-04 21:47:59.781467
46	mental_retardation	2026-07-04 21:56:56.574413
46	autism	2026-07-04 21:56:56.577065
46	multiple_disorders	2026-07-04 21:56:56.579068
45	hearing_impairment	2026-07-04 22:09:09.877642
45	mental_retardation	2026-07-04 22:09:09.881344
50	mental_retardation	2026-07-04 22:10:34.570644
50	autism	2026-07-04 22:10:34.573367
51	mental_retardation	2026-07-04 22:21:12.664724
51	autism	2026-07-04 22:21:12.666836
51	multiple_disorders	2026-07-04 22:21:12.669063
53	mental_retardation	2026-07-04 22:23:28.43118
47	vision_impairment	2026-07-04 22:24:24.80216
47	mental_retardation	2026-07-04 22:24:24.805042
115	speech_impairment	2026-07-04 22:44:15.4645
434	autism	2026-08-23 19:46:04.65577
387	intellectual_impairment	2026-08-23 19:46:04.65577
255	speech_impairment	2026-08-23 19:46:04.65577
455	autism	2026-08-23 19:46:04.65577
316	intellectual_impairment	2026-08-23 19:46:04.65577
188	speech_impairment	2026-08-23 19:46:04.65577
300	vision_impairment	2026-08-23 19:46:04.65577
149	intellectual_impairment	2026-08-23 19:46:04.65577
181	speech_impairment	2026-08-23 19:46:04.65577
245	speech_impairment	2026-08-23 19:46:04.65577
178	musculoskeletal_impairment	2026-08-23 19:46:04.65577
509	intellectual_impairment	2026-08-23 19:46:04.65577
159	intellectual_impairment	2026-08-23 19:46:04.65577
219	speech_impairment	2026-08-23 19:46:04.65577
207	speech_impairment	2026-08-23 19:46:04.65577
513	intellectual_impairment	2026-08-23 19:46:04.65577
418	mental_retardation	2026-08-23 19:46:04.65577
160	musculoskeletal_impairment	2026-08-23 19:46:04.65577
214	speech_impairment	2026-08-23 19:46:04.65577
292	speech_impairment	2026-08-23 19:46:04.65577
229	speech_impairment	2026-08-23 19:46:04.65577
304	mental_retardation	2026-08-23 19:46:04.65577
409	vision_impairment	2026-08-23 19:46:04.65577
404	intellectual_impairment	2026-08-23 19:46:04.65577
182	hearing_impairment	2026-08-23 19:46:04.65577
230	speech_impairment	2026-08-23 19:46:04.65577
177	intellectual_impairment	2026-08-23 19:46:04.65577
460	speech_impairment	2026-08-23 19:46:04.65577
47	intellectual_impairment	2026-08-23 19:46:04.65577
223	mental_retardation	2026-08-23 19:46:04.65577
202	intellectual_impairment	2026-08-23 19:46:04.65577
169	autism	2026-08-23 19:46:04.65577
152	intellectual_impairment	2026-08-23 19:46:04.65577
149	speech_impairment	2026-08-23 19:46:04.65577
158	speech_impairment	2026-08-23 19:46:04.65577
328	speech_impairment	2026-08-23 19:46:04.65577
520	speech_impairment	2026-08-23 19:46:04.65577
168	intellectual_impairment	2026-08-23 19:46:04.65577
252	speech_impairment	2026-08-23 19:46:04.65577
182	mental_retardation	2026-08-23 19:46:04.65577
405	speech_impairment	2026-08-23 19:46:04.65577
305	musculoskeletal_impairment	2026-08-23 19:46:04.65577
409	musculoskeletal_impairment	2026-08-23 19:46:04.65577
248	speech_impairment	2026-08-23 19:46:04.65577
418	autism	2026-08-23 19:46:04.65577
249	speech_impairment	2026-08-23 19:46:04.65577
368	musculoskeletal_impairment	2026-08-23 19:46:04.65577
223	autism	2026-08-23 19:46:04.65577
258	vision_impairment	2026-08-23 19:46:04.65577
454	speech_impairment	2026-08-23 19:46:04.65577
246	speech_impairment	2026-08-23 19:46:04.65577
309	autism	2026-08-23 19:46:04.65577
416	mental_retardation	2026-08-23 19:46:04.65577
178	intellectual_impairment	2026-08-23 19:46:04.65577
157	multiple_disorders	2026-08-23 19:46:04.65577
358	speech_impairment	2026-08-23 19:46:04.65577
256	speech_impairment	2026-08-23 19:46:04.65577
157	intellectual_impairment	2026-08-23 19:46:04.65577
218	speech_impairment	2026-08-23 19:46:04.65577
233	speech_impairment	2026-08-23 19:46:04.65577
452	intellectual_impairment	2026-08-23 19:46:04.65577
46	intellectual_impairment	2026-08-23 19:46:04.65577
325	intellectual_impairment	2026-08-23 19:46:04.65577
202	mental_retardation	2026-08-23 19:46:04.65577
519	speech_impairment	2026-08-23 19:46:04.65577
174	autism	2026-08-23 19:46:04.65577
291	speech_impairment	2026-08-23 19:46:04.65577
153	intellectual_impairment	2026-08-23 19:46:04.65577
207	intellectual_impairment	2026-08-23 19:46:04.65577
253	speech_impairment	2026-08-23 19:46:04.65577
232	autism	2026-08-23 19:46:04.65577
516	intellectual_impairment	2026-08-23 19:46:04.65577
227	speech_impairment	2026-08-23 19:46:04.65577
430	multiple_disorders	2026-08-23 19:46:04.65577
518	speech_impairment	2026-08-23 19:46:04.65577
303	intellectual_impairment	2026-08-23 19:46:04.65577
225	autism	2026-08-23 19:46:04.65577
211	speech_impairment	2026-08-23 19:46:04.65577
160	autism	2026-08-23 19:46:04.65577
326	speech_impairment	2026-08-23 19:46:04.65577
191	speech_impairment	2026-08-23 19:46:04.65577
479	intellectual_impairment	2026-08-23 19:46:04.65577
276	speech_impairment	2026-08-23 19:46:04.65577
225	speech_impairment	2026-08-23 19:46:04.65577
454	intellectual_impairment	2026-08-23 19:46:04.65577
243	speech_impairment	2026-08-23 19:46:04.65577
285	intellectual_impairment	2026-08-23 19:46:04.65577
278	intellectual_impairment	2026-08-23 19:46:04.65577
339	intellectual_impairment	2026-08-23 19:46:04.65577
182	speech_impairment	2026-08-23 19:46:04.65577
451	autism	2026-08-23 19:46:04.65577
285	multiple_disorders	2026-08-23 19:46:04.65577
215	speech_impairment	2026-08-23 19:46:04.65577
303	multiple_disorders	2026-08-23 19:46:04.65577
459	speech_impairment	2026-08-23 19:46:04.65577
153	mental_retardation	2026-08-23 19:46:04.65577
493	intellectual_impairment	2026-08-23 19:46:04.65577
182	intellectual_impairment	2026-08-23 19:46:04.65577
49	intellectual_impairment	2026-08-23 19:46:04.65577
159	mental_retardation	2026-08-23 19:46:04.65577
404	autism	2026-08-23 19:46:04.65577
182	autism	2026-08-23 19:46:04.65577
101	intellectual_impairment	2026-08-23 19:46:04.65577
182	multiple_disorders	2026-08-23 19:46:04.65577
174	multiple_disorders	2026-08-23 19:46:04.65577
353	multiple_disorders	2026-08-23 19:46:04.65577
217	speech_impairment	2026-08-23 19:46:04.65577
237	speech_impairment	2026-08-23 19:46:04.65577
158	intellectual_impairment	2026-08-23 19:46:04.65577
394	speech_impairment	2026-08-23 19:46:04.65577
515	intellectual_impairment	2026-08-23 19:46:04.65577
480	intellectual_impairment	2026-08-23 19:46:04.65577
213	speech_impairment	2026-08-23 19:46:04.65577
418	intellectual_impairment	2026-08-23 19:46:04.65577
274	autism	2026-08-23 19:46:04.65577
313	intellectual_impairment	2026-08-23 19:46:04.65577
293	speech_impairment	2026-08-23 19:46:04.65577
304	intellectual_impairment	2026-08-23 19:46:04.65577
251	speech_impairment	2026-08-23 19:46:04.65577
416	intellectual_impairment	2026-08-23 19:46:04.65577
169	intellectual_impairment	2026-08-23 19:46:04.65577
250	speech_impairment	2026-08-23 19:46:04.65577
402	intellectual_impairment	2026-08-23 19:46:04.65577
235	speech_impairment	2026-08-23 19:46:04.65577
451	vision_impairment	2026-08-23 19:46:04.65577
261	speech_impairment	2026-08-23 19:46:04.65577
158	autism	2026-08-23 19:46:04.65577
522	speech_impairment	2026-08-23 19:46:04.65577
248	musculoskeletal_impairment	2026-08-23 19:46:04.65577
330	speech_impairment	2026-08-23 19:46:04.65577
159	multiple_disorders	2026-08-23 19:46:04.65577
416	multiple_disorders	2026-08-23 19:46:04.65577
514	mental_retardation	2026-08-23 19:46:04.65577
267	speech_impairment	2026-08-23 19:46:04.65577
362	speech_impairment	2026-08-23 19:46:04.65577
177	speech_impairment	2026-08-23 19:46:04.65577
258	speech_impairment	2026-08-23 19:46:04.65577
150	musculoskeletal_impairment	2026-08-23 19:46:04.65577
295	speech_impairment	2026-08-23 19:46:04.65577
414	intellectual_impairment	2026-08-23 19:46:04.65577
455	intellectual_impairment	2026-08-23 19:46:04.65577
275	speech_impairment	2026-08-23 19:46:04.65577
200	intellectual_impairment	2026-08-23 19:46:04.65577
222	speech_impairment	2026-08-23 19:46:04.65577
523	speech_impairment	2026-08-23 19:46:04.65577
202	autism	2026-08-23 19:46:04.65577
150	mental_retardation	2026-08-23 19:46:04.65577
353	intellectual_impairment	2026-08-23 19:46:04.65577
335	autism	2026-08-23 19:46:04.65577
262	speech_impairment	2026-08-23 19:46:04.65577
259	speech_impairment	2026-08-23 19:46:04.65577
149	mental_retardation	2026-08-23 19:46:04.65577
174	intellectual_impairment	2026-08-23 19:46:04.65577
430	intellectual_impairment	2026-08-23 19:46:04.65577
51	intellectual_impairment	2026-08-23 19:46:04.65577
200	mental_retardation	2026-08-23 19:46:04.65577
273	speech_impairment	2026-08-23 19:46:04.65577
177	vision_impairment	2026-08-23 19:46:04.65577
409	autism	2026-08-23 19:46:04.65577
232	speech_impairment	2026-08-23 19:46:04.65577
114	intellectual_impairment	2026-08-23 19:46:04.65577
206	speech_impairment	2026-08-23 19:46:04.65577
171	speech_impairment	2026-08-23 19:46:04.65577
300	autism	2026-08-23 19:46:04.65577
274	speech_impairment	2026-08-23 19:46:04.65577
427	speech_impairment	2026-08-23 19:46:04.65577
220	speech_impairment	2026-08-23 19:46:04.65577
418	multiple_disorders	2026-08-23 19:46:04.65577
344	musculoskeletal_impairment	2026-08-23 19:46:04.65577
417	intellectual_impairment	2026-08-23 19:46:04.65577
451	intellectual_impairment	2026-08-23 19:46:04.65577
180	intellectual_impairment	2026-08-23 19:46:04.65577
299	speech_impairment	2026-08-23 19:46:04.65577
177	mental_retardation	2026-08-23 19:46:04.65577
359	speech_impairment	2026-08-23 19:46:04.65577
52	intellectual_impairment	2026-08-23 19:46:04.65577
257	speech_impairment	2026-08-23 19:46:04.65577
257	autism	2026-08-23 19:46:04.65577
299	intellectual_impairment	2026-08-23 19:46:04.65577
53	intellectual_impairment	2026-08-23 19:46:04.65577
160	speech_impairment	2026-08-23 19:46:04.65577
409	intellectual_impairment	2026-08-23 19:46:04.65577
242	speech_impairment	2026-08-23 19:46:04.65577
387	mental_retardation	2026-08-23 19:46:04.65577
313	mental_retardation	2026-08-23 19:46:04.65577
470	intellectual_impairment	2026-08-23 19:46:04.65577
201	speech_impairment	2026-08-23 19:46:04.65577
404	mental_retardation	2026-08-23 19:46:04.65577
299	mental_retardation	2026-08-23 19:46:04.65577
238	speech_impairment	2026-08-23 19:46:04.65577
461	speech_impairment	2026-08-23 19:46:04.65577
299	multiple_disorders	2026-08-23 19:46:04.65577
181	vision_impairment	2026-08-23 19:46:04.65577
272	speech_impairment	2026-08-23 19:46:04.65577
360	speech_impairment	2026-08-23 19:46:04.65577
244	speech_impairment	2026-08-23 19:46:04.65577
415	intellectual_impairment	2026-08-23 19:46:04.65577
368	vision_impairment	2026-08-23 19:46:04.65577
264	speech_impairment	2026-08-23 19:46:04.65577
345	musculoskeletal_impairment	2026-08-23 19:46:04.65577
50	intellectual_impairment	2026-08-23 19:46:04.65577
157	mental_retardation	2026-08-23 19:46:04.65577
265	speech_impairment	2026-08-23 19:46:04.65577
509	mental_retardation	2026-08-23 19:46:04.65577
200	musculoskeletal_impairment	2026-08-23 19:46:04.65577
364	speech_impairment	2026-08-23 19:46:04.65577
152	mental_retardation	2026-08-23 19:46:04.65577
456	intellectual_impairment	2026-08-23 19:46:04.65577
234	speech_impairment	2026-08-23 19:46:04.65577
217	vision_impairment	2026-08-23 19:46:04.65577
236	speech_impairment	2026-08-23 19:46:04.65577
445	intellectual_impairment	2026-08-23 19:46:04.65577
240	speech_impairment	2026-08-23 19:46:04.65577
357	speech_impairment	2026-08-23 19:46:04.65577
202	multiple_disorders	2026-08-23 19:46:04.65577
228	speech_impairment	2026-08-23 19:46:04.65577
239	speech_impairment	2026-08-23 19:46:04.65577
224	speech_impairment	2026-08-23 19:46:34.976932
254	speech_impairment	2026-08-23 19:46:34.976932
247	speech_impairment	2026-08-23 19:46:34.976932
300	intellectual_impairment	2026-08-23 19:46:34.976932
521	speech_impairment	2026-08-23 19:46:34.976932
258	intellectual_impairment	2026-08-23 19:46:34.976932
269	speech_impairment	2026-08-23 19:46:34.976932
368	intellectual_impairment	2026-08-23 19:46:34.976932
45	intellectual_impairment	2026-08-23 19:46:34.976932
160	intellectual_impairment	2026-08-23 19:46:34.976932
186	intellectual_impairment	2026-08-23 19:46:34.976932
182	psychic_development_delay	2026-08-23 19:59:17.338578
300	psychic_development_delay	2026-08-23 19:59:17.338578
292	psychic_development_delay	2026-08-23 19:59:17.338578
451	mental_retardation	2026-08-23 19:59:17.338578
202	psychic_development_delay	2026-08-23 19:59:17.338578
261	psychic_development_delay	2026-08-23 19:59:17.338578
353	mental_retardation	2026-08-23 19:59:17.338578
519	psychic_development_delay	2026-08-23 19:59:17.338578
459	psychic_development_delay	2026-08-23 19:59:17.338578
21	psychic_development_delay	2026-08-23 19:59:17.338578
509	psychic_development_delay	2026-08-23 19:59:17.338578
368	psychic_development_delay	2026-08-23 19:59:17.338578
304	psychic_development_delay	2026-08-23 19:59:17.338578
233	psychic_development_delay	2026-08-23 19:59:17.338578
318	psychic_development_delay	2026-08-23 19:59:17.338578
153	psychic_development_delay	2026-08-23 19:59:17.338578
316	mental_retardation	2026-08-23 19:59:17.338578
515	mental_retardation	2026-08-23 19:59:17.338578
53	psychic_development_delay	2026-08-23 19:59:17.338578
274	psychic_development_delay	2026-08-23 19:59:17.338578
409	mental_retardation	2026-08-23 19:59:17.338578
214	psychic_development_delay	2026-08-23 19:59:17.338578
387	psychic_development_delay	2026-08-23 19:59:17.338578
215	psychic_development_delay	2026-08-23 19:59:17.338578
213	psychic_development_delay	2026-08-23 19:59:17.338578
483	psychic_development_delay	2026-08-23 19:59:17.338578
430	mental_retardation	2026-08-23 19:59:17.338578
116	psychic_development_delay	2026-08-23 19:59:17.338578
284	psychic_development_delay	2026-08-23 19:59:17.338578
96	psychic_development_delay	2026-08-23 19:59:17.338578
158	psychic_development_delay	2026-08-23 19:59:17.338578
479	mental_retardation	2026-08-23 19:59:17.338578
160	psychic_development_delay	2026-08-23 19:59:17.338578
114	psychic_development_delay	2026-08-23 19:59:17.338578
152	psychic_development_delay	2026-08-23 19:59:17.338578
232	psychic_development_delay	2026-08-23 19:59:17.338578
417	mental_retardation	2026-08-23 19:59:17.338578
483	mental_retardation	2026-08-23 19:59:17.338578
109	psychic_development_delay	2026-08-23 19:59:17.338578
230	psychic_development_delay	2026-08-23 19:59:17.338578
165	psychic_development_delay	2026-08-23 19:59:17.338578
416	psychic_development_delay	2026-08-23 19:59:17.338578
263	psychic_development_delay	2026-08-23 19:59:17.338578
259	psychic_development_delay	2026-08-23 19:59:17.338578
291	psychic_development_delay	2026-08-23 19:59:17.338578
102	psychic_development_delay	2026-08-23 19:59:17.338578
180	mental_retardation	2026-08-23 19:59:17.338578
257	psychic_development_delay	2026-08-23 19:59:17.338578
49	psychic_development_delay	2026-08-23 19:59:17.338578
265	psychic_development_delay	2026-08-23 19:59:17.338578
470	mental_retardation	2026-08-23 19:59:17.338578
219	psychic_development_delay	2026-08-23 19:59:17.338578
181	psychic_development_delay	2026-08-23 19:59:17.338578
521	psychic_development_delay	2026-08-23 19:59:17.338578
223	psychic_development_delay	2026-08-23 19:59:17.338578
220	psychic_development_delay	2026-08-23 19:59:17.338578
313	psychic_development_delay	2026-08-23 19:59:17.338578
339	mental_retardation	2026-08-23 19:59:17.338578
402	mental_retardation	2026-08-23 19:59:17.338578
269	psychic_development_delay	2026-08-23 19:59:17.338578
276	psychic_development_delay	2026-08-23 19:59:17.338578
150	psychic_development_delay	2026-08-23 19:59:17.338578
303	mental_retardation	2026-08-23 19:59:17.338578
342	mental_retardation	2026-08-23 19:59:17.338578
92	psychic_development_delay	2026-08-23 19:59:17.338578
110	psychic_development_delay	2026-08-23 19:59:17.338578
520	psychic_development_delay	2026-08-23 19:59:17.338578
244	psychic_development_delay	2026-08-23 19:59:17.338578
452	mental_retardation	2026-08-23 19:59:17.338578
480	mental_retardation	2026-08-23 19:59:17.338578
169	mental_retardation	2026-08-23 19:59:17.338578
149	psychic_development_delay	2026-08-23 19:59:17.338578
207	mental_retardation	2026-08-23 19:59:17.338578
174	mental_retardation	2026-08-23 19:59:17.338578
312	psychic_development_delay	2026-08-23 19:59:17.338578
305	psychic_development_delay	2026-08-23 19:59:17.338578
364	psychic_development_delay	2026-08-23 19:59:17.338578
258	psychic_development_delay	2026-08-23 19:59:17.338578
177	psychic_development_delay	2026-08-23 19:59:17.338578
252	psychic_development_delay	2026-08-23 19:59:17.338578
235	psychic_development_delay	2026-08-23 19:59:17.338578
234	psychic_development_delay	2026-08-23 19:59:17.338578
518	psychic_development_delay	2026-08-23 19:59:17.338578
256	psychic_development_delay	2026-08-23 19:59:17.338578
418	psychic_development_delay	2026-08-23 19:59:17.338578
285	mental_retardation	2026-08-23 19:59:17.338578
224	psychic_development_delay	2026-08-23 19:59:17.338578
218	psychic_development_delay	2026-08-23 19:59:17.338578
414	mental_retardation	2026-08-23 19:59:17.338578
101	psychic_development_delay	2026-08-23 19:59:17.338578
264	psychic_development_delay	2026-08-23 19:59:17.338578
245	psychic_development_delay	2026-08-23 19:59:17.338578
344	mental_retardation	2026-08-23 19:59:17.338578
178	mental_retardation	2026-08-23 19:59:17.338578
93	psychic_development_delay	2026-08-23 19:59:17.338578
237	psychic_development_delay	2026-08-23 19:59:17.338578
513	mental_retardation	2026-08-23 19:59:17.338578
404	psychic_development_delay	2026-08-23 19:59:17.338578
405	psychic_development_delay	2026-08-23 19:59:17.338578
415	mental_retardation	2026-08-23 19:59:17.338578
523	psychic_development_delay	2026-08-23 19:59:17.338578
516	mental_retardation	2026-08-23 19:59:17.338578
325	mental_retardation	2026-08-23 19:59:17.338578
159	psychic_development_delay	2026-08-23 19:59:17.338578
289	mental_retardation	2026-08-23 19:59:17.338578
229	psychic_development_delay	2026-08-23 19:59:17.338578
445	mental_retardation	2026-08-23 19:59:17.338578
262	psychic_development_delay	2026-08-23 19:59:17.338578
157	psychic_development_delay	2026-08-23 19:59:17.338578
108	psychic_development_delay	2026-08-23 19:59:17.338578
272	psychic_development_delay	2026-08-23 19:59:17.338578
200	psychic_development_delay	2026-08-23 19:59:17.338578
299	psychic_development_delay	2026-08-23 19:59:17.338578
454	mental_retardation	2026-08-23 19:59:17.338578
514	psychic_development_delay	2026-08-23 19:59:17.338578
284	mental_retardation	2026-08-23 19:59:17.338578
196	speech_impairment	2026-08-23 21:22:08.397237
221	speech_impairment	2026-08-23 21:50:53.68253
221	psychic_development_delay	2026-08-23 21:50:53.68253
212	speech_impairment	2026-08-23 21:51:25.765832
212	psychic_development_delay	2026-08-23 21:51:25.765832
231	speech_impairment	2026-08-23 21:52:06.872532
407	speech_impairment	2026-08-23 21:59:41.427333
407	psychic_development_delay	2026-08-23 21:59:41.427333
\.


--
-- Data for Name: institution_types; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.institution_types (code, name_ru, description, created_at) FROM stdin;
preschool	Дошкольное образовательное учреждение	Детские сады, ясли	2025-12-02 16:47:37.825252
school	Общеобразовательная школа	Средние общеобразовательные школы	2025-12-02 16:47:37.825252
school_internat	Школа-интернат	Школы-интернаты с круглосуточным пребыванием	2025-12-02 16:47:37.825252
spo	Среднее профессиональное образование	Колледжи, техникумы	2025-12-02 16:47:37.825252
vo	Высшее образование	Университеты, институты, академии	2025-12-02 16:47:37.825252
\.


--
-- Data for Name: institutions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.institutions (id, name, district_id, type_code, director_id, description, range_min, range_max, website, aoop_url, created_at, updated_at, address) FROM stdin;
17	МБОУ «Основная школа № 17 им. Т.Н. Хренникова»	187	school	16	Муниципальное бюджетное общеобразовательное учреждение "Основная школа № 17 им. Т.Н. Хренникова"	1.0	11.0	https://sc17el.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	Корпус №1: Липецкая область, г. Елец, ул. Алеши Оборотова, д.4 Корпус №2: Липецкая область, г. Елец, ул. Рязано-Уральская, д.43 Корпус №3: Липецкая область, г. Елец, ул. Верхняя, д.17
19	МБОУ «Школа № 19 г. Ельца»	187	school	18	Муниципальное бюджетное общеобразовательное учреждение «Школа № 19 города Ельца»	1.0	11.0	https://sc19elets.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	Российская Федерация Липецкая область, г.Елец, ул. М.Горького, д.113, 1 Корпус. ул. М.Горького, д.107, 2 Корпус
20	МБОУ «Средняя школа № 23 г. Ельца»	187	school	19	Муниципальное бюджетное общеобразовательное учреждение "Средняя школа №23 города Ельца"	1.0	11.0	https://sc23-elec.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399785, Липецкая область, город Елец, улица Известковая 71а (корпус 1), 399773, Липецкая область, город Елец, улица Вермишева 1 (корпус 2)
21	МБОУ «СШ №24 им.Героя Российской Федерации Н.И.Семочкина»	187	school	20	Муниципальное бюджетное общеобразовательное учреждение «СШ №24 им. Героя Российской Федерации Н.И. Семочкина»	1.0	11.0	https://sh24-elec.gosuslugi.ru/	https://sh24elec.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_programma_TNR.pdf	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399784, Липецкая область, г.Елец, ул.Гагарина, д.20 а
22	МБОУ "Гимназия № 97 г. Ельца".	187	school	21	Муниципальное бюджетное общеобразовательное учреждение "Гимназия № 97 г. Ельца".	1.0	11.0	https://gimn97-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399773, Липецкая область, г. Елец, ул. Клубная, д.10
50	ГБОУ «Специальная школа- интернат с. Ериловка»	194	school_internat	49	Государственное бюджетное общеобразовательное учреждение Липецкой области «Специальная школа – интернат с. Ериловка»	1.0	11.0	https://sh-spck-int-erilovka-r42.gosweb.gosuslugi.ru	https://sh-spck-int-erilovka-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399768, Липецкая область, Елецкий округ, сельское поселение Черкасский сельсовет, село Ериловка, ул. 40 лет Победы, дом 29
55	МБДОУ д/с №2 "Малышок" г. Грязи	189	preschool	54	Муниципальное бюджетное дошкольное образовательное учреждение детский сад №2 "Малышок" г. Грязи Грязинского муниципального округа Липецкой области	2.0	7.0	https://ds2griazy.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399053, г. Грязи, ул. Коммунальная, д. 16
83	ЛКИТиУ (филиал) ФГБОУ ВО «МГУТУ им. К.Г. Разумовского (ПКУ)»	186	vo	80	Липецкий казачий институт технологий и управления (филиал) федерального государственного бюджетного образовательного учреждения высшего образования «Московский государственный университет технологий и управления имени К.Г. Разумовского (Первый казачий университет)»	\N	\N	https://www.mgutu48.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	398006, г. Липецк, ул. Краснознаменная, влд. 4
87	Елецкий филиал АНО ВО «РосНОУ»	186	vo	83	Елецкий филиал Автономной некоммерческой организации высшего образования «Российский новый университет».	\N	\N	https://eletsrosnou.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	398050, г. Липецк, ул. Интернациональная, д. 3
89	ЕТЖТ - филиал РГУПС	187	vo	84	Елецкий техникум железнодорожного транспорта — филиал Ростовского государственного университета путей сообщения.	\N	\N	https://etgt.ru/index.php?option=com_content&task=view&id=35&Itemid=63	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399774, Россия, ЦФО, Липецкая область, г. Елец, ул. Вермишева, д. 12
90	ФГБОУ ВО "ЕГУ им. И.А. Бунина	187	vo	85	Федеральное государственное бюджетное образовательное учреждение высшего образования «Елецкий государственный университет им. И.А. Бунина».	\N	\N	https://elsu.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399770, Российская Федерация, Липецкая область, г. Елец, ул. Коммунаров, д. 28
124	МБОУ СОШ № 9 г. Грязи	189	school	118	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 9 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	https://sh9-gryazi-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	Липецкая область, город Грязи, улица Красная площадь, дом 37
125	МБОУ СОШ № 10 г. Грязи	189	school	119	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 10 города Грязи Грязинского муниципального округа Липецкой области.	1.0	11.0	https://sh10-gryazi-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399054 Липецкая область, г. Грязи, ул. 18 Партсъезд, дом 81 А
56	МБДОУ д/с №3 «Радуга» г. Грязи	189	preschool	55	Муниципальное бюджетное дошкольное образовательное учреждение детский сад №3 «Радуга» г. Грязи Грязинского муниципального округа Липецкой области	3.0	7.0	https://dou3gryazi.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:01:37.959489	399058, Липецкая область, город Грязи, улица Некрасова, дом 1
98	МБДОУ детский сад № 16 г.Ельца	187	preschool	93	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 16 города Ельца»	2.0	8.0	https://ds16elets.gosuslugi.ru/	https://ds16elets.gosuslugi.ru/netcat_files/19/8/aop_TNR_.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:01:37.959489	399782, Липецкая область, город Елец , пос. Строитель д.7А
59	МБДОУ д/с № 10 г. Грязи	189	preschool	58	Муниципальное бюджетное дошкольное образовательное учреждение детский сад № 10 г. Грязи Грязинского муниципального округа Липецкой области	2.0	7.0	https://ds-10dubravushka-gryazi-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399057, Российская Федерация, Липецкая область, Грязинский район, город Грязи, улица Бурденко, дом 10б
61	МБДОУ д/с "Радуга" с.Б.Самовец	189	preschool	60	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Радуга" с.Большой Самовец Грязинского муниципального округа Липецкой области	3.0	7.0	https://dssamovets.gosuslugi.ru/	https://dssamovets.gosuslugi.ru/netcat_files/19/8/AOP_Samovets.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399082, Липецкая область, Грязинский район, с.Б.Самовец, ул.Октябрьская, д.19 а
99	МБДОУ детский сад №17 г. Ельца	187	preschool	94	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №17 города Ельца»	3.0	7.0	https://ds17-elec-r42.gosweb.gosuslugi.ru/	https://ds17-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_osnovnaya_obrazovatel_naya_programma_4_.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399770, Россия, Липецкая область, город Елец,ул.Пригородная,д.30
102	МБДОУ детский сад № 25 г. Ельца	187	preschool	97	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 25 города Ельца»	3.0	7.0	https://ds25-elec-r42.gosweb.gosuslugi.ru/	https://ds25-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_TNR.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	Липецкая обл., г. Елец, ул. Ленина, д. 77
132	Муниципальное бюджетное общеобразовательное учреждение	189	school	\N	\N	1.0	11.0	\N	\N	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445	Грязинского муниципального района Липецкой области
140	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа п. свх. Песковатский Грязинского	189	school	\N	\N	1.0	11.0	\N	\N	2026-07-04 20:50:37.25445	2026-07-04 20:50:37.25445	\N
6	МБОУ СШ №1 с. Кривополянье	205	school	6	Муниципальное бюджетное общеобразовательное учреждение средняя школа села Кривополянье Чаплыгинского муниципального округа Липецкой области	1.0	11.0	https://sh1-krivopolyane-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	399940, Липецкая область, Чаплыгинский округ, село Кривополянье, улица Дзержинского, дом 35
1	МБОУ СШ №1 им. Героя Советского Союза Кузнецова Н.А.	205	school	1	Муниципальное бюджетное общеобразовательное учреждение средняя школа № 1 имени Героя Советского Союза Кузнецова Николая Алексеевича города Чаплыгина Липецкой области	1.0	11.0	https://shkola1-chap.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	РФ 399900 Липецкая область, Чаплыгинский округ, город Чаплыгин, улица Свободы, дом 2 а
2	МБОУ СШ №2 г.Чаплыгина	205	school	2	Муниципальное бюджетное общеобразовательное учреждение средняя школа №2 города Чаплыгина Чаплыгинского муниципального округа Липецкой области	1.0	11.0	https://sch2-chaplygin.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399900 Липецкая область, Чаплыгинский округ, город Чаплыгин, улица Ленина, дом
3	МБОУ СШ №4 г.Чаплыгина имени П.П.Семёнова-Тян-Шанского	205	school	3	Муниципальное бюджетное общеобразовательное учреждение средняя шкоа №4 города Чаплыгина Чаплыгинского муниципального округа Липецкой области имени Петра Петровича Семёнова-Тян-Шанского	1.0	11.0	https://sch4chaplygin.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399902, Липецкая область, город Чаплыгин, улица Советская, дом 10А
4	МБОУ СШ с.Троекурово	205	school	4	Муниципальное бюджетное общеобразовательное учреждение средняя школа села Троекурово Чаплыгинского муниципального округа Липецкой области	1.0	11.0	https://sh-troekurovo-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	\N
5	МБОУ СШ с. Колыбельское	205	school	5	Муниципальное бюджетное общеобразовательное учреждение средняя школа села Колыбельское Чаплыгинского муниципального округа Липецкой области	1.0	11.0	https://kolibschool.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399947, Липецкая область. Чаплыгинский округ, с. Колыбельское, ул. Центральная, д. 35
145	МБОУ «Гимназия №1» г.Липецка	186	school	140	\N	\N	\N	https://gimnazia1lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398001, г. Липецк, улица 8 Марта, д.22/4
146	МБОУ СШ №2 г.Липецка	186	school	141	\N	\N	\N	https://sc2lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398001, г. Липецк, ул. Первомайская, д. 58
7	МБОУ ОШ с. Пиково	205	school	7	Муниципальное бюджетное общеобразовательное учреждение основная школа села Пиково Чаплыгинского муниципального округа Липейкой области	1.0	11.0	https://sh-pikovo-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399932, Липецкая область, Чаплыгинский округ, село Пиково, ул. Школьная д.2
8	МБОУ ОШ с.Нарышкино	205	school	8	Муниципальное бюджетное общеобразовательное учреждение основная школа села Нарышкино Чаплыгинского муниципального округа Липейкой области	1.0	11.0	https://sh-naryshkino-lozovka-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399933 Липецкая область, Чаплыгинский округ, д. Лозовка
9	МБОУ ОШ п.Тупки	205	school	9	Муниципальное бюджетное общеобразовательное учреждение основная школа посёлка Тупки Чаплыгинского муниципального округа Липецкой области	1.0	11.0	https://sh-tupki-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, Чаплыгинский округ, п. Тупки, ул. Зеленая, д. 56
10	МБОУ СШ №1 им. М. М. Пришвина	187	school	10	Муниципальное бюджетное общеобразовательное учреждение "Средняя школа №1 им. М. М. Пришвина"	1.0	11.0	https://sh1-elec-r42.gosweb.gosuslugi.ru/	https://sh1-elec-r42.gosweb.gosuslugi.ru/netcat_files/33/46/RP_9.1.zip	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	1. Корпус №1 - 399770, Россия, Липецкая область, город Елец, ул. Советская, д.121 2. Корпус №2 - 399776, Россия, Липецкая область, г. Елец, ул. 3-й Ламской переулок, д. 43-а 3. Корпус №3 - 399770, Россия, Липецкая область, город Елец, ул. Профинтерна, д. 2-а
11	МБОУ «Лицей № 5 г. Ельца»	187	school	11	Муниципальное бюджетное общеобразовательное учреждение "Лицей №5 города Ельца"	1.0	11.0	https://lic5-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399774, Липецкая обл., г. Елец, ул. Спутников, д.9
13	МБОУ "СШ №10 с углубленным изучением отдельных предметов"	187	school	12	Муниципальное бюджетное общеобразовательное учреждение "Средняя школа №10 с углубленным изучением отдельных предметов".	1.0	11.0	https://sh10-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399774, Липецкая область, городской округ город Елец, улица Юбилейная, дом 7а
14	МБОУ "Гимназия № 11 г. Ельца"	187	school	13	Муниципальное бюджетное общеобразовательное учреждение "Гимназия № 11 города Ельца"	1.0	11.0	https://gimnaziya11.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399774, Липецкая обл., г. Елец, ул. Радиотехническая, д.3
15	МАОУ "СШ№12 им.Героя Российской Федерации В.А.Дорохина"	187	school	14	Мунициальное автономное общеобразовательное учреждение "Средняя школа №12 им. Героя Российской Федерации В.А. Дорохина" Липецкой области	1.0	11.0	https://sh12-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399778, Липецкая область. город Елец, мкрн. Александровский, д. 15
16	МБОУ «Основная школа № 15 г. Ельца»	187	school	15	Муниципальное бюджетное общеобразовательное учреждение "Основная школа №15 города Ельца"	1.0	11.0	https://elschool15.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399770 Российская Федерация, Липецкая область г. Елец, ул. Мира, д. 83 (корпус №1) г. Елец, ул. Мира, д. 84 (корпус №2)
23	ГОАПОУ ДАПТ	190	spo	22	Государственное областное автономное профессиональное образовательное учреждение «Данковский агропромышленный техникум»	\N	\N	https://goapoudapt.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399850, Липецкая область, город Данков, улица Островского, дом 30
24	ГАПОУ «ЕМК им. К.С. Константиновой»	187	spo	23	Государственное автономное профессиональное образовательное учреждение «Елецкий медицинский колледж имени Героя Советского Союза Ксении Семеновны Константиновой»	\N	\N	https://medel48.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399775, Липецкая область, г. Елец, ул. Рабочий поселок, д. 19
25	ГОАПОУ "ЛКТиДХ"	186	spo	24	Государственное областное автономное профессиональное образовательное учреждение «Липецкий колледж транспорта и дорожного хозяйства»	\N	\N	https://lktdh48.gosuslugi.ru/	https://docs.yandex.ru/docs/view?url=ya-disk-public%3A%2F%2FC6zthJIu1xeuKN5xpsUv8REcDnbsGGziYskExvVu5XCI%2FzgsPc5WwrMMjofNfY9eq%2FJ6bpmRyOJonT3VoXnDag%3D%3D&name=%D0%9C%D0%A1-25.pdf&nosw=1	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Липецк, ул. Механизаторов, д. 10
18	МБОУ «Школа № 18 г. Ельца»	187	school	17	Муниципальное бюджетное общеобразовательное учреждение «Школа № 18 города Ельца».	1.0	11.0	\N	\N	2026-07-04 20:50:37.25445	2026-07-05 15:44:25.467128	Липецкая обл., г. Елец, ул. Кротевича, д. 6А
26	ГОБПОУ «Конь-Колодезский аграрный техникум»	204	spo	25	Государственное областное бюджетное профессиональное образовательное учреждение «Конь-Колодезский аграрный техникум»	\N	\N	https://kkolodez-edu.gosuslugi.ru/	https://kkolodez-edu.gosuslugi.ru/svedeniya-ob-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-professionalnogo-obucheniya-po-professii-13450-rabochiy-zelenogo-hozyaystva.html	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, Хлевенский округ, с. Конь-Колодезь, ул. Березовая аллея 74
27	ГОБПОУ «ЕКИТ»	187	spo	26	Государственное областное бюджетное профессиональное образовательное учреждение «Елецкий колледж инновационных технологий»	\N	\N	https://ekit-elets.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399774, Липецкая обл., г. Елец, ул. Коммунаров, зд. 30
28	ГОБПОУ «ЛТПИТУ»	198	spo	27	Государственное областное бюджетное профессиональное образовательное учреждение «Лебедянский техникум промышленных, информационных технологий и управления»	\N	\N	https://ltpitu.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399610, Липецкая область, г. Лебедянь, ул. Ленина, дом 32
29	ГОБПОУ «ЛПТ»	186	spo	28	Государственное областное бюджетное профессиональное образовательное учреждение «Липецкий политехнический техникум»	\N	\N	https://lpt-48.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398017 г. Липецк, ул. 9-Мая, 20а
30	ГОБПОУ «Липецкий областной колледж искусств им. К.Н. Игумнова»	186	spo	29	Государственное областное бюджетное профессиональное образовательное учреждение «Липецкий областной колледж искусств им. К.Н. Игумнова»	\N	\N	https://lokiigumnova.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398058, Липецкая область, г. Липецк, ул. городок Студенческий, дом 6
31	ГОБПОУ «Чаплыгинский аграрный колледж»	205	spo	30	Государственное областное бюджетное профессиональное образовательное учреждение «Чаплыгинский аграрный колледж»	\N	\N	https://college-chak-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399900, Липецкая обл., г. Чаплыгин, ул. Московская, д. 3
32	ГОБПОУ «ГТК»	189	spo	31	Государственное областное бюджетное профессиональное образовательное учреждение «Грязинский технический колледж»	\N	\N	https://gtk-gryazi.ru/svedeniya-ob-ou/osnovnye-svedeniya.html	https://gtk-gryazi.ru/files/docs/uch_plan/malyar.pdf	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399059, Липецкая область, Грязинский район, город Грязи, улица М. Расковой, дом 21
33	ГОБПОУ «ЕКЭП и ОТ»	187	spo	32	Государственное областное бюджетное профессиональное образовательное учреждение «Елецкий колледж экономики, промышленности и отраслевых технологий»	\N	\N	https://ekepiot.gosuslugi.ru/	https://disk.yandex.ru/d/jcjakp5Qt7dkIQ	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая обл., г.Елец, ул. Мира, д.119
34	ГОБПОУ «Лебедянский Педагогический Колледж»	198	spo	33	Государственное областное бюджетное профессиональное образовательное учреждение «Лебедянский педагогический колледж»	\N	\N	https://lebpedcol.ru	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Лебедянь, ул. Мира, д. 1
35	ГОБПОУ «УМПК»	203	spo	34	Государственное областное бюджетное профессиональное образовательное учреждение «Усманский многопрофильный колледж»	\N	\N	https://college-umpk.gosuslugi.ru/	https://docs.yandex.ru/docs/view?url=ya-disk-public%3A%2F%2F7a1OGfEs%2FRKyMGJ5fY0g4LvZTnolwxXLGxYnUD7%2B6m6CTfRaWLFKg1IJjQXujuJ2q%2FJ6bpmRyOJonT3VoXnDag%3D%3D&name=%2B%D0%BE%D0%BF%20%D0%A0%D0%B0%D0%B1%D0%BE%D1%87%D0%B8%D0%B9%20%D0%B7%D0%B5%D0%BB%D0%B5%D0%BD%D0%BE%D0%B3%D0%BE%20%D1%85%D0%BE%D0%B7%D0%B2%D0%B0%D0%B2.pdf&nosw=1	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Усмань, ул. К.Маркса, д.42
36	ГОБПОУ «КИИМО»	186	spo	35	Государственное областное бюджетное профессиональное образовательное учреждение «Колледж искусственного интеллекта в машиностроительной отрасли»	\N	\N	https://kiimo48.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398058, Липецкая область, город Липецк, городок Студенческий, дом 10
37	ГОБПОУ «Елецкий государственный колледж искусств им. Т.Н. Хренникова»	187	spo	36	Государственное областное бюджетное профессиональное образовательное учреждение «Елецкий государственный колледж искусств им. Т.Н. Хренникова»	\N	\N	http://www.egki.ru	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399770, Липецкая обл, г Елец, ул Мира, д 82
38	ГОБ ПОУ «Задонский политехнический техникум им. дважды героя Советского Союза М.Т. Степанищева»	195	spo	37	Государственное областное бюджетное профессиональное образовательное учреждение «Задонский политехнический техникум имени дважды героя Советского Союза Михаила Тихоновича Степанищева»	\N	\N	https://tech-zpt-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Задонск, ул. Труда, 20
39	ГАПОУ «ЛМК»	186	spo	38	Государственное автономное профессиональное образовательное учреждение «Липецкий медицинский колледж»	\N	\N	https://college-medicinskij-lipeck-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398017, г. Липецк, ул. 9 Мая, 18
40	ГОАПОУ «ЛИСК»	186	spo	39	Государственное областное автономное профессиональное образовательное учреждение «Липецкий индустриально-строительный колледж»	\N	\N	https://college-lisk-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Липецк, ул. П.А. Папина, д. 3
41	ГОАПОУ «ЛМК»	186	spo	40	Государственное областное автономное профессиональное образовательное учреждение «Липецкий металлургический колледж»	\N	\N	https://lipmetcol.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г. Липецк, ул. Фрунзе ул. 91, г. Липецк 398008
42	ГОБПОУ «ЛКИС»	186	spo	41	Государственное областное бюджетное профессиональное образовательное учреждение «Липецкий колледж индустрии сервиса»	\N	\N	https://lkis48.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398058 Липецкая обл., г. Липецк, ул. Студенческий городок, дом 2
43	ГОБПОУ «Усманский промышленно-технологический колледж»	203	spo	42	Государственное областное бюджетное профессиональное образовательное учреждение «Усманский промышленно-технологический колледж»	\N	\N	https://www.usmcollege.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399370, Липецкая область, г. Усмань, ул. Ленина, 2
44	ГОБПОУ «ЛКСАиОТ»	186	spo	43	Государственное областное бюджетное профессиональное образовательное учреждение «Липецкий колледж строительства, архитектуры и отраслевых технологий»	\N	\N	https://lksaiot.gosuslugi.ru/	https://lksaiot.gosuslugi.ru/svedeniya-ob-organizatsii/obrazovanie/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398058, г. Липецк, городок Студенческий, д.1
45	ГБОУ «Специальная школа-интернат г. Задонска»	195	school_internat	44	Государственное бюджетное общеобразовательное учреждение Липецкой области «Специальная школа-интернат г. Задонска»	1.0	11.0	https://zainternat.gosuslugi.ru/	https://zainternat.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399200, Липецкая область, Задонский район, г. Задонск, ул. Крупской, д. 13
46	ГБОУ Липецкой области «Специальная школа-интернат с. Вторые Тербуны»	202	school_internat	45	Государственное бюджетное общеобразовательное учреждение Липецкой области «Специальная школа-интернат с. Вторые Тербуны»	1.0	11.0	https://internat2e.ru/	https://terbunyinter.gosuslugi.ru/netcat_files/33/46/AOOP_OUO_26_variant_1.pdf	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, Тербунский округ, с. Вторые Тербуны, ул. Советская, д. 54
47	ГОАОУ "ЦОРиО"	186	school_internat	46	Государственное областное автономное общеобразовательное учреждение «Центр образования»	1.0	11.0	https://co-corio-lipeck-r42.gosweb.gosuslugi.ru/	https://corio48.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_398.html	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Россия, 398024, г. Липецк, ул. Механизаторов, д. 9
48	Учреждение «Специальная школа-интернат г. Ельца»	187	school_internat	47	Государственное Бюджетное Общеобразовательное	1.0	11.0	https://shkola-internat-elets.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399778, Липецкая область, г. Елец, ул. Ростовская, д.1
49	ГОАОУ «Траектория» г. Грязи	189	school_internat	48	Государственное областное автономное общеобразовательное учреждение Липецкой области «Центр непрерывного образования обучающихся с особыми образовательными потребностями» «Траектория» - полное наименование образовательного учреждения.	1.0	11.0	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/	https://co-traektoriya-gryazi-r42.gosweb.gosuslugi.ru/netcat_files/33/46/Adaptirovannaya_osnovnaya_obrazovatel_naya_programma.pdf	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399060, Липецкая обл., г. Грязи, ул. Партизанская, д. 2
51	ГБОУ «Специальная школа-интернат г.Данков»	190	school_internat	50	Государственное бюджетное общеобразовательное учреждение Липецкой области «Специальная школа-интернат г.Данкова». (ГБОУ «Специальная школа- интернат г.Данкова»).	1.0	11.0	https://dvkorrsh.gosuslugi.ru	https://dvkorrsh.gosuslugi.ru/netcat_files/33/46/AOOP_var.1_2024_25.pdf	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399852, Липецкая область, г. Данков, ул. Мира, д. 42
52	ГБОУ «Специальная школа – интернат г. Усмань»	203	school_internat	51	Государственное бюджетное общеобразовательное учреждение Липецкой области «Специальная школа – интернат г. Усмань»	1.0	11.0	https://sh-internat-usman24.gosuslugi.ru/	https://sh-internat-usman24.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399370, Липецкая область, город Усмань, улица Басова, дом 5
53	ГБОУ «Санаторная школа-интернат г. Липецка»	186	school_internat	52	Государственное бюджетное общеобразовательное учреждение Липецкой области «Санаторная школа-интернат г. Липецка»	1.0	11.0	https://sh-san-int-lipeckaya-r42.gosweb.gosuslugi.ru/	https://sh-san-int-lipeckaya-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398029, Липецкая область, г. Липецк, ул. М. Светлова, 29
62	МБДОУ д/с "Росточек" с. Синявка	189	preschool	61	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Росточек" с. Синявка Грязинского муниципального округа Липецкой области	2.0	7.0	https://ds-rostochek48.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, Грязинский район, с. Синявка, ул. Центральная площадь д.6
54	МБДОУ д/с № 1 г. Грязи	189	preschool	53	Муниципальное бюджетное дошкольное образовательное учреждение детский сад № 1 г. Грязи Грязинского муниципального округа Липецкой области	3.0	7.0	https://ds1-gryazi-r42.gosweb.gosuslugi.ru/	https://ds1-gryazi-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tyazhelymi-narusheniyami-rechi-mbdou-ds-1-g-gryazi.html	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399055, Российская Федерация, Липецкая область, г. Грязи, ул. Станционная, д. 1
58	МАДОУ д/с № 9 г. Грязи	189	preschool	57	Муниципальное автономное дошкольное образовательное учреждение детский сад общеразвивающего вида № 9 «Василек» г.Грязи Грязинского муниципального округа Липецкой области	2.0	6.0	https://ds-9vasilek-gryazi-r42.gosweb.gosuslugi.ru/	https://ds-9vasilek-gryazi-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma.html	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399059, Липецкая область, г. Грязи, улица Гризодубовой, дом 31а
66	МБДОУ д/с "Колокольчик" г. Чаплыгина Липецкой области	205	preschool	65	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Колокольчик" г. Чаплыгина Липецкой области	2.0	7.0	https://ds-kolokolchik-chaplygin-r42.gosweb.gosuslugi.ru/	https://ds-kolokolchik-chaplygin-r42.gosweb.gosuslugi.ru/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399902, Липецкая область, город Чаплыгин, улица Мира, дом 10А
67	МБДОУ д/с "Светлячок" г. Чаплыгина	205	preschool	66	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Светлячок" города Чаплыгина Чаплыгинского муниципального округа Липецкой области Российской Федерации	2.0	7.0	https://ds-svetlyachok-chaplygin-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399900, Липецкая область, Чаплыгинский округ, город Чаплыгин, улица Ломоносова, д. 46А
73	МБДОУ д/с " Теремок" с. Конюшки Чаплыгинский муниципальный округ Липецкая область	205	preschool	72	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Теремок" село Конюшки Чаплыгинский муниципальный округ Липецкая область	2.0	7.0	https://ds-teremok-konyushki-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область Чаплыгинский округ село Конюшки улица Центральная дом 220 индекс 399911
77	ЛГПУ имени П.П.Семенова-Тян-Шанского	186	vo	76	Липецкий государственный педагогический университет имени П.П.Семенова-Тян-Шанского	\N	\N	https://lspu-lipetsk.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398020, Липецкая область, город Липецк, ул. Ленина, д. 42
79	Филиал Воронежского экономико-правового института в г. Липецк	186	vo	77		\N	\N	https://lipetsk.vepi.ru	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	пр-д Сержанта Кувшинова, 5б, Липецк, Липецкая обл., 398000
80	ЛИК	186	vo	78	Липецкий институт кооперации (филиал) Белгородского университета кооперации, экономики и права	\N	\N	https://lki-lipetsk.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398002, г. Липецк, ул. Зегеля, 25а
81	Липецкий государственный технический университет	186	vo	79		\N	\N	https://www.stu.lipetsk.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398055, Россия, г. Липецк, ул. Московская, д. 30
82	Липецкий филиал Фи​нуниверситета	186	vo	139	Липецкий филиал федерального госуда​рственного образовательного бюджетного учреждения высшего образования «Финансовый университет при ​Правительстве Российской Федерации»	\N	\N	https://lipetsk.fa.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398050, Липецкая область, г. Липецк, ул. Интернациональная, 12Б
84	Липецкий филиал РАНХиГС	186	vo	81	Липецкий филиал федерального государственного бюджетного образовательного учреждения высшего образования «Российская академия народного хозяйства и государственной службы при Президенте Российской Федерации»	\N	\N	https://lip.ranepa.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	398050, г. Липецк, ул. Интернациональная, д.3
85	Липецкий филиал Российского университета медицины (РУМ)	186	vo	82		\N	\N	https://med-skills.ru/postupit-v-medicinskij/%D0%BB%D0%B8%D0%BF%D0%B5%D1%86%D0%BA%D0%B8%D0%B9-%D1%80%D1%83%D0%BC/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	г. Липецк Пл. Плеханова д. 5
95	МБДОУ детский сад №10 г.Ельца	187	preschool	90	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №10 города Ельца»	2.0	7.0	https://ds10-elec-r42.gosweb.gosuslugi.ru/	https://ds10-elec-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-osnovnaya-obrazovatelnaya-programma-doshkolnogo-obrazovaniya-dlya-detey-s-tnr-na-2025-2026g.html	2026-07-04 20:50:37.25445	2026-07-05 16:01:37.959489	399772, Россия, Липецкая область, город Елец, улица А.Гайтеровой, дом 17
96	МБДОУ детский сад № 14 г.Ельца	187	preschool	91	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 14 города Ельца»	2.0	8.0	https://ds14-elec-r42.gosweb.gosuslugi.ru/	https://ds14-elec-r42.gosweb.gosuslugi.ru/netcat_files/userfiles/Adaptirovannaya_programma_doshkolnogo_obrazovaniya1.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:10:26.217001	399784, Липецкая область, город Елец, ул. Спутников д. 8 а
117	МБОУ СОШ № 1 г. Грязи	189	school	112	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа №1 города Грязи Грязинского муниципального округа Липецкой области.	1.0	11.0	https://soh1gr.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399054, Липецкая область, Грязинский район, г. Грязи, ул. Рождественская стр.44а
93	МБДОУ детский сад № 5 г. Ельца	187	preschool	88	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 5 города Ельца»	1.5	8.0	https://detskeisad5elets.gosuslugi.ru/	https://detskeisad5elets.gosuslugi.ru/netcat_files/19/8/programma.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399774, Липецкая область, город Елец, улица Мичурина, дом 4а
118	МБОУ СОШ №2 г.Грязи	189	school	113	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 2 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	\N	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399056, Российская Федерация, Липецкая область, г.Грязи, ул.лейтенанта Шкатова, д.1
119	МБОУ Гимназия №3	189	school	114	Муниципальное бюджетное общеобразовательное учреждение гимназия №3 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	https://gimnaziya3gryazi.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, г.Грязи, ул. Авиационная, 39
120	МБОУ СОШ № 4г. Грязи	189	school	115	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 4 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	https://grsk-4.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399050, Россия. Липецкая область, город Грязи ул. Правды, 58
121	МБОУ сош школа №5 г.грязи	189	school	116	муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа №5 г. Грязи Грязинского муниципального округа липецкой области	1.0	11.0	https://sh5-gryazi-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399053 Липецкая область г.Грязи ул.Советская, д.9
122	МБОУ СОШ № 6 г. Грязи	189	school	117	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 6 г. Грязи Грязинского муниципального округа Липецкой области.	1.0	11.0	https://sh6-gryazi-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399061 Липецкая область, г. Грязи, ул. Лихачева, д.11
126	МБОУ СОШ №12 г. Грязи	189	school	120	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа № 12 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	https://grsh12.gosuslugi.ru/	https://grsh12.gosuslugi.ru/roditelyam-i-uchenikam/poleznaya-informatsiya/detyam-s-ogranichennymi-vozmozhnostyami-zdorovya/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399059, Липецкая область, г.Грязи, ул. Осоавиахима, д.1
127	МБОУ СОШ С. Б. Самовец	189	school	121	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с.Большой Самовец Грязинского муниципального округа Липецкой области.	1.0	11.0	https://scsamovec48.gosuslugi.ru/	https://scsamovec48.gosuslugi.ru/roditelyam-i-uchenikam/poleznaya-informatsiya/?category=7	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399082, РФ, Липецкая область, Грязинский район, с.Большой Самовец, ул. Советская, д.135а
128	МБОУ СОШ с. Бутырки	189	school	122	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с. Бутырки Грязинского муниципального округа Липецкой области	1.0	11.0	https://sh-butyrki-r42.gosweb.gosuslugi.ru/	https://shbutyrkir42.gosweb.gosuslugi.ru/roditelyam-i-uchenikam/poleznaya-informatsiya/detyam-s-ogranichennymi-vozmozhnostyami-zdorovya/	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399085, Липецкая область, Грязинский район, с.Бутырки, ул.Ленинская, дом 4,6
129	МБОУ ООШ с. Верхний Телелюй	189	school	123	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа с. Верхний Телелюй	1.0	11.0	https://sh-vteleluj.gosuslugi.ru/	https://sh-vteleluj.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/dokumenty-32_262.html	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399092, Липецкая область, Грязинский район, с. Верхний Телелюй, ул. Центральная д.12
130	МБОУ ООШ с. Двуречки им. И. А. Флерова	189	school	124	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа с. Двуречки Грязинского муниципального округа Липецкой области (МБОУ ООШ с. Двуречки)	1.0	11.0	https://sh-dvurechenskaya-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399074, Липецкая область, Грязинский район, с. Двуречки, ул. Ленина, д.70
131	МБОУ СОШ с. Казинка	189	school	125	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с.Казинка Грязинского муниципального округа Липецкой области	1.0	11.0	https://shkolakazinka.gosuslugi.ru/glavnoe/kontakty/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Липецкая область, Грязинский район, с.Казинка, ул. Садовая 14 а
134	МБОУ СОШ	189	school	127	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа д. Кубань Грязинского муниципального округа Липецкой области	1.0	11.0	https://schoolkuban.gosuslugi.ru/	https://schoolkuban.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty-all_215.html	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399040, Липецкая область, Грязинский район, д. Кубань, ул. Лесная, д. 17/1
135	МБОУ СОШ с. Плеханово	189	school	128	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с. Плеханово Грязинского муниципального округа Липецкой области	1.0	11.0	https://sh-plexanovo-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399083, Липецкая область, Грязинский район, с.Плеханово, ул. Школьный переулок, 1а
136	МБОУ СОШ п. свх. Прибытковский	189	school	129	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа п.свх. Прибытковский, Грязинского муниципального округа, Липецкой области	1.0	11.0	https://sch-pribytkovo.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	\N
137	МБОУ СОШ с.Сошки	189	school	130	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с.Сошки Грязинского муниципального округа Липецкой области МБОУ СОШ с.Сошки	1.0	11.0	https://sh-soshki-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399075, Липецкая область, Грязинский район, с.Сошки, ул.Мира, д.1
138	МБОУ СОШ села Фащевка	189	school	131	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа села Фащёвка Грязинского муниципального округа Липецкой области МБОУ СОШ села Фащевка	1.0	11.0	https://sh-fashhyovka-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399073, Липецкая область, Грязинский район, село Фащёвка, ул. Советская, д. 12
139	МБОУ ООШ с. Коробовка	189	school	132	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа с. Коробовка Грязинского муниципального округа Липецкой области	1.0	11.0	https://sh-korobovka-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399043 Липецкая область., Грязинский район., с. Коробовка, ул. Школьная д.1 «А»
141	МБОУ ООШ п. свх. Песковатский	189	school	133	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа п. свх. Песковатский Грязинского муниципального округа Липецкой области (МБОУ ООШ п. свх. Песковатский)	1.0	11.0	https://sh-peskovatskij-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	\N
142	МБОУ ООШ с. Петровка	189	school	134	Муниципальное бюджетное общеобразовательное учреждение основная общеобразовательная школа с. Петровка Грязинского муниципального округа Липецкой области (МБОУ ООШ с. Петровка)	1.0	11.0	https://sh-petrovka-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399088, Липецкая область, Грязинский район, с. Петровка, ул. Ленина, д. 1/а
143	МБОУ СОШ с. Синявка	189	school	135	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с.Синявка Грязинского муниципального округа Липецкой области	1.0	11.0	https://sh-sinyavka-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399087, Липецкая область, Грязинский район, село Синявка, Центральная площадь, 4
144	МБОУ СОШ с. Ярлуково	189	school	136	Муниципальное бюджетное общеобразовательное учреждение средняя общеобразовательная школа с.Ярлуково Грязинского муниципального округа Липецкой области;	1.0	11.0	https://sh-yarlukovo-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399072 Липецкая область Грязинский р-он, с.Ярлуковоㅤ
12	МБОУ «Средняя школа № 8 г. Ельца»	187	school	\N	Муниципальное бюджетное общеобразовательное учреждение "Средняя школа № 8 г. Ельца"	1.0	11.0	https://sh8-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	Корпус № 1 - 399772, Россия, Липецкая область, город Елец, ул. А. Гайтеровой, д.1А Корпус № 2 - 399772, Россия, Липецкая область, город Елец, ул. Ефремовская, д.1
123	МБОУ НОШ №7 г. Грязи	189	school	\N	Муниципальное бюджетное общеобразовательное учреждение начальная общеобразовательная школа № 7 г. Грязи Грязинского муниципального округа Липецкой области	1.0	11.0	https://sc7gr.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 15:35:44.870228	399050, Липецкая область, Грязинский р-н, г. Грязи, ул. Первомайская, д.31
57	МАДОУ д/с № 8 "Родничок" г. Грязи	189	preschool	56	Муниципальное автономное дошкольное образовательное учреждение детский сад № 8 «Родничок» г. Грязи Грязинского муниципального округа Липецкой области	1.5	6.0	https://rod8gryazi.gosuslugi.ru/	https://rod8gryazi.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_114.html	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399059, Липецкая область, г. Грязи, ул. Гастелло, д. 5
60	МБДОУ д/с № 11 г.Грязи	189	preschool	59	Муниципальное бюджетное дошкольное образовательное учреждение детский сад №11 «Рябинка» г. Грязи Грязинского муниципального округа Липецкой области	1.5	7.0	https://ds11-ryabinka.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399050,Российская Федерация, Липецкая область, г. Грязи, ул. Правды, д. 59 – а, 399056,Российская Федерация, Липецкая область, г.Грязи, ул. Красногвардейская, д. 9
63	МБДОУ д/с "Светлячок" с.Ярлуково	189	preschool	62	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Светлячок" с.Ярлуково Грязинского муниципального округа Липецкой области	1.5	6.0	https://ds-svetlyachok-yarlukovo-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399072 Липецкая область Грязинский округ с. Ярлуково ул. Советская д. 11 "А"
147	МБОУ «Лицей №3 им. К.А. Москаленко» г.Липецка	186	school	142	\N	\N	\N	https://sc3lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398007, г. Липецк, ул. Ушинского, 14
64	МБДОУ д/с "Сказка" г.Чаплыгин	205	preschool	63	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Сказка" г. Чаплыгина Липецкой области	1.5	7.0	https://ds-skazka-chaplygin-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399902 Российская Федерация, Липецкая область, город Чаплыгин, улица Советская, дом 2 "г"
65	МБДОУ д/с "Солнышко" г. Чаплыгина Липецкой области	205	preschool	64	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Солнышко" г. Чаплыгина Липецкой области	1.5	7.0	https://ds-solnyshko-chaplygin-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399900, Липецкая обл., г. Чаплыгин, ул. 8 Марта, д.14, пом.1
68	БДОУ д/с "Теремок" г. Чаплыгина	205	preschool	67	Муниципальное бюджетное дошкольное образовательное учреждение - детский сад «Теремок» города Чаплыгина Чаплыгинского муниципального округа Липецкой области Российской Федерации	1.5	7.0	https://ds-teremok-chaplygin-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	\N
69	МБДОУ д/с "Буратино" с.Братовка Чаплыгинского муниципального округа Липецкой области	205	preschool	68	Муниципальное бюджетное дошкольное общеобразовательное учреждение детский сад "Буратино" села Братовка Чаплыгинского муниципального округа Липецкой области	1.5	7.0	https://ds-buratino-chaplygin-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Липецкая область Чаплыгинский округ село Братовка улица Свинушки дом 5
70	МБДОУ д/с " Солнышко" с.Троекурово Чаплыгинского округа	205	preschool	69	Муниципальное бюджетное дошкольное образовательное учреждение детский сад « Солнышко» села Троекурово Чаплыгинского муниципального округа Липецкой области	1.5	8.0	https://ds-solnishko-troekurovo.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399910 Липецкая область, Чаплыгинский округ, село Троекурово, улица Новая, дом 8
71	МБДОУ д/с "Чебурашка" с.Кривополянье Чаплыгинского муниципального округа	205	preschool	70	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Чебурашка» села Кривополянье Чаплыгинского муниципального округа Липецкой области Российской Федерации	1.5	7.0	https://ds-cheburashka-krivopolyane-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399940 Липецкая область, Чаплыгинский округ, село Кривополянье, улица 10-й Пятилетки, дом 7
72	МБДОУ д/с "Ивушка"	205	preschool	71	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Ивушка" поселок Рощинский Чаплыгинского муниципального округа Липецкой области	1.5	7.0	https://ds-ivushka-roshhinskij-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Липецкая область Чаплыгинский округ поселок Рощинский улица Молодежная 1
74	МБДОУ д/с "Малыш" с. Ломовое Чаплыгинский округ Липецкая область	205	preschool	73	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Малыш" села Ломовое Чаплыгинский муниципальный округ Липецкая область	1.5	8.0	https://ds-malysh-lomovoe-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399931, Липецкая область Чаплыгинский округ село Ломовое улица Советская д.21
75	МБДОУ д/с "Полянка" с. Новополянье Чаплыгинского округа	205	preschool	74	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Полянка" села Новополянье Чаплыгинского муниципального округа Липецкой области	1.5	7.0	https://ds-polyanka-novopolyane-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399941, Липецкая обл., Чаплыгинский округ, с. Новополянье, ул. Школьная д.6
76	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Колосок» села Новое Петелино Чаплыгинского муниципального района Липецкой области	205	preschool	75	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Колосок» села Новое Петелино Чаплыгинского муниципального округа Липецкой области	1.5	8.0	https://dskolosok-petelino.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399915 Липецкая область Чаплыгинский округ село Новое Петелино улица Молодежная дом 10
91	МБДОУ детский сад №1 г.Ельца	187	preschool	86	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 1 города Ельца»	1.5	8.0	https://ds1-elec-r42.gosweb.gosuslugi.ru/	https://ds1-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOOP_TNR_2025.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399770, Россия,Липецкая область, г.Елец, ул.Советская д.119
92	МБДОУ детский сад № 3 г. Ельца	187	preschool	87	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №3 города Ельца»	1.5	7.0	https://ds3-elec-r42.gosweb.gosuslugi.ru/	https://ds3-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/aop_do_tnr_0.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399733, г. Елец, ул. Шоссейная, 1-б
148	МБОУ СОШ №4 г.Липецка	186	school	143	\N	\N	\N	https://sc4lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398005, г. Липецк, ул. Парковая, д.5; 398041, г. Липецк, ул. Зои Космодемьянской, д.178
94	МБДОУ «Детский сад №8 г. Ельца»	187	preschool	89	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №8 города Ельца»	1.5	3.0	https://ds8-elec-r42.gosweb.gosuslugi.ru/	\N	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399770, Липецкая область, город Елец, улица М. Горького, д. 97
97	МАДОУ Детский сад № 15 г.Ельца	187	preschool	92	Муниципальное автономное дошкольное образовательное учреждение «Детский сад № 15 города Ельца»	1.5	7.0	https://ds15-elec-r42.gosweb.gosuslugi.ru/	https://ds15-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatelnaya_programma_doshkolnogo_obrazovania_dlya_yuschikhsya_s_tyazhelymi_narusheniami_rechi_MADOU_detskiy_sad.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399778, Россия, Липецкая область, г.о.г.Елец микрорайон Александровский, дом 24
100	МБДОУ детский сад №21 г.Ельца	187	preschool	95	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №21 города Ельца»	1.5	7.0	https://ds21elets.gosuslugi.ru/	https://ds21elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/adaptirovannaya-obrazovatelnaya-programma-dlya-detey-s-tnr-na-2024-2025-uchebnyy-god.html	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Липецкая область, город Елец,ул.Коммунаров, д. 77
101	МБДОУ детский сад № 24 г. Ельца	187	preschool	96	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №24 города Ельца»	1.5	6.0	https://ds24-elec-r42.gosweb.gosuslugi.ru/	https://ds24-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_DO_ZPR_FAOP_0.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399772 Липецкая обл. г. Елец пер. Мельничный д. 10 -главный корпус, пос. ТЭЦ д. 3- 2 корпус
103	МБДОУ детский сад № 27 г. Ельца	187	preschool	98	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 27 города Ельца»	1.5	8.0	https://ds27-elec-r42.gosweb.gosuslugi.ru/	https://ds27-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_MBDOU_detskogo_sada_27_goroda_El_tsa_pech2.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399782, Липецкая область, город Елец, поселок Строитель, дом 18А
104	МБДОУ Детский Сад № 30 Г. Ельца «Ромашка»	187	preschool	99	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 30 города Ельца «Ромашка»	1.5	7.0	https://ds30elets.gosuslugi.ru/	https://ds30elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_programma_TNR_2025_2026g_kopiya.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399772, Липецкая область, город Елец, Кирпичный пер., д. 2
105	МАДОУ детский сад № 31 г.Ельца «Сказка»	187	preschool	100	Муниципальное автономное дошкольное образовательное учреждение Детский сад № 31 города Ельца «Сказка»	1.5	7.0	https://ds-skazka31.gosuslugi.ru/	https://ds-skazka-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/adaptirovannaya_magomedh_podpis.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399772, Россия, Липецкая область, город Елец, улица Октябрьская, д. 22
106	МБДОУ детский сад №32 г.Ельца «Солнышко»	187	preschool	101	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №32 города Ельца «Солнышко»	1.5	7.0	https://ds-solnyshko-elec-r42.gosweb.gosuslugi.ru/	https://ds-solnyshko-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_dlya_obuchayuschihsya_s_tyazhelymi_narusheniyami_rechi_TNR_v_MBDOU_detskiy_sad_32_g.El_tsa_Solnyshko.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Российская Федерация, 399774, Липецкая область, г. Елец, ул. Коммунаров, д.107а
107	МБДОУ детский сад №33 г. Ельца	187	preschool	102	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №33 города Ельца»	1.5	6.0	https://ds33-elec-r42.gosweb.gosuslugi.ru/	https://ds33-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/2023_AOP_TNR_GOTOVO.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399784, Россия, Липецкая область, город Елец, улица Радиотехническая, д.20а
108	МБДОУ детский сад №34 г. Ельца	187	preschool	103	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №34 города Ельца»	1.5	3.0	https://ds34elets.gosuslugi.ru/	https://ds34elets.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_54.html	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399782, Россия, Липецкая область, г. Елец, пос. Строитель, д. 22А; Россия, Липецкая область, город Елец, ул. Костенко, д. 44-б
109	МБДОУ детский сад №36 г.Ельца	187	preschool	104	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №36 города Ельца»	1.5	8.0	https://ds36elets.gosuslugi.ru/	https://ds36elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_TNR_.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399772, Липецкая область, город Елец, улица Ефремовская, дом 1А, корпус 1
110	МБДОУ «Детский сад № 37 г. Ельца»	187	preschool	105	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 37 города Ельца»	1.5	6.0	https://ds37-elec-r42.gosweb.gosuslugi.ru/	https://ds37-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_ZPR_1_.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399776, Липецкая область, город Елец, ул. Кротевича, д. 25 (корпус №1); 399776, Липецкая область, город Елец, переулок Мало -Томский, д. 10 (корпус №2)
149	МБОУ СШ №5 города Липецка	186	school	144	\N	\N	\N	https://s5litavrina.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398002, г. Липецк, ул. им. Семашко, дом № 5
150	МБОУ «Школа №6» г.Липецка	186	school	145	\N	\N	\N	https://sc6lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398902, г. Липецк, ул. Детская, 2в
151	МБОУ СОШ №7 г.Липецка	186	school	146	\N	\N	\N	https://sc7lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398005, г. Липецк, пр. Мира, 7
111	МБДОУ детский сад № 39 г. Ельца	187	preschool	106	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 39 города Ельца»	1.5	6.0	https://ds39elets.gosuslugi.ru/	https://ds39elets.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_doshkol_nogo_obrazovaniya_korrektsionno_razvivayuschey_raboty_dlya_detey_s_tyazhelymi_narusheniyami_rechi_5_8_let_MBDOU_detskiy_sad_39_g._El_tsa_na_2025_2026_g_.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399782, Липецкая область, город Елец, ул. Юбилейная, дом 3А
112	МБДОУ детский сад № 40 г. Ельца	187	preschool	107	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 40 города Ельца»	1.5	7.0	https://ds40-elec-r42.gosweb.gosuslugi.ru/	https://ds40-elec-r42.gosweb.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/dokumenty/dokumenty_63.html	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399783, Россия, Липецкая область, г. Елец, ул. Коммунаров, д. 123-а
113	МБДОУ детский сад №41 г. Ельца	187	preschool	108	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №41 города Ельца»	1.5	7.0	https://ds41-elec-r42.gosweb.gosuslugi.ru/	https://ds41-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_programma_2025_2026.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399772, Липецкая область, город Елец, ул. Ани Гайтеровой, д. 21
114	МБДОУ детский сад №46 г. Ельца «Дружные ребята»	187	preschool	109	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №46 города Ельца «Дружные ребята»	1.5	7.0	https://ds46elets.gosuslugi.ru/	https://ds46elets.gosuslugi.ru/netcat_files/19/8/AOP_TNR_MBDOU_ds_46_g._El_tsa_2023_g..pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	399771, Липецкая обл., г. Елец, ул. Орджоникидзе, д. 17
115	МБДОУ детский сад № 71 г. Ельца «Румяные щёчки»	187	preschool	110	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад № 71 города Ельца «Румяные щёчки»	1.5	7.0	https://ds71-elec-r42.gosweb.gosuslugi.ru/	https://ds71-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/AOP_TNR_1.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Корпус № 1: ул. Яна Фабрициуса, д.6-а. Корпус № 2: пос. Известкового завода, д. 14 а
116	МБДОУ детский сад №84 г. Ельца «Радуга»	187	preschool	111	Муниципальное бюджетное дошкольное образовательное учреждение «Детский сад №84 города Ельца «Радуга»	1.5	6.0	https://ds84-elec-r42.gosweb.gosuslugi.ru/	https://ds84-elec-r42.gosweb.gosuslugi.ru/netcat_files/19/8/Adaptirovannaya_obrazovatel_naya_programma_dlya_obuchayuschihsya_s_narusheniem_rechi.pdf	2026-07-04 20:50:37.25445	2026-07-05 16:22:49.905383	Корпус №1: 399773, Россия, Липецкая обл., г. Елец, ул. Вермишева, д. 17а. Корпус № 2: 399774, Россия, Липецкая обл., г. Елец, ул. Путейская, д. 10а
152	МБОУ СШ №8 г.Липецка	186	school	147	\N	\N	\N	https://sc8lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398020, г. Липецк. ул. Елецкая, д.63
153	МБОУ СШ №9 им. М.В. Водопьянова г.Липецка	186	school	148	\N	\N	\N	https://scl9-lipeck.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398020, г. Липецк, ул. Студеновская, д.4А
154	МБОУ СШ №10 г.Липецка	186	school	149	\N	\N	\N	https://sc10lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Краснозаводская, д.8
155	МБОУ СШ №11 г.Липецка	186	school	150	\N	\N	\N	https://sh11lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398011, г. Липецк, ул. Силикатная д. 19
156	МБОУ гимназия №12 города Липецка	186	school	151	\N	\N	\N	https://gimnasium12.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398020, г. Липецк, ул. Гагарина, д.24
157	МБОУ СШ №14 г.Липецка	186	school	152	\N	\N	\N	https://schkola14.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398037, г. Липецк, Боевой проезд, д.24а
158	МАОУ СШ №15 г.Липецка	186	school	153	\N	\N	\N	https://sc15lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, пл. Торговая, 14
159	МБОУ №16 г.Липецка	186	school	154	\N	\N	\N	https://lipschool16.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398043, г. Липецк, ул. Циолковского, д.34/4
160	МАОУ СОШ №17 г.Липецка	186	school	155	\N	\N	\N	https://sh17-lipeck.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398024, г. Липецк, пр. Победы, д.96
161	Муниципальное автономное общеобразовательное учреждение средняя общеобразовательная ШКОЛА №18 (МАОУ СОШ №18 г.Липецка)	186	school	156	\N	\N	\N	https://sc18lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, ул. Кривенкова, д.25
162	МБОУ гимназия №19 им. Н З. Поповичевой г.Липецка	186	school	157	\N	\N	\N	https://gimnasium19.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398002, г. Липецк, ул. Семашко, д.68
163	МАОУ СОШ №20 г.Липецка	186	school	158	\N	\N	\N	https://sc20lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398004, г. Липецк, пер. Учебный, д.1
164	МБОУ СШ №21 города Липецка	186	school	159	\N	\N	\N	https://sc21-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398058, г. Липецк, 15 микрорайон, д.5/2
165	МАОУ СОШ №23 г.Липецка	186	school	160	\N	\N	\N	https://sc23lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398902, г. Липецк, ул. Ударников, д.21
166	МБОУ СОШ №24 им. М.Б. Раковского г.Липецка	186	school	161	\N	\N	\N	https://sc24lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г. Липецк, ул. Гагарина, д.84
167	МБОУ ОШ №25 г.Липецка	186	school	162	\N	\N	\N	https://sc25lipeck.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398013, г. Липецк, ул. Ильича, д.31
168	МАОУ школа информационных технологий №26 г.Липецка	186	school	163	\N	\N	\N	https://maoush26it.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398027, г. Липецк, ул. Стаханова, д. 75
169	МАОУ Инженерно-Технологическая Школа №27 Города Липецка	186	school	164	\N	\N	\N	https://sc27lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398008, Липецкая область, город Липецк, улица Лутова, дом 15
170	МБОУ СШ №28 г.Липецка	186	school	165	\N	\N	\N	https://sh28-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398007, г. Липецк, пл. Константиновой, д.2
171	МАОУ СОШ №29 г.Липецка	186	vo	166	\N	\N	\N	https://sc29un.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398055, г. Липецк, ул.Политехническая, д.9А
172	МАОУ СШ №30 г.Липецка	186	school	167	\N	\N	\N	https://sc30lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398004, г. Липецк, ул. Коцаря С.Л., дом 1
173	МБОУ СШ №31 г.Липецка	186	school	168	\N	\N	\N	https://lipschool31.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006 г. Липецк, ул. Волгоградская, д.4
174	МБОУ №32 г.Липецка	186	school	169	\N	\N	\N	https://sc32lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, ул. Октябрьская, д.88а
175	МБОУ СШ №33 г.Липецка	186	school	170	\N	\N	\N	https://sc33lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, бульвар П.Шубина, д.15
176	МАОУ СШ №34 г.Липецка	186	school	171	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398902, г. Липецк, ул. Минская, д.7в
177	МБОУ СШ №35 г.Липецка	186	school	172	\N	\N	\N	https://sc35lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398914 г. Липецк, ул. Ракитная, д.2
178	МБОУ СОШ №36 г.Липецка	186	school	173	\N	\N	\N	https://sc36lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г. Липецк, ул. Гагарина, д.73а
179	МБОУ СШ №37 г.Липецка	186	school	174	\N	\N	\N	https://sc37lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398029, г. Липецк, ул.Писарева, д.37; 398028, г. Липецк, ул.Привокзальная, д.101; 398029, г. Липецк, ул.Пришкольная, д.21
180	МБОУ СШ №38 г.Липецка	186	school	175	\N	\N	\N	https://sc38lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
181	МБОУ СОШ №40 г.Липецка	186	school	176	\N	\N	\N	https://sc40lipschools48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
182	МБОУ СШ №41 города Липецка	186	school	177	\N	\N	\N	https://sc41lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
183	МБОУ СШ №42 г.Липецка	186	school	178	\N	\N	\N	https://sc42lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул. Стаханова, д.15
185	МБОУ СШ №45 г.Липецка	186	school	180	\N	\N	\N	https://school45lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398024, г. Липецк, ул. Папина 4
186	МБОУ СОШ №46 г.Липецка	186	school	181	\N	\N	\N	https://school46lipetsk-reg48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398032, г.Липецк, ул.Титова, д.8
187	МБОУ СОШ №47 г.Липецка	186	school	182	\N	\N	\N	https://sc47lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398043, г. Липецк, ул. Космонавтов, д.11Б
188	МАОУ СШ №48 г.Липецка	186	school	183	\N	\N	\N	https://sc48lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398032, г. Липецк, ул. Космонавтов, д.82, корп.4
189	МБОУ СОШ №49 г.Липецка	186	school	184	\N	\N	\N	https://sc49lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звездная, д.12 (корпус А), Вермишева, д.16 (корпус Б)
190	МБОУ СОШ №50 г.Липецка	186	school	185	\N	\N	\N	https://sc50lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звездная, д.6
191	МАОУ СШ №51 г.Липецка	186	school	186	\N	\N	\N	https://51lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398042, г. Липецк, 9 микрорайон, д.42А
192	МБОУ СШ №52 г.Липецка	186	school	187	\N	\N	\N	https://sc52lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398043, г. Липецк, ул. Циолковского, д.31
193	МБОУ СШ №54 г.Липецка	186	school	188	\N	\N	\N	https://sc54lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398908, г. Липецк, ул. Моршанская, д.22
194	МАОУ СШ №55 г.Липецка «Лингвист»	186	school	189	\N	\N	\N	https://sc55lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г.Липецк, ул.Космонавтов, д.16А
195	МАОУ СШ №58 города Липецка	186	school	190	\N	\N	\N	https://sh58-lipeck-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398001, г. Липецк, ул. Артемова, д.4, Липецк
197	МАОУ СШ №60 г.Липецка	186	school	192	\N	\N	\N	https://maoush60.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398027, г. Липецк, ул. Осканова, д.4
198	МБОУ многопрофильный лицей г.Липецка	186	school	193	\N	\N	\N	https://sosch61.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
199	МБОУ СШ №62 г.Липецка	186	school	194	\N	\N	\N	https://school62lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006 г. Липецк, ул. Ибаррури, 1
200	МБОУ СШ №63 г.Липецка	186	school	195	\N	\N	\N	https://s63lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, пр.Сиреневый, д.9
201	МБОУ «Гимназия №64» города Липецка	186	school	196	\N	\N	\N	https://gimnasium64.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, ул. Мичурина, 30; 398059, г. Липецк, пр. Победы, 7А
202	МБОУ «СМШ №65 «Спектр» г.Липецка	186	school	197	\N	\N	\N	https://scl65lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398055 г.Липецк, пер.сержанта Кувшинова, д.3
203	МБОУ лицей №66 г.Липецка	186	school	198	\N	\N	\N	https://liceum66.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г.Липецк, ул. Меркулова, д.11а
204	МБОУ СШ №68 города Липецка	186	school	199	\N	\N	\N	https://sc68lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046 г. Липецк, ул. Стаханова, д.17
205	МАОУ гимназия №69 г.Липецка	186	school	200	\N	\N	\N	https://gymnasium69.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, бульвар Есенина, д.7а
206	МБОУ СШ №70 г.Липецк	186	school	201	\N	\N	\N	https://70school.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, пр. Победы, д.130, д.122; Меркулова, 51
207	МБОУ СШ №72 г.Липецка	186	school	202	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398024, г.Липецк, ул. Юных Натуралистов, д.12а
208	МБОУ СОШ №77 г.Липецка	186	school	203	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, ул. Хорошавина, д.14
209	МБОУ СШ ОО ЗЗ №2 г.Липецка	186	school	204	\N	\N	\N	https://mbou-ssch-oozz2-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Коммунистическая, д.17
211	Муниципальное бюджетное дошкольное образовательное учреждение №1 г.Липецка ДОУ №1 г.Липецка	186	preschool	206	\N	\N	\N	https://ds1lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398050, г.Липецк, ул.Желябова, 19 ул. Желябова, 9 ул. Интернациональная, 26
213	Муниципальное бюджетное дошкольное образовательное учреждение №3 г.Липецка ДОУ №3 г.Липецка	186	preschool	208	\N	\N	\N	https://dou3lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398001, г. Липецк, ул. Советская, 39, 398059 ул. Пушкина, 7а
214	Муниципальное автономное дошкольное образовательное учреждение детский сад №4 г.Липецка ДОУ №4 г.Липецка	186	preschool	209	\N	\N	\N	https://dou4lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398037, г. Липецк, ул. Дмитрия Фурсова, д.1; ул. Дмитрия Фурсова, д.3
215	Муниципальное бюджетное дошкольное образовательное учреждение №5 г.Липецка ДОУ №5 г.Липецка	186	preschool	210	\N	\N	\N	https://dou5lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Корпус 1: 398908, г.Липецк, ул. Сельскохозяйственная, 12
328	МБДОУ «Малышок» с.Доброе	192	preschool	323	\N	\N	\N	https://ds-malyshok-dobroe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399140, Россия, Липецкая область, с.Доброе, ул. Победы, д.12а
212	Муниципальное автономное дошкольное образовательное учреждение детский сад №2 г.Липецка ДОУ №2 г.Липецка	186	preschool	207	\N	3.0	8.0	https://oblachnyikit.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:51:25.765832	398004, г.Липецк, ул.Стаханова, 71 А
216	Муниципальное бюджетное дошкольное образовательное учреждение №6 г.Липецка ДОУ №6 г.Липецка	186	preschool	211	\N	\N	\N	https://dou6-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, бульвар Шубина, 16 (основное здание); 398036, г. Липецк, бульвар Шубина, 20 (дополнительное здание)
217	Муниципальное бюджетное дошкольное образовательное учреждение №8 г.Липецка ДОУ №8 г.Липецка	186	preschool	212	\N	\N	\N	https://dou8lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398024, г. Липецк, проспект Победы, 92 корп. б
218	Муниципальное бюджетное дошкольное образовательное учреждение №9 г.Липецка ДОУ №9 г.Липецка	186	preschool	213	\N	\N	\N	https://ds9lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Вермишева, 10, ул. Вермишева, 7а
219	Муниципальное бюджетное дошкольное образовательное учреждение №10 г.Липецка ДОУ №10 г.Липецка	186	preschool	214	\N	\N	\N	https://doulip10.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Краснознаменная, д.8а
220	Муниципальное бюджетное дошкольное образовательное учреждение №12 г.Липецка ДОУ №12 г.Липецка	186	preschool	215	\N	\N	\N	https://dou12-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398029, г. Липецк, ул. Центральная, 21, ул. Ярославская, 13.
222	Муниципальное бюджетное дошкольное образовательное учреждение №15 г.Липецка ДОУ №15 г.Липецка	186	preschool	217	\N	\N	\N	https://dou15lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398004, г.Липецк, ул.Шуминского, 19
223	Муниципальное бюджетное дошкольное образовательное учреждение №18 г.Липецка ДОУ №18 г.Липецка	186	preschool	218	\N	\N	\N	https://mdou18lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г. Липецк, ул. Гагарина, д. 93/2
224	Муниципальное бюджетное дошкольное образовательное учреждение №19 г.Липецка ДОУ №19 г.Липецка	186	preschool	219	\N	\N	\N	https://dou19lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Основное здание - 398011, г.Липецк, ул.Астраханская, д.15
225	Муниципальное автономное дошкольное образовательное учреждение №20 г.Липецка ДОУ №20 г.Липецка	186	preschool	220	\N	\N	\N	https://dou20lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, ул. Мистюкова А.П., д. 7
226	Муниципальное бюджетное дошкольное образовательное учреждение №21 г.Липецка ДОУ №21 г.Липецка	186	preschool	221	\N	\N	\N	https://dou21lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, бульвар Есенина, 12
227	Муниципальное бюджетное дошкольное образовательное учреждение №22 г.Липецка ДОУ №22 г.Липецка	186	preschool	222	\N	\N	\N	https://dou22-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398005, г. Липецк, ул. Осипенко, 6а, ул. Невского, 26а
228	Муниципальное бюджетное дошкольное образовательное учреждение №23 г.Липецка ДОУ №23 г.Липецка	186	preschool	223	\N	\N	\N	https://dou23lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул. Смургиса, д. 3а
229	Муниципальное бюджетное дошкольное образовательное учреждение №25 г.Липецка ДОУ №25 г.Липецка	186	preschool	224	\N	\N	\N	https://25doulip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398037, г. Липецк, Боевой проезд, 39а
230	Муниципальное бюджетное дошкольное образовательное учреждение №29 г.Липецка ДОУ №29 г.Липецка	186	preschool	225	\N	\N	\N	https://mdou29lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. 50 лет НЛМК, 15а
232	Муниципальное автономное дошкольное образовательное учреждение детский сад №32 г.Липецка ДОУ №32 г.Липецка	186	preschool	227	\N	\N	\N	https://dou32lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398027 ул. Свиридова И.В., д. 8а
233	Муниципальное бюджетное дошкольное образовательное учреждение №35 г.Липецка ДОУ №35 г.Липецка	186	preschool	228	\N	\N	\N	https://dou35-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Ибаррури, 6а
234	Муниципальное бюджетное дошкольное образовательное учреждение №37 г.Липецка ДОУ №37 г.Липецка	186	preschool	229	\N	\N	\N	https://dou37lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398914, г. Липецк, ул. 300-летия Флота России, владение, 2
235	Муниципальное бюджетное дошкольное образовательное учреждение №38 г.Липецка ДОУ №38 г.Липецка	186	preschool	230	\N	\N	\N	https://dou38-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398007, г. Липецк, ул. Ушинского 15/1
236	Муниципальное автономное дошкольное образовательное учреждение детский сад №40 г.Липецка ДОУ №40 г.Липецка	186	preschool	231	\N	\N	\N	https://dou40lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, бульвар Есенина, д.7
355	МБОУ НОШ д.Ивановка	194	school	350	\N	\N	\N	https://schoolivanovka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399760, Липецкая область, Елецкий район, деревня Ивановка, улица Рабочая, дом 45
231	Муниципальное автономное дошкольное образовательное учреждение детский сад №30 г.Липецка ДОУ №30 г.Липецка	186	preschool	226	\N	1.5	8.0	https://dou30lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:52:06.872532	398036, г. Липецк, ул. Мистюкова А.П. д.1
237	Муниципальное бюджетное дошкольное образовательное учреждение №42 г.Липецка ДОУ №42 г.Липецка	186	preschool	232	\N	\N	\N	https://dou42lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398005, г. Липецк, пр. Осенний, д.6а
238	Муниципальное бюджетное дошкольное образовательное учреждение №44 г.Липецка ДОУ №44 г.Липецка	186	preschool	233	\N	\N	\N	https://dou44-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Юбилейная, 6а
239	Муниципальное автономное дошкольное образовательное учреждение №50 г.Липецка ДОУ №50 г.Липецка	186	preschool	234	\N	\N	\N	https://mirdetstva50.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398055 г.Липецк, ул. Хренникова, д.2
240	Муниципальное бюджетное дошкольное образовательное учреждение №62 г.Липецка ДОУ №62 г.Липецка	186	preschool	235	\N	\N	\N	https://ds62lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398002, г. Липецк, ул. Вавилова, 2
241	Муниципальное бюджетное дошкольное образовательное учреждение №64 г.Липецка ДОУ №64 г.Липецка	186	preschool	236	\N	\N	\N	https://dou64lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398000, г. Липецк, Студеновская, 13а
242	Муниципальное бюджетное дошкольное образовательное учреждение №66 г.Липецка ДОУ №66 г.Липецка	186	preschool	237	\N	\N	\N	https://dou66lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г. Липецк, ул. Гагарина 73/3
243	Муниципальное бюджетное дошкольное образовательное учреждение №68 города Липецка ДОУ №68 г.Липецка	186	preschool	238	\N	\N	\N	https://dou68-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул. Водопьянова, 7
244	Муниципальное бюджетное дошкольное образовательное учреждение №76 г.Липецка ДОУ №76 г.Липецка	186	preschool	239	\N	\N	\N	https://dou76-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398043, г. Липецка, Терешковой, д. 6а
245	Муниципальное бюджетное дошкольное образовательное учреждение №77 г.Липецка ДОУ №77 г.Липецка	186	preschool	240	\N	\N	\N	https://dou77-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Волгоградская, 8а
246	Муниципальное бюджетное дошкольное образовательное учреждение №78 г.Липецка ДОУ №78 г.Липецка	186	preschool	241	\N	\N	\N	https://dou78lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398024, г. Липецк, пр. Победы, 47А
247	Муниципальное бюджетное дошкольное образовательное учреждение №79 г.Липецка ДОУ №79 г.Липецка	186	preschool	242	\N	\N	\N	https://doulip79.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398032, г. Липецк, ул. Циолковского, д. 5/3
248	Муниципальное бюджетное дошкольное образовательное учреждение №83 г.Липецка ДОУ №83 г.Липецка	186	preschool	243	\N	\N	\N	https://mdoulip83.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398016, г. Липецк, ул. Космонавтов, 20/2
249	Муниципальное бюджетное дошкольное образовательное учреждение №85 г.Липецка ДОУ №85 г.Липецка	186	preschool	244	\N	\N	\N	https://lipetskdou85.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Коммунистическая, 22а
250	Муниципальное бюджетное дошкольное образовательное учреждение №91 г.Липецка ДОУ №91 г.Липецка	186	preschool	245	\N	\N	\N	https://mdoulip-91.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398000, г. Липецк, ул. Семашко, 12; ул. Липовская, 3/2
251	Муниципальное бюджетное дошкольное образовательное учреждение №95 г.Липецка ДОУ №95 Г.Липецка	186	preschool	246	\N	\N	\N	https://dou95lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Филипченко, 8
252	Муниципальное бюджетное дошкольное образовательное учреждение №96 г.Липецка ДОУ №96 г.Липецка	186	preschool	247	\N	\N	\N	https://dou96lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398043, г. Липецк, ул. Циолковского, дом 37, строение 4, ул. Космонавтов, д.25, строение 6
253	Муниципальное бюджетное дошкольное образовательное учреждение №98 г.Липецка ДОУ №98 г.Липецка	186	preschool	248	\N	\N	\N	https://dou98lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звездная, д. 6/2
254	Муниципальное бюджетное дошкольное образовательное учреждение №99 г.Липецка ДОУ №99 г.Липецка	186	preschool	249	\N	\N	\N	https://ds99-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звёздная, 17
255	Муниципальное бюджетное дошкольное образовательное учреждение №101 г.Липецка ДОУ №101 г.Липецка	186	preschool	250	\N	\N	\N	https://detsad101lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398058, г. Липецк, ул. 15 микрорайон, д.20
256	Муниципальное бюджетное дошкольное образовательное учреждение №103 г.Липецка ДОУ №103 г.Липецка	186	preschool	251	\N	\N	\N	https://dou103lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398058, г. Липецк, 15 микрорайон, д.2/2
257	Муниципальное бюджетное дошкольное образовательное учреждение №105 г.Липецка ДОУ №105 г.Липецка	186	preschool	252	\N	\N	\N	https://ds105sk48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звездная, 5
258	Муниципальное бюджетное дошкольное образовательное учреждение №107 г.Липецка ДОУ №107 г.Липецка	186	preschool	253	\N	\N	\N	https://dou107.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, ул. 8 Марта д. 20/3
259	Муниципальное бюджетное дошкольное образовательное учреждение №110 г.Липецка ДОУ №110 г.Липецка	186	preschool	254	\N	\N	\N	https://dou110lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398902, г. Липецк, пер. Рудный, 9а
260	Муниципальное бюджетное дошкольное образовательное учреждение №112 г.Липецка ДОУ №112 г.Липецка	186	preschool	255	\N	\N	\N	https://dou112-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398908, г. Липецк, ул. Энергостроителей, 8
261	Муниципальное бюджетное дошкольное образовательное учреждение №113 г.Липецка ДОУ №113 г.Липецка	186	preschool	256	\N	\N	\N	https://ds113-lipetsk48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, ул. Неделина, 47, ул. Неделина, 33
262	Муниципальное бюджетное дошкольное образовательное учреждение №114 г.Липецка ДОУ №114 г.Липецка	186	preschool	257	\N	\N	\N	https://dou114-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398001, г. Липецк, ул. 8 Марта, 24/3
263	Муниципальное бюджетное дошкольное образовательное учреждение №116 г.Липецка ДОУ №116 г.Липецка	186	preschool	258	\N	\N	\N	https://ds116lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398006, г. Липецк, ул. Жуковского, 11А
264	Муниципальное бюджетное дошкольное образовательное учреждение №119 г.Липецка ДОУ №119 г.Липецка	186	preschool	259	\N	\N	\N	https://dou119lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Корпус №1: 398024, г. Липецк, ул. Айвазовского, д.7
265	Муниципальное бюджетное дошкольное образовательное учреждение №123 г.Липецка ДОУ №119 г.Липецка	186	preschool	260	\N	\N	\N	https://ds123lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398035, г. Липецк, ул. Звёздная, 10/4
266	Муниципальное бюджетное дошкольное образовательное учреждение №124 г.Липецка ДОУ №124 г.Липецка	186	preschool	261	\N	\N	\N	https://ds124-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398002, г. Липецк, ул.Терешковой, д.23
267	Муниципальное автономное дошкольное образовательное учреждение №126 г.Липецка ДОУ №126 г.Липецка	186	preschool	262	\N	\N	\N	https://dou126lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, пр. 60-летия СССР, 14
268	Муниципальное бюджетное дошкольное образовательное учреждение №127 г.Липецка ДОУ №127 г.Липецка	186	preschool	263	\N	\N	\N	https://dou127-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398902, г. Липецк, ул. Юношеская, 12
269	Муниципальное бюджетное дошкольное образовательное учреждение №128 г.Липецка ДОУ №128 г.Липецка	186	preschool	264	\N	\N	\N	https://ds128-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, проспект 60 лет СССР, д. 8
270	Муниципальное бюджетное дошкольное образовательное учреждение №130 г.Липецка ДОУ №130 г.Липецка	186	preschool	265	\N	\N	\N	https://dou130-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398059, г. Липецк, проспект Победы, д.15
271	Муниципальное бюджетное дошкольное образовательное учреждение №133 г.Липецка ДОУ №133 г.Липецка	186	preschool	266	\N	\N	\N	https://ds133.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул. П.Смородина, д. 26
272	Муниципальное бюджетное дошкольное образовательное учреждение №134 г.Липецка ДОУ №134 г.Липецка	186	preschool	267	\N	\N	\N	https://ds134-lipeck.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398005, г. Липецк, ул. Степана Разина, 1
273	Муниципальное бюджетное дошкольное образовательное учреждение №135 г.Липецка ДОУ №135 г.Липецка	186	preschool	268	\N	\N	\N	https://lipetsksadik135.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул. П. Смородина, 4а
274	Муниципальное бюджетное дошкольное образовательное учреждение №136 г.Липецка ДОУ №136 г.Липецка	186	preschool	269	\N	\N	\N	https://dou136lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, проспект 60 лет СССР, д.29
275	Муниципальное бюджетное дошкольное образовательное учреждение №137 г.Липецка ДОУ №137 г.Липецка	186	preschool	270	\N	\N	\N	https://mdoulip137.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398046, г. Липецк, ул.Стаханова, д.31 а
276	Муниципальное бюджетное дошкольное образовательное учреждение №138 г.Липецка ДОУ №138 г.Липецка	186	preschool	271	\N	\N	\N	https://mdou138-lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398036, г. Липецк, ул. Проспект 60 лет СССР, д. 13
277	Муниципальное бюджетное дошкольное образовательное учреждение №139 г.Липецка ДОУ №139 г.Липецка	186	preschool	272	\N	\N	\N	https://dou139-lipetsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398050, г. Липецк, ул. Нижняя логовая, 1
278	МБОУ СОШ им. А.М. Селищева с.Волово	188	vo	273	\N	\N	\N	https://sh-volovskaya.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399580, Российская Федерация, Центральный федеральный округ, Липецкая обл., Воловский район, с. Волово, ул. Советская, дом 122
279	МБОУ СОШ с.Захаровка	188	school	274	\N	\N	\N	https://sh-zaxarovskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399591, Липецкая область, Воловский район, село Захаровка, улица Школьная, дом 1
280	МБОУ СОШ им. И. А. Солдатова с.Нижнее Большое	188	school	275	\N	\N	\N	https://sh-bolshovskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область Воловский район с. Нижнее Большое ул. Школьная д.91
281	МБОУ СОШ им. В.Т. Чернова д.Верхнее Чесночное	188	school	276	\N	\N	\N	https://sh-vchesnochnoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399573, Липецкая область, Воловский район, д. Верхнее Чесночное, ул. В. Чернова, д. 24
284	МБОУ СОШ №1 г.Данкова	190	school	279	\N	\N	\N	https://mousosh01-dankov.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399850, Липецкая область, г. Данков, ул. Энгельса, д.7
285	МБОУ лицей №6 г.Данкова	190	school	280	\N	\N	\N	https://sh6-dankov-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399852, РФ, Липецкая область, г. Данков, ул. Мичурина, д. 7/1.; Липецкая область, Данковский район, с. Спешнево-Ивановское, ул. Куйбышева, д.6., ; Липецкая область, Данковский район, с. Березовка, ул. Парковая, д. 3/1, ; Липецкая область, Данковский район, с. Барятино, ул. Школьная, д. 12, ; Липецкая область, Данковский район, с. Воскресенское (Октябрьский с/с), ул. Мира, д. 12
286	МБОУ СОШ с.Баловнево	190	school	281	\N	\N	\N	https://balschl.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399830 Липецкая область Данковский район с. Баловнево ул. Школьная д.43
287	МБОУ СШ с.Бигильдино	190	school	282	\N	\N	\N	https://sh-bigildino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399841, Липецкая область, Данковский район, с. Бигильдино, ул. Центральная, д.59
288	МБОУ ООШ с.Ивановка	190	school	283	\N	\N	\N	https://sh-ivanovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
289	МБОУ лицей №4 г.Данкова	190	school	284	\N	\N	\N	https://sh4-dankov-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399852, Липецкая область, Данковский район, город Данков, улица Мичурина, дом 8; 399852, Липецкая область, Данковский район, город Данков, улица Молодежная, дом 2;; Филиал МБОУ лицей №4 г. Данкова в с. Политово по адресу:399800 Липецкая область, Данковский район, ж/д ст. Политово, улица Школьная, дом 1А;399801 Липецкая область, Данковский район, с. Кудрявщино, улица Зеленая, дом 21.Телефон: (847465) 57-1-41
290	МБДОУ №1 «Солнышко»	190	preschool	285	\N	\N	\N	https://ds1dankov.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399850, РФ, Липецкая обл., г. Данков, ул. Урицкого, д.34/1
291	МБДОУ д/с №2 «Ромашка»	190	preschool	286	\N	\N	\N	https://ds-2romashka-dankov-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399851, Липецкая область, г. Данков, ул. Мичурина, д.11/1
292	Муниципальное бюджетное дошкольное образовательное учреждение детский сад комбинированного вида №3 города Данкова Липецкой области Детский сад №3 г.Данков	190	preschool	287	\N	\N	\N	https://detsad3.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399852, РФ, Липецкая область, г. Данков, ул. Мичурина, д.5, корпус 1
293	МБДОУ №4 «Ягодка»	190	preschool	288	\N	\N	\N	https://dou4yagodka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399852, Россия, Липецкая область, город Данков, ул. Молодежная, д.3; ул. Свердлова, д.14
294	МАДОУ №7 «Сказка»	190	preschool	289	\N	\N	\N	https://madou7dankov.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399852, Липецкая область, г. Данков, ул. Мира, д.40
295	МАДОУ №8 Данковского муниципального района Липецкой области	190	preschool	290	\N	\N	\N	https://ds-8ulybka-dankov-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399851, Липецкая обл., г. Данков, ул Мичурина, д 11/1 (№51, 56);; 399850, Липецкая обл., г. Данков, ул. Мира, д.5, к.1 (№35, 38, 41, 45); 399852, Липецкая обл.
296	МБДОУ детский сад с.Спешнево-Ивановское	190	preschool	291	\N	\N	\N	https://ds-speshnevoivanovskoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399824, Липецкая область Данковский район с. Спешнево-Ивановское ул. Куйбышева д.4
297	МБОУ ООШ с.Ягодное	190	preschool	292	\N	\N	\N	https://sh-yagodnoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Данковский район, с. Ягодное, ул. Школьная, д.2
298	МБОУ «Лицей №1» п.Добринка	191	school	293	\N	\N	\N	https://lic1dobrinka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399431; Липецкая область, Добринский район, п. Добринка, ул. Ленинская, дом 3.
299	МБОУ СОШ №2 п.Добринка	191	school	294	\N	\N	\N	https://sh2dobrinka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399430, Липецкая область, Добринский район, п. Добринка, ул. Октябрьская, д. 79
300	МБОУ «Гимназия им. И.М.Макаренкова» с.Ольговка	191	school	295	\N	\N	\N	https://olggimnaziya.gosuslugi.ru/nasha-shkola/o-shkole/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399420, Липецкая область, Добринский район, ж.-д. ст. Плавица, ул. Школьная, 1
301	МБОУ СОШ с.Дубовое	191	school	296	\N	\N	\N	https://dubovoe-dobrinka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399418, Липецкая область, Добринский район, с. Дубовое, ул. Лермонтова, 2 "А"
302	МБОУ СОШ с.Мазейка	191	school	297	\N	\N	\N	https://sc-mazeyka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399434, Липецкая обл., Добринский р-н, с. Мазейка, ул. Центральная, д.79
283	МБОУ СОШ с.Захаровка	188	school	278	\N	1.0	11.0	https://sh-zaxarovskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:49:27.053088	399581 Липецкая область, Воловский район, с.Захаровка, ул. Школьная, д.1
303	МБОУ СШ с.Нижняя Матренка	191	school	298	\N	\N	\N	https://nmatrenka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399412, Липецкая область, Добринский район, с. Нижняя Матренка, ул. Центральная, д.50
304	МБОУ СОШ с.Верхняя Матренка	191	school	299	\N	\N	\N	https://v-matrenka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399455 Липецкая обл., Добринский район, с. Верхняя Матренка, ул. Центральная д.32.
305	МБОУ СШ п.Петровский	191	school	300	\N	\N	\N	https://petrowskiyschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399446 Липецкая область Добринский район п. совхоза Петровский ул. Победы дом 3
306	МБОУ СШ с.Пушкино	191	school	301	\N	\N	\N	https://sh-pushkino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399441 Липецкая область, Добринский район, с. Пушкино, ул. Мира, д. 29 Б
307	МБОУ СШ ст. Хворостянка	191	school	302	\N	\N	\N	https://xvorostanka48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399410, Липецкая область, Добринский район, ст. Хворостянка, ул. Октябрьская, д.14.
308	МБОУ СШ с.Талицкий Чамлык Добринского муниципального района Липецкой области	191	school	303	\N	\N	\N	https://shc0-latalica.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399450 Липецкая область, Добринский район, с. Талицкий Чамлык, ул. Советская, д. 41
309	МАДОУ д/с №2 п.Добринка	191	preschool	304	\N	\N	\N	https://ds2dobrinka48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399431 Липецкая область, п. Добринка, ул. Воронского, дом 49
310	МАДОУ д/с №4 п.Добринка Липецкой области	191	preschool	305	\N	\N	\N	https://dobrinka4sad.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399431, Липецкая область, Добринский округ, п. Добринка, ул. Кирова, д.6
311	МБДОУ д/с с.Демшинка	191	preschool	306	\N	\N	\N	https://ds-demshinka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399458 Липецкая область Добринский район с. Демшинка ул.Школьная, д.10
312	МАДОУ д.сад ст. Плавица	191	preschool	307	\N	\N	\N	https://ds-demshinka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399420 Липецкая область, Добринский район, ж/д ст. Плавица, ул. Строителей, д.17
313	МБОУ СОШ №1 им. А.И. Левитова С.Доброе	192	school	308	\N	\N	\N	https://sc1dobroe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399140, Липецкая область, Добровский район, с. Доброе, ул. Победы, д. 13
314	МБОУ СОШ №2 с.Доброе им. М.И. Третьяковой	192	school	309	\N	\N	\N	https://sch02dobroe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399140, Липецкая область, Добровский район, с. Доброе, ул. Ленина, д. 39
315	МБОУ СОШ с.Большой Хомутец Добровского муниципального округа Липецкой области	192	school	310	\N	\N	\N	https://bh-school.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399170, Липецкая область, Добровский район, с. Большой Хомутец, ул. Советская, д.47
316	МБОУ СОШ №2 с.Каликино	192	school	311	\N	\N	\N	https://sc2kalikino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399162, Липецкая область, Добровский район, с. Каликино, ул. Советская, д. 100.
317	МБОУ СОШ №1 с.Каликино	192	school	312	\N	\N	\N	https://sc1-kalikino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399162 Липецкая область Добровский район, с.Каликино, пл.Ленина, д. 31
318	МБОУ СОШ с.Крутое	192	school	313	\N	\N	\N	https://sh-krutoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399145, Липецкая область, Добровский район, с. Крутое, ул. Комсомольская, д. 21
319	МБОУ СОШ с.Кореневщино	192	school	314	\N	\N	\N	https://sh-korenevshhino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399171 Липецкая область, Добровский район, с. Коренёвщино, ул. Центральная, д. 5
320	МБОУ ООШ с.Махоново	192	school	315	\N	\N	\N	https://schkola-s-mahonovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399161 Липецкая область Добровский район село Махоново ул. Ленина д.37
321	МБОУ СОШ с.Панино	192	school	316	\N	\N	\N	https://paninoschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399148 Липецкая область Добровский район с.Панино, ул.Молодёжная, д.5
322	МБОУ ООШ с.Порой	192	school	317	\N	\N	\N	https://porojshkola.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399155, Липецкая область, Добровский район, с. Порой, ул. Советская, д. 31
323	МБОУ СОШ с.Преображеновка	192	school	318	\N	\N	\N	https://sh-preobragenovka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399175 Липецкая область, Добровский район, с.Преображеновка, ул. Центральная, д. 8
324	МБОУ СОШ им. Н. Ф. Пономарева с.Трубетчино	192	school	319	\N	\N	\N	https://sh-trubetchino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399151 Липецкая обл, Добровский район, с. Трубетчино, ул. Почтовая, д. 17
325	МБОУ ООШ с.Екатериновка	192	school	320	\N	\N	\N	https://ekaterinovka-school.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399152, Россия, Липецкая область, Добровский район, с. Екатериновка, ул. Черёмушки, д. 2.
326	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Золотой петушок» села Доброе Добровского муниципального округа Липецкой области ДОУ детский сад «Золотой петушок» с.Доброе	192	preschool	321	\N	\N	\N	https://petushok-dobroe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399140, Россия, Липецкая область, село Доброе, улица Калинина, д. 45 А
327	МБДОУ «Малыш» с.Ратчино	192	preschool	322	\N	\N	\N	https://ds-malysh-ratchino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399147, Липецкая обл, Добровский р-н, Ратчино с, ул. Ленина д. 11
329	Муниципальное бюджетное дошкольное образовательное учреждение «Теремок» с.Большой Хомутец Добровского муниципального округа Липецкой области ДОУ «Теремок» с.Б. Хомутец	192	preschool	324	\N	\N	\N	https://ds-teremok-b-xomutec.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399170, Россия, Липецкая область, Добровский район, с. Большой Хомутец, ул. Центральная, дом 43
330	МБДОУ д/с «Берёзка» с.Каликино Добровского муниципального округа Липецкой области	192	preschool	325	\N	\N	\N	https://ds-beryozka-kalikino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область Добровский район с. Каликино площадь Ленина, 38
331	МБДОУ «Колосок» с.Крутое	192	preschool	326	\N	\N	\N	https://ds-kolosok-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399145 Липецкая область Добровский район с. Крутое ул. Комсомольская д.24
332	МБДОУ «Малышок» с.Панино	192	preschool	327	\N	\N	\N	https://paninosad31.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399148, Липецкая область, Добровский район, с. Панино, ул. Молодежная, д.31
333	МБДОУ «Солнышко» с.Трубетчино	192	preschool	328	\N	\N	\N	https://ds-solnyshko-trubetchino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399151, Липецкая область, Добровский район, с.Трубетчино, ул. Почтовая, д.33
334	МБДОУ «Сказка»	192	preschool	329	\N	\N	\N	https://ds-skazka-borisovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399173, Липецкая область, Добровский район, с. Борисовка, ул. Новая д.1/1
335	МБДОУ «Солнышко» с.Волчье	192	preschool	330	\N	\N	\N	https://ds-solnyshko-volche-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399154, Липецкая обл, Добровский р-н, Волчье с, Центральная ул, 6
336	МБДОУ «Родничок» с.Замартынье	192	preschool	331	\N	\N	\N	https://ds-rodnichok-zamartyne-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399150 Липецкая область, Добровский район, село Замартынье, улица Советская, 18
337	МБДОУ «Теремок» с.Кривец	192	preschool	332	\N	\N	\N	https://ds-teremok-krivec.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399174 Липецкая обл, Добровский округ с. Кривец, ул. Песчановка д.1
338	МБДОУ «Колобок» с.Путятино	192	preschool	333	\N	\N	\N	https://ds-kolobok-putyatino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Добровский район, с. Путятино, ул. Костикова, д. 29
339	МБОУ лицей с.Долгоруково	193	school	334	\N	\N	\N	https://lic-dolgorukovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399510, Липецкая область, с.Долгоруково, ул.Терешковой, д.19
340	МБОУ СОШ с.Братовщина имени Героя Советского Союза В.С.Севрина	193	school	335	\N	\N	\N	https://sh-bratovshhina-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399510, Липецкая область, с. Долгоруково, ул. Тимирязева, 6.
341	МБОУ СОШ с.Верхний Ломовец	193	school	336	\N	\N	\N	https://sh-verxnij-lomovec-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399525, Липецкая область, Долгоруковский район, с. Верхний Ломовец, ул. Школьная, д. 1
342	МБОУ ООШ с.Войсковая Казинка	193	school	337	\N	\N	\N	https://sh-vojskovaya-kazinka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399504 Липецкая область Долгоруковский район с. Войсковая Казинка ул. Центральная д.18
343	МБОУ ООШ д.Веселая	193	school	338	\N	\N	\N	https://veselaya.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
344	МБОУ СОШ с.Стегаловка	193	school	339	\N	\N	\N	https://stegschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399500 с. Стегаловка Долгоруковского округа Липецкой области, улица Школьная, д.5
345	МБДОУ детский сад «Солнышко» с.Долгоруково	193	preschool	340	\N	\N	\N	https://dousolnce-dolgor.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399510, область Липецкая, р-н Долгоруковский, с.Долгоруково, ул. Ивана Ермолова, д.2
346	МБДОУ детский сад «Теремок» с.Грызлово	193	preschool	341	\N	\N	\N	https://ds-teremok-gryzlovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
347	МБДОУ д/с «Карамелька» с.Дубовец	193	preschool	342	\N	\N	\N	https://dscaramelkadubovets.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399512, Липецкая область, Долгоруковский район, с. Дубовец, ул. Центральная, дом 15
348	МБДОУ детский сад "Радуга» д.Екатериновка	193	preschool	343	\N	\N	\N	https://ds-raduga-ekaterinovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Долгоруковского округа, д.Екатериновка, ул. Центральная, 10
349	МБОУ СОШ с.Каменское им. Г.Н.Елецких	194	school	344	\N	\N	\N	https://sckamenskoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399760 Липецкая область Елецкий район с.Каменское ул.Школьная, зд.25
350	МБОУ СОШ №2 с.Казаки	194	school	345	\N	\N	\N	https://sckazaki.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399746, Липецкая область, Елецкий район, село Казаки, ул. Мира, д.2
351	МБОУ СОШ п.Ключ жизни	194	school	346	\N	\N	\N	https://sc-klychgizni.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399770, Россия, Липецкая область, г. Елец, ул. 9-ое Декабря, 54
352	МБОУ СШ с.Талица им. С.А. Бутова	194	school	347	\N	\N	\N	https://schooltalitsa.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399761, Липецкая область, Елецкий район, с. Талица, ул. Советская, д. 152Б
353	МБОУ СОШ п.Солидарность	194	school	348	\N	\N	\N	https://solshk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399750, Липецкая область, Елецкий район, п. Солидарность, ул. Школьная, д. 2 А.
354	МБОУ ООШ с.Лавы	194	school	349	\N	\N	\N	https://sh-lavy.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399780, Липецкая область, Елецкий район, с.Лавы, ул.Северная, д. 3
356	МБДОУ детский сад п.Елецкий	194	preschool	351	\N	\N	\N	https://detsadeletskiy.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399774, Липецкая область, Елецкий район, п. Елецкий, ул. 50 лет Октября, д.4
357	МБДОУ детский сад «Солнышко» п.Газопровод	194	preschool	352	\N	\N	\N	https://detsadsolnischko.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399742, Липецкая область, Елецкий район, п.Газопровод, ул.Мирная д.5
358	МБДОУ детский сад «Солнышко» села Казаки комбинированного вида	194	preschool	353	\N	\N	\N	https://ds-kazakisol.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399746, Липецкая область, Елецкий район, село Казаки, улица Мира, д. 28
359	МБДОУ д/с «Тополёк» с.Казаки	194	preschool	354	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399747 Липецкая область, Елецкий район, село Казаки, улица Заводская, 78
360	МБДОУ детский сад д.Казинка	194	preschool	355	\N	\N	\N	https://doukazinka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399759 Липецкая область Елецкий район д.Казинка ул. Совхозная д.4
361	МБДОУ детский сад с.Каменское	194	preschool	356	\N	\N	\N	https://dskamenskoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399760, Липецкая область, Елецкий район, село Каменское, улица Школьная, дом 23
362	МБДОУ детский сад п.Ключ жизни	194	preschool	357	\N	\N	\N	https://ds-klyuch.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Елецкий район, пос. Ключ жизни, ул. 1-ая Садовая, д.9
363	МБДОУ детский сад п.Маяк	194	preschool	358	\N	\N	\N	https://dsmayak.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399749, Липецкая область, Елецкий район, п. Маяк, ул. Садовая, д.10.
364	МБДОУ детский сад п.Солидарность	194	preschool	359	\N	\N	\N	https://solsadik.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399750, Липецкая обл., Елецкий район, п. Солидарность, ул. Школьная, д. 6а, 6б
365	МБДОУ детский сад посёлок Соколье	194	preschool	360	\N	\N	\N	https://sokolieds.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399753, Липецкая область, Елецкий район, поселок Соколье, улица Лорха, д.9
366	МБДОУ детский сад с.Талица	194	preschool	361	\N	\N	\N	https://dstalisa.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399761 Липецкая область Елецкий район село Талица улица Советская дом 146А
367	МБДОУ детский сад "Сказка" д.Хмелинец	194	preschool	362	\N	\N	\N	https://douhmelinec.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Елецкий район, деревня Хмелинец, переулок Новый, д.2
368	МБОУ СОШ с.Афанасьево Измалковского округа Липецкой области	196	school	363	\N	\N	\N	https://sh-afanasevo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
369	МБОУ СОШ №1 с.Измалково Измалковского округа Липецкой области	196	school	364	\N	\N	\N	https://sh-1izmalkovo-izmalkovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
370	МБОУ СОШ с.Преображенье Измалковского округа Липецкой области	196	school	365	\N	\N	\N	https://preobrajnie.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399012, Россия, Липецкая область, Измалковский район, с.Преображенье, ул. Стаханова, д.10
371	МБОУ СОШ с.Чернава Измалковского округа	196	school	366	\N	\N	\N	https://sh-chernava-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
372	МБОУ ООШ с.Измалково Измалковского округа Липецкой области	196	school	367	\N	\N	\N	http://ms2.my.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399000, Россия, Липецкая обл, Измалковский р-н, Измалково с, Советская ул, 53.
373	МБОУ ООШ с.Лебяжье Измалковского округа Липецкой области	196	school	368	\N	\N	\N	https://lebiaje.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399003, Липецкая область, Измалковский округ, с. Лебяжье, ул. Школьная, д.1
374	МБОУ ООШ с.Полевые Локотцы	196	school	369	\N	\N	\N	https://polevie.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399002, Липецкая область, Измалковский, 2 Лебяженский сельсовет, с Полевые Локотцы, Д. 24
375	МБОУ ООШ Д.Сухой Семенек Измалковского округа Липецкой области	196	school	370	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399007, Липецкая область, Измалковский р-н, д Сухой Семенек, Школьная ул, д. 62
376	МБДОУ «Родничок» С.Слобода Измалковского района Липецкой области	196	preschool	371	\N	\N	\N	https://4250.maam.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399000, Липецкая область, Измалковский район, село Слобода, ул Мира, д. 23
377	МБДОУ «Улыбка» с.Пятницкое Измалковского района Липецкой области	196	preschool	372	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399235, Липецкая область, Измалковский район, село Пятницкое, улица Рабочий поселок, д. 2
378	МБДОУ «Ручеёк» Д.Панкратовка Измалковского района Липецкой области	196	preschool	373	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399014, Липецкая область, Измалковский район, деревня Панкратовка, Молодежная ул, д. 6
379	МБДОУ «Светлячок» д.Недоходовка Измалковского района	196	preschool	374	\N	\N	\N	https://www.list-org.com/company/2245115	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399010, Липецкая область, Измалковский район, деревня Недоходовка, улица Центральная, д. 8
380	МБДОУ «Сказка» д.Денисово Измалковского района Липецкой области	196	preschool	375	\N	\N	\N	https://denskazka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399022, Липецкая область, Измалковский район, д.Денисово, ул.Овражная, д.7
405	МБДОУ д/с «Колосок» п.Лев Толстой	199	preschool	400	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399870, Россия, Липецкая область, Лев-Толстовский район, п. Лев Толстой, ул. Садовая, д. 40а
381	МБДОУ «Теремок» с.Быково Измалковского района Липецкой области	196	preschool	376	\N	\N	\N	https://5286.maam.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399026, Липецкая область, Измалковский район, с.Быково, ул.Центральная, д.42.
382	МБДОУ «Солнышко» с.Измалково Измалковского района Липецкой области	196	preschool	377	\N	\N	\N	https://ds-solnyshko-izmalkovo-r42.gosweb.gosuslugi.ru/titulnaya-stranitsa/text_27.html	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399000, Липецкая область, Измалковский округ, с.Измалково, ул. Мира, дом 6
383	МБДОУ «Ромашка» с.Афанасьево Измалковского района	196	preschool	378	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399020, Липецкая область, Измалковский район, село Афанасьево, улица Рабочая, д. 2
384	МБДОУ "Солнышко" с.Чернава Измалковского района Липецкой области	196	preschool	379	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399234, Липецкая область, Измалковский район, село Чернава, улица Первомайская, д. 192
385	МБОУ СШ с.Сотниково	197	school	380	\N	\N	\N	http://http://sotnicowo.nubex.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399685 Липецкая область, Краснинский район, с. Сотниково, ул. Лесная, 20
386	МБОУ СШ с.Решетово-Дуброво	197	school	381	\N	\N	\N	https://sh-reshetovodubrovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Краснинский р-н, с.Решетово-Дуброво, ул.Центральная д11, индекс 399683
387	МБОУ СОШ с.Красное	197	school	382	\N	\N	\N	https://sh-krasnoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
388	МБОУ СШ п.Лески	197	school	383	\N	\N	\N	https://sh-leski-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399675 Липецкая область, Краснинский район, п. Лески, ул. Октябрьская, д.45.
389	МБОУ СШ с.Верхнедрезгалово	197	school	384	\N	\N	\N	https://sh-verxnedrezgalovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399663 Липецкая область Краснинский район село Верхнедрезгалово улица Центральная дом 60
390	МБДОУ детский сад «Антошка» д.Дегтевая Краснинского муниципального округа Липецкой области	197	preschool	385	\N	\N	\N	https://ds-antoshka-degtevaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399680, Липецкая область, Краснинский район, деревня Дегтевая, Центральная ул., д.25
391	МБДОУ детский сад «Теремок» с.Верхнедрезгалово	197	preschool	386	\N	\N	\N	https://mbdou-detskiy-sad-teremok-s-vs-xa1.orgs.biz/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399663, Россия, Липецкая обл, Краснинский р-н, Верхнедрезгалово с, Центральная ул., д. 87
392	МБДОУ детский сад «Солнышко» с.Ищеино	197	preschool	387	\N	\N	\N	https://www.list-org.com/company/2644434	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399688, Липецкая область, Краснинский район, село Ищеино, Школьная ул., д.10
393	МБДОУ детский сад «Малыш» с.Красное	197	preschool	388	\N	\N	\N	https://det-sad.3dn.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399670, Липецкая область, Краснинский район, село Красное, Коммунальная ул., д.12
394	МБДОУ детский сад «Солнышко» с.Красное	197	preschool	389	\N	\N	\N	https://ds-solnyshko-krasnoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399670, Липецкая область, Краснинский район, посeлок Краснинский, улица Газовиков, дом 17
395	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Чебурашка» с.Суходол (МБДОУ Детский Сад «Чебурашка» С.Суходол	197	preschool	390	\N	\N	\N	https://www.list-org.com/company/2644437	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399684, Липецкая область, Краснинский район, село Суходол, Торговая ул., д.5а
396	МБДОУ детский сад «Солнышко» с.Решетово-Дуброво	197	preschool	391	\N	\N	\N	https://mbdoureshetovodubrovo.ucoz.net/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Краснинский район, село Решетово-Дуброво, ул. Центральная, д. 44
397	МБДОУ детский сад «Ромашка»	197	preschool	392	\N	\N	\N	http://camomile-caduk.ucoz.site/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399675, Краснинский район, п. Лески, ул. Мира, д.7
398	МБОУ п.Лев Толстой	199	school	393	\N	\N	\N	https://sh-levtolstoj-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399870 Россия, Липецкая область, п. Лев Толстой, пер. Советский зд.2
400	МБОУ с.Кузовлево	199	school	395	\N	\N	\N	https://kuzovlevo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399883, Липецкая область, Лев-Толстовский район, с.Кузовлево, ул.Школьная, д.8
401	МБОУ с.Митягино	199	school	396	\N	\N	\N	https://ltmit24.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399881, Липецкая область, Лев-Толстовский район, с.Митягино, ул.Горбатовка д.4 юридический адрес
402	МБОУ с.Новочемоданово	199	school	397	\N	\N	\N	https://n-tschemodanowo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399880 Липецкая область Лев Толстовский район село Новочемоданово улица Школьная дом 1
403	МБОУ им. Героя Советского Союза Аулова В.И. с.Первомайское	199	school	398	\N	\N	\N	https://school-imaulovavi.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399884, Липецкая обл., Лев-Толстовский р-он, с. Первомайское, ул. Центральная, д. 12
404	МБОУ им. Л.Н. Толстого	199	school	399	\N	\N	\N	https://ltschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399870 Липецкая обл., Лев-Толстовский р-н, п. Лев Толстой, ул. Молодежная, д. 6
406	МБДОУ д/с «Теремок» п.Лев Толстой	199	preschool	401	\N	\N	\N	https://ds-teremok-lt.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399870, Липецкая область п. Лев Толстой ул. Коммунистическая, д.30
408	МБОУ гимназия с.Боринское	200	school	403	\N	\N	\N	https://gimn-borinskoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398510, Липецкая область, Липецкий округ, село Боринское, улица П. Смородина, д.11
409	МБОУ СШ с.Ильино	200	school	404	\N	\N	\N	https://schoolilyino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398507, Липецкая область, Липецкий район, с. Ильино, ул. Административная д .2
410	МБОУ СОШ с.Кузьминские Отвержки	200	school	405	\N	\N	\N	https://koschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
411	МБОУ НОШ с.Ленино	200	school	406	\N	\N	\N	https://sh-lenino.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398531, Липецкая область, Липецкий район, с. Ленино, ул. Молодежная, д.123
412	МБОУ СОШ д.Новая Деревня	200	school	407	\N	\N	\N	https://sh-novaya-derevnya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398503 Липецкая область, Липецкий район, д. Новая Деревня, ул. Первомайская, д.9
413	МБОУ СОШ с.Новодмитриевка Липецкого муниципального района Липецкой области	200	school	408	\N	\N	\N	https://sc-nd48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398550, Липецкая обл., Липецкий р-н, с. Новодмитриевка, ул. Ленина, д. 2
414	МБОУ СОШ имени Героя Советского Союза В.М.Игнатьева с.Пружинки	200	school	409	\N	\N	\N	https://sh48pruzhinki.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398541 Липецкая область Липецкий район село Пружинки улица 50 лет Октября дом 201А
415	МБОУ СШ с.Сенцово	200	school	410	\N	\N	\N	https://sc-sentsovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398540, Липецкая область, Липецкий район, село Сенцово, улица 8 Марта, дом 157
416	МБОУ СОШ с.Сырское	200	school	411	\N	\N	\N	https://syrskoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398533, Россия, Липецкая область, Липецкий район, село Сырское, улица Ленина, д. 7
417	МБОУ СОШ с.Сухая Лубна имени Мозгунова А.З.	200	school	412	\N	\N	\N	https://sh-lubna48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Липецкий район, село Сухая Лубна, улица Советская, дом 23а
418	МБОУ СОШ с.Троицкое им. Героя Советского Союза М.Д.Карасёва	200	school	413	\N	\N	\N	https://sctroickoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398530 Липецкая область, Липецкий округ, с. Троицкое, ул. Гагарина, д.78
419	МБОУ СОШ с.Хрушевка Липецкого муниципального округа	200	school	414	\N	\N	\N	https://hruschevka48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398532, Липецкая область, Липецкий район, с. Хрущевка, ул. Титова, д. 79
420	МБОУ СШ с.Частая Дубрава имени Героя Советского Союза Е.А. Дьяконова	200	school	415	\N	\N	\N	https://sh-chastaya-dubrava-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398513, Россия, Липецкая область, Липецкий район ул. Московская, 13а
421	МБДОУ детский сад «Чебурашка» с.Боринское	200	preschool	416	\N	\N	\N	https://ds-cheburashka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398510 Липецкая область Липецкий район с. Боринское, ул. Салтыкова - Щедрина, д.38
422	МБДОУ детский сад «Липка»	200	preschool	417	\N	\N	\N	https://dslipka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398507, Липецкая область Липецкий район, село Ильино, Новая улица, 2
423	МБДОУ д/с «Ромашка» д.Новая Деревня	200	preschool	418	\N	\N	\N	https://ds-romashka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398503, Липецкая область, Липецкий район, д. Новая Деревня, ул. Первомайская, д. 8
424	МБДОУ детский сад «Солнышко» с.Сенцово	200	preschool	419	\N	\N	\N	https://ds-solsen.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Липецкий район, село Сенцово, ул.70 лет Октября, дом 1Б
425	МБДОУ детский сад «Ручеек» с.Троицкое	200	preschool	420	\N	\N	\N	https://ds-rucheek-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398530 Липецкая область, Липецкий район, с. Троицкое, ул. Октябрьская, д.30
426	МБДОУ детский сад «Пчелка» с.Частая Дубрава Липецкого муниципального округа	200	preschool	421	\N	\N	\N	https://ds-pchelka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398513, Россия, Липецкая область, Липецкий район с. Частая Дубрава ул. Московская, 7а
427	МАДОУ детский сад «Петушок» д.Копцевы Хутора	200	preschool	422	\N	\N	\N	https://ds-petushok-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	398501 Липецкая область, Липецкий район, д. Копцевы Хутора, ул. Котовского, д. 1а
428	МБОУ «СШ с.Становое»	201	school	423	\N	\N	\N	https://scstanovoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399710 Липецкая область, Становлянский округ, с. Становое, ул. Советская, д. 89
429	МБОУ «ОШ с.Грунин Воргол»	201	school	424	\N	\N	\N	https://sh-gruninskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399721 Липецкая область, Становлянский район, с. Грунин Воргол, ул. Советская, д.1
430	МБОУ «СШ с.Ламское»	201	school	425	\N	\N	\N	https://sh-lamskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399704, Российская Федерация, Липецкая область, Становлянский округ, село Ламское, улица Школьная, дом 2
481	МБОУ «СОШ с.Конь-Колодезь»	204	school	476	\N	\N	\N	https://sh-konkolodez-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
431	МБОУ «СШ с.Толстая Дубрава»	201	school	426	\N	\N	\N	https://sh-tolstodubravskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Россия, 399702, Липецкая область, Становлянский округ, с. Толстая Дубрава, ул. 40 лет Победы, д. 5
432	МБОУ «СШ с.Тростное»	201	school	427	\N	\N	\N	https://sh-trostnovskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399716, Липецкая область, Становлянский район, с.Тростное, ул.Центральная д.34
433	МБДОУ «Сказка» с.Становое	201	preschool	428	\N	\N	\N	https://ds-skazka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399722, Липецкая обл., Становлянский округ, с. Становое, ул. Ватутина, д.24; 399722 Липецкая область становлянский округ, пос.Дружба 1Б
434	МБДОУ «Теремок» с.Становое	201	preschool	429	\N	\N	\N	https://dsteremokstanovoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399710, Липецкая обл., Становлянский район, с. Становое, ул Советская, д.33
435	МБДОУ «Светлячок» с.Ламское)	201	preschool	430	\N	\N	\N	https://ds-svetlyachok-lamskoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399704, Липецкая область, Становлянский округ, с. Ламское, ул. Победы, д. 5
436	МБДОУ «Дубравушка» с.Толстая Дубрава	201	preschool	431	\N	\N	\N	https://dubravushkasad-48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399702, РФ, Липецкая область, Становлянский округ, село Толстая Дубрава, улица Центральная, д 34
437	МБДОУ д/с «Малыш» с.Тростное	201	preschool	432	\N	\N	\N	https://dstrostnoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399716, Липецкая область, Становлянский район, село Тростное, Центральная ул, д. 10
438	МБДОУ д/с «Мещерский»	201	preschool	433	\N	\N	\N	https://ds-meshherskij-barsukovo-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399707, Липецкая область, Становлянский округ, деревня Барсуково, улица Ленина, дом 18
439	МБДОУ «Родничок» с.Берёзовка	201	preschool	434	\N	\N	\N	https://ds-rodnichok-beryozovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399708, Липецкая область, Становлянский округ, с. Берёзовка, ул. Ю. Тарасова, д.17
440	МБДОУ детский сад «Солнышко» с.Дмитриевка	201	preschool	435	\N	\N	\N	https://ds-solnyshko-dmitrievka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
441	МБДОУ «Колобок» с.Кириллово	201	preschool	436	\N	\N	\N	https://kirillovodetsad.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399713, Российская Федерация, Липецкая область, Становлянский округ, село Кириллово, улица Центральная, дом.11
442	МБДОУ «Ёлочка» д.Лукьяновка	201	preschool	437	\N	\N	\N	https://ds-elochka-stan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399700, Липецкая обл., Становлянский округ, д. Лукьяновка, ул Парковая, д.17
443	Муниципальное бюджетное дошкольное образовательное учреждение детский сад «Теремок» с.Пальна - Михайловка Становлянского муниципального округа Липецкой области (МБДОУ детский сад «Теремок» с.Пальна-Михайловка	201	preschool	438	\N	\N	\N	https://ds-teremok-palnamixajlovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399732, Липецкая область, Становлянский округ, с.Пальна-Михайловка, ул.Молодёжная, дом 15
444	МБДОУ «Ягодка» с.Чернолес	201	preschool	439	\N	\N	\N	https://ds-yagodka-chernoles-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399725 Липецкая область, Становлянский округ, с.Чернолес, ул.Центральная, д.18
445	МБОУ СОШ с.Тербуны	202	school	440	\N	\N	\N	https://sc-terbuny.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	\N
446	МБОУ СОШ с.Вторые Тербуны	197	school	441	\N	\N	\N	https://terbuny2sch.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399551, Липецкая область, Тербунский район, с. Вторые Тербуны, ул. Советская. д.37
447	МАДОУ детский сад «Солнышко»	197	preschool	442	\N	\N	\N	https://dssolnyshkoterbuny.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Россия, 399540, Липецкая область, Тербунский район, с. Тербуны, ул. Мира д.3
448	МБДОУ детский сад «Колокольчик»	197	preschool	443	\N	\N	\N	https://dskolocolchikterbuny.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Россия, 399540, Липецкая область, Тербунский район, с. Тербуны, ул. Коммунальная д.15
449	МБДОУ детский сад «Ромашка»	197	preschool	444	\N	\N	\N	https://romashka48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399 540 Липецкая область, Тербунский район, село Тербуны, ул. Куйбышева, д. 22
450	МБОУ лицей №1 г.Усмани	203	school	445	\N	\N	\N	https://lic1-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370 Липецкая область г. Усмань ул. Чернышевского, 118
451	МБОУ СОШ №2 г.Усмани	203	school	446	\N	\N	\N	https://sh2-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370, Липецкая область, г. Усмань, ул. Радищева, д.50
452	МБОУ СОШ №3 г.Усмани	203	school	447	\N	\N	\N	https://uschool3.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370, Липецкая область, г.Усмань, ул.Шмидта, д.15
453	МБОУ СОШ села Девица	203	school	448	\N	\N	\N	https://sh-devickaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399361 Липецкая обл., Усманский р-он, с.Девица, ул. Молодежная, д.№6
454	МБОУ СОШ ст.Дрязги	203	school	449	\N	\N	\N	https://sc-dryazgi.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399330, Липецкая область, Усманский район, ж/д ст.Дрязги, ул. Советская, д.38
455	МБОУ СОШ с.Завальное	203	school	450	\N	\N	\N	https://zavshkola.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399346 Липецкая область, Усманский район, с.Завальное, ул.Школьная 147
531	МБДОУ детский сад с.Уткино	195	preschool	526	\N	\N	\N	\N	\N	2026-08-21 15:52:53.651883	2026-08-21 15:52:53.651883	\N
456	МБОУ СОШ с.Октябрьское	203	school	451	\N	\N	\N	https://sh-oktyabrskoye.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399331 Липецкая область Усманский район с. Октябрьское ул. Базарная, д.1
457	МБОУ СОШ с.Сторожевое	203	school	452	\N	\N	\N	https://sh-storozhevoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	З99344, Липецкая область, Усманский район, с. Сторожевое, ул. Школьная, д.46
458	МБОУ ООШ с.Никольское	203	school	453	\N	\N	\N	https://sh-nikolskaya-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399350, Липецкая область, Усманский район, с. Никольское, ул.Советская, 79
459	МБДОУ «ЦРР – д/с «Сказка» г.Усмани	203	preschool	454	\N	\N	\N	https://ds-skazka-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370, Липецкая область, г. Усмань, ул. Терешковой, д. 29
460	МБДОУ д/с «Почемучка» г.Усмани	203	preschool	455	\N	\N	\N	https://ds-pochemuchka-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370, Липецкая область, г. Усмань, ул. Ленина, 28
461	МБДОУ д/с «Теремок» г.Усмани Липецкой области	203	preschool	456	\N	\N	\N	https://ds-teremok-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399370 Липецкая область г.Усмань улица Ленина дом 65
462	МБДОУ д\\с «Журавлёнок» г.Усмани	203	preschool	457	\N	\N	\N	https://ds-zhuravlyonok48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, г.Усмань, ул.Шмидта, д.2
463	МБДОУ д/с «Радуга» г.Усмань	203	preschool	458	\N	\N	\N	https://ds-raduga-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область г. Усмань ул. Воздвиженская д. 1
464	МБДОУ д/с «Непоседа» г.Усмани	203	preschool	459	\N	\N	\N	https://ds-neposeda-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399341, Липецкая область, Усманский район, город Усмань, улица Матросова, дом 39
465	МБДОУ д/с «Родничок» с.Девица	203	preschool	460	\N	\N	\N	https://ds-rodnichok-devica-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область Усманский район село Девица улица Советская д 27
466	МБДОУ д/с «Колобок» с.Завальное	203	preschool	461	\N	\N	\N	https://ds-kolobok-zavalnoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Усманский район, с. Завальное, ул. Ленина, 54
467	МБДОУ д/с «Тополёк» с.Октябрьское	203	preschool	462	\N	\N	\N	https://ds-topolek-oktyabrskoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399331, Липецкая область, Усманский район с. Октябрьское, проспект Революции, дом 91а
468	МБДОУ д/с «Березка» с.Сторожевое	203	preschool	463	\N	\N	\N	https://ds-berezka-storozhevoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399 344, Липецкая обл., Усманский р-он, с.Сторожевое, ул.Школьная д.47
469	МБДОУ д/с «Мальвинка» с.Никольское	203	preschool	464	\N	\N	\N	https://ds-malvinka-nikolskoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399350 Липецкая область, Усманский район, с.Никольское, ул. Чапаева, д.45
470	МБОУ ООШ с.Поддубровка	203	preschool	465	\N	\N	\N	https://beresschkola.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399351, Липецкая область, Усманский район, с. Поддубровка, ул. Школьная, д. 31.; 399367 Липецкая область Усманский район, с. Березняговка, ул. Ворошилова, д.103
471	МБДОУ д/с «Колокольчик» с.Березняговка	203	preschool	466	\N	\N	\N	https://ds-kolokolchik-bereznyagovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399367 Липецкая область, Усманский район, с.Березняговка, улица Ворошилова. дом 104
472	МБДОУ детский сад «Василек» с.Грачевка	203	preschool	467	\N	\N	\N	https://ds-vasilek-grachevka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399366 Липецкая область Усманский район с. Грачевка ул. Советская д. 43
473	МБДОУ д/с «Ручеёк»	203	preschool	468	\N	\N	\N	https://ds-rucheyok-dmitrievka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Усманский район, с.Дмитриевка, улица Молодежная, д.17 а
474	МБДОУ д/с «Буратино» с.Крутченская Байгора	203	preschool	469	\N	\N	\N	https://ds-buratino-krutchenskaya-bajgora-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399363, Липецкая область, Усманский район, с.Крутченская Байгора, ул. Центральная, д.17а
475	МБДОУ д/с «Берёзка» с.Новоуглянка	203	preschool	470	\N	\N	\N	https://ds-beryozka-usman-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399360 Липецкая область, Усманский район, с.Новоуглянка, ул.Дзержинского, дом 10
476	МБДОУ д/с «Искорка» с.Пригородка	203	preschool	471	\N	\N	\N	https://ds-iskorka-prigorodka.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399371 Липецкая область, Усманский район, с. Пригородка, ул. Юбилейная, д.1
477	МБДОУ д/с «Колосок» пос. совхоза «Ударник»	203	preschool	472	\N	\N	\N	https://ds-kolosok-udarnik-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399345 Липецкая область Усманский район пос. совхоза "Ударник" ул. Молодёжная д.15
478	МБДОУ д/с «Аистёнок» с.Стрелецкие Хутора	203	preschool	473	\N	\N	\N	https://ds-aistyonok-strelcy.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399371, Липецкая обл., Усманский р-он, с. Стрелецкие Хутора, ул. Г. Телегина, 160а
479	МБОУ «Лицей села Хлевное»	204	school	474	\N	\N	\N	https://hlevnoeschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399260, Липецкая область, Хлевенский район, село Хлевное, ул. Свободы, д.52
480	МБОУ СОШ с.Дмитряшевка (МБОУ СОШ С.Дмитряшевка Хлевенского Муниципального района Липецкой области	204	school	475	\N	\N	\N	\N	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399250, Липецкая область, Хлевенский район, с.Дмитряшевка, ул.Октябрьская, д.64
482	МБОУ «СОШ с.Новое Дубовое»	204	school	477	\N	\N	\N	https://sh-novoe-dubovoe-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Хлевенский район, село Новое Дубовое, улица Советская, дом 80.
483	МБОУ СОШ с.Елецкая Лозовка	204	school	478	\N	\N	\N	https://sh-eleckaya-lozovka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399263, Липецкая область, Хлевенский район, с. Елецкая Лозовка, ул. Выгонскя-Буторина, д. 20
489	МБОУ гимназия «Новое поколение» города Задонска	195	school	484	\N	\N	\N	https://novoepokolenie.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, город Задонск, улица В.Севастьянова, дом 3
490	МБОУ гимназия №1 г.Задонска	195	school	485	\N	\N	\N	https://gymnasium1zd.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399200 Липецкая область, город Задонск, ул.Свободы 57а
491	МБОУ СОШ с.Донское	195	school	486	\N	\N	\N	https://doschool.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399240, Липецкая область, Задонский район, с. Донское, ул. Новая, д. 1
492	МБОУ СОШ с.Ольшанец	195	school	487	\N	\N	\N	https://sc-olshanets.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Россия, 399222, Липецкая область, Задонский район, пос. Освобождение, ул. Школьная, д. 6
493	МБОУ СОШ с.Паниковец	195	school	488	\N	\N	\N	https://panikovets.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, с. Пани́ковец, ул. Запрудная, д. 18.
494	МБОУ СОШ с.Гнилуша	195	school	489	\N	\N	\N	https://gnilusha.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, с Гнилуша, ул. Советская д. 84
495	МБОУ СОШ с.Хмелинец	195	school	490	\N	\N	\N	https://hmelinetc.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, с.Хмелинец, ул.Зыкова, д.3
496	МБДОУ детский сад №1 г.Задонска	195	preschool	491	\N	\N	\N	https://ds1zadonsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399200 Липецкая область г. Задонск ул. К.Маркса д.56 "А"
497	МБДОУ детский сад №3 г.Задонска	195	preschool	492	\N	\N	\N	https://ds3zadonsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399200, Липецкая область, г. Задонск, ул. М Горькогод.5.Адрес
498	МБДОУ детский сад №5 г.Задонска	195	preschool	493	\N	\N	\N	https://ds5zadonsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399200 Липецкая обл., г. Задонск, ул. Свободы, д. 38 "а"
499	МБДОУ детский сад №6 «Сказка» г.Задонска	195	preschool	494	\N	\N	\N	https://ds6zadonsk.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399200, Липецкая область, г.Задонск, ул.Советская д.48
500	МБДОУ детский сад «Непоседы» с.Бутырки	195	preschool	495	\N	\N	\N	https://butirki11.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, улица Рабочая, дом 11
501	МБДОУ детский сад с.Кашары	195	preschool	496	\N	\N	\N	https://ds-kashari48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область Задонский район с.Кашары ул. Рабочая д.4
502	МБДОУ детский сад с.Болховское	195	preschool	497	\N	\N	\N	https://dsbolxovskoe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399241, Липецкая область, Задонский район, с. Болховское, ул. Центральная, д.30
503	МБДОУ детский сад с.Гнилуша	195	preschool	498	\N	\N	\N	https://gnilusha-detsad.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399214, Липецкая область, Задонский район, с.Гнилуша, ул.Ленина, д.44
504	МБДОУ детский сад с.Донское	195	preschool	499	\N	\N	\N	https://donskoe-detsad.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399240 Липецкая область Задонский район с.Донское ул.Гагарина д.1
505	МБДОУ детский сад с.Ольшанец	195	preschool	500	\N	\N	\N	https://ds-olshanec.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399222, Липецкая область, Задонский район, п. Освобождение, ул. Школьная, д.9
506	МБДОУ детский сад с.Репец Задонского муниципального района	195	preschool	501	\N	\N	\N	https://ds-repets.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Задонский район, с.Репец, ул.Павлова, д.4
507	МБДОУ детский сад с.Паниковец	195	preschool	502	\N	\N	\N	https://dspanikowets.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399205, Липецкая область, Задонский район, с.Паниковец, ул.Запрудная, д.4
532	МБДОУ детский сад поселка Культура	198	preschool	527	\N	\N	\N	\N	\N	2026-08-21 15:52:53.651883	2026-08-21 15:52:53.651883	\N
486	МБДОУ д/с «Аистёнок» с.Елец-Маланино	204	preschool	481	\N	2.0	8.0	https://ds-aistyonok-elecmalanino-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:53:18.417417	399265 Липецкая область Хлевенский район село Елец-Маланино улица Дорожная дом 1
485	МБДОУ д/с «Родничок» с.Конь-Колодезь	204	preschool	480	\N	3.0	7.0	https://ds-rodnichok-konkolodez-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:55:02.852063	399281 Российская Федерация, Липецкая область, Хлевенский район, село Конь-Колодезь, улица Берёзовая аллея, дом 30
487	МБДОУ детский сад «Солнышко» села Воробьевка	204	preschool	482	\N	1.5	8.0	https://ds-solnyshko-vorobevka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:55:26.568387	399270 Липецкая область Хлевенский район с. Воробьевка ул. Мира дом 4
508	МБДОУ детский сад с.Скорняково	195	preschool	503	\N	\N	\N	https://dsskornyakovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399231, Липецкая обл, р-н Задонский, с Скорняково, ул. Центральная, д.11
509	МБОУ «Гимназия №1 имени Н.И. Борцова» г.Лебедянь	198	school	504	\N	\N	\N	https://gimn1lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399610 Липецкая область, г.Лебедянь, ул. Антонова, дом 14
510	МБОУ СШ №2 г.Лебедяни	198	school	505	\N	\N	\N	https://sh2-lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399610, Липецкая область, Лебедянский район, город Лебедянь, улица Средняя, здание 29
511	МБОУ СОШ №3 г.Лебедянь	198	school	506	\N	\N	\N	https://sc3lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399611, Липецкая область, Лебедянский район, город Лебедянь, Школьная ул., д. 17
512	МБОУ СОШ п.свх. Агроном	198	school	507	\N	\N	\N	https://schagronom.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399621 Липецкая область, Лебедянский район, п.свх. Агроном, ул. Школьная, д.1
513	МБОУ СОШ с.Куймань	198	school	508	\N	\N	\N	https://shkuyman.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399642 Липецкая область, Лебедянский район, с. Куймань, ул. Школьная, д. 15б
514	МБОУ «СОШ с.Ольховец»	198	school	509	\N	\N	\N	https://scolhov.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399628, Липецкая область, Лебедянский район, с. Ольховец, ул. Церквянка, д.110в
515	МБОУ СОШ с.Большое Попово	198	school	510	\N	\N	\N	https://shbpopovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399 645 Липецкая область Лебедянский район п. Сахарного Завода ул. Октябрьская д. № 5а
516	МБОУ СОШ с.Мокрое	198	school	511	\N	\N	\N	https://shmokroe.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399635 Липецкая область Лебедянский район с. Мокрое ул. Строителей д.82
517	МБДОУ детский сад №1 г.Лебедянь	198	preschool	512	\N	\N	\N	https://ds1lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399610 Липецкая обл., г. Лебедянь, ул. Победы, д. 13 А
518	МБДОУ детский сад комбинированного вида №2 г.Лебедянь Липецкой области	198	preschool	513	\N	\N	\N	https://ds2lebed.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399613 Липецкая область, г.Лебедянь, ул. Советская, д. 76
519	МБДОУ детский сад комбинированного вида №3 г.Лебедянь	198	preschool	514	\N	\N	\N	https://lebds3.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399611 Липецкая обл., г. Лебедянь, ул. Шоссейный проезд, д. 10
520	МБДОУ детский сад комбинированного вида №4 г.Лебедянь	198	preschool	515	\N	\N	\N	https://lebds4k.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399611 Липецкая область, г. Лебедянь, улица Машиностроителей д. 22
521	МБДОУ детский сад №5 г.Лебедянь	198	preschool	516	\N	\N	\N	https://ds5-lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399610, Липецкая область, г. Лебедянь, ул. Карла Маркса, д. 57
522	МБДОУ детский сад комбинированного вида №6 г.Лебедянь	198	preschool	517	\N	\N	\N	https://mbdou6leb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399610, Липецкая область, г. Лебедянь, улица Тургенева дом 7.
523	МАДОУ детский сад комбинированного вида №7 г.Лебедянь	198	preschool	518	\N	\N	\N	https://cheremushki-lebedyan.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399612 Липецкая обл., г. Лебедянь, ул. Советской Армии д.28
524	МБДОУ детский сад «Ёлочка» с.Троекурово	198	preschool	519	\N	\N	\N	https://elochkatroekyrovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399626 Липецкая область, Лебедянский район, ул. Садовая, д.16, д.16а
525	МБДОУ п.свх. Агроном	198	preschool	520	\N	\N	\N	https://agronomdetsad.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399621 ул. Советская, дом 18, п. свх. Агроном, Лебедянский район, Липецкой области
526	МБДОУ с.Докторово	198	preschool	521	\N	\N	\N	https://agronomdetsad.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399648, Россия, Липецкая область, Лебедянский район, улица Набережная, дом 1А, помещение 3
527	МБДОУ с.Куймань	198	preschool	522	\N	\N	\N	https://dskyiman.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	Липецкая область, Лебедянский район, Село Куймань, ул Садовая, д 13.
528	МБДОУ с.Романово	198	preschool	523	\N	\N	\N	https://dsromanovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399608 с.Романово Лебедянского района Липецкой области, ул.Гусевка, д.3а
529	МБДОУ с.Большое Попово	198	preschool	524	\N	\N	\N	https://dsbpopovo.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399645, Липецкая обл, Лебедянский округ, Большое Попово с, Центральная усадьба ул, 8
530	МБДОУ детский сад п.Сахзавода	198	preschool	525	\N	\N	\N	https://dssahzavod.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 15:51:15.108635	399645, Липецкая область, Лебедянский район, поселок Сахарного Завода, ул.Октябрьская, д.1а; д.2а
399	МБОУ п. Свх. им. Льва Толстого	199	school	394	\N	\N	\N	https://ltsvh.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-21 16:22:25.651709	399888, Липецкая область, Лев-Толстовский район, п. Свх. им. Льва Толстого, ул. Лесная, д. 3.
133	Средняя общеобразовательная школа с. Карамышево	189	school	126	Муниципальное бюджетное общеобразовательное учреждение	1.0	11.0	https://sckaramyshevo48.gosuslugi.ru/glavnoe/kontakty/	\N	2026-07-04 20:50:37.25445	2026-08-21 16:22:59.930908	399077 Липецкая область, Грязинский район, с. Карамышево, ул.Ленина
210	Кадетская школа Липецкой области имени А.П. Коврижных	186	school	205	Государственное бюджетное общеобразовательное учреждение Липецкой области "Кадетская школа имени майора милиции Коврижных А.П."	5.0	11.0	https://lipcadet.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 20:08:42.79151	398043, Липецкая обл., г. Липецк, ул. Космонавтов, 36/3; г. Липецк, ул.Прокатная, д.10; 398059 г.Липецк, Торговая пл. д.14
184	МАОУ "Лицей 44" г. Липецка	186	school	179	Муниципальное автономное общеобразовательное учреждение «Лицей 44»	1.0	11.0	https://liceum44.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 20:11:39.942706	398050 г. Липецк, ул. Плеханова, д.51а, д.49
196	МАОУ СШ №59 «Перспектива» г.Липецка	186	school	191	\N	\N	\N	https://progymnasium59.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:22:08.397237	398055 г. Липецк, проезд Сержанта Кувшинова, д. 8 - детский сад; 398020 г. Липецк, улица Шкатова, д.23 – детский сад; 398055 г. Липецк, улица Московская, д. 95 – детский сад; 398055 г. Липецк, проезд Сержанта Кувшинова, д.5 – школа
282	МБДОУ детский сад «Искорка»	188	preschool	277	\N	1.5	7.0	https://iskorka48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:48:25.689411	399580 Липецкая область, Воловский район, с. Волово, ул. Почтовая, д.2;; 399580 Липецкая область, Воловский район, с. Волово, ул. Советская, д.97
221	Муниципальное автономное дошкольное образовательное учреждение детский сад №14 г.Липецка ДОУ №14 г.Липецка	186	preschool	216	\N	1.5	6.0	https://dou14lip.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:50:53.68253	398007, г. Липецк, ул. Кутузова, строение 5
484	МАДОУ д/с с.Хлевное	204	preschool	479	\N	2.0	8.0	https://dshlevnoe48.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:53:01.371453	399260, Липецкая область, Хлевенский район, с. Хлевное, ул. Ленинская д. 10а
488	МБДОУ д/с «Подрастай-ка!» с.Верхняя Колыбелька	204	preschool	483	Муниципальное бюджетное дошкольное образовательное учреждение детский сад "Подрастай-ка" села Верхняя Колыбелька Хлевенского муниципального округа Липецкой области	1.5	8.0	https://ds-podrastajka-verxnyaya-kolybelka-r42.gosweb.gosuslugi.ru/	\N	2026-08-21 15:51:15.108635	2026-08-23 21:54:36.583378	399268 Липецкая область Хлевенский район с. Верхняя Колыбелька ул. Молодежная д.46
407	МБДОУ «Радуга»	199	preschool	402	Муниципальное бюджетное дошкольное образовательное учреждение «Радуга» Лев Толстовского муниципального района	1.5	6.0	https://ds-raduga.gosuslugi.ru	https://ds-raduga.gosuslugi.ru/svedeniya-ob-obrazovatelnoy-organizatsii/obrazovanie/	2026-08-21 15:51:15.108635	2026-08-23 21:59:41.427333	Место нахождения: 399870, Липецкая область, п. Лев Толстой, ул. Володарского д. 47а
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.schema_migrations (filename, applied_at) FROM stdin;
000_schema_migrations.sql	2026-08-21 16:45:08.261545
001_drop_links.sql	2026-08-21 16:45:08.274242
002_aoop_unique_name.sql	2026-08-21 16:45:08.285951
003_intellectual_impairment.sql	2026-08-23 19:34:35.918237
004_institution_conditions_from_aoop.sql	2026-08-23 19:46:04.65577
005_institution_conditions_from_aoop_fix.sql	2026-08-23 19:46:34.976932
006_three_intellect_conditions.sql	2026-08-23 19:59:17.338578
007_drop_admin_email.sql	2026-11-14 08:38:43.651556
\.


--
-- Name: action_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.action_log_id_seq', 123, true);


--
-- Name: administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.administrators_id_seq', 6, true);


--
-- Name: aoop_programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.aoop_programs_id_seq', 571, true);


--
-- Name: directors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.directors_id_seq', 530, true);


--
-- Name: districts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.districts_id_seq', 205, true);


--
-- Name: institutions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.institutions_id_seq', 535, true);


--
-- Name: action_log action_log_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.action_log
    ADD CONSTRAINT action_log_pkey PRIMARY KEY (id);


--
-- Name: administrators administrators_login_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_login_key UNIQUE (login);


--
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: admission_types admission_types_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.admission_types
    ADD CONSTRAINT admission_types_pkey PRIMARY KEY (code);


--
-- Name: aoop_programs aoop_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.aoop_programs
    ADD CONSTRAINT aoop_programs_pkey PRIMARY KEY (id);


--
-- Name: condition_types condition_types_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.condition_types
    ADD CONSTRAINT condition_types_pkey PRIMARY KEY (code);


--
-- Name: directors directors_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT directors_pkey PRIMARY KEY (id);


--
-- Name: districts districts_name_key; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_name_key UNIQUE (name);


--
-- Name: districts districts_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);


--
-- Name: institution_admission institution_admission_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_admission
    ADD CONSTRAINT institution_admission_pkey PRIMARY KEY (institution_id, admission_code);


--
-- Name: institution_conditions institution_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_conditions
    ADD CONSTRAINT institution_conditions_pkey PRIMARY KEY (institution_id, condition_code);


--
-- Name: institution_types institution_types_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_types
    ADD CONSTRAINT institution_types_pkey PRIMARY KEY (code);


--
-- Name: institutions institutions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: idx_aoop_institution; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_aoop_institution ON public.aoop_programs USING btree (institution_id);


--
-- Name: idx_directors_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_directors_email ON public.directors USING btree (email);


--
-- Name: idx_directors_name; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_directors_name ON public.directors USING btree (full_name);


--
-- Name: idx_districts_name; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_districts_name ON public.districts USING btree (name);


--
-- Name: idx_inst_admission_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_inst_admission_type ON public.institution_admission USING btree (admission_code);


--
-- Name: idx_inst_conditions_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_inst_conditions_type ON public.institution_conditions USING btree (condition_code);


--
-- Name: idx_institutions_director; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_institutions_director ON public.institutions USING btree (director_id);


--
-- Name: idx_institutions_district; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_institutions_district ON public.institutions USING btree (district_id);


--
-- Name: idx_institutions_range; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_institutions_range ON public.institutions USING btree (range_min, range_max);


--
-- Name: idx_institutions_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_institutions_type ON public.institutions USING btree (type_code);


--
-- Name: uq_aoop_institution_name; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX uq_aoop_institution_name ON public.aoop_programs USING btree (institution_id, name);


--
-- Name: directors update_directors_updated_at; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER update_directors_updated_at BEFORE UPDATE ON public.directors FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: institutions update_institutions_updated_at; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER update_institutions_updated_at BEFORE UPDATE ON public.institutions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: action_log action_log_administrator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.action_log
    ADD CONSTRAINT action_log_administrator_id_fkey FOREIGN KEY (administrator_id) REFERENCES public.administrators(id);


--
-- Name: aoop_programs aoop_programs_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.aoop_programs
    ADD CONSTRAINT aoop_programs_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: institution_admission institution_admission_admission_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_admission
    ADD CONSTRAINT institution_admission_admission_code_fkey FOREIGN KEY (admission_code) REFERENCES public.admission_types(code) ON DELETE CASCADE;


--
-- Name: institution_admission institution_admission_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_admission
    ADD CONSTRAINT institution_admission_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: institution_conditions institution_conditions_condition_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_conditions
    ADD CONSTRAINT institution_conditions_condition_code_fkey FOREIGN KEY (condition_code) REFERENCES public.condition_types(code) ON DELETE CASCADE;


--
-- Name: institution_conditions institution_conditions_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institution_conditions
    ADD CONSTRAINT institution_conditions_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;


--
-- Name: institutions institutions_director_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.directors(id) ON DELETE SET NULL;


--
-- Name: institutions institutions_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.districts(id) ON DELETE RESTRICT;


--
-- Name: institutions institutions_type_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_type_code_fkey FOREIGN KEY (type_code) REFERENCES public.institution_types(code) ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: user
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict vydQ7wgyv9liKZhcw1YhQViIJqbud7lotAcvs4agNUg0czXSIyNvc7F3nO2akyu

