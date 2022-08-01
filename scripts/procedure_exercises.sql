-- Написать процедуру, что принимает число (скидка), обновить total в таблице carts, где новое значение будет уменьшенным
-- на скидку, допустимое значение new_total >= 0
CREATE OR REPLACE PROCEDURE update_carts_total(discount decimal)
LANGUAGE plpgsql
AS $$
DECLARE
    new_total decimal;
BEGIN
    UPDATE carts SET total = total - discount WHERE id = 1
    RETURNING total INTO new_total;

    IF new_total >= 0.0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END; $$;

CALL update_carts_total(7.3);

DROP PROCEDURE update_carts_total;


-- Обновить total в таблице carts суммарным значением total заказа для каждого пользователя, имя которого содержит 1
CREATE OR REPLACE PROCEDURE set_new_carts_total(target_user_id int, expense_limit decimal)
LANGUAGE plpgsql
AS $$
DECLARE
    result record;
BEGIN
	FOR result IN (
		SELECT first_name, last_name, SUM(orders.total) AS expense
		FROM users LEFT JOIN carts  ON users.id = carts.user_id
			       LEFT JOIN orders ON carts.id = orders.cart_id
		WHERE orders.total > expense_limit AND user_id < target_user_id
		GROUP BY first_name, last_name
        )
	    LOOP
            UPDATE carts SET total = result.expense
            WHERE result.first_name LIKE '%1%';

			IF result.expense >= 0 THEN
				COMMIT;
			ELSE
        		ROLLBACK;
    		END IF;
		END LOOP;
END; $$;

CALL set_new_carts_total(1000, 11.2);

DROP PROCEDURE set_new_carts_total;
