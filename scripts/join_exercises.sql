-- Вывести заказы, которые успешно доставлены и оплачены
SELECT orders.id, status_name
FROM orders JOIN order_status ON orders.order_status_id = order_status.id
WHERE status_name = 'Finished';


-- Вывести подукты следующих категорий: Category 7, Category 11, Category 18
SELECT products.title, categories.title
FROM products JOIN categories ON products.category_id = categories.id
WHERE categories.title IN ('Category 7', 'Category 11', 'Category 18')
ORDER BY categories.title;


-- Вывести незавершенные заказы по состоянию на 31.12.2020
SELECT orders.id, status_name, created_at
FROM orders JOIN order_status ON orders.order_status_id = order_status.id
WHERE status_name NOT IN ('Finished', 'Canceled')
  AND created_at <= TO_TIMESTAMP('31.12.2020', 'DD.MM.YYYY')
ORDER BY created_at;


-- Вывести все корзины, которые были созданы, но заказ так и не был оформлен
SELECT carts.id, orders.id
FROM carts LEFT JOIN orders ON carts.id = orders.cart_id
WHERE orders.id IS NULL;


-- Вывести среднюю сумму всех завершенных сделок
SELECT AVG(total) as avg_sum
FROM orders JOIN order_status ON orders.order_status_id = order_status.id
WHERE status_name = 'Finished';


-- Вывести имена и электронную почту потенциальных и существующих пользователей из города city 17
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, email
FROM users
WHERE city = 'city 17'
UNION
SELECT name ||' '|| surname ||' '|| middle_name AS full_name, email
FROM potential_customers
WHERE city = 'city 17';


-- Вывести наименование группы товаров, общее количество по группе товаров в порядке убывания количества
SELECT products.title, COUNT(products.title) AS num_product_by_category
FROM products JOIN categories ON products.category_id = categories.id
GROUP BY products.title
ORDER BY 2 DESC;


-- Вывести продукты, которые ни разу не попадали в корзину.
SELECT products.title
FROM products LEFT JOIN cart_product ON products.id = cart_product.product_id
WHERE cart_id IS NULL;


-- Вывести все продукты, которые так и не попали ни в 1 заказ. (но в корзину попасть могли).
SELECT products.title
FROM products LEFT JOIN cart_product ON products.id = cart_product.product_id
              LEFT JOIN carts ON carts.id = cart_product.cart_id
              LEFT JOIN orders ON carts.id = orders.cart_id
WHERE orders.id IS NULL;


-- Вывести топ 10 продуктов, которые добавляли в корзины чаще всего.
SELECT products.title, COUNT(products.id)
FROM products LEFT JOIN cart_product ON products.id = cart_product.product_id
GROUP BY products.id
ORDER BY 2 DESC
LIMIT 10;

-- Вывести топ 10 продуктов, которые не только добавляли в корзины, но и оформляли заказы чаще всего.
SELECT products.title, COUNT(products.id)
FROM products JOIN cart_product ON products.id = cart_product.product_id
              JOIN carts ON carts.id = cart_product.cart_id
              JOIN orders ON carts.id = orders.cart_id
GROUP BY products.id
ORDER BY 2 DESC
LIMIT 10;


-- Вывести топ 5 юзеров, которые потратили больше всего денег.
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, orders.total
FROM users LEFT JOIN carts ON users.id = carts.user_id
           LEFT JOIN orders ON carts.id = orders.cart_id
ORDER BY orders.total DESC NULLS LAST
LIMIT 5;


-- Вывести топ 5 юзеров, которые сделали больше всего заказов.
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, COUNT(orders.id)
FROM users JOIN carts ON users.id = carts.user_id
           JOIN orders ON carts.id = orders.cart_id
GROUP BY orders.id, full_name
ORDER BY 2 DESC
LIMIT 5;


-- Вывести топ 5 юзеров, которые создали корзины, но так и не сделали заказы.
SELECT first_name ||' '|| last_name ||' '|| middle_name AS full_name, COUNT(carts.id)
FROM users JOIN carts ON users.id = carts.user_id
           LEFT JOIN orders ON carts.id = orders.cart_id
WHERE orders.id IS NULL
GROUP BY carts.id, full_name
ORDER BY full_name DESC
LIMIT 5;
