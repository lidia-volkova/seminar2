/* Задача 1
Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
*/
CREATE DATABASE if not exists seminar2;
USE seminar2;

DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS sales
(id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
VALUES 
	('2022-01-01', 156),
	('2022-01-02', 180),
	('2022-01-03', 21),
	('2022-01-04', 124),
	('2022-01-05', 341);


/* Задача 2
Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300 (функция IF).
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/
SELECT
id AS 'id заказа',
IF (count_product<100,'Маленький заказ',IF(count_product>300,'Большой заказ','Средний заказ')) AS 'Тип заказа'
FROM sales;


/* Задача 3
Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders
(id INT PRIMARY KEY AUTO_INCREMENT,
employee_id VARCHAR(3) NOT NULL,
amount DECIMAL(5,2) NOT NULL,
order_status VARCHAR(10) NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e03', 15.00, 'OPEN'),
	('e01', 25.50, 'OPEN'),
	('e05', 100.70, 'CLOSED'),
	('e02', 22.18, 'OPEN'),
	('e04', 9.50, 'CANCELLED');

SELECT *, 
CASE 
    WHEN order_status = 'OPEN' THEN "Order is in open state"
    WHEN order_status = 'CLOSED' THEN "Order is closed"
    WHEN order_status = 'CANCELLED' THEN "Order is cancelled"
    ELSE "Unknown order state"
END AS full_order_status
FROM orders;


/* Задача 4
Чем NULL отличается от 0?
*/
 0 - число, обозначающее количество.
 NULL - отсутствие информации