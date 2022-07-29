-- Добавить в категории новую, поставить точку сохранения, добавить еще две записи, поставить вторую точку сохранения,
-- удалить первую, изменить последнюю записи, поупаржняться откатывать транзакцию до точек сохранения и коммитить.

SELECT *
FROM categories;

BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO categories VALUES (21, 'Bakery', 'Food products obtained by baking from dough loosened with yeast or sourdough');

SAVEPOINT add_bakery;

INSERT INTO categories VALUES (22, 'Vegetables', 'the edible part of some plants, as well as any solid plant food, with the exception of fruits, cereals and nuts');
INSERT INTO categories VALUES (23, 'Dairy', 'Cream, fermented baked milk, kefir, butter, yogurt, sour cream, cottage cheese, etc.');

SAVEPOINT add_vegetables_and_dairy;

UPDATE categories SET description = 'Milk based products'
WHERE id = 23;

DELETE FROM categories
WHERE id = 21;

-- удаление точек сохранения
RELEASE SAVEPOINT add_bakery;
RELEASE SAVEPOINT add_vegetables_and_dairy;

-- откат точек сохранения
ROLLBACK TO SAVEPOINT add_bakery;
ROLLBACK TO SAVEPOINT add_vegetables_and_dairy;

-- закрепление транзакции
COMMIT;

-- откат транзакции
ROLLBACK;
