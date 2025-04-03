DROP DATABASE IF EXISTS customers;

CREATE DATABASE IF NOT EXISTS customers;

USE customers;

DROP TABLE IF EXISTS customers_all;

CREATE TABLE customers_all (
	id SERIAL PRIMARY KEY,
	gender_prefix VARCHAR (20) COMMENT 'Префикс пола',
    firstname VARCHAR(50) NOT NULL COMMENT 'Имя',
    lastname VARCHAR(50) NOT NULL COMMENT 'Фамилия', 
    correspondence_language CHAR(2) NOT NULL COMMENT 'Язык общения',
    birth_date VARCHAR(10) COMMENT 'Дата рождения',
    gender VARCHAR (10) NOT NULL COMMENT 'Пол',
    marital_status VARCHAR (10) COMMENT 'Семейное положение',
    country VARCHAR(20) NOT NULL COMMENT 'Страна',
    postal_code VARCHAR(8) COMMENT 'Почтовый индекс',
    region VARCHAR(20) NOT NULL COMMENT 'Регион',
    city VARCHAR(35) COMMENT 'Город',
    street VARCHAR(100) COMMENT 'Улица',
    building_number VARCHAR(10) COMMENT 'Номер дома'
) COMMENT = 'Таблица покупателей всё в одном';

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    gender_prefix VARCHAR(20) NOT NULL COMMENT 'Префикс пола',
    firstname VARCHAR(50) NOT NULL COMMENT 'Имя',
    lastname VARCHAR(50) NOT NULL COMMENT 'Фамилия',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX(lastname)
) COMMENT = 'Таблица покупателей';

DROP TABLE IF EXISTS languages;

CREATE TABLE languages (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	correspondence_language CHAR(2) NOT NULL COMMENT 'Язык общения'
) COMMENT = 'Таблица языков общения';

DROP TABLE IF EXISTS marital_status;

CREATE TABLE marital_status (
	id TINYINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	marital_status ENUM ('Uknown', 'Not married', 'Married', 'Divorced', 'Widower') COMMENT 'Семейное положение'
) COMMENT = 'Таблица семейного положения';

DROP TABLE IF EXISTS customers_profile;

CREATE TABLE customers_profile (
	id SERIAL PRIMARY KEY,
	customer_id BIGINT UNSIGNED NOT NULL COMMENT 'ID клиента',
	login VARCHAR(30) NOT NULL UNIQUE COMMENT 'Логин',
	password_hash CHAR(55) NOT NULL UNIQUE COMMENT 'Хэш пароля',
	phone CHAR(11) NOT NULL COMMENT 'Номер телефона',
	email VARCHAR(120) NOT NULL UNIQUE COMMENT 'e-mail',
	correspondence_language_id INT UNSIGNED NOT NULL COMMENT 'Язык общения',
	birth_date DATE NOT NULL COMMENT 'Дата рождения',
	gender ENUM ('Male', 'Female') NOT NULL COMMENT 'Пол',
	marital_status_id TINYINT UNSIGNED NOT NULL COMMENT 'Семейное положение',
	FOREIGN KEY (customer_id) REFERENCES customers (id),
	FOREIGN KEY (correspondence_language_id) REFERENCES languages (id),
	FOREIGN KEY (marital_status_id) REFERENCES marital_status (id)
) COMMENT = 'Таблица профилей покупателей';

DROP TABLE IF EXISTS countries;

CREATE TABLE countries (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	country CHAR(2) NOT NULL COMMENT 'Страна'
) COMMENT = 'Таблица стран';

DROP TABLE IF EXISTS postal_codes;

CREATE TABLE postal_codes (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	postal_code VARCHAR(10) NOT NULL COMMENT 'Почтовый индекс'
) COMMENT = 'Таблица почтовых индексов';

DROP TABLE IF EXISTS regions;

CREATE TABLE regions (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	region VARCHAR(20) NOT NULL COMMENT 'Регион'
) COMMENT = 'Таблица регионов';

DROP TABLE IF EXISTS cities;

CREATE TABLE cities (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	city VARCHAR(35) NOT NULL COMMENT 'Город'
) COMMENT = 'Таблица городов';

DROP TABLE IF EXISTS streets;

CREATE TABLE streets (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
	street VARCHAR(100) NOT NULL COMMENT 'Улица'
) COMMENT = 'Таблица улиц';
 
DROP TABLE IF EXISTS additional_info_customers;

CREATE TABLE additional_info_customers (
	id SERIAL PRIMARY KEY,
	customer_id BIGINT UNSIGNED NOT NULL COMMENT 'ID клиента',
	countries_id INT UNSIGNED NOT NULL COMMENT 'Страна',
	postal_codes_id INT UNSIGNED NOT NULL COMMENT 'Почтовый индекс',
	regions_id INT UNSIGNED NOT NULL COMMENT 'Регион',
	cities_id INT UNSIGNED NOT NULL COMMENT 'Город',
	streets_id INT UNSIGNED NOT NULL COMMENT 'Улица',
    building_number INT UNSIGNED NOT NULL COMMENT 'Номер дома',
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (countries_id) REFERENCES countries (id),
    FOREIGN KEY (postal_codes_id) REFERENCES postal_codes (id),
    FOREIGN KEY (regions_id) REFERENCES regions (id),
    FOREIGN KEY (cities_id) REFERENCES cities (id),
    FOREIGN KEY (streets_id) REFERENCES streets (id)
) COMMENT = 'Таблица дополнительной информации о покупателе';
    
