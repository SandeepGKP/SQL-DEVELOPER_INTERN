CREATE DATABASE ekevate_task6;
USE ekevate_task6;

--  Sample Tables and Data Setup
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Sample Data
INSERT INTO departments VALUES 
(1, 'Engineering', 'New York'),
(2, 'HR', 'Boston'),
(3, 'Sales', 'New York');

INSERT INTO employees VALUES 
(101, 'Alice', 1, 60000),
(102, 'Bob', 1, 70000),
(103, 'Charlie', 2, 40000),
(104, 'Diana', 3, 30000),
(105, 'Eve', 3, 35000);

INSERT INTO customers VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Robert Brown');

INSERT INTO orders VALUES
(201, 1, 100.00),
(202, 1, 250.00),
(203, 2, 300.00);

-- 1. Subquery in SELECT Clause (Correlated)
SELECT 
    name,
    department_id,
    salary,
    (SELECT AVG(salary)
     FROM employees e2
     WHERE e2.department_id = e1.department_id) AS avg_department_salary
FROM employees e1;

-- 2. Subquery in WHERE Clause: IN
SELECT name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'New York'
);

-- 3. Subquery in WHERE Clause: EXISTS
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 4. Subquery in WHERE Clause: Scalar (=)
SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

-- 5. Subquery in FROM Clause (Derived Table)
SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg
WHERE avg_salary > 50000;

-- 6. Correlated Subquery in WHERE
SELECT name
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e1.department_id
);

-- 7. Scalar Subquery in SELECT
SELECT 
    name, 
    salary,
    (SELECT MAX(salary) FROM employees) AS highest_salary
FROM employees;
