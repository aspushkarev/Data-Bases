CREATE DATABASE db_broker;

CREATE SCHEMA IF NOT EXISTS broker_schema;

CREATE USER alexander WITH PASSWORD 'alexander';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA broker_schema TO "alexander"; 
ALTER DEFAULT PRIVILEGES GRANT SELECT ON TABLES TO alexander;

CREATE TYPE gender AS ENUM('мужской', 'женский');

DROP TABLE IF EXISTS broker_schema.users;
CREATE TABLE broker_schema.users (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	patronymic VARCHAR(50) NOT NULL,
	birthday DATE NOT NULL,
	current_gender gender NOT NULL,
	citizenship VARCHAR(30) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO broker_schema.users 
VALUES (DEFAULT, 'Рустем', 'Флюрович', 'Габдрашитов', '1984-11-03', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Михаил', 'Николаевич', 'Горбунов', '1989-09-12', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Павел', 'Михайлович', 'Артеменко', '1965-08-26', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Павел', 'Николаевич', 'Колмогоров', '1961-03-21', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Сергей', 'Сергеевич', 'Дегтярёв', '1975-07-08', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Алина', 'Талгатовна', 'Зарипова', '1993-04-14', 'женский', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Артём', 'Сергеевич', 'Волгин', '1992-01-25', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Илья', 'Николаевич', 'Юдин', '1990-07-19', 'мужской', 'Россия', DEFAULT, DEFAULT),
(DEFAULT, 'Константин', 'Васильевич', 'Кособрюхов', '1980-02-18', 'мужской', 'Россия', DEFAULT, DEFAULT);

DROP TABLE IF EXISTS broker_schema.invest_profiles;
CREATE TABLE broker_schema.invest_profiles (
	id SERIAL PRIMARY KEY,
	name_profile VARCHAR(50) NOT NULL UNIQUE,
	description TEXT NOT NULL
);

INSERT INTO broker_schema.invest_profiles (id, name_profile, description)
VALUES (DEFAULT, 'Консервативный', 'Ваша цель - сохранение и защита капитала. Вы готовы размещать средства только в консервативные инструменты. Доходы предполагаются на уровне или чуть выше существующих процентных ставок по депозитам в соответствующей валюте. Однако доходность носит вероятностный характер, она скорее ожидаемая, чем гарантированная.'),
(DEFAULT, 'Умеренно консервативный', 'Вы готовы принять разумный уровень инвестиционного риска в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +2-5% годовых в рублях и/или +2-5% в долларах США. В этом случае стоимость капитала может колебаться, а также упасть ниже суммы Ваших первоначальных инвестиций.'),
(DEFAULT, 'Рациональный', 'Вы готовы принять умеренно высокий уровень инвестиционного риска и колебаний стоимости в кратко- и среднесрочной перспективе в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +5-8% годовых в рублях и/или +5-8% в доллорах США. Стоимость капитала может колебаться, а также упасть ниже сыммы Ваших первоначальных инвестиций'),
(DEFAULT, 'Умеренно агрессивный', 'Вы готовы принять высокий уровень инвестиционного риска и колебаний стоимости в кратко- и среднесрочной перспективе в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +8-13% годовых в рублях и/или +8-12% в доллорах США. Стоимость капитала может колебаться, а также упасть ниже суммы Ваших первоначальных инвестиций в течение некоторго периода времени.'),
(DEFAULT, 'Агрессивный', 'Вы готовы принять высокий уровень инвестиционного риска и колебаний стоимости на инвестиционном горизонте в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +13-18% годовых в рублях и/или +12-16% в доллорах США. Стоимость капитала может колебаться, а также упасть существенно ниже суммы Ваших первоначальных инвестиций на инвестиционном горизонте.'),
(DEFAULT, 'Сверхагрессивный', 'Вы готовы принять крайне высокий уровень инвестиционного  риска и колебаний стоимости на инвестиционном горизонте в обмен на потенциальную возможность получить доход на уровне существующих процентных ставок по депозитам +18% и выше годовых в рублях и/или +16% и выше в доллорах США. Вы можете самостоятельно определять и контролировать уровень инвестиционного риска и вероятной доходности, но, в случае ряда неудачных решений (сделок), возможно, с использованием "плеча" и производных финансовых инструментов, Ваши потери могут составлять на уровне 60% от первоначальных инвестиций.'),
(DEFAULT, 'Профессиональный', 'Вы готовы самостоятельно оценивать и контролировать уровень инвестиционных рисков и брать на себя все риски без ограничений, в том числе маржинальные, и, таким образом, осознаёте, что в случае ряда неудачных сделок, возможно с использованием "плеча" и производных финансовых инструментов, Ваши потери могут составить 100% и даже более от суммы первоначальных инвестиций.');

CREATE TYPE qualifying_investor_status AS ENUM('FALSE', 'TRUE');

DROP TABLE IF EXISTS broker_schema.user_profiles;
CREATE TABLE broker_schema.user_profiles (
	id SERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	login VARCHAR(30) NOT NULL UNIQUE,
	password_hash CHAR(55) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	email VARCHAR(120) NOT NULL UNIQUE,
	number_of_contract CHAR(10) NOT NULL UNIQUE,
	date_of_contract TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	brokerage_account CHAR(15) NOT NULL UNIQUE,
	individual_investment_account CHAR(15) UNIQUE,
	invest_profile_id INT NOT NULL,
	qualifying_investor_status qualifying_investor_status NOT NULL DEFAULT 'FALSE',
	FOREIGN KEY (user_id) REFERENCES broker_schema.users (id),
	FOREIGN KEY (invest_profile_id) REFERENCES broker_schema.invest_profiles (id)
);

INSERT INTO broker_schema.user_profiles 
VALUES (DEFAULT, 1, 'asdf', '78bf69kgrejj7h3', '89039992799', 'psashok@mail.ru', '451361/21', DEFAULT, '451396', NULL, 4, 'FALSE'),
(DEFAULT, 2, 'qwer', 'hiujhrgrejj7h3', '89039992794', 'psashok2@mail.ru', '451391/21', DEFAULT, '451986', '345674', 5, 'FALSE'),
(DEFAULT, 3, 'zaqw', 'khd38vngty0te', '89039992797', 'kolya@mail.ru', '589732/19', DEFAULT, '451929', '345639', 7, 'FALSE'),
(DEFAULT, 4, 'wsdf', 'hjloe8nbh73f8', '89039692794', 'petya@mail.ru', '389571/13', DEFAULT, '419985', '396678', 1, 'FALSE'),
(DEFAULT, 5, 'frhe', 'mkdyhs9jeuof7', '89039792794', 'pavel@mail.ru', '123456/22', DEFAULT, '459685', NULL, 7, DEFAULT),
(DEFAULT, 6, 'fkeq', 'bspq8mdie8vr3', '89037422771', 'nikolay@mail.ru', '567392/26', DEFAULT, '452894', '345973', 4, 'TRUE'),
(DEFAULT, 7, 'krql', 'meomfkys18d9k', '89039992794', 'aleksey@mail.ru', '289460/18', DEFAULT, '451893', '345206', 6, DEFAULT),
(DEFAULT, 8, 'gklo', 'noe9nf8rz0#sq', '89996392644', 'boris@mail.ru', '1852743/15', DEFAULT, '192837', NULL, 5, 'TRUE'),
(DEFAULT, 9, 'aky3', 'do0h7m5j8f32s', '89124685420', 'anton@mail.ru', '495871/17', DEFAULT, '428764', NULL, 2, 'FALSE');

DROP TABLE IF EXISTS broker_schema.currencys;
CREATE TABLE broker_schema.currencys (
	id SERIAL PRIMARY KEY,
	symbol CHAR(1) NOT NULL,
	abbreviation CHAR(3) NOT NULL,
	description VARCHAR(20) NOT NULL
);

INSERT INTO broker_schema.currencys 
VALUES (DEFAULT, '$', 'USD', 'Американский доллар'),
(DEFAULT, '₽', 'RUB', 'Российский рубль'),
(DEFAULT, '€', 'EUR', 'Евро'),
(DEFAULT, '$', 'CND', 'Канадский доллар'),
(DEFAULT, '£', 'GBP', 'Фунт стерлингов'),
(DEFAULT, '¥', 'JPY', 'Японская иена'),
(DEFAULT, '₣', 'CHF', 'Швейцарский франк'),
(DEFAULT, '¥', 'CNY', 'Китайский юань');

DROP TABLE IF EXISTS broker_schema.bill_of_users;
CREATE TABLE broker_schema.bill_of_users (
	id SERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	cash DECIMAL (11,2),
	currency_id INT,
	FOREIGN KEY (user_id) REFERENCES broker_schema.users (id),
	FOREIGN KEY (currency_id) REFERENCES broker_schema.currencys (id)
);

INSERT INTO broker_schema.bill_of_users 
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

DROP TABLE IF EXISTS broker_schema.markets;
CREATE TABLE broker_schema.markets (
	id SERIAL PRIMARY KEY,
	type_market VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO broker_schema.markets (id, type_market)
VALUES (DEFAULT, 'Российский'),
(DEFAULT, 'Зарубежные');

DROP TABLE IF EXISTS broker_schema.issuer;
CREATE TABLE broker_schema.issuer (
	id SERIAL PRIMARY KEY,
	ticker_symbol CHAR(5) NOT NULL UNIQUE,
	name_of_the_issuer VARCHAR(30) NOT NULL UNIQUE,
	price DECIMAL (11,2),
	market_id INT NOT NULL,
	info_about_issuer TEXT NOT NULL,
	FOREIGN KEY (market_id) REFERENCES broker_schema.markets (id)
);

INSERT INTO broker_schema.issuer 
VALUES (DEFAULT, 'AAPL','Apple', 125, 2, 'Apple — американская корпорация из Купертино, инновационный лидер рынка гаджетов. Работает в премиум-сегменте. Создатель iPhone, iPod, iPad, Apple Watch, Apple TV, хранилища iCloud, технологии бесконтактной оплаты Apple Pay и собственного программного обеспечения: операционных систем iOS и MacOS.'),
(DEFAULT, 'AYX', 'Alteryx Class A', 1259, 2, 'Alteryx Inc. («Элтерикс Инк.») является компанией, разрабатывающей программное обеспечение для самостоятельной аналитики данных. Компания предоставляет платформу на условиях подписки, позволяющую организациям подготавливать, объединять и анализировать данные из множества источников, что облегчает принятие решений на основе таких данных. Компания упрощает доступ к аналитической информации, основанной на данных, для всех специалистов по обработке данных, бизнес-аналитиков, программистов и специалистов по анализу данных за счет расширения функционала и аналитических инструментов. Платформа Компании позволяет бизнес-аналитикам просматривать базовые данные, метаданные и использовать прикладные аналитические инструменты на любом этапе процесса. Платформа Компании предназначена для взаимодействия с широким ассортиментом традиционных источников данных. Платформа также способна обрабатывать данные из облачных приложений, например, Google Analytics, Marketo, NetSuite, Salesforce и Workday, а также платформ социальных сетей Facebook и Twitter. Платформа Компании состоит из компонентов Alteryx Designer, Alteryx Server, Alteryx Connect и Alteryx Promote.'),
(DEFAULT, 'MU', 'Micron Technology', 18.7, 2, 'Micron Technology — американская транснациональная корпорация, производитель чипов памяти и флеш-накопителей. По данным 2019 года, занимает 4 место в списке крупнейших мировых производителей микроэлектронных компонентов.'),
(DEFAULT, 'MSFT', 'Microsoft', 45, 2, 'Microsoft — американская корпорация, создатель программного обеспечения для компьютеров, игровых приставок и офисных приложений. Разработчик Windows и Xbox. В апреле 2021 года Microsoft получила десятилетний контракт на поставку устройств дополненной реальности для армии США.'),
(DEFAULT, 'INTC', 'Intel', 16, 2, 'Intel — американская компания, самый крупный в мире разработчик микропроцессоров и чипсетов (наборов микросхем). Занимает 75% рынка в своём сегменте. Продукцию компании используют Dell, HP, Lenovo.'),
(DEFAULT, 'GAZP', 'Газпром', 163, 1, 'ПАО «Газпром» — глобальная энергетическая компания, располагает самыми богатыми в мире запасами природного газа. Доля компании в мировых запасах составляет 17%, в российских — 72%. Основные направления деятельности — геологоразведка, добыча, транспортировка, хранение, переработка и реализация газа, газового конденсата и нефти, реализация газа в качестве моторного топлива, а также производство и сбыт тепло- и электроэнергии. В структуру компании входят такие публичные эмитенты как Газпром нефть, Мосэнерго, ТГК-1, ОГК-2. Дивиденды: Компания стремится с 2021 г. выплачивать дивиденды в размере 50% чистой прибыли по МСФО с учетом «неденежных» корректировок. Если долговая нагрузка Группы превысит уровень 2,5 по коэффициенту «Чистый долг/EBITDA», совет директоров имеет возможность предложить размер дивидендов ниже целевых уровней.'),
(DEFAULT, 'SBER', 'Сбербанк', 370, 1, 'Сбербанк — один из системообразующих банков российской банковской системы, крупнейшая кредитная организация по размеру активов в РФ. Сбербанк занимает более 30% от банковской системы РФ и выступает главным аккумулятором средств клиентов. В секторе кредитования на долю банка приходится свыше 40% от общего выданных займов, а клиентская база насчитывает более миллиона предприятий. В региональную сеть СберБанка входят 11 территориальных банков с 14 080 подразделениями в 83 субъектах РФ Банк активно реализует инновационные программы в финансовой сфере и выступает одним из наиболее передовых представителей отрасли. В структуре группы Сбербанка присутствует множество лабораторий, специализирующихся на развитии технологической базы организации. Кроме того, компания присутствует в таких сегментах бизнеса как торговля недвижимостью, медицинские услуги, электронная коммерция. Амбиции Стратегии 2023: Рентабельность выше 17% Достаточность базового капитала (Common Equity Tier 1) >12,5% Уровень дивидендных выплат — 50% от чистой прибыли Дисциплина в управлении расходами и стоимостью риска Рост выручки от нефинансовых сервисов — более 100% ежегодно Топ-3 на рынке электронной коммерции'),
(DEFAULT, 'LKOH', 'ЛУКОЙЛ', 7450, 1, 'ЛУКОЙЛ — одна из крупнейших вертикально интегрированных нефтегазовых компаний в мире, на долю которой приходится более 2% мировой добычи нефти и около 1% доказанных запасов углеводородов. Большая часть углеводородных запасов компании приходится на месторождения в Западной Сибири. ЛУКОЙЛ занимает одну из главных позиций на мировом рынке производства нефтепродуктов и нефтехимии, поставляя свою продукцию в 27 стран мира. Компания является полностью вертикально-интегрированной, контролируя всю производственную цепочку — от добычи нефти и газа до сбыта нефтепродуктов. 88% запасов и 83% добычи углеводородов приходится на Российскую Федерацию, при этом основная деятельность сосредоточена на территории 4-х федеральных округов — Северо-Западного, Приволжского, Уральского и Южного. В 2017 г. Совет директоров утвердил программу стратегического развития группы «ЛУКОЙЛ» на 2018–2027 г. Стратегия направлена на устойчивый рост ключевых показателей и выполнение прогрессивной дивидендной политики при консервативном сценарии цены на нефть, а также на дополнительное развитие бизнеса и распределение средств акционерам в случае более благоприятной конъюнктуры. Одним из приоритетов компании является устойчивый рост дивидендов не менее чем на уровень рублевой инфляции. Средний ежегодный темп прироста дивидендных выплат составляет 15%.'),
(DEFAULT, 'GMKN', 'ГМК Норникель', 160, 1, 'Норильский никель — крупнейший в мире производитель никеля и палладия, один из крупнейших в мире производителей платины и меди. Компания также производит кобальт, родий, серебро, золото, иридий, рутений, селен, теллур и серу. Основные виды деятельности: - поиск, разведка, добыча, обогащение и переработка полезных ископаемых; - производство, маркетинг и реализация цветных и драгоценных металлов. Норильский никель развивает стратегическое партнерство более чем в 30 странах. Потребителями продукции являются порядка 400 компаний-партнеров. В России основными производственными подразделениями группы являются следующие вертикально интегрированные предприятия: - Заполярный филиал ПАО «ГМК «Норильский никель»; - АО «Кольская горно-металлургическая компания». Стратегия компании подразумевает развитие приоритетных первоклассных активов, модернизацию действующих активов для повышения эффективности и создание новых экологичных и безопасных производственных мощностей.'),
(DEFAULT, 'ROSN', 'Роснефть', 340, 1, 'ПАО «НК «Роснефть» — лидер российской нефтяной отрасли и крупнейшая публичная нефтегазовая корпорация мира. Для обеспечения устойчивого роста добычи в долгосрочной перспективе Роснефть активно расширяет свою ресурсную базу за счет геологоразведочных работ и новых приобретений. Основными видами деятельности Роснефти являются: - поиск и разведка месторождений углеводородов; - добыча нефти, газа, газового конденсата; - реализация проектов по освоению морских месторождений; - переработка добытого сырья; - реализация нефти, газа и продуктов их переработки на территории России и за ее пределами. Компания удерживает лидирующие позиции по добыче и переработки нефти в российском нефтегазовом секторе. На ее долю приходится 40% от годовой добычи нефти и 35% переработки на территории РФ. На мировом рынке Роснефть входит в число крупнейших представителей отрасли с 6% от мировой добычи. К существенным преимуществам компании относится широкая розничная сбытовая сеть, а также наличие собственных экспортных терминалов как в России, так и за рубежом.'),
(DEFAULT, 'VTBR', 'ВТБ', 0.1, 1, 'ВТБ — российский коммерческий банк c государственным участием. Второй по величине активов банк страны и первый по размеру уставного капитала. Основным акционером Банка является Российская Федерация, которой в лице Росимущества принадлежит 60,9% голосующих акций, или 47,2% (с учетом ГК Агентство по страхованию вкладов — 92,23%) от уставного капитала Банка. Сеть банка формируют свыше 1000 офисов в 75 регионах страны. В числе предоставляемых услуг: выпуск банковских карт, ипотечное и потребительское кредитование, автокредитование, услуги дистанционного управления счетами, кредитные карты с льготным периодом, срочные вклады, аренда сейфовых ячеек, денежные переводы. Часть услуг доступна клиентам в круглосуточном режиме, для чего используются современные телекоммуникационные технологии. Группа является стратегическим холдингом, предусматривая единую стратегию развития компаний всей группы в рамках единого бренда, централизованного финансового менеджмента и управления рисками, а также унифицированных систем контроля.');

DROP TABLE IF EXISTS broker_schema.bounds;
CREATE TABLE broker_schema.bounds (
	id SERIAL PRIMARY KEY,
	simbol VARCHAR(15) NOT NULL,
	name_of_the_issuer VARCHAR(30) NOT NULL,
	info_about_issuer TEXT NOT NULL,
	maturity_date DATE NOT NULL,
	profitability VARCHAR(5),
	market_id INT NOT NULL,
	FOREIGN KEY (market_id) REFERENCES broker_schema.markets (id)
);

INSERT INTO broker_schema.bounds 
VALUES (DEFAULT, 'SU26215RMFS2', 'ОФЗ-26215', 'Наименование: МинФин РФ, облигации федерального займа с постоянным купонным доходом, документарные именные, выпуск 26215', '2023-08-16', '8,11%', 1),
(DEFAULT, 'RU000A0JXRV7', 'Альфа-Банк-20-боб', 'Наименование: "Альфа-Банк" АО, биржевые облигации процентные документарные на предъявителя, серии БО-20', '2032-11-05', '7,0%', 1),
(DEFAULT, 'Газпнф1P3R', 'RU000A0ZYDS7', 'Наименование: "Газпром нефть" ПАО, биржевые облигации документарные на предъявителя, серии 001P-03R', '2022-10-17', '7,62%', 1),
(DEFAULT, 'ГПБ БО-19', 'RU000A0ZYRY5', 'Наименование: "Газпромбанк" АО, облигации биржевые процентные документарные на предъявителя, серия БО-19', '2023-12-02', '6,08%', 1),
(DEFAULT, 'ГТЛК 1P-04', 'RU000A0JXPG2', 'Наименование: "Государственная транспортная лизинговая компания" ПАО, облигации биржевые процентные документарные на предъявителя, серии 001Р-04', '2030-10-08', '9,3%', 1),
(DEFAULT, 'ИКС5Фин1P3', 'RU000A0ZZ083', 'Наименование: "ИКС 5 ФИНАНС" ООО, облигации биржевые процентные документарные на предъявителя, серии 001P-03', '2030-09-10', '1,23%', 1),
(DEFAULT, 'ЛСР БО 1P2', 'RU000A0JXPM0', 'Наименование: "Группа ЛСР" ПАО, биржевые облигации документарные на предъявителя, серии БО-001P-02', '2022-04-20', '6,87%', 1),
(DEFAULT, 'МТС 001P-3', 'RU000A0ZYFC6', 'Наименование: "Мобильные ТелеСистемы", ПАО, биржевые облигации документарные на предъявителя, серии 001P-03', '2022-11-03', '8,37%',1 ),
(DEFAULT, 'ОГК-2 1P3R', 'RU000A0ZZ1H2', 'Наименование: "Вторая генерирующая компания оптового рынка электроэнергии", ПАО, облигации биржевые процентные документарные на предъявителя серии 001P-03R', '2023-03-21', '6,72%', 1),
(DEFAULT, 'РЖД 1P-07R', 'RU000A0ZZ9R4', 'Наименование: "РЖД" ОАО, биржевые облигации документарные на предъявителя, серии 001P-07R', '2033-05-26', '8,97%', 1);

DROP TABLE IF EXISTS broker_schema.type_of_bids;
CREATE TABLE broker_schema.type_of_bids (
	id SERIAL PRIMARY KEY,
	types VARCHAR(15) NOT NULL UNIQUE,
	description TEXT NOT NULL
);

INSERT INTO broker_schema.type_of_bids 
VALUES (DEFAULT, 'Лимитная', 'Купить не дороже указанной цены'),
(DEFAULT, 'Рыночная', 'Купить по рыночной цене'),
(DEFAULT, 'Стоп-лимит', 'Если цена вырастет до указанной, выставить лимитную заявку на покупку'),
(DEFAULT, 'Тейк-профит', 'Если цена упадёт до указанной, выставить лимитную заявку на покупку'),
(DEFAULT, 'Стоп-лосс', 'Если цена вырастет до указанной, купить по рыночной цене');

CREATE TYPE deal AS ENUM('buy', 'sell');
CREATE TYPE closed AS ENUM ('yes', 'no');

DROP TABLE IF EXISTS broker_schema.deals;
CREATE TABLE broker_schema.deals (
	id SERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	type_of_bid_id INT NOT NULL,
	issuer_id BIGINT NOT NULL,
	deal deal NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL (11,2),
	currency_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	closed closed DEFAULT 'no',
	FOREIGN KEY (user_id) REFERENCES broker_schema.users (id),
	FOREIGN KEY (type_of_bid_id) REFERENCES broker_schema.type_of_bids (id),
	FOREIGN KEY (issuer_id) REFERENCES broker_schema.issuer (id),
	FOREIGN KEY (currency_id) REFERENCES broker_schema.currencys (id)
);

INSERT INTO broker_schema.deals
VALUES (DEFAULT, 1, 2, 6, 'buy', 7, 125, 2, DEFAULT, DEFAULT),
(DEFAULT, 2, 2, 1, 'buy', 15, 1230, 2, DEFAULT, DEFAULT),
(DEFAULT, 7, 3, 8, 'buy', 99, 12, 1, DEFAULT, DEFAULT),
(DEFAULT, 5, 2, 10, 'buy', 1, 2378, 2, DEFAULT, DEFAULT),
(DEFAULT, 3, 1, 5, 'sell', 3, 11, 1, DEFAULT, DEFAULT),
(DEFAULT, 4, 1, 6, 'buy', 128, '2456.8', 2, DEFAULT, DEFAULT),
(DEFAULT, 4, 2, 6, 'sell', 128, 2600, 2, DEFAULT, 'yes'),
(DEFAULT, 1, 2, 2, 'sell', 7, 230, 2, DEFAULT, 'yes'),
(DEFAULT, 2, 1, 1, 'sell', 15, 1258, 2, DEFAULT, 'yes'),
(DEFAULT, 7, 3, 8, 'sell', 90, 15, 1, DEFAULT, DEFAULT),
(DEFAULT, 5, 2, 7, 'buy', 14, 58, 2, DEFAULT, DEFAULT),
(DEFAULT, 8, 2, 2, 'sell', 77, 125, 2, DEFAULT, DEFAULT),
(DEFAULT, 1, 4, 9, 'buy', 70, 22, 2, DEFAULT, DEFAULT),
(DEFAULT, 9, 5, 2, 'buy', 42, 15, 2, DEFAULT, DEFAULT),
(DEFAULT, 10, 3, 8, 'sell', 37, 34, 2, DEFAULT, DEFAULT),
(DEFAULT, 2, 2, 1, 'buy', 19, 58, 2, DEFAULT, DEFAULT);

