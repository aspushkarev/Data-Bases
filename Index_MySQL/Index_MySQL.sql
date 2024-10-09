USE broker;

-- DROP INDEX bound_idx ON bounds;

CREATE FULLTEXT INDEX bound_idx ON bounds(name_of_the_issuer, info_about_issuer, profitability);

SELECT * FROM bounds;

EXPLAIN SELECT * FROM bounds;

SELECT * FROM bounds
WHERE MATCH(name_of_the_issuer, info_about_issuer, profitability) AGAINST('Альфа');

SELECT * FROM bounds
WHERE MATCH(name_of_the_issuer, info_about_issuer, profitability) AGAINST('нефть');

SELECT * FROM bounds
WHERE MATCH(name_of_the_issuer, info_about_issuer, profitability) AGAINST('Газпром*' IN BOOLEAN MODE);

EXPLAIN SELECT * FROM bounds
WHERE MATCH(name_of_the_issuer, info_about_issuer, profitability) AGAINST('Газпром*' IN BOOLEAN MODE);


CREATE FULLTEXT INDEX users_idx ON users(patronymic);

-- DROP INDEX users_idx ON users;

SELECT * FROM users;

EXPLAIN SELECT * FROM users;

SELECT * FROM users
WHERE MATCH(patronymic) AGAINST('Артеменко');

SELECT * FROM users
WHERE MATCH(patronymic) AGAINST('Г*' IN BOOLEAN MODE);

EXPLAIN SELECT * FROM users
WHERE MATCH(patronymic) AGAINST('Г*' IN BOOLEAN MODE);
