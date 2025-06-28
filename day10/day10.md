# Day 10: CASE & IF Logic

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

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    status VARCHAR(20),
    priority VARCHAR(20),
    start_date DATE,
    end_date DATE
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
(110, 'Judy Wilson', 62000, 1, '2019-08-30', 4.3);

INSERT INTO sales (sale_id, employee_id, amount, sale_date, region) VALUES
(1, 103, 15000.00, '2024-01-15', 'North'),
(2, 108, 22000.00, '2024-01-20', 'South'),
(3, 103, 18000.00, '2024-02-01', 'North'),
(4, 108, 12000.00, '2024-02-10', 'South'),
(5, 103, 25000.00, '2024-03-01', 'North');

INSERT INTO projects (project_id, project_name, status, priority, start_date, end_date) VALUES
(1, 'Employee Portal', 'In Progress', 'High', '2024-01-01', '2024-06-30'),
(2, 'CRM Implementation', 'Completed', 'Medium', '2023-10-01', '2024-01-31'),
(3, 'Marketing Campaign', 'On Hold', 'Low', '2024-02-01', '2024-05-31'),
(4, 'Budget Planning', 'In Progress', 'High', '2024-01-15', '2024-03-31'),
(5, 'Recruitment System', 'Completed', 'Medium', '2023-12-01', '2024-02-28');
```

## 📌 Questions

1. Grade employees (A/B/C) by salary slabs
2. Mark employees as 'New Joiner' if joined in last 90 days else 'Tenured'
3. Categorize sales performance based on amount
4. Assign project priority levels using CASE
5. Calculate bonus based on performance rating and tenure
6. Categorize employees by department and salary range 