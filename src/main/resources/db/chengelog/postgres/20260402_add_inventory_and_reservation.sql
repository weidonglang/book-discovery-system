-- liquibase formatted sql

-- changeset codex:20260402_add_inventory_and_reservation
ALTER TABLE public.book
    ADD COLUMN total_copies INTEGER NOT NULL DEFAULT 1,
    ADD COLUMN available_copies INTEGER NOT NULL DEFAULT 1;

UPDATE public.book b
SET total_copies = GREATEST(
        1,
        COALESCE((
            SELECT COUNT(*)
            FROM public.book_loan bl
            WHERE bl.book_id = b.id
              AND bl.status = 'BORROWED'
              AND bl.marked_as_deleted = FALSE
        ), 0)
    ),
    available_copies = CASE
        WHEN COALESCE((
            SELECT COUNT(*)
            FROM public.book_loan bl
            WHERE bl.book_id = b.id
              AND bl.status = 'BORROWED'
              AND bl.marked_as_deleted = FALSE
        ), 0) > 0 THEN 0
        ELSE 1
    END;

CREATE SEQUENCE public.book_reservation_id_sequence START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE public.book_reservation
(
    id BIGINT NOT NULL,
    created_by VARCHAR(255),
    created_date TIMESTAMP,
    marked_as_deleted BOOLEAN,
    modified_by VARCHAR(255),
    modified_date TIMESTAMP,
    requested_at TIMESTAMP NOT NULL,
    fulfilled_at TIMESTAMP,
    cancelled_at TIMESTAMP,
    status VARCHAR(32) NOT NULL,
    book_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    CONSTRAINT book_reservation_pkey PRIMARY KEY (id),
    CONSTRAINT book_reservation_book_id_fk FOREIGN KEY (book_id) REFERENCES public.book (id),
    CONSTRAINT book_reservation_user_id_fk FOREIGN KEY (user_id) REFERENCES public.user (id)
);

CREATE UNIQUE INDEX user_active_book_reservation_unq
    ON public.book_reservation (user_id, book_id)
    WHERE status = 'ACTIVE' AND marked_as_deleted = FALSE;
