 --------------------------------------SQL Employee & Department Database Tables--------------------------------------------------

## Objective
Demonstrate basic SQL operations including data extraction using `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT` on a sample employee-management database.

## Tools Used
- MySQL Workbench
- SQL (MySQL syntax)

## Tables
1. **departments**
   - dept_name (Primary Key)
   - location

2. **employees**
   - id (Primary Key, Auto Increment)
   - name
   - department (Foreign Key referencing departments)
   - salary
   - hire_date

## Features Demonstrated
- Table creation with foreign keys
- Inserting multiple rows
- Filtering data using `WHERE`, `AND`, `OR`, `LIKE`, `BETWEEN`
- Sorting results using `ORDER BY ASC/DESC`
- Limiting results using `LIMIT`

## Sample Queries
- Get all employees
- Get top 3 highest-paid employees
- Filter employees by department or salary range
- Search employee names using pattern matching

## 🚀 How to Run
1. Open **MySQL Workbench**
2. Paste and run the script from `script.sql`
3. View table structure and query results


