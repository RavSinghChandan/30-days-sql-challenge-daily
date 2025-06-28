-- 1. Employees + Managers (same table)
SELECT 
    e.name as employee_name,
    e.salary as employee_salary,
    m.name as manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 2. Orders → Customers → Countries
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.customer_name,
    co.country_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN countries co ON c.country_id = co.country_id;

-- 3. Tickets → Agents → Teams
SELECT 
    t.ticket_id,
    t.status,
    t.created_date,
    a.agent_name,
    tm.team_name
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
JOIN teams tm ON a.team_id = tm.team_id;

-- 4. Show employee hierarchy (employee, manager, department)
SELECT 
    e.name as employee_name,
    e.salary,
    m.name as manager_name,
    d.department_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 5. Show order details with customer and country information
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.customer_name,
    co.country_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN countries co ON c.country_id = co.country_id
ORDER BY o.order_date;

-- 6. Show ticket details with agent and team information
SELECT 
    t.ticket_id,
    t.status,
    t.created_date,
    c.customer_name,
    a.agent_name,
    tm.team_name
FROM tickets t
JOIN customers c ON t.customer_id = c.customer_id
JOIN agents a ON t.agent_id = a.agent_id
JOIN teams tm ON a.team_id = tm.team_id; 