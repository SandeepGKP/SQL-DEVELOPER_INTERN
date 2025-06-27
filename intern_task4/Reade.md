# Task 4: Aggregate Functions and Grouping (SQL)

## Objective
Summarize and analyze tabular data using SQL aggregate functions like `SUM`, `COUNT`, and `AVG` along with `GROUP BY` and `HAVING`.

## Tools Used
- DB Browser for SQLite / MySQL Workbench
- SQL (Standard syntax)

## Table Used: `orders`

| Column Name   | Data Type   | Description                    |
|---------------|-------------|--------------------------------|
| order_id      | INTEGER     | Primary key                    |
| customer_id   | INTEGER     | ID of the customer             |
| order_date    | DATE        | Date of the order              |
| total_amount  | DECIMAL     | Total order value              |


## Key SQL Concepts Used
- SUM(), COUNT(), AVG() – Aggregate functions
- GROUP BY – To categorize data
- HAVING – To filter grouped results
