--------------------------------------------- SQL Joins Practice----------------------------------------------------------

## Objective
Demonstrate and understand how to merge data from multiple tables using different types of SQL JOINs.

##  Tools Used
- MySQL Workbench *(recommended)*
- DB Browser for SQLite *(limited JOIN support)*

##  Tables Created
- `Customers`: Contains customer details (CustomerID, Name, City)
- `Orders`: Contains order details (OrderID, OrderDate, CustomerID, Amount)

## JOINs Demonstrated
1. **INNER JOIN** – Returns only records with matching CustomerID in both tables.
2. **LEFT JOIN** – Returns all records from `Customers`, even if no matching order exists.
3. **RIGHT JOIN** – Returns all records from `Orders`, even if no matching customer exists.
4. **FULL OUTER JOIN** – Combines LEFT and RIGHT JOIN; returns all records from both tables.

> 🔁 FULL OUTER JOIN is simulated using `UNION` as it's not natively supported in all MySQL versions.

##  How to Run
1. Open MySQL Workbench.
2. Paste and run the full script.
3. View results for each JOIN type.

##  Sample Data
- 4 customers (`Alice`, `Bob`, `Charlie`, `David`)
- 4 orders to test join behavior

##  Expected Outcome
Mastery of:
- How different SQL JOINs work
- When to use each JOIN type
- Identifying unmatched/missing relationships in datasets


