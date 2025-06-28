# Day 9: UNION vs UNION ALL

## 🧱 Schema Creation

```sql
CREATE TABLE employees_old_branch (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department VARCHAR(50),
    hire_date DATE
);

CREATE TABLE employees_new_branch (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department VARCHAR(50),
    hire_date DATE
);

CREATE TABLE active_employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    status VARCHAR(20)
);

CREATE TABLE inactive_employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    status VARCHAR(20)
);

CREATE TABLE products_2023 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

CREATE TABLE products_2024 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);
```

## 📥 Sample Data

```sql
INSERT INTO employees_old_branch (employee_id, name, salary, department, hire_date) VALUES
(101, 'Alice Johnson', 60000, 'IT', '2020-01-15'),
(102, 'Bob Smith', 45000, 'HR', '2021-03-20'),
(103, 'Charlie Brown', 52000, 'Sales', '2019-11-10'),
(104, 'David Wilson', 70000, 'IT', '2018-06-05'),
(105, 'Eva Davis', 30000, 'Marketing', '2022-02-28');

INSERT INTO employees_new_branch (employee_id, name, salary, department, hire_date) VALUES
(201, 'Frank Miller', 55000, 'HR', '2023-01-10'),
(202, 'Grace Lee', 75000, 'IT', '2023-02-15'),
(203, 'Helen Garcia', 40000, 'Sales', '2023-03-01'),
(204, 'Ian Chen', 47000, 'Marketing', '2023-04-05'),
(105, 'Eva Davis', 30000, 'Marketing', '2022-02-28'); -- Duplicate employee

INSERT INTO active_employees (employee_id, name, status) VALUES
(101, 'Alice Johnson', 'Active'),
(102, 'Bob Smith', 'Active'),
(103, 'Charlie Brown', 'Active'),
(104, 'David Wilson', 'Active');

INSERT INTO inactive_employees (employee_id, name, status) VALUES
(105, 'Eva Davis', 'Inactive'),
(106, 'Frank Miller', 'Inactive'),
(103, 'Charlie Brown', 'Inactive'); -- Duplicate employee

INSERT INTO products_2023 (product_id, product_name, price, category) VALUES
(1, 'Laptop Pro', 1200.00, 'Electronics'),
(2, 'Office Chair', 300.00, 'Furniture'),
(3, 'Coffee Maker', 150.00, 'Appliances'),
(4, 'Desk Lamp', 80.00, 'Furniture');

INSERT INTO products_2024 (product_id, product_name, price, category) VALUES
(5, 'Smartphone X', 800.00, 'Electronics'),
(6, 'Standing Desk', 400.00, 'Furniture'),
(7, 'Blender', 120.00, 'Appliances'),
(1, 'Laptop Pro', 1200.00, 'Electronics'); -- Duplicate product
```

## 📌 Questions

1. Combine employee data from two tables (old and new branches) using UNION
2. Combine employee data from two tables using UNION ALL
3. Fetch all distinct and non-distinct employee records
4. Combine active and inactive employees using UNION
5. Combine active and inactive employees using UNION ALL
6. Combine products from 2023 and 2024 using both UNION and UNION ALL 