-- Напишите запрос который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm.
-- (к первой или второй таблице, используя SELECT)
select city,sname,snum,comm from salespeople;

-- Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose.
-- (“заказчики”)
select rating, cname from customers;

-- Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений.
-- (уникальные значения в  “snum“ “Продавцы”)
select snum from salespeople
group by sname;

-- Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G.
-- Используется оператор "LIKE": (“заказчики”)
select * from customers
where cname like "G%";

-- Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000.
-- (“Заказы”, “amt”  - сумма)
select * from orders
where amt >1000;

-- Напишите запрос который выбрал бы наименьшую сумму заказа.
-- (Из поля “amt” - сумма в табличке “Заказы” выбрат наименьшее значение)
select min(amt) from orders;

-- Напишите запрос к табличке “Заказчики”, который может показать всех заказчиков,
-- у которых рейтинг больше 100 и они находятся не в Риме.
select * from customers
where rating > 100 and city = "rome";