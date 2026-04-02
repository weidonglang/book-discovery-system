-- liquibase formatted sql

-- changeset codex:20260402_create_book_loan_table
CREATE SEQUENCE public.book_loan_id_sequence START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE public.book_loan
(
    id BIGINT NOT NULL,
    created_by VARCHAR(255),
    created_date TIMESTAMP,
    marked_as_deleted BOOLEAN,
    modified_by VARCHAR(255),
    modified_date TIMESTAMP,
    borrowed_at TIMESTAMP NOT NULL,
    due_date TIMESTAMP NOT NULL,
    returned_at TIMESTAMP,
    renew_count INTEGER NOT NULL DEFAULT 0,
    status VARCHAR(32) NOT NULL,
    book_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    CONSTRAINT book_loan_pkey PRIMARY KEY (id),
    CONSTRAINT book_loan_book_id_fk FOREIGN KEY (book_id) REFERENCES public.book (id),
    CONSTRAINT book_loan_user_id_fk FOREIGN KEY (user_id) REFERENCES public.user (id)
);

CREATE UNIQUE INDEX user_active_book_loan_unq
    ON public.book_loan (user_id, book_id)
    WHERE status = 'BORROWED' AND marked_as_deleted = FALSE;
