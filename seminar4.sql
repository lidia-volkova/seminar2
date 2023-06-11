--Таблица AUTO

CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES
(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', 9152222221),
(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', 9173333334),
(111116,'BMW', 'СИНИЙ', date'2015-01-01', 9173333334),
(111121,'AUDI', 'СИНИЙ', date'2009-01-01', 9173333332),
(111122,'AUDI', 'СИНИЙ', date'2011-01-01', 9213333336),
(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', 9214444444),
(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117,'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

--Задание №1. Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA

SELECT mark, color, COUNT(*) FROM auto
WHERE mark IN ('BMW', 'LADA')
GROUP BY color, mark
ORDER BY mark;

--Задание №2. Вывести на экран марку авто(количество) и количество авто не этой марки (Например: 20 BMW, остальные - 300)

--1 вариант (как-то криво, но работает :))

SELECT COUNT(*) FROM auto
WHERE mark = 'BMW'
UNION
SELECT COUNT(*) FROM auto
WHERE mark NOT IN ('BMW');

--2 вариант 

--создаём проедставления
CREATE VIEW BMW AS
SELECT COUNT(*) AS BMW FROM auto
WHERE mark = 'BMW';

CREATE VIEW other AS
SELECT COUNT(*) AS `остальные` FROM auto
WHERE mark NOT IN ('BMW');

--выводим оба представления в одну таблицу 
SELECT * FROM BMW
CROSS JOIN other;

--убираем представления
DROP VIEW BMW;

DROP VIEW other;

--использование подзапросов

SELECT
	a.mark,
	COUNT(a.mark),
	(SELECT COUNT(au.mark)
		FROM auto AS au
		WHERE a.mark != au.mark) AS `Другие`
FROM auto AS a
GROUP BY mark
HAVING a.mark = 'BMW';

--еще вариант с подзапросами

SELECT 
MARK,
COUNT(MARK) AS `число машин данной марки`,
(SELECT COUNT(MARK) FROM AUTO AS A1 WHERE A2.MARK != A1.MARK) AS `число машин других марок`
FROM AUTO AS A2
GROUP BY MARK;

--Даны 2 таблицы, созданные следующим образом:

CREATE TABLE test_a (
    id INT,
    data VARCHAR(1)
);

CREATE TABLE test_b (id INT);

INSERT INTO test_a(id, data) VALUES
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

INSERT INTO test_b(id) VALUES
(10),
(30),
(50);

--Задание №3.Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.

SELECT * FROM test_a 
LEFT JOIN test_b
ON test_b.id = test_a.id
WHERE test_b.id IS NULL;
