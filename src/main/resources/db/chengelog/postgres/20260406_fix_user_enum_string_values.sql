-- liquibase formatted sql

-- changeset codex:20260406_fix_user_enum_string_values
UPDATE public."user"
SET gender = CASE gender
                 WHEN '0' THEN 'MALE'
                 WHEN '1' THEN 'FEMALE'
                 WHEN '2' THEN 'OTHERS'
                 ELSE gender
    END,
    marital_status = CASE marital_status
                         WHEN '0' THEN 'SINGLE'
                         WHEN '1' THEN 'MARRIED'
                         WHEN '2' THEN 'IN_RELATIONSHIP'
                         ELSE marital_status
        END
WHERE gender IN ('0', '1', '2')
   OR marital_status IN ('0', '1', '2');
