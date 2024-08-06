USE broker;

-- Запрос показывающий портфели инвесторов, сделки с эмитентами у которых не закрыты

SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
INNER JOIN users u ON up.user_id = u.id
INNER JOIN deals d ON d.user_id = u.id
INNER JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

-- Запрос для отображения подробной информации по эмитенту из портфеля инвестора

SELECT 	u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value, -- book_value - балансовая стоимость
		(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM issuers i  
LEFT JOIN deals d ON i.id = d.issuer_id
LEFT JOIN users u ON u.id = d.user_id
WHERE d.closed = 'no' AND u.id = 4
ORDER BY u.id;


-- Запрос показывающий состояние счёта инвестора

SELECT bou.user_id, SUM(bou.cash) AS cash, bou.currency_id FROM bill_of_users bou
WHERE bou.user_id = 1
GROUP BY currency_id 
ORDER BY currency_id;

-- Запрос показывающий аббревиатуру валюты и её символ

SELECT c.abbreviation, c.symbol FROM currencys c
WHERE c.id = 1;

-- Запрос с подзапросами показывающий состояние счёта инвестора

SELECT
	bou.user_id,
	SUM(bou.cash) AS cash,
	(SELECT c.symbol FROM currencys c WHERE c.id = bou.currency_id) AS symbol,
	(SELECT c2.abbreviation FROM currencys c2 WHERE c2.id = bou.currency_id) AS abbreviation
FROM bill_of_users bou WHERE bou.user_id = 1
GROUP BY currency_id 
ORDER BY currency_id;

-- Запрос показывающий историю сделок с ценными бумагами по выбранному инвестору (например инвестор номер 3)

SELECT CONCAT(u.firstname, ' ', u.lastname, ' ', u.patronymic) AS name, 
	i.name_of_the_issuer, 
	d.deal, 
	d.quantity, 
	d.price, 
	(SELECT d.quantity * d.price) AS book_value FROM deals d
INNER JOIN issuers i ON d.issuer_id = i.id
INNER JOIN users u ON u.id = d.user_id 
WHERE u.id = 3;
