CREATE DATABASE elevates_task3;
USE elevates_task3;

-- 1. Drop tables if they already exist
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- 2. Create departments table with VARCHAR instead of TEXT
CREATE TABLE departments (
    dept_name VARCHAR(50) PRIMARY KEY,
    location VARCHAR(100)
);

-- 3. Create employees table with department as VARCHAR to match foreign key
CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INTEGER,
    hire_date DATE,
    FOREIGN KEY (department) REFERENCES departments(dept_name)
);

-- 4. Insert data into departments
INSERT INTO departments (dept_name, location) VALUES 
('Sales', 'New York'),
('IT', 'San Francisco'),
('HR', 'Chicago'),
('Marketing', 'Boston');

-- 5. Insert data into employees
INSERT INTO employees (name, department, salary, hire_date) VALUES 
('Alice Johnson', 'Sales', 60000, '2020-03-15'),
('Bob Smith', 'IT', 80000, '2019-06-01'),
('Charlie Evans', 'HR', 50000, '2021-01-10'),
('David Green', 'Marketing', 70000, '2018-09-23'),
('Eva Adams', 'Sales', 55000, '2022-05-05'),
('Frank White', 'IT', 75000, '2020-11-30'),
('Grace Lee', 'HR', 48000, '2021-12-12'),
('Helen Brown', 'Marketing', 72000, '2019-08-14'),
('Ian Black', 'Sales', 64000, '2020-02-28'),
('Jack Wilson', 'IT', 82000, '2017-04-18');

-- 6. Sample Queries

-- A. Select all employees
SELECT * FROM employees;

-- B. Select specific columns
SELECT name, salary FROM employees;

-- C. Employees in Sales with salary > 55000
SELECT * FROM employees
WHERE department = 'Sales' AND salary > 55000;

-- D. Employees in Sales OR HR
SELECT * FROM employees
WHERE department = 'Sales' OR department = 'HR';

-- E. Employees with names containing 'a'
SELECT * FROM employees
WHERE name LIKE '%a%';

-- F. Employees with salary between 50000 and 75000
SELECT * FROM employees
WHERE salary BETWEEN 50000 AND 75000;

-- G. Order by salary (ascending)
SELECT * FROM employees
ORDER BY salary ASC;

-- H. Order by salary (descending) and get top 3
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;


