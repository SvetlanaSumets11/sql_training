-- Создать функцию, которая сетит shipping_total = 0 в таблице order, если город юзера равен x. Использовать IF clause
CREATE OR REPLACE FUNCTION find_shipping_total_by_city(search_city varchar)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
	WITH shipping_total_table AS (
        SELECT orders.shipping_total, users.city
        FROM users JOIN carts  ON users.id = carts.user_id
                   JOIN orders ON carts.id = orders.cart_id
	)
	UPDATE orders SET shipping_total = 0
  	FROM shipping_total_table
  	WHERE shipping_total_table.city = search_city;
  	IF NOT FOUND THEN RAISE 'Search error. % city not found', search_city; END IF;
END; $$;


SELECT find_shipping_total_by_city('city 17');


SELECT orders.shipping_total, users.city
FROM users JOIN carts  ON users.id = carts.user_id
           JOIN orders ON carts.id = orders.cart_id
WHERE users.city = 'city 17';


DROP FUNCTION find_shipping_total_by_city;
