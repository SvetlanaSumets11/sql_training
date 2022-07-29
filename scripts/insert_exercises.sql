-- Создайте новую таблицу potential customers с полями id, email, name, surname, middle_name, city
CREATE TABLE public.potential_customers (
 	id serial NOT NULL,
 	email varchar(255),
 	name varchar(255),
 	surname varchar(255),
 	middle_name varchar(255),
 	city varchar(255)
 );


 INSERT INTO potential_customers VALUES (1, 'email1@gmail.com', 'Svetlana', 'Sumets', 'Igorevna', 'city 12');
 INSERT INTO potential_customers VALUES (2, 'email2@gmail.com', 'Anna', 'Svitskaya', 'Sergeevna', 'city 17');
 INSERT INTO potential_customers VALUES (3, 'email3@gmail.com', 'Igor', 'Marchenko', 'Evgenevich', 'city 11');
 INSERT INTO potential_customers VALUES (4, 'email4@gmail.com', 'Svetlana', 'Kosikova', 'Pavlovna', 'city 17');
 INSERT INTO potential_customers VALUES (5, 'email5@gmail.com', 'Pavel', 'Antonenko', 'Vitalevich', 'city 17');
 INSERT INTO potential_customers VALUES (6, 'email6@gmail.com', 'Dana', 'Nurova', 'Denisovna', 'city 1');
 INSERT INTO potential_customers VALUES (7, 'email7@gmail.com', 'Sergey', 'Novickov', 'Anatolevich', 'city 22');
 INSERT INTO potential_customers VALUES (8, 'email8@gmail.com', 'Anna', 'Krymskaya', 'Sergeevna', 'city 16');
 INSERT INTO potential_customers VALUES (9, 'email9@gmail.com', 'Ekaterina', 'Fomina', 'Sergeevna', 'city 17');
 INSERT INTO potential_customers VALUES (10, 'email10@gmail.com', 'Kirill', 'Kotelevec', 'Andreevich', 'city 22');
