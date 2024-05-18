-- Добавление данных

INSERT INTO broker_schema.users (id, firstname, lastname, patronymic, birthday, current_gender, citizenship, created_at, updated_at)
VALUES (DEFAULT, 'Андрей', 'Андреевич', 'Красноштанов', '1971-01-09', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Сергей', 'Карлович', 'Пушкарев', '1960-08-11', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Гарик', 'Аликович', 'Якубов', '1987-11-15', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Зинаида', 'Алексеевна', 'Пушкарева', '1958-12-18', 'женский', 'Россия', DEFAULT, DEFAULT);

INSERT INTO broker_schema.user_profiles (id, user_id, login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status)
VALUES (DEFAULT, 10, 'hlfe', '78bf69qfretj7h3', '89039992791', 'liza5@mail.ru', '454361/21', DEFAULT, '452396', NULL, 4, 'FALSE'),
(DEFAULT, 11, 'fvmy', 'eiujhsgrejk7h3', '89039792794', 'mark2@mail.ru', '451371/21', DEFAULT, '453986', '345642', 3, 'FALSE'),
(DEFAULT, 12, 'skey', 'ghd34vnlty0te', '89036992707', 'ivolga@lenta.ru', '589712/19', DEFAULT, '451924', NULL, 6, 'FALSE'),
(DEFAULT, 13, 'xhap', 'jjlol8nbk73f8', '89033692894', 'match1@mail.ru', '329571/11', DEFAULT, '415985', '376675', 2, 'FALSE')

INSERT INTO broker_schema.user_profiles (id, user_id, login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status)
VALUES (DEFAULT, 1, 'hgfe', '78bf65qfretj7h3', '89039692791', 'liz5@mail.ru', '453361/21', DEFAULT, '452896', NULL, 4, 'FALSE')
RETURNING id, user_id, login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status;

INSERT INTO broker_schema.bill_of_users (id, user_id, cash, currency_id)
VALUES (DEFAULT, 10, 23864, 2),
(DEFAULT, 11, 97371356, 1),
(DEFAULT, 12, 99, 1),
(DEFAULT, 13, 763974193, 2);

INSERT INTO broker_schema.bill_of_users (id, user_id, cash, currency_id)
VALUES (DEFAULT, 12, 49731, 2),
(DEFAULT, 13, 5692, 1)
RETURNING id, user_id, cash;

SELECT * FROM broker_schema.bill_of_users;

INSERT INTO broker_schema.deals (id, user_id, type_of_bid_id, issuer_id, deal, quantity, price, currency_id, created_at, closed)
VALUES (DEFAULT, 10, 2, 6, 'buy', 17, 25, 2, DEFAULT, DEFAULT),
(DEFAULT, 12, 2, 1, 'buy', 5, 130, 2, DEFAULT, DEFAULT),
(DEFAULT, 11, 3, 8, 'buy', 39, 142, 1, DEFAULT, DEFAULT),
(DEFAULT, 13, 2, 10, 'buy', 91, 239, 2, DEFAULT, DEFAULT);

-- Запрос показывающий состояние счёта инвестора

SELECT bou.user_id, SUM(bou.cash) AS cash, bou.currency_id FROM broker_schema.bill_of_users bou
WHERE bou.user_id = 1
GROUP BY currency_id, user_id 
ORDER BY currency_id;

SELECT c.abbreviation, c.symbol FROM broker_schema.currencys c
WHERE c.id = 1;

-- Итоговый запрос с подзапросами показывающий состояние счёта инвестора

SELECT
	bou.user_id,
	SUM(bou.cash) AS cash,
	(SELECT c.symbol FROM broker_schema.currencys c WHERE c.id = bou.currency_id) AS symbol,
	(SELECT c2.abbreviation FROM broker_schema.currencys c2 WHERE c2.id = bou.currency_id) AS abbreviation
FROM broker_schema.bill_of_users bou WHERE bou.user_id = 1
GROUP BY currency_id, user_id
ORDER BY currency_id;

-- Запрос, показывающий портфели инвесторов (то есть список всех инвесторов с эмитентами, сделки по которым не закрыты)

SELECT u.id, u.firstname || ' ' || u.lastname || ' ' || u.patronymic AS name_client, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM broker_schema.user_profiles AS up 
JOIN broker_schema.users u ON up.user_id = u.id
JOIN broker_schema.deals d ON d.user_id = u.id
JOIN broker_schema.issuer i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

SELECT u.id, u.firstname || ' ' || u.lastname || ' ' || u.patronymic AS name_client, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM broker_schema.user_profiles AS up 
LEFT JOIN broker_schema.users u ON up.user_id = u.id
LEFT JOIN broker_schema.deals d ON d.user_id = u.id
LEFT JOIN broker_schema.issuer i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

-- Запрос для отображения подробной информации по эмитенту из портфеля инвестора

SELECT * FROM broker_schema.issuer;

SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value  -- book_value - балансовая стоимость
	--	(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM broker_schema.issuer i  
JOIN broker_schema.deals d ON i.id = d.issuer_id
JOIN broker_schema.users u ON u.id = d.user_id
WHERE d.closed = 'no' AND u.id = 4
ORDER BY u.id;

-- Запрос выведет 20 строк с использованием INNER JOIN

SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value  -- book_value - балансовая стоимость
	--	(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM broker_schema.issuer i  
INNER JOIN broker_schema.deals d ON i.id = d.issuer_id
INNER JOIN broker_schema.users u ON u.id = d.user_id;

-- Запрос выведет 23 строчки с использованием LEFT JOIN

SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value  -- book_value - балансовая стоимость
	--	(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM broker_schema.issuer i  
LEFT JOIN broker_schema.deals d ON i.id = d.issuer_id
LEFT JOIN broker_schema.users u ON u.id = d.user_id;

-- Запрос выведет 21 строку с использованием RIGHT JOIN

SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value  -- book_value - балансовая стоимость
	--	(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM broker_schema.issuer i  
RIGHT JOIN broker_schema.deals d ON i.id = d.issuer_id
RIGHT JOIN broker_schema.users u ON u.id = d.user_id;

--Запрос, показывающий историю сделок с ценными бумагами по выбранному инвестору (например, инвестор номер 4)

SELECT CONCAT(u.firstname, ' ', u.lastname, ' ', u.patronymic) AS name, i.name_of_the_issuer, d.deal, d.quantity, d.price, 
	(SELECT d.quantity * d.price) AS book_value FROM broker_schema.deals d
INNER JOIN broker_schema.issuer i ON d.issuer_id = i.id
INNER JOIN broker_schema.users u ON u.id = d.user_id 
WHERE u.id = 4;

-- Операции UPDATE и DELETE

SELECT * FROM broker_schema.bill_of_users
ORDER BY id;

UPDATE broker_schema.bill_of_users AS bou
SET cash = 37932
WHERE bou.id = 1;

-- Сначало проверим запрос с использованием SELECT

SELECT * FROM broker_schema.bill_of_users
WHERE user_id = 1 AND id = 2
ORDER BY id;

-- Теперь удалим неверный счёт

DELETE FROM broker_schema.bill_of_users
WHERE user_id = 1 AND id = 2;

-- Создадим копию таблицы счетов клиентов

DROP TABLE broker_schema.bill_of_users_copy;

CREATE TABLE broker_schema.bill_of_users_copy (
	id SERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	cash DECIMAL (11,2),
	currency_id INT,
	FOREIGN KEY (user_id) REFERENCES broker_schema.users (id),
	FOREIGN KEY (currency_id) REFERENCES broker_schema.currencys (id)
) TABLESPACE broker_space;

SELECT * FROM broker_schema.bill_of_users_copy;

INSERT INTO broker_schema.bill_of_users_copy (
id, user_id, cash, currency_id)
SELECT * FROM broker_schema.bill_of_users;

SELECT * FROM broker_schema.bill_of_users_copy
WHERE user_id = 13 AND id = 62;

UPDATE broker_schema.bill_of_users_copy
SET user_id = 12
WHERE user_id = 13 AND id = 62;

-- Теперь обновим счёт клиента 13

UPDATE broker_schema.bill_of_users_copy AS bouc
SET cash = 4585
FROM broker_schema.bill_of_users
WHERE bouc.user_id = 13
RETURNING bouc.user_id, bouc.cash, bouc.currency_id;

SELECT * FROM broker_schema.bill_of_users_copy as bou
WHERE bou.user_id = 13;

-- Пример DELETE с JOIN и USING
-- Создадим копию таблицы и будем с ней тренироваться :)

DROP TABLE broker_schema.bill_of_users_yet_copy;

CREATE TABLE broker_schema.bill_of_users_yet_copy (
	id SERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	cash DECIMAL (11,2),
	currency_id INT,
	FOREIGN KEY (user_id) REFERENCES broker_schema.users (id),
	FOREIGN KEY (currency_id) REFERENCES broker_schema.currencys (id)
) TABLESPACE broker_space;

SELECT * FROM broker_schema.bill_of_users_yet_copy;

INSERT INTO broker_schema.bill_of_users_yet_copy (
id, user_id, cash, currency_id)
SELECT * FROM broker_schema.bill_of_users;

SELECT bouyc.user_id, bouyc.cash, c.symbol FROM broker_schema.bill_of_users_yet_copy bouyc
JOIN broker_schema.currencys AS c
ON bouyc.user_id = 1 AND bouyc.currency_id = c.id;

SELECT bouyc.user_id, bouyc.cash, c.symbol FROM broker_schema.bill_of_users_yet_copy bouyc
JOIN broker_schema.currencys AS c
ON bouyc.cash > 3810301;

-- Теперь построим результирующий запрос на удаление выбранных строк

DELETE FROM broker_schema.bill_of_users_yet_copy
USING
	(SELECT bouyc.user_id, bouyc.cash, c.symbol FROM broker_schema.bill_of_users_yet_copy bouyc
		JOIN broker_schema.currencys AS c
		ON bouyc.cash > 3810301) AS foo;

-- RegExp

-- Найдём клиента у которого email начинается на 'a', а дальнейшие символы не имеют значение

SELECT * FROM broker_schema.user_profiles
WHERE email LIKE 'a%';

-- Найдём клиентов у которых есть в номере телефона цифры 26

SELECT * FROM broker_schema.user_profiles
WHERE phone LIKE '%26%';

-- Задание со *

-- Скопируем в файл список ранее найденных клиентов у которых в email есть символ 'a'

COPY (SELECT * FROM broker_schema.user_profiles WHERE email LIKE 'a%') TO '/Users/alexander/docs/psql/data/email.copy';

-- COPY broker_schema.currencys TO PROGRAM 'rar > /Users/alexander/docs/psql/data/currencys.gz';
