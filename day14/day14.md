# Day 14: Date Functions

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    birth_date DATE,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    delivery_date DATE,
    total_amount DECIMAL(10,2)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing');

INSERT INTO employees (employee_id, name, salary, department_id, birth_date, hire_date) VALUES
(101, 'Alice Johnson', 60000, 2, '1990-05-15', '2020-01-15'),
(102, 'Bob Smith', 45000, 1, '1985-12-20', '2021-03-20'),
(103, 'Charlie Brown', 52000, 3, '1988-08-10', '2019-11-10'),
(104, 'David Wilson', 70000, 2, '1982-03-05', '2018-06-05'),
(105, 'Eva Davis', 30000, 4, '1995-07-28', '2022-02-28'),
(106, 'Frank Miller', 55000, 1, '1987-11-12', '2020-09-12'),
(107, 'Grace Lee', 75000, 2, '1980-06-01', '2017-12-01'),
(108, 'Helen Garcia', 40000, 3, '1992-04-15', '2021-07-15');

INSERT INTO projects (project_id, project_name, start_date, end_date, status) VALUES
(1, 'Employee Portal', '2024-01-01', '2024-06-30', 'In Progress'),
(2, 'CRM Implementation', '2023-10-01', '2024-01-31', 'Completed'),
(3, 'Marketing Campaign', '2024-02-01', '2024-05-31', 'On Hold'),
(4, 'Budget Planning', '2024-01-15', '2024-03-31', 'In Progress'),
(5, 'Recruitment System', '2023-12-01', '2024-02-28', 'Completed');

INSERT INTO orders (order_id, customer_id, order_date, delivery_date, total_amount) VALUES
(1, 1, '2024-01-15', '2024-01-20', 1500.00),
(2, 2, '2024-01-20', '2024-01-25', 2300.00),
(3, 3, '2024-02-01', '2024-02-05', 800.00),
(4, 4, '2024-02-10', '2024-02-15', 3200.00),
(5, 5, '2024-02-15', '2024-02-20', 1800.00);
```

## 📌 Questions

1. Employees joined in last 3 months
2. Calculate age of each employee
3. Days remaining for next work anniversary
4. Projects that started in current year
5. Employees with upcoming birthdays (next 30 days)
6. Average project duration by status 