# Day 12: Window Functions

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    hire_date DATE,
    performance_rating DECIMAL(3,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    amount DECIMAL(10,2),
    sale_date DATE,
    region VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    region VARCHAR(50)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing'), (5, 'Finance');

INSERT INTO employees (employee_id, name, salary, department_id, hire_date, performance_rating) VALUES
(101, 'Alice Johnson', 60000, 2, '2020-01-15', 4.2),
(102, 'Bob Smith', 45000, 1, '2021-03-20', 3.8),
(103, 'Charlie Brown', 52000, 3, '2019-11-10', 4.5),
(104, 'David Wilson', 70000, 2, '2018-06-05', 3.9),
(105, 'Eva Davis', 30000, 4, '2022-02-28', 4.1),
(106, 'Frank Miller', 55000, 1, '2020-09-12', 3.7),
(107, 'Grace Lee', 75000, 2, '2017-12-01', 4.8),
(108, 'Helen Garcia', 40000, 3, '2021-07-15', 4.0),
(109, 'Ian Chen', 47000, 4, '2020-04-22', 3.6),
(110, 'Judy Wilson', 62000, 1, '2019-08-30', 4.3),
(111, 'Kevin Park', 65000, 2, '2020-05-10', 4.4),
(112, 'Lisa Wang', 58000, 3, '2021-01-15', 4.1);

INSERT INTO sales (sale_id, employee_id, amount, sale_date, region) VALUES
(1, 103, 15000.00, '2024-01-15', 'North'),
(2, 108, 22000.00, '2024-01-20', 'South'),
(3, 103, 18000.00, '2024-02-01', 'North'),
(4, 108, 12000.00, '2024-02-10', 'South'),
(5, 103, 25000.00, '2024-03-01', 'North'),
(6, 112, 19000.00, '2024-03-05', 'North'),
(7, 108, 16000.00, '2024-03-10', 'South'),
(8, 103, 21000.00, '2024-03-15', 'North');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, region) VALUES
(1, 1, '2024-01-01', 1500.00, 'North'),
(2, 2, '2024-01-02', 2300.00, 'South'),
(3, 3, '2024-01-03', 800.00, 'North'),
(4, 4, '2024-01-04', 3200.00, 'South'),
(5, 5, '2024-01-05', 1800.00, 'North'),
(6, 6, '2024-01-06', 2700.00, 'South'),
(7, 7, '2024-01-07', 1200.00, 'North'),
(8, 8, '2024-01-08', 4100.00, 'South');
```

## 📌 Questions

1. Rank employees by salary within department
2. Running total of salaries
3. Difference between max salary and each employee's salary
4. Calculate moving average of sales amounts
5. Find employees with top 2 salaries in each department
6. Calculate cumulative sum of order amounts by region 