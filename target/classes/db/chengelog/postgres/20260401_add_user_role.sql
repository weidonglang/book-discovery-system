-- liquibase formatted sql

-- changeset codex:20260401_add_user_role

ALTER TABLE public."user"
    ADD COLUMN IF NOT EXISTS role CHARACTER VARYING(30);

UPDATE public."user"
SET role = 'USER'
WHERE role IS NULL;

ALTER TABLE public."user"
    ALTER COLUMN role SET DEFAULT 'USER';

ALTER TABLE public."user"
    ALTER COLUMN role SET NOT NULL;
