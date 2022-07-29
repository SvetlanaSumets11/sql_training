-- Запрос: Продукты, цена которых от 50 до 120; оптимизировать с помощью индекса
EXPLAIN SELECT id, title, price
FROM products
WHERE price BETWEEN 50.00 AND 120.00
ORDER BY 3 DESC;

CREATE INDEX index_products_between_60_100 ON products(price)
WHERE price BETWEEN 50.00 AND 120.00;

DROP INDEX index_products_between_60_100;


-- Запрос: Имя, пароль, количесиво корзин пользователя и статус заказа по ним, когда фамилия содержит 2, пароль - 21;
-- оптимизировать с помощью индекса
EXPLAIN SELECT first_name ||' '|| last_name AS full_name, password, COUNT(orders.cart_id), status_name
FROM users JOIN carts ON users.id = carts.user_id
	       JOIN orders ON carts.id = orders.cart_id
	       JOIN order_status ON orders.order_status_id = order_status.id
WHERE last_name ILIKE '%2%' AND password ILIKE '%21%'
GROUP BY full_name, password, status_name
ORDER BY 3 DESC;

CREATE INDEX index_users_with_carts ON users(last_name, password)
WHERE last_name ILIKE '%2%' AND password ILIKE '%21%';

DROP INDEX index_users_with_carts;
