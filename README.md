# Book Discovery and Recommendation System

Java-based book discovery, recommendation, and circulation project for graduation design, coursework, and local demo use.

Current status:
- Search, recommendation, borrowing, reservation, rating, and authentication flows are available
- Frontend demo pages are included under `src/main/resources/static/ui`
- Elasticsearch-based search is integrated
- `hybrid-v2` search path is available: exact match + BM25 + vector
- A minimal local Python AI service is included for embedding integration testing

This repository is suitable for:
- Graduation project demo
- Java Web coursework
- Backend portfolio project
- A base system for further work on hybrid retrieval, RAG, and explainable recommendation

This is a local-development and demo-oriented version, not a production-hardened release.

## Features

### Core business
- User registration, login, refresh token flow, and role-based access control
- Book listing, detail, rating, borrowing, return, renewal, and reservation
- Recommendation overview, popular books, preference-based recommendation, and collaborative filtering
- Behavior logging for search, detail click, and recommendation click

### Search
- PostgreSQL exact matching
- Elasticsearch BM25 full-text retrieval
- Hybrid search API for keyword and natural-language queries
- Chinese query expansion rules for common categories and author aliases
- Automatic book search index sync on create, update, and logical delete

### Frontend
- Home dashboard
- Search workspace
- Book detail page
- Recommendation page
- Borrowing page
- Profile page
- Admin page

## Tech Stack

- Java 17
- Spring Boot 3.5.7
- Spring Web
- Spring Security
- Spring Data JPA
- Spring Data Elasticsearch
- PostgreSQL
- Elasticsearch 8
- Liquibase
- MapStruct
- Lombok
- Swagger UI / springdoc OpenAPI
- Python 3 for the local AI service
- Docker / Docker Compose

## Repository Structure

```text
src/main/java/com/weidonglang/NewBookRecommendationSystem/
  config/
  controller/
  dao/
  dto/
  entity/
  enums/
  exception/
  manager/
  recommender/
  repository/
  search/
  security/
  service/
  transformer/

src/main/resources/
  application.properties
  db/
  static/ui/

ai-service/
docs/
scripts/
```

## Quick Start

### Option A: Recommended local development flow

Open two terminals in the project root.

Terminal 1:

```powershell
.\start-ai-service.bat
```

Terminal 2:

```powershell
.\start-dev.bat -WithAi
```

This starts:
- PostgreSQL on `localhost:5043`
- Elasticsearch on `localhost:9200`
- Spring Boot on `http://localhost:8010/book-service`
- Local AI service on `http://127.0.0.1:8001`

Swagger UI:

```text
http://localhost:8010/book-service/swagger-ui/index.html
```

Frontend search page:

```text
http://localhost:8010/book-service/ui/books.html
```

### Option B: Docker app container

```powershell
docker compose up --build
```

This starts the app, PostgreSQL, and Elasticsearch inside Docker.

## Default Accounts and Local Config

Default bootstrap admin:
- Email: `admin@booknook.local`
- Password: `Admin123!`

Default Docker database:
- Database: `book_recommendation_system`
- Username: `postgres`
- Password: `postgres`

Important:
- If your local PostgreSQL volume already contains old data, your actual password may be different
- In that case, override the backend connection password when starting locally

For example:

```powershell
.\start-dev.bat -WithAi -DbPassword 20041117
```

## Search and Vector Testing

### Rebuild the search index

Run after startup:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\rebuild-search-index.ps1
```

Expected result:
- successful login
- `Book search index rebuilt successfully.`
- `indexedCount > 0`

### Verify hybrid search

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-hybrid-search.ps1 -Query "Pride and Prejudice"
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-hybrid-search.ps1 -Query "classic romance"
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-hybrid-search.ps1 -Query "Jane Austen"
```

When AI mode is enabled and the index has been rebuilt, the strategy should show:

```text
hybrid-v2(exact-db+bm25+vector)
```

More detailed local testing steps are in:

- [docs/vector-local-test-checklist.md](docs/vector-local-test-checklist.md)

## Python AI Service

The current local AI service is intentionally minimal.

It provides:
- `GET /health`
- `POST /embed`

Current embedding backend:
- deterministic `hash-bow`
- intended for integration and workflow testing
- not a final semantic model

Details:
- [ai-service/README.md](ai-service/README.md)
- [docs/vector-retrieval-ai-service-plan.md](docs/vector-retrieval-ai-service-plan.md)

## Current Search Status

Implemented now:
- exact match
- BM25 retrieval
- hybrid search API
- vector retrieval skeleton and integration
- local embedding service integration
- Chinese query expansion for some common natural-language cases

Not finished yet:
- real production-grade embedding model
- final retrieval quality tuning
- RAG evidence retrieval and answer generation
- benchmark-quality retrieval evaluation

## Known Limitations

- The current local embedding backend is a placeholder, so semantic quality is limited
- Natural-language retrieval works as a demo path, but ranking quality still needs improvement
- Configuration defaults are development-oriented
- The project is suitable for demo and coursework use, not direct production deployment

## Development Notes

When to restart what:
- If you change Java backend code: restart the backend
- If you change Python AI service code: restart the AI service
- If you change index structure or embedding write logic: restart backend and rebuild the search index
- If you only change frontend static resources: hard refresh the page, and restart backend only if needed

Useful commands:

```powershell
.\start-ai-service.bat
```

```powershell
.\start-dev.bat -WithAi
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\rebuild-search-index.ps1
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify-hybrid-search.ps1 -Query "classic romance"
```

## Roadmap

Near-term priorities:
1. Replace the placeholder embedding backend with a real local embedding model
2. Improve hybrid retrieval quality and query rewrite rules
3. Build RAG evidence retrieval
4. Add answer generation with citation
5. Add evaluation for retrieval, recommendation, and QA

## Screenshots

If the image assets exist in your branch, you can use:

- `docs/images/home-dashboard.png`
- `docs/images/search-workspace.png`
- `docs/images/book-detail.png`
- `docs/images/recommendation-shelf.png`
- `docs/images/borrowing-records.png`
- `docs/images/swagger-ui.png`

## License

See the repository `LICENSE` file if present.
