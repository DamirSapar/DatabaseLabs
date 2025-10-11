/*
Sapar Damir
ID:24B032191
*/
--Task 1.1
CREATE TABLE employees(
    employee_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    age INTEGER CHECK ( age BETWEEN 18 AND 65),
    salary NUMERIC CHECK ( salary > 0 )
);

--Task 1.2
CREATE TABLE products_catalog(
    product_id INTEGER,
    product_name TEXT,
    regular_price NUMERIC,
    discount_price NUMERIC,
    CONSTRAINT valid_discount CHECK ( regular_price>0 AND discount_price>0 AND discount_price<regular_price)
);

--Task 1.3
CREATE TABLE bookings(
    booking_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    num_guests INTEGER,
    CHECK ( num_guests BETWEEN 1 AND 10),
    CHECK ( check_out_date>check_in_date )
);

--Task 1.4
--  Valid inserts
INSERT INTO employees VALUES (1, 'John', 'Smith', 30, 5000);
INSERT INTO employees VALUES (2, 'Alice', 'Brown', 45, 8000);

--  Invalid: violates CHECK (age BETWEEN 18 AND 65)
-- INSERT INTO employees VALUES (3, 'Tom', 'Young', 16, 4000);

--  Invalid: violates CHECK (salary > 0)
-- INSERT INTO employees VALUES (4, 'Mary', 'Green', 25, -1000);


--  Valid product
INSERT INTO products_catalog VALUES (1, 'Laptop', 1000, 800);
INSERT INTO products_catalog VALUES (2, 'Phone', 700, 600);

--  Invalid: violates valid_discount (discount_price >= regular_price)
-- INSERT INTO products_catalog VALUES (3, 'Tablet', 500, 600);

--  Invalid: violates valid_discount (regular_price <= 0)
-- INSERT INTO products_catalog VALUES (4, 'TV', 0, 100);


--  Valid booking
INSERT INTO bookings VALUES (1, '2025-10-10', '2025-10-15', 2);
INSERT INTO bookings VALUES (2, '2025-11-01', '2025-11-05', 4);

--  Invalid: violates CHECK (num_guests BETWEEN 1 AND 10)
-- INSERT INTO bookings VALUES (3, '2025-10-20', '2025-10-25', 12);

--  Invalid: violates CHECK (check_out_date > check_in_date)
-- INSERT INTO bookings VALUES (4, '2025-10-25', '2025-10-20', 3);

--Task 2.1
CREATE TABLE customers(
    customer_id INTEGER NOT NULL ,
    email TEXT NOT NULL ,
    phone TEXT,
    registration_date DATE NOT NULL
);

--Task 2.2
CREATE TABLE inventory(
    item_id INTEGER NOT NULL ,
    item_name TEXT NOT NULL ,
    quantity INTEGER NOT NULL CHECK ( quantity>=0 ),
    unit_price NUMERIC NOT NULL CHECK ( unit_price>0 ),
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--Task 2.3
--  Valid inserts (всё корректно)
INSERT INTO customers VALUES (1, 'john@example.com', '1234567890', '2025-10-10');
INSERT INTO customers VALUES (2, 'anna@example.com', NULL, '2025-10-11');  -- phone может быть NULL

--  Invalid: violates NOT NULL on email
-- INSERT INTO customers VALUES (3, NULL, '9999999999', '2025-10-12');
-- Error: column "email" contains NULL, but NOT NULL prohibits it.

--  Invalid: violates NOT NULL on registration_date
-- INSERT INTO customers VALUES (4, 'kate@example.com', '8888888888', NULL);


--  Valid inventory items
INSERT INTO inventory VALUES (1, 'Laptop', 10, 1200, DEFAULT);
INSERT INTO inventory VALUES (2, 'Mouse', 50, 20, '2025-10-10 12:00:00');

--  Invalid: violates CHECK (quantity >= 0)
-- INSERT INTO inventory VALUES (3, 'Keyboard', -5, 100, '2025-10-10 12:00:00');

--  Invalid: violates CHECK (unit_price > 0)
-- INSERT INTO inventory VALUES (4, 'Monitor', 10, 0, '2025-10-10 12:00:00');

--  Invalid: violates NOT NULL on item_name
-- INSERT INTO inventory VALUES (5, NULL, 5, 10, '2025-10-10 12:00:00');

--Task 3.1
CREATE TABLE users(
    user_id INTEGER,
    username TEXT  UNIQUE ,
    email TEXT  UNIQUE ,
    created_at TIMESTAMP
);

--Task 3.2
CREATE TABLE course_enrollments(
    enrollment_id INTEGER,
    student_id INTEGER,
    course_code TEXT,
    semester TEXT,
    UNIQUE (student_id,course_code,semester)
);

--Task 3.3
ALTER TABLE users
ADD CONSTRAINT unique_username UNIQUE (username);

ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);
--  Valid inserts
INSERT INTO users VALUES (1, 'damian', 'damian@example.com', DEFAULT);
INSERT INTO users VALUES (2, 'alice', 'alice@example.com', DEFAULT);

--  Invalid: violates unique_username (duplicate username)
-- INSERT INTO users VALUES (3, 'damian', 'damian2@example.com', DEFAULT);
-- Error: repeating username "damian" violates the unique_username.

--  Invalid: violates unique_email (duplicate email)
-- INSERT INTO users VALUES (4, 'john', 'alice@example.com', DEFAULT);
-- Error: email replay "alice@example.com " — violates unique_email.


--  Valid course enrollments
INSERT INTO course_enrollments VALUES (1, 101, 'CS101', 'Fall 2025');
INSERT INTO course_enrollments VALUES (2, 102, 'CS101', 'Fall 2025');
INSERT INTO course_enrollments VALUES (3, 101, 'CS102', 'Fall 2025'); -- тот же студент, но другой курс

--  Invalid: violates UNIQUE (student_id, course_code, semester)
-- INSERT INTO course_enrollments VALUES (4, 101, 'CS101', 'Fall 2025');
-- Error: Student 101 is already enrolled in CS101 in Fall 2025.

--Task 4.1
CREATE TABLE departments(
    dept_id INTEGER PRIMARY KEY ,
    dept_name TEXT NOT NULL ,
    location TEXT
);
--  Valid inserts (всё корректно)
INSERT INTO departments VALUES (1, 'Human Resources', 'Astana');
INSERT INTO departments VALUES (2, 'Finance', 'Almaty');
INSERT INTO departments VALUES (3, 'IT', 'Shymkent');

--  Invalid: duplicate dept_id (violates PRIMARY KEY)
-- INSERT INTO departments VALUES (1, 'Marketing', 'Astana');
-- Error: duplicate key value "departments_pkey" — dept_id = 1 already exists.

--  Invalid: NULL dept_id (violates NOT NULL property of PRIMARY KEY)
-- INSERT INTO departments VALUES (NULL, 'Logistics', 'Aktobe');
-- Error: The PRIMARY KEY cannot contain NULL, as it must identify the record..

--Task 4.2
CREATE TABLE student_courses(
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);

/*
Task 4.3 — Comparison Exercise

1. Difference between UNIQUE and PRIMARY KEY:
   - PRIMARY KEY uniquely identifies each record in a table.
     It automatically implies NOT NULL and UNIQUE.
   - UNIQUE ensures all values in a column are different,
     but it allows NULL values and is not the main identifier.

2. When to use a single-column vs. composite PRIMARY KEY:
   - Use a single-column key when one attribute uniquely identifies a record (e.g., dept_id).
   - Use a composite key when a combination of two or more columns is needed to ensure uniqueness
     (e.g., student_id + course_id in student_courses).

3. Why a table can have only one PRIMARY KEY but multiple UNIQUE constraints:
   - A table represents one main entity, so it should have one main identifier — one PRIMARY KEY.
   - However, it can have multiple UNIQUE constraints to ensure uniqueness for other important columns
     (like email, username, etc.).
*/

 --Task 5.1
 CREATE TABLE employees_dept(
     emp_id INTEGER PRIMARY KEY ,
     emp_name TEXT NOT NULL ,
     dept_id INTEGER REFERENCES departments(dept_id),
     hire_date DATE
 );
 INSERT INTO employees_dept VALUES (1, 'John Doe', 1, '2024-05-10');
INSERT INTO employees_dept VALUES (2, 'Alice Brown', 2, '2024-06-15');
INSERT INTO employees_dept VALUES (3, 'Michael Smith', 3, '2024-07-01');
-- Нарушение внешнего ключа (FOREIGN KEY)
-- INSERT INTO employees_dept VALUES (4, 'Sarah Green', 99, '2024-08-01');
-- Error: The inserted dept_id = 99 does not exist in the departments table.

--Task 5.2
CREATE TABLE authors(
    author_id INTEGER PRIMARY KEY ,
    author_name TEXT NOT NULL ,
    country TEXT
);

CREATE TABLE publishers(
    publisher_id INTEGER PRIMARY KEY ,
    publisher_name TEXT NOT NULL ,
    city TEXT
);

CREATE TABLE books(
    book_id INTEGER PRIMARY KEY ,
    title TEXT NOT NULL ,
    author_id INTEGER REFERENCES authors(author_id),
    publisher_id INTEGER REFERENCES publishers(publisher_id),
    publication_year INTEGER,
    isbn TEXT UNIQUE
);

INSERT INTO authors VALUES (1, 'George Orwell', 'United Kingdom');
INSERT INTO authors VALUES (2, 'Fyodor Dostoevsky', 'Russia');
INSERT INTO authors VALUES (3, 'Haruki Murakami', 'Japan');

INSERT INTO publishers VALUES (1, 'Penguin Books', 'London');
INSERT INTO publishers VALUES (2, 'Vintage', 'New York');
INSERT INTO publishers VALUES (3, 'Kodansha', 'Tokyo');

INSERT INTO books VALUES (1, '1984', 1, 1, 1949, '9780451524935');
INSERT INTO books VALUES (2, 'Crime and Punishment', 2, 2, 1866, '9780140449136');
INSERT INTO books VALUES (3, 'Kafka on the Shore', 3, 3, 2002, '9781400079278');

--Task 5.3
CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY ,
    category_name TEXT NOT NULL
);

CREATE TABLE products_fk(
    product_id INTEGER PRIMARY KEY ,
    product_name TEXT NOT NULL ,
    category_id INTEGER REFERENCES categories(category_id) ON DELETE RESTRICT
);

CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY ,
    order_date DATE NOT NULL
);

CREATE TABLE order_items(
    item_id INTEGER PRIMARY KEY ,
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE ,
    product_id INTEGER REFERENCES products_fk(product_id),
    quantity INTEGER CHECK ( quantity>0 )
);

-- Категории
INSERT INTO categories VALUES (1, 'Electronics');
INSERT INTO categories VALUES (2, 'Clothing');

-- Продукты (ссылаются на категории)
INSERT INTO products_fk VALUES (1, 'Laptop', 1);
INSERT INTO products_fk VALUES (2, 'T-Shirt', 2);

-- Заказы
INSERT INTO orders VALUES (1, '2025-10-10');
INSERT INTO orders VALUES (2, '2025-10-11');

-- Элементы заказов
INSERT INTO order_items VALUES (1, 1, 1, 2);  -- 2 ноутбука
INSERT INTO order_items VALUES (2, 1, 2, 3);  -- 3 футболки
INSERT INTO order_items VALUES (3, 2, 1, 1);  -- 1 ноутбук в другом заказе

/*
   Scenario 1: Try to delete a category that has products (RESTRICT)

   Expected: FAIL
   Because ON DELETE RESTRICT prevents deleting a category
   if there are products linked to it.
 */

-- DELETE FROM categories WHERE category_id = 1;

-- Result:
-- ERROR: update or delete on table "categories" violates foreign key constraint
-- "products_fk_category_id_fkey" on table "products_fk"
-- DETAIL: Key (category_id)=(1) is still referenced from table "products_fk".
--  Explanation: The deletion failed because category 'Electronics'
-- still has linked products in products_fk.


/*
   Scenario 2: Delete an order and observe CASCADE effect

   Expected: SUCCESS
   Because ON DELETE CASCADE automatically removes related order_items.
 */

-- Before deletion:
-- SELECT * FROM order_items;
--  item_id | order_id | product_id | quantity
-- ---------+-----------+------------+----------
--     1    |     1     |     1      |     2
--     2    |     1     |     2      |     3
--     3    |     2     |     1      |     1

-- Perform deletion
DELETE FROM orders WHERE order_id = 1;

-- After deletion:
-- SELECT * FROM order_items;
--  item_id | order_id | product_id | quantity
-- ---------+-----------+------------+----------
--     3    |     2     |     1      |     1
--  Explanation: All order_items linked to order_id = 1 were
-- automatically deleted due to ON DELETE CASCADE.


/*
   Scenario 3: Documenting results

   - Deleting a category with products (RESTRICT): FAILED, category remains.
   - Deleting an order with items (CASCADE): SUCCESS, related order_items deleted.
   - Verification shows only remaining items from order_id = 2.
 */

-- Task 6.1

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL CHECK (price >= 0),
    stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount NUMERIC NOT NULL CHECK (total_amount >= 0),
    status TEXT NOT NULL CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
);

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price > 0)
);

INSERT INTO customers VALUES
(1, 'Damir Spencer', 'damir@example.com', '87070000001', '2025-09-01'),
(2, 'Alice Brown', 'alice@example.com', '87070000002', '2025-09-02'),
(3, 'John Doe', 'john@example.com', '87070000003', '2025-09-03'),
(4, 'Maria Green', 'maria@example.com', '87070000004', '2025-09-04'),
(5, 'Alex Johnson', 'alex@example.com', '87070000005', '2025-09-05');

INSERT INTO products VALUES
(1, 'Laptop', '15-inch display, 16GB RAM', 1200, 10),
(2, 'Mouse', 'Wireless optical mouse', 25, 100),
(3, 'Keyboard', 'Mechanical RGB keyboard', 80, 50),
(4, 'Monitor', '27-inch 144Hz', 300, 20),
(5, 'Headphones', 'Noise cancelling', 150, 30);

INSERT INTO orders VALUES
(1, 1, '2025-10-01', 1250, 'pending'),
(2, 2, '2025-10-02', 150, 'processing'),
(3, 3, '2025-10-03', 300, 'shipped'),
(4, 4, '2025-10-04', 80, 'delivered'),
(5, 5, '2025-10-05', 1400, 'pending');

INSERT INTO order_details VALUES
(1, 1, 1, 1, 1200),  -- Laptop
(2, 1, 2, 2, 25),    -- 2 Mice
(3, 2, 5, 1, 150),   -- Headphones
(4, 3, 4, 1, 300),   -- Monitor
(5, 5, 1, 1, 1200);  -- Laptop

--  Duplicate email violates UNIQUE
-- INSERT INTO customers VALUES (6, 'Duplicate', 'damir@example.com', '87070000006', '2025-09-06');
-- ERROR: duplicate key value violates unique constraint "customers_email_key"

--  Negative price violates CHECK (price >= 0)
-- INSERT INTO products VALUES (6, 'Broken Item', 'Invalid price', -10, 5);

--  Invalid status violates CHECK (status IN (...))
-- INSERT INTO orders VALUES (6, 1, '2025-10-10', 200, 'returned');

-- Deleting customer with id = 1 will delete all their orders automatically
DELETE FROM customers WHERE customer_id = 1;

-- Check results:
-- SELECT * FROM orders WHERE customer_id = 1;  -- Should return 0 rows
-- SELECT * FROM order_details WHERE order_id = 1;  -- Should also be deleted automatically

--  Quantity cannot be 0
-- INSERT INTO order_details VALUES (6, 2, 3, 0, 80);
-- ERROR: new row violates check constraint "order_details_quantity_check"

/*

E-COMMERCE DATABASE TEST RESULTS

1. UNIQUE constraint on email works correctly — duplicate emails rejected.
2. CHECK constraints prevent negative prices, stock, or invalid order status.
3. FOREIGN KEY with ON DELETE CASCADE:
   - When a customer is deleted, all related orders and order_details are also removed.
4. Quantity > 0 constraint verified — invalid rows rejected.
5. All NOT NULL columns prevent incomplete data from being inserted.

*/
