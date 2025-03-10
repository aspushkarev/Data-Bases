USE broker;

-- представление, показывающее портфели инвесторов (то есть список всех инвесторов с эмитентами, сделки по которым не закрыты)

CREATE OR REPLACE VIEW view_bags AS
SELECT u.id, u.firstname, u.lastname, u.patronymic, i.ticker_symbol, i.name_of_the_issuer, d.quantity FROM user_profiles up 
JOIN users u ON up.user_id = u.id
JOIN deals d ON d.user_id = u.id
JOIN issuers i ON i.id = d.issuer_id 
WHERE d.closed = 'no'
ORDER BY u.id;

-- Показать все портфели инвесторов

SELECT * FROM view_bags;

-- Показать портфель инвестора 5

SELECT * FROM view_bags 
WHERE id = 5;

-- Представление для отображения подробной информации по эмитенту из портфеля инвестора

SELECT * FROM issuers i;

CREATE OR REPLACE VIEW view_issuer_from_bags AS
SELECT 	u.id,
		u.firstname, 
		u.lastname, 
		u.patronymic,
		i.name_of_the_issuer,						 -- name_of_the_issuer - название эмитента
		d.quantity, 								 -- quantity - количество ценных бумаг
		i.price,									 -- price - текущая цена на рынке
		d.price AS book_price,						 -- book_price - балансовая цена
		(SELECT d.quantity * i.price) AS value, 	 -- value - стоимость
		(SELECT d.quantity * d.price) AS book_value, -- book_value - балансовая стоимость
		(SELECT book_value - value) AS revaluation	 -- revaluation - переоценка (за всё время)
FROM  issuers i  
JOIN deals d ON i.id = d.issuer_id
JOIN users u ON u.id = d.user_id
WHERE d.closed = 'no' AND u.id = 4
ORDER BY u.id;

SELECT * FROM view_issuer_from_bags;

-- Представление, показывающее историю сделок с ценными бумагами по выбранному инвестору (например инвестор номер 4)

CREATE OR REPLACE VIEW view_history_deals AS
SELECT CONCAT(u.firstname, ' ', u.lastname, ' ', u.patronymic) AS name, i.name_of_the_issuer, d.deal, d.quantity, d.price, (SELECT d.quantity * d.price) AS book_value FROM deals d
INNER JOIN issuers i ON d.issuer_id = i.id
INNER JOIN users u ON u.id = d.user_id 
WHERE u.id = 4;

SELECT * FROM view_history_deals;
