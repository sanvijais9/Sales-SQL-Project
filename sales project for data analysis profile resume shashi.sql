select * from customers;
insert into customers values
('8', 'reena', 'reena@example.com', '2018-09-14', 'bhuvneshwer','odisha');
select * from customers;
insert into customers values
('9', 'seena', 'seena@example.com', '2017-09-12', 'kalahandi','odisha'),
('10', 'tina', 'tina@example.com', '2022-08-16', 'sambalpur','odisha');
select * from orders;
INSERT INTO Orders VALUES
(5001, 1, '2023-05-10', 150000.00),
(5002, 2, '2023-09-11', 12000.00),
(5003, 3, '2023-08-13', 20000.00),
(5004, 4, '2022-02-15', 50000.00),
(5005, 5, '2020-05-20', 70000.00),
(5006, 6, '2021-07-11', 130000.00),
(5007, 7, '2021-05-17', 10000.00);
select * from orders;
INSERT INTO Orders VALUES
(5008, 8, '2022-03-10', 150000.00),
(5009, 9, '2021-04-11', 12000.00),
(5010, 10, '2019-02-13', 20000.00);
select * from orders;
select *  from order_items;

INSERT INTO Order_Items VALUES
(1, 5001, 101, 4, 150000.00),
(2, 5002, 102, 2, 12000.00),
(3, 5003, 103, 5, 20000.00),
(4, 5004, 104, 3, 70000.00),
(5, 5005, 105, 5, 130000.00),
(6, 5006, 106, 6, 10000.00),
(7, 5007, 107, 7, 150000.00),
(8, 5008, 108, 8, 50000.00),
(9, 5009, 109, 9, 20000),
(10, 5010, 110, 10, 100000.00);

select * from order_items;
select * from orders;
select * from customers;
select * from products;

--Basic SELECT--
SELECT * FROM products;

--WHERE + ORDER BY--
SELECT * FROM Products
WHERE category = 'Electronics'
ORDER BY price DESC;

--Aggregate Functions + GROUP BY--
SELECT category, COUNT(*) AS product_count, AVG(price) AS avg_price
FROM Products
GROUP BY category;

--JOIN (INNER, LEFT, RIGHT, FULL)--
-- INNER JOIN--
SELECT c.name, o.order_id, o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- LEFT JOIN--
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

--subquery--
SELECT name FROM Customers
WHERE customer_id IN (
  SELECT customer_id FROM Orders
  WHERE total_amount > 50000
);

--Window Functions--
SELECT customer_id, order_id, total_amount,
       RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) as rank
FROM Orders;


--CTE (Common Table Expression)--
WITH CustomerOrders AS (
    SELECT customer_id, COUNT(*) as total_orders
    FROM Orders
    GROUP BY customer_id
)
SELECT c.name, co.total_orders
FROM Customers c
JOIN CustomerOrders co ON c.customer_id = co.customer_id;
select * from orders;
--CASE Statements--
SELECT product_name, price,
CASE
    WHEN price >= 10000 THEN 'High-End'
    WHEN price BETWEEN 50000 AND 20000 THEN 'Mid-Range'
    ELSE 'Budget'
END AS price_segment
FROM Products;

--EXISTS--
SELECT name FROM Customers c
WHERE EXISTS (
    SELECT 1 FROM Orders o
    WHERE o.customer_id = c.customer_id
);


--Monthly Revenue Trend--
SELECT DATE_TRUNC('month', order_date) AS month, SUM(total_amount) AS revenue
FROM Orders
GROUP BY month
ORDER BY month;

--Top 5 Products by Revenue--
SELECT p.product_name, SUM(oi.quantity * oi.unit_price) AS revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

--Returning Customers---
SELECT customer_id, COUNT(*) AS order_count
FROM Orders
GROUP BY customer_id
HAVING COUNT(*) > 1;


--DCL (Data Control Language)--

---only for statement not practices--
-- Grant permissions to analyst

GRANT SELECT, INSERT ON Customers TO analyst_user;

-- Revoke permissions

REVOKE INSERT ON Customers FROM analyst_user;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    signup_date DATE,
    city VARCHAR(100),
    state VARCHAR(50)
); 

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    stock_qty INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', '2023-01-15', 'New York', 'NY'),
(2, 'ram', 'ram@example.com', '2024-03-15', 'London ', 'UK'),
(3, 'shyam', 'shyam@example.com', '2025-06-15', 'new delhi', 'delhi'),
(4, 'mohan', 'mohan@example.com', '2022-05-15', 'agra', 'UP'),
(5, 'rohan', 'rohan@example.com', '2019-02-15', 'lucknow', 'UP'),
(6, 'shashi', 'shashi@example.com', '2023-01-15', 'agra', 'UP'),
(7, 'tushal', 'tushal@example.com', '2024-01-15', 'pune', 'maharashtra ');
select * from Customers;

--Insert a product
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 300000.00, 60),
(102, 'CPU', 'Electronics', 15000.00, 40),
(103, 'Motherboard', 'Electronics', 4000.00, 50),
(104, 'RAM', 'Electronics', 3000.00, 50),
(105, 'SSD', 'Electronics', 2000.00, 45),
(106, 'PSU', 'Electronics', 4000.00, 15),
(107, 'keyboard', 'Electronics', 1000.00, 30),
(108, 'mouse', 'Electronics', 500.00, 20),
(109, 'GPU', 'Electronics', 4000.00, 40),
(110, 'printer', 'Electronics', 10000.00, 10);
select * from products;









