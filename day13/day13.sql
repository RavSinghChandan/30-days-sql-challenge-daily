-- 1. Highest paid employee per department
SELECT d.department_name, e.name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE (e.department_id, e.salary) IN (
    SELECT department_id, MAX(salary)
    FROM employees
    GROUP BY department_id
);

-- 2. Count of open tickets per agent
SELECT a.agent_name, COUNT(t.ticket_id) as open_tickets
FROM agents a
LEFT JOIN tickets t ON a.agent_id = t.agent_id AND t.status = 'Open'
GROUP BY a.agent_id, a.agent_name;

-- 3. Total revenue by customer per region
SELECT c.region, c.customer_name, SUM(o.total_amount) as total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region, c.customer_id, c.customer_name
ORDER BY c.region, total_revenue DESC;

-- 4. Average salary by department with employee count
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary,
    SUM(e.salary) as total_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_salary DESC;

-- 5. Total orders and revenue by customer
SELECT 
    c.customer_name,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_revenue,
    AVG(o.total_amount) as avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- 6. Agent performance (tickets closed vs open)
SELECT 
    a.agent_name,
    COUNT(CASE WHEN t.status = 'Closed' THEN 1 END) as closed_tickets,
    COUNT(CASE WHEN t.status = 'Open' THEN 1 END) as open_tickets,
    COUNT(t.ticket_id) as total_tickets,
    ROUND(
        COUNT(CASE WHEN t.status = 'Closed' THEN 1 END) * 100.0 / COUNT(t.ticket_id), 
        2
    ) as closure_rate
FROM agents a
LEFT JOIN tickets t ON a.agent_id = t.agent_id
GROUP BY a.agent_id, a.agent_name
ORDER BY closure_rate DESC; 