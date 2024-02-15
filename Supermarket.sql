USE master
GO
if exists (select * from sysdatabases where name='Supermarket')
DROP DATABASE Supermarket
GO
CREATE DATABASE Supermarket
GO
USE Supermarket
GO

CREATE TABLE Products(
product_id int PRIMARY KEY NOT NULL,
product_name varchar(30) NOT NULL,
barcode int NOT NULL,
category varchar(30) DEFAULT 'Other' NOT NULL,
brand varchar(30) NOT NULL,
quantity decimal(9,2),
expiry_date date NOT NULL,
warehouse_price decimal(9,2) NOT NULL,
supermarket_price decimal(9,2) NOT NULL
);

CREATE TABLE Categories(
category_id int PRIMARY KEY NOT NULL,
category_name varchar(30) NOT NULL,
warehouse_no int
);

CREATE TABLE Warehouses(
warehouse_no int PRIMARY KEY NOT NULL,
name varchar(30),
address varchar(50)
);

CREATE TABLE Promotional_products(
product_id int NOT NULL,
promotion_start_date date,
promotion_end_date date,
discount_percent int,
PRIMARY KEY (product_id, promotion_start_date)
);

CREATE TABLE Sales_details(
sales_id int PRIMARY KEY NOT NULL,
product_id int NOT NULL,
cashier_id int NOT NULL,
amount decimal(9,2) NOT NULL,
date date DEFAULT GETDATE(),
payment_mode_id int NOT NULL,
);

CREATE TABLE Payment_methods(
payment_mode_id int PRIMARY KEY NOT NULL,
method_name varchar(7) CHECK (method_name in
('voucher','in cash', 'card'))
);

CREATE TABLE Employees(
employee_id int PRIMARY KEY NOT NULL,
name varchar(30) NOT NULL,
address varchar(30),
phone varchar(20) NOT NULL,
email varchar(30),
salary decimal(9,2),
position char(30)
);

ALTER TABLE Warehouses
ADD UNIQUE (name,address);

ALTER TABLE Employees
ADD UNIQUE (name,address);

ALTER TABLE Promotional_products
ADD UNIQUE (product_id,promotion_start_date);

ALTER TABLE Categories
ADD CONSTRAINT uniq_name UNIQUE (category_name);

ALTER TABLE Promotional_products
ADD CONSTRAINT check_prom CHECK (discount_percent > 0);

ALTER TABLE Products
ADD CONSTRAINT check_pr_price CHECK (warehouse_price <
supermarket_price);

ALTER TABLE Products
ADD CONSTRAINT ch_еxp CHECK (expiry_date > GETDATE());

ALTER TABLE Employees
ADD CHECK (email LIKE '__%@__%.__%');

ALTER TABLE Promotional_products
ADD CHECK (promotion_start_date < promotion_end_date);

ALTER TABLE Promotional_products
ADD CONSTRAINT prom_pr_fk FOREIGN KEY (product_id)
REFERENCES Products(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE Products
ADD CONSTRAINT cat_pr_fk FOREIGN KEY (category)
REFERENCES Categories(category_name)
ON UPDATE CASCADE
ON DELETE NO ACTION;

ALTER TABLE Sales_details
ADD CONSTRAINT sales_product_fk FOREIGN KEY (product_id)
REFERENCES Products(product_id);

ALTER TABLE Sales_details
ADD CONSTRAINT sales_pay_fk FOREIGN KEY
(payment_mode_id)
REFERENCES Payment_methods(payment_mode_id);

ALTER TABLE Sales_details
ADD CONSTRAINT sales_empl_fk FOREIGN KEY (cashier_id)
REFERENCES Employees(employee_id);

INSERT INTO Categories (category_id, category_name, warehouse_no)
VALUES (6,'Food',16),
(2,'Seafood',2),
(3,'Beauty & Care',13),
(4,'Soft Drink',10),
(5,'Bakery',8)

INSERT INTO Categories(category_id,category_name)
VALUES (7,'Other');

INSERT INTO
Products(product_id,product_name,barcode,brand,quantity,expiry_date,
warehouse_price, supermarket_price)
VALUES (9874,'Battery AA',874526987,'Toshiba',10,'2023-05-18',1.10,2.50);

INSERT INTO Products(product_id ,product_name,barcode,category ,brand ,
quantity ,expiry_date ,warehouse_price,supermarket_price)
VALUES (4481,'Bread',123432423, 'Bakery', 'EveryDay',49,'2022-06-01',
1.20, 1.90),
(2009,'Fish',344213309, 'Seafood', 'InSea',34,'2022-09-23',4.30,6.70),
(2019,'Shrimp',354213309, 'Seafood', 'InSea',74,'2022-07-13',14.30,16.70),
(2029,'Tuna',364213309, 'Seafood', 'Pure',23,'2022-09-13',8.90,9.70),
(2039,'Clams',374213309, 'Seafood', 'Pure',10,'2022-07-23',4.00,7.99),
(2093,'Rice',234752909, 'Food','Baldo',79,'2022-12-12',5.10,7.50),
(2332,'Pasta',908900214,'Food','Barilla',98,'2022-08-06',2.00,3.28),
(1221,'Pasta',128970345,'Food','Ronzoni',55,'2022-12-30',3.70,6.00),
(1291,'Pasta',128970895,'Food','Buitoni',98,'2022-11-30',9.70,15.00),
(2201,'Cola',128970895,'Soft Drink','Coca-Cola',45,'2022-10-10',1.30,2.05),
(2211,'Fanta',128932895,'Soft Drink','Coca-Cola',19,'2022-08-30',1.20,1.94),
(8561,'Sprite',678970895,'Soft Drink','Coca-Cola',28,'2022-11-30',2.00,3.00),
(1055,'Rice',908944895,'Food','Lal',32,'2022-11-30',2.70,5.00),
(1241,'Shampoo',028970345,'Beauty & Care' ,'Elseve' ,50, '2024-12-30' , 10.70
,12.00),
(1891,'Shampoo',028970895,'Beauty & Care', 'Pantene', 18, '2023-11-30',
15.70 ,20.00),
(2801,'Shampoo',028970895,'Beauty & Care','Dove',43,'2024-10-10' , 19.30 ,
26.00),
(2771,'Shampoo',028932895,'Beauty & Care','Syoss',24,'2023-01-30', 16.20,
18.90),
(0551,'Shampoo',078970895,'Beauty & Care','Elidor',58,'2024-11-30' , 20.00,
30.00),
(1355,'Shampoo',008944895,'Beauty & Care','Aveda',30,'2024-11-30' ,21.70 ,
28.00),
(3201,'Toothpaste',018970345,'Beauty & Care','Colgate Total',50,
'2024-02-05',3.70,6.00),
(3891,'Toothpaste',018970895,'Beauty & Care','Crest Pro-Health',18,
'2023-01-30', 15.70,20.00),
(3601,'Toothpaste',018970895,'Beauty & Care','Sensodyne ' ,43,'2024-10-10',
9.30,12.00),
(3771,'Toothpaste',018932895,'Beauty & Care','Crest Tartar Protection',24,
'2023-09-30', 16.20,18.90),
(3551,'Toothpaste',018970895,'Beauty & Care','AH Dental Care Advance',58,
'2024-04-30', 10.00,13.00),
(3355,'Toothpaste',018944895,'Beauty & Care','Lacalut White',30,
'2024-11-30', 7.70,12.00),

INSERT INTO Warehouses(warehouse_no,name,address)
VALUES (16,'Sardo & Sons','Main Road 70'),
(13,'Tradition','Main Road 76'),
(10,'Tradition 2','Corporation Street 2'),
(8,'Tradition 3','Corporation Street 16'),
(2,'Sardo 1','Deansgate 7');

INSERT INTO Employees (employee_id,name,address ,phone ,email ,salary ,
position)
VALUES (12, 'Anna Berner', 'New door 9', '456134122','annabern@gmail.com
',2700.00, 'Cashier'),
(13, 'Joshua Maximo', 'Office ten 8', '456226732','joshuua@gmail.com',
2700.00, 'Cashier'),
(14, 'Mark Pather', 'Office ten 9', '456226700','markkk_p@gmail.com',
2700.00, 'Cashier'),
(15, 'Carl Eff', 'New zeq 17', '456223392','carl_eff@gmail.com', 2700.00,
'Cashier'),
(16, 'Dannio Daniles', 'Ofsite 98', '456220056' ,'dannioooo@gmail.com',
2700.00, 'Cashier'),
(17, 'Danila Maxim', 'Office ten 28', '456897732','danimax@gmail.bg',
2700.00, 'Cashier'),
(18, 'Eleonora Evgeniy', 'Meditation Lane 22',
'4561124460','Elionorr@abv.bg', 2700.00, 'Cashier'),
(51, 'Smith Williams', 'Meditation Lane 12', '456100430','smith433@abv.bg',
10000.00, 'Ceo'),
(22, 'Jones Johnson', 'Meditation Lane 7', '456100930',
'jones_1990@abv.bg', 2900.00, 'Consultant'),
(23, 'Henry Anderson', 'Gentle Rain Drive 8', '456100455','henryy76@abv.bg',
3700.00, 'Consultant'),
(21, 'Moreno Lucas', 'Gentle Rain Drive 4', '456100499',
'lucas_moreno@abv.bg', 3500.00, 'Consultant'),
(31, 'David Davis', 'Gentle Rain Drive 92', '456100232','daviddavis@abv.bg',
8900.00, 'Manager');

INSERT INTO Payment_methods(payment_mode_id,method_name)
VALUES (1,'voucher'),
(2,'in cash'),
(3,'card');

INSERT INTO Promotional_products
(product_id,promotion_start_date,promotion_end_date,discount_percent)
VALUES (1221,'2022-06-20','2022-07-15',10),
(3201,'2022-06-20','2022-07-15',15),
(3771,'2022-07-20','2022-08-10',5),
(2332,'2022-05-25','2022-06-05',25),
(3601,'2022-07-20','2022-08-10',5);

INSERT INTO
Sales_details(sales_id,product_id,amount,cashier_id,date,payment_mode_id)
VALUES (5,2093,5,12,'2022-05-20',1),
(10,2771,1,12,'2022-05-26',1),
(11,3355,3,23,'2022-04-25',2),
(7,4481,5,21,'2022-03-10',3),
(12,1291,10,31,'2022-02-05',3),
(13,8561,25,21,'2022-02-06',2);

