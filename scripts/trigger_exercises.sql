-- Создать триггер, что валидирует имя пользователя при смене строки в таблице users
CREATE OR REPLACE FUNCTION check_entered_user()
RETURNS TRIGGER
AS $$
BEGIN
    IF length(NEW.last_name) < 11 OR length(NEW.first_name) < 12 OR length(NEW.middle_name) < 13
	THEN
        RAISE EXCEPTION 'Name is too short or null';
    END IF;
    RETURN NEW;
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER validate_user_name
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE PROCEDURE check_entered_user();

DROP TRIGGER validate_user_name ON users;

UPDATE users SET first_name = 'first_name 2' WHERE id = 2;
UPDATE users SET last_name = NULL WHERE id = 2;
UPDATE users SET middle_name = '' WHERE id = 2;


-- Создать валидатор поля total в таблице orders
CREATE OR REPLACE FUNCTION check_total()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF NEW.total < 0 THEN
		RAISE 'The total amount cannot be less then 0';
	END IF;
	RETURN NEW;
END; $$;

CREATE TRIGGER check_total_in_orders
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW EXECUTE PROCEDURE check_total();

DROP TRIGGER check_total_in_orders ON orders;

UPDATE orders SET total = 100.5 WHERE id = 11;
UPDATE orders SET total = -33 WHERE id = 11;
