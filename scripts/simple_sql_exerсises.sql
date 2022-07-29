-- Добавить в таблицу users колонку phone_number (int)
ALTER TABLE users
ADD COLUMN phone_number int;


-- Поменять тип данных в таблице users колонки phone_number с int на varchar
ALTER TABLE users
ALTER COLUMN phone_number TYPE varchar(20);


-- В таблице products увеличить цену в 2 раза
UPDATE products SET price = price * 2;


-- Вывести всех пользователей
SELECT * from users;


-- Вывести все продукты
SELECT * from products;


-- Вывести все статусы
SELECT * FROM order_status;


-- Вывести продукты, цена которых больше 80.00 и меньше или равно 150.00
SELECT title, price
FROM products
WHERE price BETWEEN 80 AND 150
ORDER BY 2 DESC;


-- Вывести заказы совершенные после 01.10.2020
SELECT id, created_at
FROM orders
WHERE created_at > TO_TIMESTAMP('01.10.2020', 'DD.MM.YYYY')
ORDER BY created_at;


-- Вывести заказы, полученные за первое полугодие 2020 года
SELECT id, created_at
FROM orders
WHERE EXTRACT(MONTH FROM created_at) <= 6 AND EXTRACT(YEAR FROM created_at) = 2020
ORDER BY 2;


-- Вывести максимальную сумму сделки за 3 квартал 2020
SELECT MAX(total) as max_sum
FROM orders
WHERE EXTRACT(QUARTER FROM created_at) = 3 AND EXTRACT(YEAR FROM created_at) = 2020;


-- Вывести имена и электронные адреса всех users отсортированных по городам и по имени
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, email
FROM users
ORDER BY city, first_name;
