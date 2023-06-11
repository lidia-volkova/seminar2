--1.	Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE VIEW cheap_cars AS
SELECT * FROM cars WHERE cost < 25000;

SELECT * FROM cheap_cars;

--2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW cheap_cars AS
SELECT * FROM cars WHERE cost < 30000;

SELECT * FROM cheap_cars;

DROP VIEW cheap_cars;

--3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW skoda_audi AS
SELECT * FROM cars WHERE name IN ('Skoda', 'Audi');

SELECT * FROM skoda_audi;

DROP VIEW skoda_audi;

--Задача 2
--Таблица Groupss

CREATE TABLE Groupss
(
    gr_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    gr_name VARCHAR(50) NOT NULL,    
    gr_temp INT NOT NULL
);

INSERT INTO Groupss (gr_name, gr_temp) VALUES
('Замороженные', -10),
('Нормальной температуры', 18),
('Теплые', 37);

SELECT * FROM Groupss;

DROP TABLE Groupss;

--Таблица Analysis

CREATE TABLE Analysis
(
    an_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    an_name VARCHAR(255) NOT NULL,
    an_cost DECIMAL(10,2) NOT NULL,
    an_price DECIMAL(10,2) NOT NULL,
    an_group INT NOT NULL,
    FOREIGN KEY (an_group) REFERENCES Groupss (gr_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Analysis (an_name, an_cost, an_price, an_group) VALUES
('Анализ1', 15.6, 31.2, 2),
('Анализ2', 18.2, 27.5, 2),
('Анализ3', 20.8, 50.0, 3),
('Анализ4', 8.4, 12, 2),
('Анализ5', 17.6, 34.2, 1),
('Анализ6', 78.2, 160.3, 3),
('Анализ7', 15.2, 30.2, 1),
('Анализ8', 45.8, 90.7, 3),
('Анализ9', 86.3, 152.4, 1),
('Анализ10', 5.3, 10.6, 3),
('Анализ11', 12.5, 25.1, 1),
('Анализ12', 21.3, 44.5, 1);

SELECT * FROM Analysis;

DROP TABLE Analysis;

--Таблица Orders

CREATE TABLE Orders
(
    ord_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ord_datetime DATETIME NOT NULL,    
    ord_an INT NOT NULL,
    FOREIGN KEY (ord_an) REFERENCES Analysis (an_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (ord_datetime, ord_an) VALUES
  ("2020-02-05 10:37:27",4),--
  ("2021-10-04 04:37:19",9),
  ("2022-10-04 09:00:17",11),
  ("2020-10-04 10:56:30",4),
  ("2021-10-04 07:56:53",6),
  ("2022-10-04 01:10:53",3),
  ("2020-02-05 06:29:24",8),--
  ("2021-10-04 10:47:16",4),
  ("2022-10-04 11:38:19",10),
  ("2022-10-04 02:09:52",9);

INSERT INTO Orders (ord_datetime, ord_an) VALUES
  ("2020-10-04 06:29:44",7),
  ("2020-10-04 06:40:23",8),
  ("2022-10-04 10:00:30",11),
  ("2020-02-06 05:21:14",10),--
  ("2021-10-04 09:38:43",2),
  ("2022-10-04 04:38:05",10),
  ("2020-02-11 08:40:40",3),--
  ("2021-10-04 10:02:17",4),
  ("2020-02-12 02:23:38",3),--
  ("2020-02-10 10:14:58",8);--

SELECT * FROM Orders;

DROP TABLE Orders;

--Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT an_name AS `Название анализа`,an_cost AS `Себестоимость` , an_price AS `Цена(розничная)` FROM Analysis an
JOIN Orders o
ON an.an_id = o.ord_an
WHERE 
(
    DAYOFYEAR(o.ord_datetime) BETWEEN DAYOFYEAR('2020-02-05') AND (DAYOFYEAR('2020-02-05') + 7) 
    AND YEAR(o.ord_datetime) = YEAR('2020-02-05')
);

-- Задача 3
--Таблица train_schedule

CREATE TABLE train_schedule
(
    train_id INT NOT NULL,
    stantion VARCHAR(50) NOT NULL,    
    stantion_time TIME NOT NULL
);

INSERT INTO train_schedule (train_id, stantion, stantion_time) VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose', '13:30:00');

SELECT * FROM train_schedule;

DROP TABLE train_schedule;

-- Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, 
-- мы вычитаем время станций для пар смежных станций. 
-- Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
-- Проще это сделать с помощью оконной функции LEAD . 
-- Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
-- В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.

WITH ts AS
(
  SELECT 
    *,
    LEAD(stantion_time) OVER(PARTITION BY train_id) AS next_stantion_time
  FROM train_schedule
)
SELECT
    train_id AS `Номер поезда`,
    stantion AS `Станция`, 
    stantion_time AS `Время убытия`,    
    TIMEDIFF(next_stantion_time, stantion_time) AS `Время в пути`
FROM ts;