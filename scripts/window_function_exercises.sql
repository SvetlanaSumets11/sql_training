-- Сравнить цену каждого продукта n с средней ценой продуктов в категории продукта n
SELECT categories.title, products.title, price,
       AVG(price) OVER (PARTITION BY categories.title) AS avg_price
FROM products JOIN categories ON products.category_id = categories.id;


-- Вывести сумму total заказов по статусу заказа
SELECT order_status.status_name, orders.created_at,
       SUM(orders.total) OVER (PARTITION BY order_status.status_name) AS sum_total
FROM orders JOIN order_status ON orders.order_status_id = order_status.id;


-- Вывести сумму total корзин по статусу заказов
SELECT carts.id, order_status.status_name,
       SUM(carts.total) OVER (PARTITION BY order_status.status_name) AS sum_total
FROM carts JOIN orders ON carts.id = orders.cart_id
           JOIN order_status ON orders.order_status_id = order_status.id;
