CREATE TABLE public.users (
    id serial NOT NULL,
    email varchar(255),
    password varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    middle_name varchar(255),
    is_staff smallint,
    country varchar(255),
    city varchar(255),
    address text
);

CREATE TABLE public.carts (
    id serial NOT NULL,
    user_id int,
    subtotal decimal,
    total decimal,
    time_stamp timestamp(2)
);

CREATE TABLE public.cart_product (
    cart_id int NOT NULL,
    product_id int NOT NULL
);

CREATE TABLE public.products (
    id serial NOT NULL,
    title varchar(255),
    description text,
    in_stock int,
    price float,
    slug varchar (45),
    category_id int
);

CREATE TABLE public.categories (
    id serial NOT NULL,
    title varchar(255),
    description text
);

CREATE TABLE public.orders (
    id serial NOT NULL,
    cart_id int,
    order_status_id int,
    shipping_total decimal,
    total decimal,
    created_at timestamp(2),
    updated_at timestamp(2)
);

CREATE TABLE public.order_status (
    id serial NOT NULL,
    status_name varchar(255)
);

ALTER TABLE ONLY public.users
ADD CONSTRAINT users_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.carts
ADD CONSTRAINT carts_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.orders
ADD CONSTRAINT orders_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.order_status
ADD CONSTRAINT order_status_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.products
ADD CONSTRAINT products_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.categories
ADD CONSTRAINT categories_pkey
PRIMARY KEY (id);

ALTER TABLE ONLY public.carts
ADD CONSTRAINT users_user_id_fkey
FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.orders
ADD CONSTRAINT carts_cart_id2_fkey
FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY public.orders
ADD CONSTRAINT order_status_order_status_id_fkey
FOREIGN KEY (order_status_id) REFERENCES public.order_status(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.cart_product
ADD CONSTRAINT carts_cart_id_fkey
FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY public.cart_product
ADD CONSTRAINT products_product_id_fkey
FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY public.products
ADD CONSTRAINT category_id_fkey
FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;
