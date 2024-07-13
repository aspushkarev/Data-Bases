DROP TABLE IF EXISTS users_part;

CREATE TABLE users_part (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	firstname VARCHAR(50) NOT NULL COMMENT 'Имя',
	lastname VARCHAR(50) NOT NULL COMMENT 'Фамилия',
	patronymic VARCHAR(50) NOT NULL COMMENT 'Отчество',
	birthday DATE NOT NULL COMMENT 'Дата рождения',
	gender ENUM('мужской', 'женский') NOT NULL COMMENT 'Пол',
	citizenship VARCHAR(30) NOT NULL COMMENT 'Гражданство',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX(firstname),
	INDEX(lastname),
	INDEX(patronymic)
) COMMENT = 'Таблица инвесторов с партициями по HASH'
PARTITION BY HASH(id)
PARTITIONS 10;

INSERT INTO users_part
VALUES (DEFAULT, 'Рустем', 'Флюрович', 'Габдрашитов', '1984-11-03', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Михаил', 'Николаевич', 'Горбунов', '1989-09-12', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Павел', 'Михайлович', 'Артеменко', '1965-08-26', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Павел', 'Николаевич', 'Колмогоров', '1961-03-21', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Сергей', 'Сергеевич', 'Дегтярёв', '1975-07-08', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Алина', 'Талгатовна', 'Зарипова', '1993-04-14', 'женский', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Артём', 'Сергеевич', 'Волгин', '1992-01-25', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Илья', 'Николаевич', 'Юдин', '1990-07-19', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Константин', 'Васильевич', 'Кособрюхов', '1980-02-18', 'мужской', 'Россия', DEFAULT, DEFAULT);

SELECT * FROM users_part;

SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'users_part';

DROP TABLE IF EXISTS bill_of_users_part;

CREATE TABLE bill_of_users_part (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'ID инвестора',
	cash DECIMAL (11,2) COMMENT 'Деньги или счёт',
	currency_id TINYINT UNSIGNED COMMENT 'Валюта счёта'
	-- FOREIGN KEY (user_id) REFERENCES users (id),
	-- FOREIGN KEY (currency_id) REFERENCES currencys (id)
) COMMENT = 'Таблица счетов инвесторов с партициями по HASH'
PARTITION BY HASH(id)
PARTITIONS 10;

INSERT INTO bill_of_users_part 
VALUES (DEFAULT, 1, 150245, 2),
(DEFAULT, 1, 1000, 1),
(DEFAULT, 2, 150, 1),
(DEFAULT, 3, 1502453, 2),
(DEFAULT, 4, 100500, 2),
(DEFAULT, 5, 55000, 1),
(DEFAULT, 6, 345893, 2),
(DEFAULT, 7, 35, 1),
(DEFAULT, 8, 5893854, 2),
(DEFAULT, 8, '5024.25', 1),
(DEFAULT, 9, '13245.78', 1),
(DEFAULT, 9, 47950245, 2);

SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'bill_of_users_part';

DROP TABLE IF EXISTS deals_part;

CREATE TABLE deals_part (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL COMMENT 'ID инвестора',
	type_of_bid_id TINYINT UNSIGNED NOT NULL COMMENT 'Тип заявки',
	issuer_id BIGINT UNSIGNED NOT NULL COMMENT 'ID эмитента',
	deal ENUM ('buy', 'sell') NOT NULL COMMENT 'Сделка на покупку или продажу',
	quantity INT UNSIGNED NOT NULL COMMENT 'Количество',
	price DECIMAL (11,2) COMMENT 'Цена сделки',
	currency_id TINYINT UNSIGNED NOT NULL COMMENT 'ID валюты',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время совершения сделки',
	closed ENUM ('yes', 'no') DEFAULT 'no' COMMENT 'Статус сделки (закрыта или нет)'
	-- FOREIGN KEY (user_id) REFERENCES users (id),
	-- FOREIGN KEY (type_of_bid_id) REFERENCES type_of_bids (id),
	-- FOREIGN KEY (issuer_id) REFERENCES issuers (id),
	-- FOREIGN KEY (currency_id) REFERENCES currencys (id)
) COMMENT = 'Таблица сделок с ценными бумагами с партициями по ключу'
PARTITION BY KEY()
PARTITIONS 6;

INSERT INTO deals_part
VALUES 
(DEFAULT, 1, 2, 3, 'buy', 7, 125, 2, DEFAULT, DEFAULT),
(DEFAULT, 2, 2, 1, 'buy', 15, 1230, 2, DEFAULT, DEFAULT),
(DEFAULT, 7, 3, 8, 'buy', 99, 12, 1, DEFAULT, DEFAULT),
(DEFAULT, 5, 2, 10, 'buy', 1, 2378, 2, DEFAULT, DEFAULT),
(DEFAULT, 3, 1, 5, 'sell', 3, 11, 1, DEFAULT, DEFAULT),
(DEFAULT, 4, 1, 6, 'buy', 128, '2456.8', 2, DEFAULT, DEFAULT),
(DEFAULT, 4, 2, 6, 'sell', 128, 2600, 2, DEFAULT, 'yes'),
(DEFAULT, 1, 2, 3, 'sell', 7, 230, 2, DEFAULT, 'yes'),
(DEFAULT, 2, 1, 1, 'sell', 15, 1258, 2, DEFAULT, 'yes'),
(DEFAULT, 7, 3, 8, 'sell', 90, 15, 1, DEFAULT, DEFAULT),
(DEFAULT, 5, 2, 7, 'buy', 14, 58, 2, DEFAULT, DEFAULT),
(DEFAULT, 8, 2, 2, 'sell', 77, 125, 2, DEFAULT, DEFAULT),
(DEFAULT, 1, 4, 9, 'buy', 70, 22, 2, DEFAULT, DEFAULT),
(DEFAULT, 9, 5, 2, 'buy', 42, 15, 2, DEFAULT, DEFAULT),
(DEFAULT, 9, 3, 8, 'sell', 37, 34, 2, DEFAULT, DEFAULT),
(DEFAULT, 2, 2, 1, 'buy', 19, 58, 2, DEFAULT, DEFAULT);

SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'deals_part';

