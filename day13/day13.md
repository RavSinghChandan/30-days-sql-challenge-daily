# Day 13: Aggregate + Joins

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    agent_id INT,
    customer_id INT,
    status VARCHAR(20),
    created_date DATE,
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing'), (5, 'Finance');

INSERT INTO employees (employee_id, name, salary, department_id) VALUES
(101, 'Alice Johnson', 60000, 2),
(102, 'Bob Smith', 45000, 1),
(103, 'Charlie Brown', 52000, 3),
(104, 'David Wilson', 70000, 2),
(105, 'Eva Davis', 30000, 4),
(106, 'Frank Miller', 55000, 1),
(107, 'Grace Lee', 75000, 2),
(108, 'Helen Garcia', 40000, 3);

INSERT INTO teams (team_id, team_name) VALUES
(1, 'Support Team A'),
(2, 'Support Team B'),
(3, 'Premium Support');

INSERT INTO agents (agent_id, agent_name, team_id) VALUES
(1, 'Sarah Johnson', 1),
(2, 'Mike Chen', 1),
(3, 'Lisa Brown', 2),
(4, 'Tom Davis', 3);

INSERT INTO customers (customer_id, customer_name, region) VALUES
(1, 'John Smith', 'North'),
(2, 'Maria Garcia', 'South'),
(3, 'David Wilson', 'North'),
(4, 'Anna Mueller', 'South');

INSERT INTO tickets (ticket_id, agent_id, customer_id, status, created_date) VALUES
(1, 1, 1, 'Open', '2024-01-15'),
(2, 2, 2, 'Closed', '2024-01-16'),
(3, 3, 1, 'Open', '2024-01-17'),
(4, 4, 3, 'Closed', '2024-01-18'),
(5, 1, 2, 'Open', '2024-01-19'),
(6, 2, 4, 'Closed', '2024-01-20');

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-01-15', 1500.00),
(2, 2, '2024-01-20', 2300.00),
(3, 1, '2024-02-01', 800.00),
(4, 3, '2024-02-10', 3200.00),
(5, 2, '2024-02-15', 1800.00),
(6, 4, '2024-02-20', 2700.00);
```

## 📌 Questions

1. Highest paid employee per department
2. Count of open tickets per agent
3. Total revenue by customer per region
4. Average salary by department with employee count
5. Total orders and revenue by customer
6. Agent performance (tickets closed vs open) 