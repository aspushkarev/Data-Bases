USE broker;

-- Добавляем нового инвестора через процедуру и транзакцию

DROP PROCEDURE IF EXISTS add_new_investor;

DELIMITER //

CREATE PROCEDURE add_new_investor (firstname VARCHAR(50), lastname VARCHAR(50), patronymic VARCHAR(50),
birthday DATE, gender enum('мужской', 'женский'), citizenship VARCHAR(30), login VARCHAR(30), 
password_hash CHAR(55), phone CHAR(11), email VARCHAR(120), number_of_contract CHAR(10), date_of_contract DATETIME, 
brokerage_account CHAR(15), individual_investment_account CHAR(15), invest_profile_id INT, qualifying_investor_status ENUM('FALSE','TRUE'), OUT tran_result VARCHAR(200))
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100); 
	
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET tran_rollback := 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result := CONCAT(code, ': ', error_string);
	END;

	START TRANSACTION;
	
	INSERT INTO users (firstname, lastname, patronymic, birthday, gender, citizenship)
	VALUES (firstname, lastname, patronymic, birthday, gender, citizenship);

	INSERT INTO user_profiles (user_id, login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status)
	VALUES (last_insert_id(), login, password_hash, phone, email, number_of_contract, date_of_contract, brokerage_account, individual_investment_account, invest_profile_id, qualifying_investor_status);
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result := 'Successfully!';
		COMMIT;
	END IF;
END //

DELIMITER ;

-- вызываем процедуру для добавления инвестора

CALL add_new_investor('Николай', 'Иванович', 'Махонов', '1979-12-18', 'мужской', 'Россия', 
				  'ivk', 'fkghjrasd', '89029756295', 'Mikola@mail.ru', '143532/25', '2025-12-04', '451673', '384684', 3, TRUE, @tran_result);
				 
SELECT @tran_result;

SELECT * FROM users;

SELECT * FROM user_profiles;


-- Покупка/продажа ценных бумаг через процедуру и транзакцию

DROP PROCEDURE IF EXISTS deal_stocks;

DELIMITER //

CREATE PROCEDURE deal_stocks (IN user_id BIGINT, type_of_bid_id INT, issuer_id BIGINT, deal ENUM('buy','sell'), quantity INT, price DECIMAL(11,2), currency_id INT, OUT tran_result VARCHAR(200))
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;
	DECLARE code VARCHAR(100);
	DECLARE error_string VARCHAR(100);
	DECLARE old_cash DECIMAL(11,2);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN 
		SET old_cash = (SELECT cash FROM bill_of_users bou WHERE bou.id = user_id);
		SET tran_rollback = 1;
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = CONCAT(code, ':', error_string);
	END;

	START TRANSACTION;

	INSERT INTO deals (user_id, type_of_bid_id, issuer_id, deal, quantity, price, currency_id)
	VALUES (user_id, type_of_bid_id, issuer_id, deal, quantity, price, currency_id);

	UPDATE bill_of_users
	SET cash := old_cash - (quantity * price)
	WHERE id = user_id;
	
	IF tran_rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result = 'Successfully!';
		COMMIT;
	END IF;
	
END //

DELIMITER ;

CALL deal_stocks (17, 2, 8, 'buy', 3, 94, 1, @tran_result); -- У инвестора номер 17 недостаточно кэша для покупки ценной бумаги

CALL deal_stocks (1, 2, 8, 'buy', 3, 94, 1, @tran_result); -- У инвестора под номером 1 достаточно средств для сделки. Сделка прошла успешно, изменения закомичены

SELECT @tran_result;

SELECT * FROM deals;

SELECT * FROM bill_of_users;


-- Триггер проверяет дату рождения при добавлении инвестора. Инвестор должен быть совершеннолетний

DROP TRIGGER IF EXISTS check_birthday_before_insert;

DELIMITER //

CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	IF TIMESTAMPDIFF(YEAR, NEW.birthday, CURRENT_DATE()) < 18 THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. You are don`t adult!';
	END IF;
END //

DELIMITER ;

-- При попытке вставить инвестора младше 18 лет, код выдаст ошибку '45000'

INSERT INTO users 
VALUES (DEFAULT, 'Михаил', 'Сергеевич', 'Горбачёв', '2012-11-03', 'мужской', 'Россия', DEFAULT, DEFAULT);

-- Триггер проверяет счёт при выполнении покупки или продажи ценной бумаги (после операции счёт не может быть пуст)

DROP TRIGGER IF EXISTS check_cash_after_update;

DELIMITER //

CREATE TRIGGER check_cash_after_update AFTER UPDATE ON bill_of_users
FOR EACH ROW
BEGIN 
	IF NEW.cash <= '0' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough cash. You must top up your account!';
	END IF;
END //

DELIMITER ;

-- Проверяем работу триггера. При обновлении счёта последний не должен быть меньше нуля

UPDATE bill_of_users
SET cash = 0
WHERE id = 1;