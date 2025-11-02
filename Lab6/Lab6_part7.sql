-- Exercise 7.1
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id AND
d.location = 'Building A';

-- Exercise 7.2
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE d.location = 'Building A';
--Query 1 (ON clause): Applies the filter BEFORE the join, so all employees are included, but only departments in Building A are matched.
--Query 2 (WHERE clause): Applies the filter AFTER the join, so employees are excluded if their department is not in Building A.

-- Exercise 7.3
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id AND d.location = 'Building A';

SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE d.location = 'Building A';

--No, there is no difference in the results between Query 1 (filter in ON) and Query 2 (filter in WHERE) when using an INNER JOIN
/*
An INNER JOIN only includes rows that satisfy all conditions for both the join and the filter. Since both clauses filter out non-matching rows and rows where d.location is not 'Building A', the set of rows returned is identical regardless of where the d.location = 'Building A' condition is placed.
*/