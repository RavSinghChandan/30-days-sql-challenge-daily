# Day 1: SELECT, WHERE, DISTINCT

## 🧱 Schema Creation

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Marketing');

INSERT INTO employees (employee_id, name, salary, department_id) VALUES
(101, 'Alice', 60000, 2),
(102, 'Bob', 45000, 1),
(103, 'Charlie', 52000, 3),
(104, 'David', 70000, 2),
(105, 'Eva', 30000, 4),
(106, 'Frank', 55000, 1),
(107, 'Grace', 75000, 2),
(108, 'Helen', 40000, 3),
(109, 'Ian', 47000, 4),
(110, 'Judy', 62000, 1);
```

## 📌 Questions

1. Fetch all employees.
2. Get unique department names.
3. Select only those with salary > 50000.
4. Select only those working in IT or HR.
