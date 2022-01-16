--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3 (Ubuntu 12.3-1.pgdg16.04+1)
-- Dumped by pg_dump version 12.3 (Ubuntu 12.3-1.pgdg16.04+1)

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
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(255),
    country character varying(255)
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.authors ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    name character varying(50),
    pages integer,
    author_id integer
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.books ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, name, country) FROM stdin;
1	J. D. Salinger	US
2	F. Scott. Fitzgerald	US
3	Jane Austen	UK
4	Leo Tolstoy	RU
5	Sun Tzu	CN
6	Johann Wolfgang von Goethe	DE
7	Janis Eglitis	LV
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, name, pages, author_id) FROM stdin;
1	The Catcher in the Rye	300	1
2	Nine Stories	200	1
3	Franny and Zooey	150	1
4	The Great Gatsby	400	2
5	Tender is the Night	500	2
6	Pride and Prejudice	700	3
7	The Art of War	128	5
8	Faust I	300	6
9	Faust II	300	6
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 7, true);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 9, true);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: authors_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authors_id_idx ON public.authors USING btree (id);


--
-- Name: authors_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authors_name_idx ON public.authors USING btree (name);


--
-- Name: books_author_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX books_author_id_idx ON public.books USING btree (author_id);


--
-- Name: books_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX books_id_idx ON public.books USING btree (id);


--
-- Name: books_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX books_name_idx ON public.books USING btree (name);


--
-- Name: books fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- PostgreSQL database dump complete
--
