# Day 20: Real Join Project (Ticket System)

## 🧱 Schema Creation

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    region VARCHAR(50),
    registration_date DATE
);

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    email VARCHAR(100),
    team_id INT,
    hire_date DATE,
    performance_rating DECIMAL(3,2),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES agents(agent_id)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    agent_id INT,
    priority VARCHAR(20),
    status VARCHAR(20),
    category VARCHAR(50),
    subject VARCHAR(200),
    description TEXT,
    created_date DATETIME,
    updated_date DATETIME,
    resolved_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE ticket_responses (
    response_id INT PRIMARY KEY,
    ticket_id INT,
    agent_id INT,
    response_text TEXT,
    response_date DATETIME,
    is_internal BOOLEAN,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE ticket_metrics (
    metric_id INT PRIMARY KEY,
    ticket_id INT,
    first_response_time INT, -- in minutes
    resolution_time INT, -- in minutes
    customer_satisfaction INT, -- 1-5 scale
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO customers (customer_id, customer_name, email, phone, region, registration_date) VALUES
(1, 'John Smith', 'john.smith@email.com', '555-0101', 'North', '2023-01-15'),
(2, 'Maria Garcia', 'maria.garcia@email.com', '555-0102', 'South', '2023-02-20'),
(3, 'David Wilson', 'david.wilson@email.com', '555-0103', 'North', '2023-03-10'),
(4, 'Anna Mueller', 'anna.mueller@email.com', '555-0104', 'South', '2023-04-05'),
(5, 'Carlos Rodriguez', 'carlos.rodriguez@email.com', '555-0105', 'North', '2023-05-12');

INSERT INTO teams (team_id, team_name, manager_id) VALUES
(1, 'General Support', NULL),
(2, 'Technical Support', NULL),
(3, 'Premium Support', NULL);

INSERT INTO agents (agent_id, agent_name, email, team_id, hire_date, performance_rating) VALUES
(1, 'Sarah Johnson', 'sarah.johnson@company.com', 1, '2022-01-15', 4.2),
(2, 'Mike Chen', 'mike.chen@company.com', 1, '2022-03-20', 4.5),
(3, 'Lisa Brown', 'lisa.brown@company.com', 2, '2022-06-10', 4.1),
(4, 'Tom Davis', 'tom.davis@company.com', 2, '2022-08-05', 3.9),
(5, 'Emma Wilson', 'emma.wilson@company.com', 3, '2022-11-12', 4.8);

-- Update team managers
UPDATE teams SET manager_id = 1 WHERE team_id = 1;
UPDATE teams SET manager_id = 3 WHERE team_id = 2;
UPDATE teams SET manager_id = 5 WHERE team_id = 3;

INSERT INTO tickets (ticket_id, customer_id, agent_id, priority, status, category, subject, description, created_date, updated_date, resolved_date) VALUES
(1, 1, 1, 'High', 'Resolved', 'Technical', 'Login Issue', 'Cannot login to the application', '2024-01-15 09:30:00', '2024-01-15 10:15:00', '2024-01-15 10:15:00'),
(2, 2, 2, 'Medium', 'Open', 'Billing', 'Invoice Question', 'Need clarification on recent invoice', '2024-01-16 14:20:00', '2024-01-16 14:20:00', NULL),
(3, 3, 3, 'Low', 'Resolved', 'General', 'Feature Request', 'Would like to see dark mode option', '2024-01-17 11:45:00', '2024-01-17 16:30:00', '2024-01-17 16:30:00'),
(4, 4, 4, 'High', 'In Progress', 'Technical', 'System Error', 'Getting 500 error when accessing dashboard', '2024-01-18 08:15:00', '2024-01-18 09:00:00', NULL),
(5, 5, 5, 'Medium', 'Resolved', 'Billing', 'Payment Issue', 'Payment not processing correctly', '2024-01-19 13:30:00', '2024-01-19 15:45:00', '2024-01-19 15:45:00'),
(6, 1, 1, 'Low', 'Open', 'General', 'Account Update', 'Need to update contact information', '2024-01-20 10:00:00', '2024-01-20 10:00:00', NULL),
(7, 2, 2, 'High', 'Resolved', 'Technical', 'API Integration', 'API calls failing with timeout', '2024-01-21 16:20:00', '2024-01-21 18:30:00', '2024-01-21 18:30:00'),
(8, 3, 3, 'Medium', 'In Progress', 'Billing', 'Subscription Change', 'Want to upgrade subscription plan', '2024-01-22 12:15:00', '2024-01-22 12:15:00', NULL);

INSERT INTO ticket_responses (response_id, ticket_id, agent_id, response_text, response_date, is_internal) VALUES
(1, 1, 1, 'Thank you for contacting support. I can help you with your login issue.', '2024-01-15 09:35:00', FALSE),
(2, 1, 1, 'Please try clearing your browser cache and cookies.', '2024-01-15 10:00:00', FALSE),
(3, 2, 2, 'I will look into your invoice question and get back to you shortly.', '2024-01-16 14:25:00', FALSE),
(4, 3, 3, 'Thank you for the feature request. I will forward this to our product team.', '2024-01-17 11:50:00', FALSE),
(5, 4, 4, 'I am investigating the system error you reported.', '2024-01-18 08:20:00', FALSE),
(6, 5, 5, 'I can see the payment issue. Let me help you resolve this.', '2024-01-19 13:35:00', FALSE);

INSERT INTO ticket_metrics (metric_id, ticket_id, first_response_time, resolution_time, customer_satisfaction) VALUES
(1, 1, 5, 45, 5),
(2, 3, 5, 285, 4),
(3, 5, 5, 135, 5),
(4, 7, 10, 130, 4);
```

## 📌 Questions

1. Tickets with agent name and open duration
2. Average handling time per agent
3. Customers with most support tickets
4. Team performance comparison
5. Ticket resolution time by priority
6. Customer satisfaction analysis 