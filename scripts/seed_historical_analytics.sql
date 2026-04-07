BEGIN;

-- Remove only the synthetic history created by this script so it is safe to rerun.
DELETE FROM public.user_behavior_log
WHERE created_by = 'history-seed-script';

DELETE FROM public.search_log
WHERE created_by = 'history-seed-script';

DELETE FROM public.book_loan
WHERE created_by = 'history-seed-script';

DO $$
DECLARE
    seed_actor CONSTANT TEXT := 'history-seed-script';
    seed_source CONSTANT TEXT := 'history-seed';
    sort_text CONSTANT TEXT := 'SortingBy(fieldName=id, direction=ASC, isNumber=true)';
    user_ids BIGINT[];
    recent_book_ids BIGINT[];
    monthly_book_ids BIGINT[];
    seasonal_book_ids BIGINT[];
    legacy_book_ids BIGINT[];
    recent_category_ids BIGINT[];
    monthly_category_ids BIGINT[];
    seasonal_category_ids BIGINT[];
    legacy_category_ids BIGINT[];
    recent_author_ids BIGINT[];
    monthly_author_ids BIGINT[];
    seasonal_author_ids BIGINT[];
    legacy_author_ids BIGINT[];
    recent_tag_ids BIGINT[];
    monthly_tag_ids BIGINT[];
    seasonal_tag_ids BIGINT[];
    legacy_tag_ids BIGINT[];
    recent_publisher_ids BIGINT[];
    monthly_publisher_ids BIGINT[];
    seasonal_publisher_ids BIGINT[];
    legacy_publisher_ids BIGINT[];
    total_books BIGINT;
    user_count INTEGER;
    idx INTEGER;
    user_id_value BIGINT;
    book_id_value BIGINT;
    category_id_value BIGINT;
    author_id_value BIGINT;
    tag_id_value BIGINT;
    publisher_id_value BIGINT;
    event_time TIMESTAMP;
    borrowed_at_value TIMESTAMP;
    due_date_value TIMESTAMP;
    returned_at_value TIMESTAMP;
    result_total BIGINT;
    search_keyword TEXT;
    search_reason TEXT;
    range_reason TEXT;
    result_label TEXT;
BEGIN
    SELECT COUNT(*)
    INTO total_books
    FROM public.book
    WHERE COALESCE(marked_as_deleted, FALSE) = FALSE;

    IF total_books = 0 THEN
        RAISE EXCEPTION 'Cannot seed historical analytics because no books exist.';
    END IF;

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO user_ids
    FROM public."user"
    WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
      AND role = 'USER';

    IF user_ids IS NULL OR array_length(user_ids, 1) IS NULL THEN
        SELECT ARRAY_AGG(id ORDER BY id)
        INTO user_ids
        FROM public."user"
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE;
    END IF;

    IF user_ids IS NULL OR array_length(user_ids, 1) IS NULL THEN
        RAISE EXCEPTION 'Cannot seed historical analytics because no users exist.';
    END IF;

    user_count := array_length(user_ids, 1);

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO recent_book_ids
    FROM (
        SELECT id
        FROM public.book
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
        ORDER BY COALESCE(users_rate_count, 0) DESC, COALESCE(rate, 0) DESC, id
        LIMIT 8
    ) ranked_books;

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO monthly_book_ids
    FROM (
        SELECT id
        FROM public.book
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
          AND (recent_book_ids IS NULL OR id <> ALL(recent_book_ids))
        ORDER BY COALESCE(users_rate_count, 0) DESC, COALESCE(rate, 0) DESC, id
        LIMIT 8
    ) ranked_books;

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO seasonal_book_ids
    FROM (
        SELECT id
        FROM public.book
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
          AND (recent_book_ids IS NULL OR id <> ALL(recent_book_ids))
          AND (monthly_book_ids IS NULL OR id <> ALL(monthly_book_ids))
        ORDER BY COALESCE(users_rate_count, 0) DESC, COALESCE(rate, 0) DESC, id
        LIMIT 8
    ) ranked_books;

    SELECT ARRAY_AGG(id ORDER BY id)
    INTO legacy_book_ids
    FROM (
        SELECT id
        FROM public.book
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
          AND (recent_book_ids IS NULL OR id <> ALL(recent_book_ids))
          AND (monthly_book_ids IS NULL OR id <> ALL(monthly_book_ids))
          AND (seasonal_book_ids IS NULL OR id <> ALL(seasonal_book_ids))
        ORDER BY COALESCE(users_rate_count, 0) DESC, COALESCE(rate, 0) DESC, id
        LIMIT 8
    ) ranked_books;

    IF monthly_book_ids IS NULL OR array_length(monthly_book_ids, 1) IS NULL THEN
        monthly_book_ids := recent_book_ids;
    END IF;
    IF seasonal_book_ids IS NULL OR array_length(seasonal_book_ids, 1) IS NULL THEN
        seasonal_book_ids := monthly_book_ids;
    END IF;
    IF legacy_book_ids IS NULL OR array_length(legacy_book_ids, 1) IS NULL THEN
        legacy_book_ids := seasonal_book_ids;
    END IF;

    SELECT ARRAY_AGG(DISTINCT category_id ORDER BY category_id)
    INTO recent_category_ids
    FROM public.book
    WHERE id = ANY(recent_book_ids)
      AND category_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT category_id ORDER BY category_id)
    INTO monthly_category_ids
    FROM public.book
    WHERE id = ANY(monthly_book_ids)
      AND category_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT category_id ORDER BY category_id)
    INTO seasonal_category_ids
    FROM public.book
    WHERE id = ANY(seasonal_book_ids)
      AND category_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT category_id ORDER BY category_id)
    INTO legacy_category_ids
    FROM public.book
    WHERE id = ANY(legacy_book_ids)
      AND category_id IS NOT NULL;

    IF recent_category_ids IS NULL THEN
        SELECT ARRAY_AGG(id ORDER BY id)
        INTO recent_category_ids
        FROM (
            SELECT id
            FROM public.book_category
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
            LIMIT 3
        ) categories;
    END IF;
    IF monthly_category_ids IS NULL THEN
        monthly_category_ids := recent_category_ids;
    END IF;
    IF seasonal_category_ids IS NULL THEN
        seasonal_category_ids := monthly_category_ids;
    END IF;
    IF legacy_category_ids IS NULL THEN
        legacy_category_ids := seasonal_category_ids;
    END IF;

    SELECT ARRAY_AGG(DISTINCT author_id ORDER BY author_id)
    INTO recent_author_ids
    FROM public.book
    WHERE id = ANY(recent_book_ids)
      AND author_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT author_id ORDER BY author_id)
    INTO monthly_author_ids
    FROM public.book
    WHERE id = ANY(monthly_book_ids)
      AND author_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT author_id ORDER BY author_id)
    INTO seasonal_author_ids
    FROM public.book
    WHERE id = ANY(seasonal_book_ids)
      AND author_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT author_id ORDER BY author_id)
    INTO legacy_author_ids
    FROM public.book
    WHERE id = ANY(legacy_book_ids)
      AND author_id IS NOT NULL;

    IF recent_author_ids IS NULL THEN
        SELECT ARRAY_AGG(id ORDER BY id)
        INTO recent_author_ids
        FROM (
            SELECT id
            FROM public.author
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
            LIMIT 3
        ) authors;
    END IF;
    IF monthly_author_ids IS NULL THEN
        monthly_author_ids := recent_author_ids;
    END IF;
    IF seasonal_author_ids IS NULL THEN
        seasonal_author_ids := monthly_author_ids;
    END IF;
    IF legacy_author_ids IS NULL THEN
        legacy_author_ids := seasonal_author_ids;
    END IF;

    SELECT ARRAY_AGG(DISTINCT tag_id ORDER BY tag_id)
    INTO recent_tag_ids
    FROM public.book_tag
    WHERE book_id = ANY(recent_book_ids);

    SELECT ARRAY_AGG(DISTINCT tag_id ORDER BY tag_id)
    INTO monthly_tag_ids
    FROM public.book_tag
    WHERE book_id = ANY(monthly_book_ids);

    SELECT ARRAY_AGG(DISTINCT tag_id ORDER BY tag_id)
    INTO seasonal_tag_ids
    FROM public.book_tag
    WHERE book_id = ANY(seasonal_book_ids);

    SELECT ARRAY_AGG(DISTINCT tag_id ORDER BY tag_id)
    INTO legacy_tag_ids
    FROM public.book_tag
    WHERE book_id = ANY(legacy_book_ids);

    IF recent_tag_ids IS NULL THEN
        SELECT ARRAY_AGG(id ORDER BY id)
        INTO recent_tag_ids
        FROM (
            SELECT id
            FROM public.tag
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
            LIMIT 3
        ) tags;
    END IF;
    IF monthly_tag_ids IS NULL THEN
        monthly_tag_ids := recent_tag_ids;
    END IF;
    IF seasonal_tag_ids IS NULL THEN
        seasonal_tag_ids := monthly_tag_ids;
    END IF;
    IF legacy_tag_ids IS NULL THEN
        legacy_tag_ids := seasonal_tag_ids;
    END IF;

    SELECT ARRAY_AGG(DISTINCT publisher_id ORDER BY publisher_id)
    INTO recent_publisher_ids
    FROM public.book
    WHERE id = ANY(recent_book_ids)
      AND publisher_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT publisher_id ORDER BY publisher_id)
    INTO monthly_publisher_ids
    FROM public.book
    WHERE id = ANY(monthly_book_ids)
      AND publisher_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT publisher_id ORDER BY publisher_id)
    INTO seasonal_publisher_ids
    FROM public.book
    WHERE id = ANY(seasonal_book_ids)
      AND publisher_id IS NOT NULL;

    SELECT ARRAY_AGG(DISTINCT publisher_id ORDER BY publisher_id)
    INTO legacy_publisher_ids
    FROM public.book
    WHERE id = ANY(legacy_book_ids)
      AND publisher_id IS NOT NULL;

    IF recent_publisher_ids IS NULL THEN
        SELECT ARRAY_AGG(id ORDER BY id)
        INTO recent_publisher_ids
        FROM (
            SELECT id
            FROM public.publisher
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
            LIMIT 3
        ) publishers;
    END IF;
    IF monthly_publisher_ids IS NULL THEN
        monthly_publisher_ids := recent_publisher_ids;
    END IF;
    IF seasonal_publisher_ids IS NULL THEN
        seasonal_publisher_ids := monthly_publisher_ids;
    END IF;
    IF legacy_publisher_ids IS NULL THEN
        legacy_publisher_ids := seasonal_publisher_ids;
    END IF;

    -- Recent browse traffic inside the last 7 days.
    FOR idx IN 1..14 LOOP
        user_id_value := user_ids[((idx - 1) % user_count) + 1];
        event_time := NOW() - make_interval(days => (idx - 1) % 6, hours => (idx * 2) % 12, mins => (idx * 7) % 50);
        search_keyword := 'browse-books';
        search_reason := FORMAT(
                'filters categories=null authors=null publishers=null tags=null ranges price=null-null pages=null-null duration=null-null sort=%s results=%s',
                sort_text,
                total_books
        );
        result_label := FORMAT(
                'results=%s | sort=%s | page=1 | size=8',
                total_books,
                sort_text
        );

        INSERT INTO public.search_log (
            id, user_id, keyword, source, reason,
            category_ids, author_ids, publisher_ids, tag_ids,
            from_price, to_price, from_pages_number, to_pages_number,
            from_reading_duration, to_reading_duration,
            sort_by, page_number, page_size, deleted_records, result_count,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.search_log_id_sequence'),
            user_id_value,
            search_keyword,
            seed_source,
            result_label || ' | ' || search_reason,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NULL,
            NULL, NULL,
            sort_text, 1, 8, FALSE, total_books,
            event_time, event_time, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            NULL,
            'SEARCH',
            search_keyword,
            seed_source,
            search_reason,
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Recent category-focused searches.
    IF recent_category_ids IS NOT NULL AND array_length(recent_category_ids, 1) IS NOT NULL THEN
        FOR idx IN 1..8 LOOP
            user_id_value := user_ids[((idx + 1) % user_count) + 1];
            category_id_value := recent_category_ids[((idx - 1) % array_length(recent_category_ids, 1)) + 1];
            event_time := NOW() - make_interval(days => (idx - 1) % 7, hours => (idx * 3) % 12, mins => (idx * 11) % 55);

            SELECT COUNT(*)
            INTO result_total
            FROM public.book
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
              AND category_id = category_id_value;

            search_keyword := FORMAT('category:%s', category_id_value);
            search_reason := FORMAT(
                    'filters categories=[%s] authors=null publishers=null tags=null ranges price=null-null pages=null-null duration=null-null sort=%s results=%s',
                    category_id_value,
                    sort_text,
                    result_total
            );
            result_label := FORMAT(
                    'results=%s | categories=%s | sort=%s | page=1 | size=8',
                    result_total,
                    category_id_value,
                    sort_text
            );

            INSERT INTO public.search_log (
                id, user_id, keyword, source, reason,
                category_ids, author_ids, publisher_ids, tag_ids,
                from_price, to_price, from_pages_number, to_pages_number,
                from_reading_duration, to_reading_duration,
                sort_by, page_number, page_size, deleted_records, result_count,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.search_log_id_sequence'),
                user_id_value,
                search_keyword,
                seed_source,
                result_label || ' | ' || search_reason,
                category_id_value::TEXT, NULL, NULL, NULL,
                NULL, NULL, NULL, NULL,
                NULL, NULL,
                sort_text, 1, 8, FALSE, result_total,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );

            INSERT INTO public.user_behavior_log (
                id, user_id, book_id, action_type, keyword, source, reason,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.user_behavior_log_id_sequence'),
                user_id_value,
                NULL,
                'SEARCH',
                search_keyword,
                seed_source,
                search_reason,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );
        END LOOP;
    END IF;

    -- Monthly author-focused searches.
    IF monthly_author_ids IS NOT NULL AND array_length(monthly_author_ids, 1) IS NOT NULL THEN
        FOR idx IN 1..6 LOOP
            user_id_value := user_ids[((idx + 2) % user_count) + 1];
            author_id_value := monthly_author_ids[((idx - 1) % array_length(monthly_author_ids, 1)) + 1];
            event_time := NOW() - make_interval(days => 9 + ((idx - 1) % 18), hours => (idx * 2) % 10, mins => (idx * 9) % 50);

            SELECT COUNT(*)
            INTO result_total
            FROM public.book
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
              AND author_id = author_id_value;

            search_keyword := FORMAT('author:%s', author_id_value);
            search_reason := FORMAT(
                    'filters categories=null authors=[%s] publishers=null tags=null ranges price=null-null pages=null-null duration=null-null sort=%s results=%s',
                    author_id_value,
                    sort_text,
                    result_total
            );
            result_label := FORMAT(
                    'results=%s | authors=%s | sort=%s | page=1 | size=8',
                    result_total,
                    author_id_value,
                    sort_text
            );

            INSERT INTO public.search_log (
                id, user_id, keyword, source, reason,
                category_ids, author_ids, publisher_ids, tag_ids,
                from_price, to_price, from_pages_number, to_pages_number,
                from_reading_duration, to_reading_duration,
                sort_by, page_number, page_size, deleted_records, result_count,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.search_log_id_sequence'),
                user_id_value,
                search_keyword,
                seed_source,
                result_label || ' | ' || search_reason,
                NULL, author_id_value::TEXT, NULL, NULL,
                NULL, NULL, NULL, NULL,
                NULL, NULL,
                sort_text, 1, 8, FALSE, result_total,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );

            INSERT INTO public.user_behavior_log (
                id, user_id, book_id, action_type, keyword, source, reason,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.user_behavior_log_id_sequence'),
                user_id_value,
                NULL,
                'SEARCH',
                search_keyword,
                seed_source,
                search_reason,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );
        END LOOP;
    END IF;

    -- Seasonal tag-focused searches.
    IF seasonal_tag_ids IS NOT NULL AND array_length(seasonal_tag_ids, 1) IS NOT NULL THEN
        FOR idx IN 1..5 LOOP
            user_id_value := user_ids[((idx + 3) % user_count) + 1];
            tag_id_value := seasonal_tag_ids[((idx - 1) % array_length(seasonal_tag_ids, 1)) + 1];
            event_time := NOW() - make_interval(days => 35 + ((idx - 1) * 7), hours => (idx * 3) % 11, mins => (idx * 13) % 50);

            SELECT COUNT(DISTINCT b.id)
            INTO result_total
            FROM public.book b
            JOIN public.book_tag bt ON bt.book_id = b.id
            WHERE COALESCE(b.marked_as_deleted, FALSE) = FALSE
              AND bt.tag_id = tag_id_value;

            search_keyword := FORMAT('tag:%s', tag_id_value);
            search_reason := FORMAT(
                    'filters categories=null authors=null publishers=null tags=[%s] ranges price=null-null pages=null-null duration=null-null sort=%s results=%s',
                    tag_id_value,
                    sort_text,
                    result_total
            );
            result_label := FORMAT(
                    'results=%s | tags=%s | sort=%s | page=1 | size=8',
                    result_total,
                    tag_id_value,
                    sort_text
            );

            INSERT INTO public.search_log (
                id, user_id, keyword, source, reason,
                category_ids, author_ids, publisher_ids, tag_ids,
                from_price, to_price, from_pages_number, to_pages_number,
                from_reading_duration, to_reading_duration,
                sort_by, page_number, page_size, deleted_records, result_count,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.search_log_id_sequence'),
                user_id_value,
                search_keyword,
                seed_source,
                result_label || ' | ' || search_reason,
                NULL, NULL, NULL, tag_id_value::TEXT,
                NULL, NULL, NULL, NULL,
                NULL, NULL,
                sort_text, 1, 8, FALSE, result_total,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );

            INSERT INTO public.user_behavior_log (
                id, user_id, book_id, action_type, keyword, source, reason,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.user_behavior_log_id_sequence'),
                user_id_value,
                NULL,
                'SEARCH',
                search_keyword,
                seed_source,
                search_reason,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );
        END LOOP;
    END IF;

    -- Older publisher-focused searches.
    IF legacy_publisher_ids IS NOT NULL AND array_length(legacy_publisher_ids, 1) IS NOT NULL THEN
        FOR idx IN 1..4 LOOP
            user_id_value := user_ids[((idx + 4) % user_count) + 1];
            publisher_id_value := legacy_publisher_ids[((idx - 1) % array_length(legacy_publisher_ids, 1)) + 1];
            event_time := NOW() - make_interval(days => 96 + ((idx - 1) * 11), hours => (idx * 2) % 9, mins => (idx * 5) % 50);

            SELECT COUNT(*)
            INTO result_total
            FROM public.book
            WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
              AND publisher_id = publisher_id_value;

            search_keyword := FORMAT('publisher:%s', publisher_id_value);
            search_reason := FORMAT(
                    'filters categories=null authors=null publishers=[%s] tags=null ranges price=null-null pages=null-null duration=null-null sort=%s results=%s',
                    publisher_id_value,
                    sort_text,
                    result_total
            );
            result_label := FORMAT(
                    'results=%s | publishers=%s | sort=%s | page=1 | size=8',
                    result_total,
                    publisher_id_value,
                    sort_text
            );

            INSERT INTO public.search_log (
                id, user_id, keyword, source, reason,
                category_ids, author_ids, publisher_ids, tag_ids,
                from_price, to_price, from_pages_number, to_pages_number,
                from_reading_duration, to_reading_duration,
                sort_by, page_number, page_size, deleted_records, result_count,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.search_log_id_sequence'),
                user_id_value,
                search_keyword,
                seed_source,
                result_label || ' | ' || search_reason,
                NULL, NULL, publisher_id_value::TEXT, NULL,
                NULL, NULL, NULL, NULL,
                NULL, NULL,
                sort_text, 1, 8, FALSE, result_total,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );

            INSERT INTO public.user_behavior_log (
                id, user_id, book_id, action_type, keyword, source, reason,
                created_date, modified_date, created_by, modified_by, marked_as_deleted
            )
            VALUES (
                nextval('public.user_behavior_log_id_sequence'),
                user_id_value,
                NULL,
                'SEARCH',
                search_keyword,
                seed_source,
                search_reason,
                event_time, event_time, seed_actor, seed_actor, FALSE
            );
        END LOOP;
    END IF;

    -- A few range-only searches to exercise structured stats without a keyword term.
    FOR idx IN 1..4 LOOP
        user_id_value := user_ids[((idx + 5) % user_count) + 1];
        event_time := NOW() - make_interval(days => 18 + ((idx - 1) * 9), hours => (idx * 4) % 10, mins => (idx * 6) % 55);
        SELECT COUNT(*)
        INTO result_total
        FROM public.book
        WHERE COALESCE(marked_as_deleted, FALSE) = FALSE
          AND price BETWEEN 20 AND 80
          AND pages_number BETWEEN 180 AND 480;

        search_keyword := 'filtered-search';
        range_reason := FORMAT(
                'filters categories=null authors=null publishers=null tags=null ranges price=20-80 pages=180-480 duration=null-null sort=%s results=%s',
                sort_text,
                result_total
        );
        result_label := FORMAT(
                'results=%s | price=20-80 | pages=180-480 | sort=%s | page=1 | size=8',
                result_total,
                sort_text
        );

        INSERT INTO public.search_log (
            id, user_id, keyword, source, reason,
            category_ids, author_ids, publisher_ids, tag_ids,
            from_price, to_price, from_pages_number, to_pages_number,
            from_reading_duration, to_reading_duration,
            sort_by, page_number, page_size, deleted_records, result_count,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.search_log_id_sequence'),
            user_id_value,
            search_keyword,
            seed_source,
            result_label || ' | ' || range_reason,
            NULL, NULL, NULL, NULL,
            20, 80, 180, 480,
            NULL, NULL,
            sort_text, 1, 8, FALSE, result_total,
            event_time, event_time, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            NULL,
            'SEARCH',
            search_keyword,
            seed_source,
            range_reason,
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Recent clicks that should dominate the 7-day window.
    FOR idx IN 1..18 LOOP
        user_id_value := user_ids[((idx + 1) % user_count) + 1];
        book_id_value := recent_book_ids[((idx - 1) % array_length(recent_book_ids, 1)) + 1];
        event_time := NOW() - make_interval(days => (idx - 1) % 7, hours => (idx * 2) % 8, mins => (idx * 5) % 45);

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BOOK_DETAIL_CLICK',
            NULL,
            'direct',
            'Historical detail click seeded for analytics demo.',
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Monthly clicks that appear in 30-day and all-time windows.
    FOR idx IN 1..12 LOOP
        user_id_value := user_ids[((idx + 2) % user_count) + 1];
        book_id_value := monthly_book_ids[((idx - 1) % array_length(monthly_book_ids, 1)) + 1];
        event_time := NOW() - make_interval(days => 10 + ((idx - 1) % 18), hours => (idx * 3) % 10, mins => (idx * 7) % 40);

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BOOK_DETAIL_CLICK',
            NULL,
            'direct',
            'Monthly-window detail click seeded for analytics demo.',
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Seasonal and legacy clicks to make 90-day and all-time windows diverge.
    FOR idx IN 1..8 LOOP
        user_id_value := user_ids[((idx + 3) % user_count) + 1];
        book_id_value := seasonal_book_ids[((idx - 1) % array_length(seasonal_book_ids, 1)) + 1];
        event_time := NOW() - make_interval(days => 35 + ((idx - 1) * 5), hours => (idx * 2) % 9, mins => (idx * 6) % 35);

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BOOK_DETAIL_CLICK',
            NULL,
            'direct',
            'Seasonal detail click seeded for analytics demo.',
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    FOR idx IN 1..5 LOOP
        user_id_value := user_ids[((idx + 4) % user_count) + 1];
        book_id_value := legacy_book_ids[((idx - 1) % array_length(legacy_book_ids, 1)) + 1];
        event_time := NOW() - make_interval(days => 102 + ((idx - 1) * 9), hours => (idx * 2) % 8, mins => (idx * 7) % 30);

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BOOK_DETAIL_CLICK',
            NULL,
            'direct',
            'Legacy detail click seeded for analytics demo.',
            event_time, event_time, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Recent borrow events that will dominate the 7-day popular window.
    FOR idx IN 1..10 LOOP
        user_id_value := user_ids[((idx + 1) % user_count) + 1];
        book_id_value := recent_book_ids[((idx - 1) % array_length(recent_book_ids, 1)) + 1];
        borrowed_at_value := NOW() - make_interval(days => 2 + ((idx - 1) % 5), hours => (idx * 3) % 9, mins => (idx * 5) % 30);
        due_date_value := borrowed_at_value + INTERVAL '14 days';
        returned_at_value := LEAST(borrowed_at_value + INTERVAL '2 days', NOW() - INTERVAL '30 minutes');

        INSERT INTO public.book_loan (
            id, borrowed_at, due_date, returned_at, renew_count, status, book_id, user_id,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.book_loan_id_sequence'),
            borrowed_at_value, due_date_value, returned_at_value, idx % 2, 'RETURNED', book_id_value, user_id_value,
            borrowed_at_value, returned_at_value, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BORROW_BOOK',
            NULL,
            seed_source,
            'Historical borrowed-and-returned seed event.',
            borrowed_at_value, borrowed_at_value, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Monthly borrow events.
    FOR idx IN 1..8 LOOP
        user_id_value := user_ids[((idx + 2) % user_count) + 1];
        book_id_value := monthly_book_ids[((idx - 1) % array_length(monthly_book_ids, 1)) + 1];
        borrowed_at_value := NOW() - make_interval(days => 12 + ((idx - 1) * 2), hours => (idx * 2) % 8, mins => (idx * 4) % 30);
        due_date_value := borrowed_at_value + INTERVAL '14 days';
        returned_at_value := borrowed_at_value + INTERVAL '4 days';

        INSERT INTO public.book_loan (
            id, borrowed_at, due_date, returned_at, renew_count, status, book_id, user_id,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.book_loan_id_sequence'),
            borrowed_at_value, due_date_value, returned_at_value, 0, 'RETURNED', book_id_value, user_id_value,
            borrowed_at_value, returned_at_value, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BORROW_BOOK',
            NULL,
            seed_source,
            'Monthly-window borrowed-and-returned seed event.',
            borrowed_at_value, borrowed_at_value, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    -- Seasonal and legacy borrow events for 90-day/all-time spread.
    FOR idx IN 1..6 LOOP
        user_id_value := user_ids[((idx + 3) % user_count) + 1];
        book_id_value := seasonal_book_ids[((idx - 1) % array_length(seasonal_book_ids, 1)) + 1];
        borrowed_at_value := NOW() - make_interval(days => 40 + ((idx - 1) * 6), hours => (idx * 2) % 7, mins => (idx * 3) % 25);
        due_date_value := borrowed_at_value + INTERVAL '14 days';
        returned_at_value := borrowed_at_value + INTERVAL '5 days';

        INSERT INTO public.book_loan (
            id, borrowed_at, due_date, returned_at, renew_count, status, book_id, user_id,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.book_loan_id_sequence'),
            borrowed_at_value, due_date_value, returned_at_value, 1, 'RETURNED', book_id_value, user_id_value,
            borrowed_at_value, returned_at_value, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BORROW_BOOK',
            NULL,
            seed_source,
            'Seasonal borrowed-and-returned seed event.',
            borrowed_at_value, borrowed_at_value, seed_actor, seed_actor, FALSE
        );
    END LOOP;

    FOR idx IN 1..4 LOOP
        user_id_value := user_ids[((idx + 4) % user_count) + 1];
        book_id_value := legacy_book_ids[((idx - 1) % array_length(legacy_book_ids, 1)) + 1];
        borrowed_at_value := NOW() - make_interval(days => 108 + ((idx - 1) * 12), hours => (idx * 2) % 6, mins => (idx * 4) % 20);
        due_date_value := borrowed_at_value + INTERVAL '14 days';
        returned_at_value := borrowed_at_value + INTERVAL '6 days';

        INSERT INTO public.book_loan (
            id, borrowed_at, due_date, returned_at, renew_count, status, book_id, user_id,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.book_loan_id_sequence'),
            borrowed_at_value, due_date_value, returned_at_value, 0, 'RETURNED', book_id_value, user_id_value,
            borrowed_at_value, returned_at_value, seed_actor, seed_actor, FALSE
        );

        INSERT INTO public.user_behavior_log (
            id, user_id, book_id, action_type, keyword, source, reason,
            created_date, modified_date, created_by, modified_by, marked_as_deleted
        )
        VALUES (
            nextval('public.user_behavior_log_id_sequence'),
            user_id_value,
            book_id_value,
            'BORROW_BOOK',
            NULL,
            seed_source,
            'Legacy borrowed-and-returned seed event.',
            borrowed_at_value, borrowed_at_value, seed_actor, seed_actor, FALSE
        );
    END LOOP;
END
$$;

COMMIT;
