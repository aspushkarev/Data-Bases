USE broker;

-- Запрос, показывающий количество сделок на покупку

SELECT deal, 
	   SUM(CASE WHEN deal = 'buy'
			THEN 1
			ELSE 0
			END) AS sum_by_buy
FROM deals
GROUP BY deal;

-- Запрос, показывающий количество сделок на покупку и имеющих статус не закрыто

SELECT deal, closed, COUNT(*) FROM deals
WHERE deal = 'buy'
GROUP BY deal, closed
HAVING closed = 'no';

--Запрос, показывающий объём сделок по каждой ценной бумаге

SELECT i.name_of_the_issuer, SUM(d.price) AS total
FROM deals d
JOIN issuers i ON i.id = d.issuer_id
GROUP BY i.name_of_the_issuer WITH ROLLUP;

--Запрос, показывающий объём сделок по каждой ценной бумаге (вместо NULL впечатываем 'ИТОГО')

SELECT IF(GROUPING(i.name_of_the_issuer), 'ИТОГО', i.name_of_the_issuer) AS name,
		SUM(d.price) AS total
FROM deals d
JOIN issuers i ON i.id = d.issuer_id
GROUP BY i.name_of_the_issuer WITH ROLLUP;

--Запрос, показывающий максимальную и минимальную цену покупки бумаги

SELECT i.name_of_the_issuer, MAX(d.price) AS max_price, MIN(d.price) AS min_price
FROM deals d
JOIN issuers i ON i.id = d.issuer_id
GROUP BY i.name_of_the_issuer;

--Запрос, показывающий самую дорогую и самую дешевую цену в каждой категории (в моём случае по валюте)

SELECT  i.name_of_the_issuer,
		c.abbreviation,
		MAX(d.price) OVER(PARTITION BY d.currency_id) AS max_price,
		MIN(d.price) OVER(PARTITION BY d.currency_id) AS min_price
FROM deals d
JOIN issuers i ON i.id = d.issuer_id
JOIN currencys c ON c.id = d.currency_id;

--

SELECT 	RANK() OVER(PARTITION BY c.abbreviation ORDER BY i.name_of_the_issuer) AS position,
		i.name_of_the_issuer,
		d.price,
		c.abbreviation
FROM deals d
JOIN issuers i ON i.id = d.issuer_id
JOIN currencys c ON c.id = d.currency_id;
