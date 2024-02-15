/*Indexes*/

CREATE INDEX prod_name_idx
ON Employees(name);

CREATE INDEX category__idx
ON Employees(address);

CREATE INDEX name_idx
ON Employees(phone);

/*Views*/

CREATE VIEW v_employee_info
AS
SELECT name, address
FROM Employees
WHERE salary >= 3000;

CREATE VIEW v_products_info
AS
SELECT product_name,brand,supermarket_price AS price
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM Sales_details)
AND product_id IN (SELECT product_id FROM Promotional_products
WHERE promotion_start_date>GETDATE());