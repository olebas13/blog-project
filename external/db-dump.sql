--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

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

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    email character varying(100) NOT NULL,
    name character varying(30) NOT NULL,
    avatar character varying(255),
    created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.account OWNER TO blog;

--
-- Name: account_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_seq OWNER TO blog;

--
-- Name: article; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.article (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    logo character varying(255) NOT NULL,
    descr character varying(255) NOT NULL,
    content text NOT NULL,
    id_category integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    views bigint DEFAULT 0 NOT NULL,
    comments integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.article OWNER TO blog;

--
-- Name: category; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    url character varying(20) NOT NULL,
    articles integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.category OWNER TO blog;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: blog
--

CREATE TABLE public.comment (
    id bigint NOT NULL,
    id_account bigint NOT NULL,
    id_article bigint NOT NULL,
    content text NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comment OWNER TO blog;

--
-- Name: comment_seq; Type: SEQUENCE; Schema: public; Owner: blog
--

CREATE SEQUENCE public.comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_seq OWNER TO blog;

--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.account (id, email, name, avatar, created) FROM stdin;
\.


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.article (id, title, url, logo, descr, content, id_category, created, views, comments) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.category (id, name, url, articles) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: blog
--

COPY public.comment (id, id_account, id_article, content, created) FROM stdin;
\.


--
-- Name: account_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.account_seq', 1, false);


--
-- Name: comment_seq; Type: SEQUENCE SET; Schema: public; Owner: blog
--

SELECT pg_catalog.setval('public.comment_seq', 1, false);


--
-- Name: account account_pk; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pk PRIMARY KEY (id);


--
-- Name: article article_pk; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pk PRIMARY KEY (id);


--
-- Name: category category_pk; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);


--
-- Name: comment comment_pk; Type: CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pk PRIMARY KEY (id);


--
-- Name: account_email_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX account_email_uindex ON public.account USING btree (email);


--
-- Name: account_id_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX account_id_uindex ON public.account USING btree (id);


--
-- Name: article_id_category_index; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX article_id_category_index ON public.article USING btree (id_category);


--
-- Name: article_id_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX article_id_uindex ON public.article USING btree (id);


--
-- Name: category_id_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX category_id_uindex ON public.category USING btree (id);


--
-- Name: category_url_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX category_url_uindex ON public.category USING btree (url);


--
-- Name: comment_id_account_index; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX comment_id_account_index ON public.comment USING btree (id_account);


--
-- Name: comment_id_article_index; Type: INDEX; Schema: public; Owner: blog
--

CREATE INDEX comment_id_article_index ON public.comment USING btree (id_article);


--
-- Name: comment_id_uindex; Type: INDEX; Schema: public; Owner: blog
--

CREATE UNIQUE INDEX comment_id_uindex ON public.comment USING btree (id);


--
-- Name: article article_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_category_id_fk FOREIGN KEY (id_category) REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: comment comment_account_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_account_id_fk FOREIGN KEY (id_account) REFERENCES public.account(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: comment comment_article_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: blog
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_article_id_fk FOREIGN KEY (id_article) REFERENCES public.article(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

