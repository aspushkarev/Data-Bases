USE broker;

-- Запрос показывающий портфели инвесторов, сделки с эмитентами по которым не закрыты

SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

EXPLAIN SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

EXPLAIN ANALYZE SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

EXPLAIN FORMAT=Tree SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

EXPLAIN FORMAT=JSON SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

CREATE INDEX users_idx2 ON users(firstname);

-- DROP INDEX users_idx ON users;