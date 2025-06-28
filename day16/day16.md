# Day 16: EXISTS vs NOT EXISTS

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
    department_name VARCHAR(50)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20)
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    employee_id INT,
    subject VARCHAR(200),
    status VARCHAR(20),
    created_date DATE,
    resolved_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    registration_date DATE
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing'), (5, 'Finance');

INSERT INTO employees (employee_id, name, salary, department_id, hire_date) VALUES
(101, 'Alice Johnson', 60000, 2, '2020-01-15'),
(102, 'Bob Smith', 45000, 1, '2021-03-20'),
(103, 'Charlie Brown', 52000, 3, '2019-11-10'),
(104, 'David Wilson', 70000, 2, '2018-06-05'),
(105, 'Eva Davis', 30000, 4, '2022-02-28'),
(106, 'Frank Miller', 55000, 1, '2020-09-12'),
(107, 'Grace Lee', 75000, 2, '2017-12-01'),
(108, 'Helen Garcia', 40000, 3, '2021-07-15'),
(109, 'Ian Chen', 47000, 4, '2020-04-22'),
(110, 'Judy Wilson', 62000, 1, '2019-08-30');

INSERT INTO projects (project_id, project_name, start_date, end_date, status) VALUES
(1, 'Employee Portal', '2024-01-01', '2024-06-30', 'In Progress'),
(2, 'CRM Implementation', '2023-10-01', '2024-01-31', 'Completed'),
(3, 'Marketing Campaign', '2024-02-01', '2024-05-31', 'On Hold'),
(4, 'Budget Planning', '2024-01-15', '2024-03-31', 'In Progress'),
(5, 'Recruitment System', '2023-12-01', '2024-02-28', 'Completed');

INSERT INTO employee_projects (employee_id, project_id, role, start_date, end_date) VALUES
(101, 1, 'Developer', '2024-01-01', NULL),
(102, 5, 'Analyst', '2023-12-01', '2024-02-28'),
(103, 2, 'Manager', '2023-10-01', '2024-01-31'),
(104, 1, 'Lead Developer', '2024-01-01', NULL),
(105, 3, 'Designer', '2024-02-01', NULL),
(106, 5, 'Tester', '2023-12-01', '2024-02-28'),
(107, 2, 'Developer', '2023-10-01', '2024-01-31'),
(108, 4, 'Analyst', '2024-01-15', NULL);

INSERT INTO tickets (ticket_id, employee_id, subject, status, created_date, resolved_date) VALUES
(1, 101, 'Login Issue', 'Resolved', '2024-01-15', '2024-01-16'),
(2, 102, 'System Access', 'Open', '2024-01-20', NULL),
(3, 103, 'Database Error', 'Resolved', '2024-01-25', '2024-01-26'),
(4, 104, 'Performance Issue', 'Open', '2024-02-01', NULL),
(5, 105, 'Feature Request', 'Resolved', '2024-02-05', '2024-02-10'),
(6, 106, 'Bug Report', 'Open', '2024-02-15', NULL);

INSERT INTO customers (customer_id, customer_name, email, registration_date) VALUES
(1, 'John Smith', 'john.smith@email.com', '2023-01-15'),
(2, 'Maria Garcia', 'maria.garcia@email.com', '2023-02-20'),
(3, 'David Wilson', 'david.wilson@email.com', '2023-03-10'),
(4, 'Anna Mueller', 'anna.mueller@email.com', '2023-04-05'),
(5, 'Carlos Rodriguez', 'carlos.rodriguez@email.com', '2023-05-12');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1, 1, '2024-01-15', 1500.00, 'Completed'),
(2, 2, '2024-01-20', 2300.00, 'Completed'),
(3, 1, '2024-02-01', 800.00, 'Completed'),
(4, 3, '2024-02-10', 3200.00, 'Completed'),
(5, 2, '2024-02-15', 1800.00, 'Completed'),
(6, 4, '2024-02-20', 2700.00, 'Completed');
```

## 📌 Questions

1. Employees assigned to at least one project
2. Employees with no ticket in past month
3. Customers who have placed orders
4. Departments with no employees
5. Projects with no assigned employees
6. Employees with salary above department average 