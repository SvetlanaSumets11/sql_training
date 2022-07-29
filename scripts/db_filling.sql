COPY public.users (id, email, password, first_name, last_name, middle_name, is_staff, country, city, address)
FROM '/usr/src/data/users.csv' DELIMITER ',' CSV;

COPY public.categories (id, title, description)
FROM '/usr/src/data/categories.csv' DELIMITER ',' CSV;

COPY public.order_status (id, status_name)
FROM '/usr/src/data/order_statuses.csv' DELIMITER ',' CSV;

COPY public.products (id, title, description, in_stock, price, slug, category_id)
FROM '/usr/src/data/products.csv' DELIMITER ',' CSV;

COPY public.carts (id, user_id, subtotal, total, time_stamp)
FROM '/usr/src/data/carts.csv' DELIMITER ',' CSV;

COPY public.orders (id, cart_id, order_status_id, shipping_total, total, created_at, updated_at)
FROM '/usr/src/data/orders.csv' DELIMITER ',' CSV;

COPY public.cart_product (cart_id, product_id)
FROM '/usr/src/data/cart_products.csv' DELIMITER ',' CSV;
