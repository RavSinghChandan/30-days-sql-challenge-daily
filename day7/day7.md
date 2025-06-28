# Day 7: Multi-Level Joins

## 🧱 Schema Creation

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    manager_id INT,
    department_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
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

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    agent_id INT,
    customer_id INT,
    status VARCHAR(20),
    created_date DATE,
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales'), (4, 'Marketing');

INSERT INTO employees (employee_id, name, salary, manager_id, department_id) VALUES
(101, 'Alice', 60000, NULL, 2),
(102, 'Bob', 45000, 101, 1),
(103, 'Charlie', 52000, 101, 3),
(104, 'David', 70000, 101, 2),
(105, 'Eva', 30000, 102, 4),
(106, 'Frank', 55000, 102, 1),
(107, 'Grace', 75000, 104, 2),
(108, 'Helen', 40000, 103, 3);

INSERT INTO countries (country_id, country_name) VALUES
(1, 'USA'), (2, 'Canada'), (3, 'UK'), (4, 'Germany');

INSERT INTO customers (customer_id, customer_name, country_id) VALUES
(1, 'John Smith', 1),
(2, 'Maria Garcia', 2),
(3, 'David Wilson', 3),
(4, 'Anna Mueller', 4);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-01-15', 1500.00),
(2, 2, '2024-01-20', 2300.00),
(3, 1, '2024-02-01', 800.00),
(4, 3, '2024-02-10', 3200.00);

INSERT INTO teams (team_id, team_name) VALUES
(1, 'Support Team A'),
(2, 'Support Team B'),
(3, 'Premium Support');

INSERT INTO agents (agent_id, agent_name, team_id) VALUES
(1, 'Sarah Johnson', 1),
(2, 'Mike Chen', 1),
(3, 'Lisa Brown', 2),
(4, 'Tom Davis', 3);

INSERT INTO tickets (ticket_id, agent_id, customer_id, status, created_date) VALUES
(1, 1, 1, 'Open', '2024-01-15'),
(2, 2, 2, 'Closed', '2024-01-16'),
(3, 3, 1, 'Open', '2024-01-17'),
(4, 4, 3, 'Closed', '2024-01-18');
```

## 📌 Questions

1. Employees + Managers (same table)
2. Orders → Customers → Countries
3. Tickets → Agents → Teams
4. Show employee hierarchy (employee, manager, department)
5. Show order details with customer and country information
6. Show ticket details with agent and team information 