# Day 8: Subqueries

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    head_employee_id INT,
    FOREIGN KEY (head_employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    start_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO employees (employee_id, name, salary, department_id, hire_date) VALUES
(101, 'Alice', 60000, 2, '2020-01-15'),
(102, 'Bob', 45000, 1, '2021-03-20'),
(103, 'Charlie', 52000, 3, '2019-11-10'),
(104, 'David', 70000, 2, '2018-06-05'),
(105, 'Eva', 30000, 4, '2022-02-28'),
(106, 'Frank', 55000, 1, '2020-09-12'),
(107, 'Grace', 75000, 2, '2017-12-01'),
(108, 'Helen', 40000, 3, '2021-07-15'),
(109, 'Ian', 47000, 4, '2020-04-22'),
(110, 'Judy', 62000, 1, '2019-08-30');

INSERT INTO departments (department_id, department_name, head_employee_id) VALUES
(1, 'HR', 102),
(2, 'IT', 104),
(3, 'Sales', 103),
(4, 'Marketing', 109);

INSERT INTO projects (project_id, project_name, department_id, start_date) VALUES
(1, 'Employee Portal', 2, '2023-01-15'),
(2, 'Recruitment System', 1, '2023-02-01'),
(3, 'CRM Implementation', 3, '2023-01-20'),
(4, 'Brand Campaign', 4, '2023-03-01');
```

## 📌 Questions

1. Employees earning above overall average salary
2. Employees who joined before their department head
3. Departments where no one earns below 40k
4. Find employees with salary higher than the average salary in their department
5. Find departments that have more employees than the average department
6. Find employees who earn more than the highest salary in Marketing department 