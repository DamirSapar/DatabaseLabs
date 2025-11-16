--Part 2
--Exercise 2.1
CREATE INDEX emp_salary_idx ON employees(salary);
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'employees';
--There are 2 indexes: the primary key index on emp_id, new index emp_salary_idx

--Exercise 2.2
CREATE INDEX emp_dept_idx ON employees(dept_id);
SELECT * FROM employees WHERE dept_id = 101;
--Indexing foreign keys is beneficial because queries filtering or joining on foreign keys become much faster

--Exercise 2.3
SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
--Automatic indexes:primary key indexes (employees_pkey, departments_pkey, projects_pkey), all others were created manually


--Part 3
--Exercise 3.1
CREATE INDEX emp_dept_salary_idx ON employees(dept_id, salary);
SELECT emp_name, salary
FROM employees
WHERE dept_id = 101 AND salary > 52000;
--No, this index is not useful for filtering only by salary, the first column (dept_id) must appear in the filter for PostgreSQL to use this index

--Exercise 3.2
CREATE INDEX emp_salary_dept_idx ON employees(salary, dept_id);
SELECT * FROM employees WHERE dept_id = 102 AND salary > 50000;
SELECT * FROM employees WHERE salary > 50000 AND dept_id = 102;
--Yes, column order matters.Index (salary, dept_id) is useful for queries starting with salary.Index (dept_id, salary) is useful for queries starting with dept_id.


--Part 4
--Exercise 4.1
ALTER TABLE employees ADD COLUMN email VARCHAR(100);

UPDATE employees SET email = 'john.smith@company.com' WHERE emp_id = 1;
UPDATE employees SET email = 'jane.doe@company.com' WHERE emp_id = 2;
UPDATE employees SET email = 'mike.johnson@company.com' WHERE emp_id = 3;
UPDATE employees SET email = 'sarah.williams@company.com' WHERE emp_id = 4;
UPDATE employees SET email = 'tom.brown@company.com' WHERE emp_id = 5;

CREATE UNIQUE INDEX emp_email_unique_idx ON employees(email);
INSERT INTO employees VALUES
(6, 'New Employee', 101, 55000, 'john.smith@company.com');
--ERROR: duplicate key value violates unique constraint … , Because the email already exists.

--Exercise 4.2
ALTER TABLE employees ADD COLUMN phone VARCHAR(20) UNIQUE;
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'employees' AND indexname LIKE '%phone%';
--Yes, PostgreSQL automatically created a unique B-tree index


--Part 5
--Exercise 5.1
CREATE INDEX emp_salary_desc_idx ON employees(salary DESC);
SELECT emp_name, salary FROM employees ORDER BY salary DESC;
--The index speeds up sorting because PostgreSQL can read salaries already sorted in descending order

--Exercise 5.2
CREATE INDEX proj_budget_nulls_first_idx ON projects(budget NULLS FIRST);
SELECT proj_name, budget
FROM projects
ORDER BY budget NULLS FIRST;


--Part 6
--Exercise 6.1
CREATE INDEX emp_name_lower_idx ON employees(LOWER(emp_name));
SELECT * FROM employees WHERE LOWER(emp_name) = 'john smith';
--Without this index, PostgreSQL must scan the entire table (Sequential Scan) and apply LOWER() to every row

--Exercise 6.2
ALTER TABLE employees ADD COLUMN hire_date DATE;

UPDATE employees SET hire_date = '2020-01-15' WHERE emp_id = 1;
UPDATE employees SET hire_date = '2019-06-20' WHERE emp_id = 2;
UPDATE employees SET hire_date = '2021-03-10' WHERE emp_id = 3;
UPDATE employees SET hire_date = '2020-11-05' WHERE emp_id = 4;
UPDATE employees SET hire_date = '2018-08-25' WHERE emp_id = 5;

CREATE INDEX emp_hire_year_idx ON employees(EXTRACT(YEAR FROM hire_date));
SELECT emp_name FROM employees WHERE EXTRACT(YEAR FROM hire_date) = 2020;


--Part 7
--Exercise 7.1
ALTER INDEX emp_salary_idx RENAME TO employees_salary_index;

--Exercise 7.2
DROP INDEX emp_salary_dept_idx;
--You drop indexes to reduce overhead — unused indexes slow down INSERT/UPDATE/DELETE

--Exercise 7.3
REINDEX INDEX employees_salary_index;


--Part 8
--Exercise 8.1
CREATE INDEX emp_salary_filter_idx ON employees(salary) WHERE salary > 50000;

--Exercise 8.2
CREATE INDEX proj_high_budget_idx ON projects(budget)
WHERE budget > 80000;
--A partial index is smaller, faster, and only covers the rows you actually need

--Exercise 8.3
EXPLAIN SELECT * FROM employees WHERE salary > 52000;
--If you see Index Scan : index is used. If you see Seq Scan : PostgreSQL scanned the whole table.


--Part 9
--Exercise 9.1
CREATE INDEX dept_name_hash_idx ON departments USING HASH (dept_name);
SELECT * FROM departments WHERE dept_name = 'IT';
--Hash indexes are useful ONLY for equality (=).They cannot be used for ranges

--Exercise 9.2
CREATE INDEX proj_name_btree_idx ON projects(proj_name);
CREATE INDEX proj_name_hash_idx ON projects USING HASH (proj_name);


--Part 10
--Exercise 10.1
SELECT
    schemaname,
    tablename,
    indexname,
    pg_size_pretty(pg_relation_size(indexname::regclass)) AS index_size
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
--The largest index is usually on the largest column or composite indexes.

--Exercise 10.2
DROP INDEX IF EXISTS proj_name_hash_idx;

--Exercise 10.3
CREATE VIEW index_documentation AS
SELECT
    tablename,
    indexname,
    indexdef,
    'Improves salary-based queries' AS purpose
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname LIKE '%salary%';
