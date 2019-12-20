--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: diary; Type: TABLE; Schema: public; Owner: seb-user
--

CREATE TABLE public.diary (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    allow_auto_edit boolean NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.diary OWNER TO "seb-user";

--
-- Name: diary_id_seq; Type: SEQUENCE; Schema: public; Owner: seb-user
--

CREATE SEQUENCE public.diary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.diary_id_seq OWNER TO "seb-user";

--
-- Name: diary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: seb-user
--

ALTER SEQUENCE public.diary_id_seq OWNED BY public.diary.id;


--
-- Name: diary_image; Type: TABLE; Schema: public; Owner: seb-user
--

CREATE TABLE public.diary_image (
    id bigint NOT NULL,
    diary_id bigint NOT NULL,
    url character varying NOT NULL
);


ALTER TABLE public.diary_image OWNER TO "seb-user";

--
-- Name: diary_image_id_seq; Type: SEQUENCE; Schema: public; Owner: seb-user
--

CREATE SEQUENCE public.diary_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.diary_image_id_seq OWNER TO "seb-user";

--
-- Name: diary_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: seb-user
--

ALTER SEQUENCE public.diary_image_id_seq OWNED BY public.diary_image.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: seb-user
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."user" OWNER TO "seb-user";

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: seb-user
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO "seb-user";

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: seb-user
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: diary id; Type: DEFAULT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary ALTER COLUMN id SET DEFAULT nextval('public.diary_id_seq'::regclass);


--
-- Name: diary_image id; Type: DEFAULT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary_image ALTER COLUMN id SET DEFAULT nextval('public.diary_image_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: diary; Type: TABLE DATA; Schema: public; Owner: seb-user
--

COPY public.diary (id, user_id, title, content, allow_auto_edit, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: diary_image; Type: TABLE DATA; Schema: public; Owner: seb-user
--

COPY public.diary_image (id, diary_id, url) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: seb-user
--

COPY public."user" (id, name, email, created_at) FROM stdin;
1	Neo	neo@matrix.mov	1999-09-11 09:00:00+09
2	Morpheus	morpheus@matrix.mov	1812-09-11 09:18:59+09:18:59
3	Trinity	trinity@matrix.mov	1995-12-31 21:13:14+09
\.


--
-- Name: diary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: seb-user
--

SELECT pg_catalog.setval('public.diary_id_seq', 1, false);


--
-- Name: diary_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: seb-user
--

SELECT pg_catalog.setval('public.diary_image_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: seb-user
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: diary_image diary_image_pkey; Type: CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary_image
    ADD CONSTRAINT diary_image_pkey PRIMARY KEY (id);


--
-- Name: diary diary_pkey; Type: CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary
    ADD CONSTRAINT diary_pkey PRIMARY KEY (id);


--
-- Name: user unique_email; Type: CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: diary_image diary_image_diary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary_image
    ADD CONSTRAINT diary_image_diary_id_fkey FOREIGN KEY (diary_id) REFERENCES public.diary(id);


--
-- Name: diary diary_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: seb-user
--

ALTER TABLE ONLY public.diary
    ADD CONSTRAINT diary_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

