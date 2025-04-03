USE customers;

SELECT DISTINCT gender_prefix, length(gender_prefix) AS len FROM customers_all
ORDER BY len DESC;

SELECT DISTINCT marital_status FROM  customers_all;

INSERT INTO languages (correspondence_language)
	SELECT DISTINCT correspondence_language FROM customers_all;

SELECT * FROM languages;

INSERT INTO customers (gender_prefix, firstname, lastname)
	SELECT gender_prefix, firstname, lastname FROM customers_all;

SELECT * FROM customers;

-- дописать запрос
-- INSERT INTO marital_status (id, marital_status)
-- 	SELECT DISTINCT marital_status FROM  customers_all;

SELECT * FROM marital_status;

-- дописать запрос
-- INSERT INTO customers_profile (birth_date, gender)
-- SELECT birth_date, gender FROM customers_all;

SELECT * FROM customers_profile;

INSERT INTO countries (country)
	SELECT DISTINCT country FROM customers_all;

SELECT * FROM countries;

INSERT INTO postal_codes (postal_code)
	SELECT DISTINCT postal_code FROM customers_all;

SELECT * FROM postal_codes;

INSERT INTO regions (region)
	SELECT DISTINCT region FROM customers_all;

SELECT * FROM regions;

INSERT INTO cities (city)
	SELECT DISTINCT city FROM customers_all;

SELECT city FROM cities;

INSERT INTO streets (street)
	SELECT DISTINCT street FROM customers_all;

SELECT street FROM streets;

-- дописать запрос
INSERT INTO additional_info_customers (id, customer_id, countries_id, postal_codes_id, regions_id, cities_id, streets_id, building_number)
VALUES (DEFAULT, 1, 1, 1, 1, 1, 1, 13);


SELECT * FROM additional_info_customers; 

