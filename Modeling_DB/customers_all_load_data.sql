-- Загрузка данных из файла *.csv

USE customers;

LOAD DATA LOCAL
	INFILE '/Users/alexander/Repo/Data-Bases/Modeling_DB/some_customers.csv'
	INTO TABLE customers_all
	FIELDS TERMINATED BY ","
    LINES TERMINATED BY "\n"
    IGNORE 1 LINES
	(gender_prefix, firstname, lastname, correspondence_language, birth_date, gender, marital_status, country, postal_code, region, city, street, building_number);

SELECT * FROM customers_all;

SHOW VARIABLES LIKE 'secure_file_priv';

SET GLOBAL local_infile = true;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

/* 

Затем нужно выйти из консоли и вновь подключиться к серверу с параметром
--local-infile=1

mysql --local-infile=1 -u root -p

*/
