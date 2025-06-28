# Day 17: Views

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    hire_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_worked INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'HR', 'Floor 1'),
(2, 'IT', 'Floor 2'),
(3, 'Sales', 'Floor 1'),
(4, 'Marketing', 'Floor 3'),
(5, 'Finance', 'Floor 2');

INSERT INTO employees (employee_id, name, salary, department_id, hire_date, status) VALUES
(101, 'Alice Johnson', 60000, 2, '2020-01-15', 'Active'),
(102, 'Bob Smith', 45000, 1, '2021-03-20', 'Active'),
(103, 'Charlie Brown', 52000, 3, '2019-11-10', 'Active'),
(104, 'David Wilson', 70000, 2, '2018-06-05', 'Active'),
(105, 'Eva Davis', 30000, 4, '2022-02-28', 'Active'),
(106, 'Frank Miller', 55000, 1, '2020-09-12', 'Inactive'),
(107, 'Grace Lee', 75000, 2, '2017-12-01', 'Active'),
(108, 'Helen Garcia', 40000, 3, '2021-07-15', 'Active'),
(109, 'Ian Chen', 47000, 4, '2020-04-22', 'Active'),
(110, 'Judy Wilson', 62000, 1, '2019-08-30', 'Active');

INSERT INTO projects (project_id, project_name, department_id, start_date, end_date, budget, status) VALUES
(1, 'Employee Portal', 2, '2024-01-01', '2024-06-30', 50000.00, 'In Progress'),
(2, 'CRM Implementation', 3, '2023-10-01', '2024-01-31', 75000.00, 'Completed'),
(3, 'Marketing Campaign', 4, '2024-02-01', '2024-05-31', 30000.00, 'On Hold'),
(4, 'Budget Planning', 5, '2024-01-15', '2024-03-31', 15000.00, 'In Progress'),
(5, 'Recruitment System', 1, '2023-12-01', '2024-02-28', 25000.00, 'Completed');

INSERT INTO employee_projects (employee_id, project_id, role, hours_worked) VALUES
(101, 1, 'Developer', 160),
(102, 5, 'Analyst', 120),
(103, 2, 'Manager', 200),
(104, 1, 'Lead Developer', 180),
(105, 3, 'Designer', 140),
(106, 5, 'Tester', 80),
(107, 2, 'Developer', 160),
(108, 4, 'Analyst', 100);
```

## 📌 Questions

1. Create view_active_employees
2. Create view to show department and average salary
3. Query from both views
4. Create view for project summary
5. Create view for employee project assignments
6. Create view for department statistics 