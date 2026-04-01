`scripts/generate-json-seed-sql.js` rebuilds the database seed from:

- `src/main/resources/json/Authors - final.json`
- `src/main/resources/json/Books - final.json`

It generates:

- `scripts/generated/reset_from_json.sql`

What the generated SQL does:

1. Truncates `user_book_rate`, `user_book_category`, `user_reading_info`, `book`, and `author`
2. Resets identities
3. Re-inserts all authors from JSON
4. Re-inserts all books from JSON

Run:

```powershell
node scripts/generate-json-seed-sql.js
psql -U postgres -d book_recommendation_system -f scripts/generated/reset_from_json.sql
```

This replaces current test seed data. It also clears reading preferences and ratings because those tables depend on books/authors.
