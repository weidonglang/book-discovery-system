const fs = require('fs');
const path = require('path');

const root = process.cwd();
const authorsPath = path.join(root, 'src', 'main', 'resources', 'json', 'Authors - final.json');
const booksPath = path.join(root, 'src', 'main', 'resources', 'json', 'Books - final.json');
const outputPath = path.join(root, 'scripts', 'generated', 'reset_from_json.sql');

const authors = JSON.parse(fs.readFileSync(authorsPath, 'utf8'));
const books = JSON.parse(fs.readFileSync(booksPath, 'utf8'));
const authorByJsonId = new Map(authors.map((author, index) => [index + 1, author]));

function sqlString(value) {
  if (value === null || value === undefined) return 'NULL';
  const normalized = String(value)
    .normalize('NFKC')
    .replace(/[\u2018\u2019]/g, "'")
    .replace(/[\u201C\u201D]/g, '"')
    .replace(/[\u2013\u2014]/g, '-')
    .replace(/\u2026/g, '...')
    .replace(/\u00A0/g, ' ')
    .replace(/\uFFFD/g, '')
    .replace(/[^\x09\x0A\x0D\x20-\x7E]/g, '');
  return `'${normalized.replace(/'/g, "''")}'`;
}

function sqlDate(value) {
  if (!value) return 'NULL';
  const iso = new Date(value).toISOString().slice(0, 10);
  return `DATE ${sqlString(iso)}`;
}

function categoryName(categoryId) {
  const map = {
    1: 'Science Fiction',
    2: 'Horror',
    3: 'Classic',
    4: 'Action and Adventure',
    5: 'Romantic',
    6: 'Kids',
    7: 'History',
    8: 'Sport'
  };
  return map[categoryId];
}

const lines = [];
lines.push('-- Generated from src/main/resources/json/Authors - final.json and Books - final.json');
lines.push('-- Usage: psql -U postgres -d book_recommendation_system -f scripts/generated/reset_from_json.sql');
lines.push('BEGIN;');
lines.push('');
lines.push('TRUNCATE TABLE public.user_book_rate, public.user_book_category, public.user_reading_info, public.book, public.author RESTART IDENTITY CASCADE;');
lines.push('');

for (const author of authors) {
  lines.push(`INSERT INTO public.author`);
  lines.push(`(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)`);
  lines.push(`VALUES (${sqlString(author.name)}, ${sqlString(author.description)}, ${sqlDate(author.birthdate)}, ${sqlDate(author.deathdate)}, ${sqlString(author.country)}, ${author.age}, ${sqlString(author.gender)}, ${sqlString(author.imageUrl)}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);`);
  lines.push('');
}

for (const book of books) {
  const author = authorByJsonId.get(book.author.id);
  if (!author) {
    throw new Error(`Unknown author id for book "${book.name}": ${book.author.id}`);
  }
  const authorIdExpr = `(SELECT id FROM public.author WHERE name = ${sqlString(author.name)})`;
  const category = categoryName(book.category.id);
  if (!category) {
    throw new Error(`Unknown category id for book "${book.name}": ${book.category.id}`);
  }
  const categoryIdExpr = `(SELECT id FROM public.book_category WHERE name = ${sqlString(category)})`;
  lines.push(`INSERT INTO public.book`);
  lines.push(`(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)`);
  lines.push(`VALUES (${authorIdExpr}, ${categoryIdExpr}, ${sqlString(book.name)}, ${Number(book.price)}, ${Number(book.rate)}, ${Number(book.usersRateCount)}, ${Number(book.pagesNumber)}, ${Number(book.readingDuration)}, ${sqlDate(book.publishDate)}, ${sqlString(book.description)}, ${sqlString((book.imageUrl || '').trim())}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);`);
  lines.push('');
}

lines.push('COMMIT;');
lines.push('');

fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, lines.join('\n'), 'utf8');

console.log(`Generated ${outputPath}`);
console.log(`Authors: ${authors.length}, Books: ${books.length}`);
