CREATE DATABASE elevate_task7;
USE elevate_task7;

-- Drop tables if they exist (for rerun safety)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- 1. Create Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 2. Insert Sample Data into Customers
INSERT INTO Customers (customer_id, name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com'),
(4, 'Diana Rose', 'diana@example.com');

-- 3. Insert Sample Data into Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-07-01', 2500.00),
(102, 1, '2024-07-10', 3200.00),
(103, 2, '2024-07-05', 1500.00),
(104, 3, '2024-07-06', 1000.00),
(105, 1, '2024-07-20', 1800.00),
(106, 2, '2024-07-25', 500.00),
(107, 4, '2024-07-30', 7000.00);

-- 4. Create View: CustomerOrderSummary
CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;

-- 5. Create View: PublicCustomerInfo (for limited exposure)
CREATE VIEW PublicCustomerInfo AS
SELECT customer_id, name
FROM Customers;

-- 6. Use the Views

-- a) Show full summary
SELECT * FROM CustomerOrderSummary;

-- b) Show high-value customers (spent more than 5000)
SELECT name, total_spent
FROM CustomerOrderSummary
WHERE total_spent > 5000;

-- c) Use public customer info (without emails)
SELECT * FROM PublicCustomerInfo;
