-- liquibase formatted sql

-- changeset codex:20260401_create_publisher_and_tag_tables

CREATE SEQUENCE IF NOT EXISTS public.publisher_id_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.publisher
(
    id                BIGINT                 NOT NULL DEFAULT nextval('publisher_id_sequence'::regclass),
    name              CHARACTER VARYING(100) NOT NULL,
    description       TEXT                   NULL,
    country           CHARACTER VARYING(80)  NULL,
    website_url       CHARACTER VARYING(255) NULL,

    created_date      TIMESTAMP              NOT NULL,
    modified_date     TIMESTAMP              NOT NULL,
    created_by        CHARACTER VARYING(100) NOT NULL,
    modified_by       CHARACTER VARYING(100) NOT NULL,
    marked_as_deleted BOOLEAN                NOT NULL DEFAULT FALSE,

    PRIMARY KEY (id),
    CONSTRAINT publisher_name_unq UNIQUE (name)
) TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS public.tag_id_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.tag
(
    id                BIGINT                 NOT NULL DEFAULT nextval('tag_id_sequence'::regclass),
    name              CHARACTER VARYING(80)  NOT NULL,
    description       CHARACTER VARYING(255) NULL,

    created_date      TIMESTAMP              NOT NULL,
    modified_date     TIMESTAMP              NOT NULL,
    created_by        CHARACTER VARYING(100) NOT NULL,
    modified_by       CHARACTER VARYING(100) NOT NULL,
    marked_as_deleted BOOLEAN                NOT NULL DEFAULT FALSE,

    PRIMARY KEY (id),
    CONSTRAINT tag_name_unq UNIQUE (name)
) TABLESPACE pg_default;

ALTER TABLE public.book
    ADD COLUMN IF NOT EXISTS publisher_id BIGINT NULL;

ALTER TABLE public.book
    ADD CONSTRAINT book_publisher_id_fk FOREIGN KEY (publisher_id) REFERENCES public.publisher (id);

CREATE TABLE IF NOT EXISTS public.book_tag
(
    book_id BIGINT NOT NULL,
    tag_id  BIGINT NOT NULL,
    PRIMARY KEY (book_id, tag_id),
    CONSTRAINT book_tag_book_id_fk FOREIGN KEY (book_id) REFERENCES public.book (id),
    CONSTRAINT book_tag_tag_id_fk FOREIGN KEY (tag_id) REFERENCES public.tag (id)
) TABLESPACE pg_default;
