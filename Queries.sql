/*Simple queries*/

SELECT brand
FROM Products
WHERE expiry_date >= '2024-01-01'
AND product_name = 'Shampoo';

SELECT brand
FROM Products
WHERE product_name = 'Toothpaste' AND quantity <= 20;

/*Queries on two or more relations*/

SELECT m.name
FROM Employees as m, Employees as m2
WHERE m.salary > m2.salary
AND m2.name = 'Henry Anderson';

SELECT brand
FROM Products
WHERE product_name = 'Fish'
EXCEPT
SELECT brand
FROM Products
WHERE product_name = 'Pasta';

SELECT product_name
FROM Products p
JOIN Sales_details s ON p.product_id = s.product_id
JOIN Employees e ON s.cashier_id = e.employee_id
WHERE e.name = 'Anna Berner'
UNION
SELECT product_name
FROM Products p
JOIN Sales_details s ON p.product_id = s.product_id
JOIN Employees e ON s.cashier_id = e.employee_id
WHERE e.name = 'Moreno Lucas';

SELECT category
FROM Products
WHERE product_name = 'Shampoo'
INTERSECT
SELECT category
FROM Products
WHERE product_name = 'Toothpaste';


/*Subqueries*/

SELECT product_name,brand,supermarket_price AS price
FROM Products
WHERE supermarket_price >=ALL (SELECT
supermarket_price FROM Products WHERE category =
'Beauty & Care')

SELECT product_name,brand,supermarket_price AS price
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM
Sales_details) AND product_id IN (SELECT product_id
FROM Promotional_products WHERE
promotion_start_date>GETDATE())

SELECT cashier_id,name,COUNT(sales_id)as no_sales
FROM Sales_details,(SELECT name,employee_id FROM
Employees)as e
where cashier_id = e.employee_id
GROUP BY cashier_id,name

SELECT product_name,brand,supermarket_price AS
price,category
FROM Products p
WHERE supermarket_price <=ALL (SELECT
supermarket_price FROM Products WHERE
p.category=category)
GROUP BY
category,product_name,brand,supermarket_price

/*Compounds*/

SELECT product_name,quantity,discount_percent
FROM Products pr JOIN Promotional_products promotion
ON pr.product_id=promotion.product_id
WHERE promotion.promotion_start_date='2022-06-20'
AND pr.category='Food';

SELECT s.sales_id, e.name Cashier_name, e.phone
Cashier_phone
FROM Sales_details s JOIN Employees e
ON s.cashier_id=e.employee_id
JOIN Payment_methods p ON
p.payment_mode_id=s.payment_mode_id
WHERE p.method_name NOT LIKE 'in cash';

/*Grouping and Aggregation*/

SELECT AVG(salary) as 'AverageSalary'
FROM Employees;

SELECT COUNT(e.position) as 'cashiers_number'
FROM Employees e
WHERE e.position = 'Cashier'

SELECT SUM(p.quantity) as 'toothpastes_all_quantity'
FROM Products p
WHERE p.product_name='Toothpaste'

SELECT p.product_name,p.quantity
FROM Products p
GROUP BY p.product_name,p.quantity
HAVING SUM(p.quantity) < 20

SELECT p.product_name, SUM(p.quantity) as 'all_quantity'
FROM Products p
WHERE p.category='Soft Drink' AND p.supermarket_price
< 2.00
GROUP BY p.product_name