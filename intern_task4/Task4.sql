-- Task 4: Aggregate Functions and Grouping
CREATE DATABASE elevates_task4;
USE elevates_task4;

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2024-01-10', 500),
(2, 102, '2024-01-11', 300),
(3, 101, '2024-01-12', 200),
(4, 103, '2024-01-12', 700),
(5, 102, '2024-01-13', 100);

-- 1. Total sales (SUM) by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- 2. Total number of orders (COUNT) per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- 3. Average order value (AVG) per customer
SELECT customer_id, AVG(total_amount) AS average_order_value
FROM orders
GROUP BY customer_id;

-- 4. Customers who spent more than 500 (using HAVING)
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_amount > 500;

-- 5. Combined report: total orders, total amount, average value
SELECT customer_id,
       COUNT(order_id) AS total_orders,
       SUM(total_amount) AS total_spent,
       AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;
