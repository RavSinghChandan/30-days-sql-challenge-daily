# Day 11: CTE (Common Table Expressions)

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    manager_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing'), (5, 'Finance');

INSERT INTO employees (employee_id, name, salary, department_id, manager_id, hire_date) VALUES
(101, 'Alice Johnson', 60000, 2, NULL, '2020-01-15'),
(102, 'Bob Smith', 45000, 1, 101, '2021-03-20'),
(103, 'Charlie Brown', 52000, 3, 101, '2019-11-10'),
(104, 'David Wilson', 70000, 2, 101, '2018-06-05'),
(105, 'Eva Davis', 30000, 4, 102, '2022-02-28'),
(106, 'Frank Miller', 55000, 1, 102, '2020-09-12'),
(107, 'Grace Lee', 75000, 2, 104, '2017-12-01'),
(108, 'Helen Garcia', 40000, 3, 103, '2021-07-15'),
(109, 'Ian Chen', 47000, 4, 102, '2020-04-22'),
(110, 'Judy Wilson', 62000, 1, 102, '2019-08-30'),
(111, 'Kevin Park', 65000, 2, 104, '2020-05-10'),
(112, 'Lisa Wang', 58000, 3, 103, '2021-01-15');

INSERT INTO projects (project_id, project_name, department_id, start_date, end_date) VALUES
(1, 'Employee Portal', 2, '2024-01-01', '2024-06-30'),
(2, 'Recruitment System', 1, '2024-02-01', '2024-05-31'),
(3, 'CRM Implementation', 3, '2024-01-15', '2024-04-30'),
(4, 'Brand Campaign', 4, '2024-03-01', '2024-07-31'),
(5, 'Budget Planning', 5, '2024-01-10', '2024-03-31');
```

## 📌 Questions

1. Find 2nd highest salary in each department
2. Recursive CTE to find reporting hierarchy of an employee
3. Find employees with salary above department average using CTE
4. Calculate running total of salaries by department
5. Find top 3 employees by salary in each department
6. Create a CTE to show employee count and average salary by department 