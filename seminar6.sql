--Задача 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов.
--Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

-- создание тестовой таблицы

DROP TABLE IF EXISTS num;
CREATE TABLE num (n BIGINT);

INSERT INTO num VALUES
(-10),
(86400),
(3600),
(60),
(0),
(9479598475);

SELECT * FROM num;

-- решение задачи

DROP FUNCTION IF EXISTS parse_seconds_to_datestring;

DELIMITER $$
CREATE FUNCTION parse_seconds_to_datestring (num BIGINT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE rez VARCHAR(50);
    DECLARE sec BIGINT;
    DECLARE min SMALLINT;
    DECLARE hrs SMALLINT;
    DECLARE dys BIGINT;
    SET rez = '';
    SET sec = 0;
    SET min = 0;
    SET hrs = 0;
    SET dys = 0;
    IF (num < 0) THEN
        SET rez = NULL;
        RETURN rez;
    END IF;
    SET dys = FLOOR(num / 86400);
    SET sec = num % 86400;
    SET hrs = FLOOR(sec / 3600);
    SET sec = sec % 3600;
    SET min = FLOOR(sec / 60);
    SET sec = sec % 60;
    SET rez = CONCAT(dys, ' days ', hrs, ' hours ', min, ' minutes ', sec, ' seconds ');
RETURN rez;
END $$
DELIMITER ;

SELECT n, parse_seconds_to_datestring(n) from num;

--Задача 2.	Выведите только четные числа от 1 до 10 включительно.
--Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)

DROP FUNCTION IF EXISTS nums;
DELIMITER $$
CREATE FUNCTION nums() RETURNS VARCHAR(50)
DETERMINISTIC
  BEGIN
    DECLARE i INT;
        DECLARE str VARCHAR(50);
        SET str = ' ';
    SET i = 2;
    WHILE i < 11 DO
      SET str = CONCAT(str, ' ', i);
            SET i = i + 2;
    END WHILE;
RETURN str;
END $$
DELIMITER ;
SELECT nums();


DELIMITER $$
CREATE PROCEDURE nums()
  BEGIN
    DECLARE i INT;
    SET i = 2;
    CREATE TEMPORARY TABLE nums (numbers int);
    WHILE i < 11 DO
      INSERT INTO nums VALUES (i);
      SET i = i + 2;
    END WHILE;
    SELECT * FROM nums;
    DROP TABLE IF EXISTS nums;
END $$
DELIMITER ;

CALL nums();


DROP PROCEDURE nums;




-- 1 вариант решения - процедура с входным параметром, 
-- определение четности числа в цикле, 
-- создание и заполнение временной таблицы и ее вывод

DROP PROCEDURE IF EXISTS get_even_numbers;

DELIMITER $$
CREATE PROCEDURE get_even_numbers (IN num INT)
BEGIN
    DECLARE i INT;  
    SET i = 1;
    CREATE TEMPORARY TABLE nums (numbers int);
    WHILE i <= num DO
        IF (i % 2 = 0)
        THEN
            INSERT INTO nums VALUES (i);
        END IF;
        SET i = i + 1;    
    END WHILE;
    SELECT * FROM nums;
    DROP TABLE IF EXISTS nums;
END $$
DELIMITER ;

CALL get_even_numbers(10);

-- 2 вариант решения - вывод в строку

DROP PROCEDURE IF EXISTS get_even_numbers2;

DELIMITER $$
CREATE PROCEDURE get_even_numbers2 ()
BEGIN
    DECLARE i INT;
    DECLARE rez VARCHAR(50);
    SET i = 4;
    SET rez = '2';    
    WHILE i <= 10 DO
        SET rez = CONCAT(rez, ', ', i);        
        SET i = i + 2;    
    END WHILE;
    SELECT rez;
END $$
DELIMITER ;

CALL get_even_numbers2();