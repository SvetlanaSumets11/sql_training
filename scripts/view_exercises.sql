-- Создать представление для отображения пользователей и их трат на заказы
CREATE VIEW payment_for_orders
AS
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, orders.total
FROM users LEFT JOIN carts ON users.id = carts.user_id
           LEFT JOIN orders ON carts.id = orders.cart_id;

SELECT * FROM payment_for_orders;
DROP VIEW payment_for_orders;


-- Создать представление для отображения продуктов, их цен, заказов, их сумм
CREATE VIEW products_join_orders
AS
SELECT products.title, products.price, orders.id, orders.total
FROM products JOIN cart_product ON products.id = cart_product.product_id
              JOIN carts ON carts.id = cart_product.cart_id
              JOIN orders ON carts.id = orders.cart_id;

SELECT * FROM products_join_orders;
DROP VIEW products_join_orders;


-- Создать представление для отображения информации про заказ и статуса заказа
CREATE VIEW order_join_order_status
AS
SELECT orders.id, shipping_total, total, created_at, updated_at, status_name
FROM orders JOIN order_status ON orders.order_status_id = order_status.id;

SELECT * FROM order_join_order_status;
DROP VIEW order_join_order_status;


-- Создать материализированное представление для отображения информации о пользователе, его количество корзин и статус заказа
CREATE MATERIALIZED VIEW count_users_with_carts
AS
SELECT user_id, last_name, first_name, COUNT(cart_id) AS amount, status_name
FROM users JOIN carts ON users.id = carts.user_id
	       JOIN orders ON carts.id = orders.cart_id
	       JOIN order_status ON orders.order_status_id = order_status.id
GROUP BY user_id, last_name, first_name, status_name
ORDER BY amount DESC;

SELECT * FROM count_users_with_carts;
DROP MATERIALIZED VIEW count_users_with_carts;
