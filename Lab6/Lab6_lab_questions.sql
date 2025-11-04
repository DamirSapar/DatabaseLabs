-- Question 1:
--INNER JOIN returns only rows with matching values in both tables. LEFT JOIN returns all rows from the left table and only matching rows from the right table, using NULL for non-matches on the right.

-- Question 2:
--To generate a Cartesian product (all possible combinations) of rows from two tables. A common use is creating an availability matrix or schedule

-- Question 3:
--For outer joins (like LEFT JOIN), the ON condition filters before the join preserves unmatched rows, while the WHERE clause filters after the join, potentially excluding the preserved outer table's rows. For inner joins, both clauses produce the same result because non-matching rows are excluded regardless.

-- Question 4:
--The result is 50.A CROSS JOIN calculates the Cartesian product, so the total count is 5 * 10 = 50

-- Question 5:
--It automatically joins on all columns that share the exact same name in both tables

-- Question 6:
--The primary risk is unintended joins or code fragility.If two columns that are not intended for joining accidentally share the same name, the join condition will silently change, leading to incorrect results.

-- Question 7:
--SELECT * FROM B RIGHT JOIN A ON A.id = B.id

-- Question 8:
--Use it when you need all rows from both tables, with NULL values where no match exists. It's ideal for finding orphaned records
