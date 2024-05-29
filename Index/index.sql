SHOW seq_page_cost;
SHOW random_page_cost;
SET random_page_cost = 1.1;

-- Создание индекса к таблице users

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

CREATE INDEX lastname_idx ON broker_schema.users (lastname);

ANALYZE broker_schema.users;

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

-- Создание индекса на часть таблицы

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

CREATE INDEX part_lastname ON broker_schema.users (lastname) WHERE birthday > '1993-08-14';

ANALYZE broker_schema.users;

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

-- Создание индекса на несколько полей

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

CREATE INDEX first_last_idx ON broker_schema.users (lastname, firstname);

ANALYZE broker_schema.users;

EXPLAIN (costs, verbose, format text, analyze) SELECT * FROM broker_schema.users;

-- Создание индекса для полнотекстового поиска

SELECT symbol, to_tsvector(description) FROM broker_schema.currencys;

SELECT symbol, to_tsvector(description)@@to_tsquery('Евро') from broker_schema.currencys;

ALTER TABLE broker_schema.currencys ADD COLUMN desc_lexeme tsvector;

UPDATE broker_schema.currencys
SET desc_lexeme = to_tsvector(description);

SELECT symbol, desc_lexeme FROM broker_schema.currencys;

EXPLAIN ANALYZE SELECT symbol FROM broker_schema.currencys WHERE desc_lexeme @@ to_tsquery('Евро');

CREATE INDEX search_idx_desc ON broker_schema.currencys USING GIN (desc_lexeme);

ANALYZE broker_schema.currencys;

EXPLAIN ANALYZE SELECT symbol FROM broker_schema.currencys WHERE desc_lexeme @@ to_tsquery('Евро');

SELECT name_of_the_issuer, to_tsvector(info_about_issuer) FROM broker_schema.bounds;