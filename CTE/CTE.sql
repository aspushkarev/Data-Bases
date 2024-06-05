DROP TABLE IF EXISTS statistics;

CREATE TABLE statistics (
	player_name VARCHAR (100) NOT NULL,
	player_id INT NOT NULL,
	year_game SMALLINT NOT NULL CHECK(year_game > 0),
	points DECIMAL(12,2) CHECK(points >= 0),
	PRIMARY KEY(player_name, year_game)
);

INSERT INTO statistics (player_name, player_id, year_game, points)
VALUES ('Mike',1,2018,18), 
('Jack',2,2018,14), 
('Jackie',3,2018,30), 
('Jet',4,2018,30), 
('Luke',1,2019,16), 
('Mike',2,2019,14), 
('Jack',3,2019,15), 
('Jackie',4,2019,28), 
('Jet',5,2019,25), 
('Luke',1,2020,19),
('Mike',2,2020,17), 
('Jack',3,2020,18), 
('Jackie',4,2020,29), 
('Jet',5,2020,27)
RETURNING *;

SELECT * FROM statistics;

-- запрос суммы очков с группировкой и сортировкой по годам

SELECT year_game, SUM(points) FROM statistics
GROUP BY year_game
ORDER BY year_game ASC;

SELECT year_game, SUM(points) FROM statistics
GROUP BY GROUPING SETS (year_game);

SELECT year_game, SUM(points) FROM statistics
GROUP BY GROUPING SETS (year_game)
ORDER BY year_game;

-- с ИТОГО в конце
SELECT year_game, SUM(points) FROM statistics
GROUP BY ROLLUP (year_game)
ORDER BY (year_game);

-- cte показывающее тоже самое

SELECT DISTINCT year_game FROM statistics
	ORDER BY year_game ASC;
	
WITH my_cte AS (
	SELECT player_id, year_game, points FROM statistics
	GROUP BY player_id, year_game, points
)
SELECT st.year_game, SUM(st.points)
FROM statistics AS st
	LEFT JOIN my_cte ON my_cte.player_id IN (SELECT DISTINCT year_game FROM statistics
						 						ORDER BY year_game ASC)
GROUP BY st.year_game
ORDER BY st.year_game;

-- используя функцию LAG вывести кол-во очков по всем игрокам за текущий год и за предыдущий

SELECT player_name, points, year_game, LAG(points, 1) OVER (ORDER BY year_game) AS previous_year_game
FROM statistics
GROUP BY player_name, year_game;

-- то же самое, но другой синтаксис
SELECT player_name, points, year_game, LAG(points, 1) OVER w AS previous_year_game
FROM statistics
WINDOW w AS (ORDER BY year_game);
