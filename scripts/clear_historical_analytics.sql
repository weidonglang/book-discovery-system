BEGIN;

DELETE FROM public.user_behavior_log
WHERE created_by = 'history-seed-script';

DELETE FROM public.search_log
WHERE created_by = 'history-seed-script';

DELETE FROM public.book_loan
WHERE created_by = 'history-seed-script';

COMMIT;
