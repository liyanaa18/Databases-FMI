CREATE TRIGGER tr_update_product_id ON Products
AFTER UPDATE
AS
BEGIN
UPDATE Sales_details
SET Sales_details.product_id=product_id
WHERE product_id IN (SELECT product_id FROM inserted)
UPDATE Promotional_products
SET Promotional_products.product_id=product_id
WHERE product_id IN (SELECT product_id FROM inserted)
END

CREATE TRIGGER tr_del_cat ON Categories
AFTER DELETE
AS
UPDATE Products
SET category='Other'
WHERE category IN (select category_name from deleted where
category_name=category)

CREATE TRIGGER tr_insert_warehouse ON Warehouses
AFTER INSERT
AS
UPDATE Categories
SET warehouse_no=(SELECT warehouse_no FROM inserted)
WHERE warehouse_no IS NULL

CREATE TRIGGER tr_del_empl ON Employees
INSTEAD OF DELETE
AS
UPDATE Employees
SET position='not work'
WHERE employee_id IN (SELECT employee_id FROM deleted)