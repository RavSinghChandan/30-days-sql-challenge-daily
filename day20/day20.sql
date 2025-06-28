-- 1. Tickets with agent name and open duration
SELECT 
    t.ticket_id,
    t.subject,
    t.priority,
    t.status,
    a.agent_name,
    t.created_date,
    CASE 
        WHEN t.status = 'Resolved' THEN 
            TIMESTAMPDIFF(MINUTE, t.created_date, t.resolved_date)
        ELSE 
            TIMESTAMPDIFF(MINUTE, t.created_date, NOW())
    END as duration_minutes
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
ORDER BY duration_minutes DESC;

-- 2. Average handling time per agent
SELECT 
    a.agent_name,
    COUNT(t.ticket_id) as total_tickets,
    AVG(tm.resolution_time) as avg_resolution_time_minutes,
    AVG(tm.first_response_time) as avg_first_response_minutes,
    AVG(tm.customer_satisfaction) as avg_satisfaction
FROM agents a
LEFT JOIN tickets t ON a.agent_id = t.agent_id
LEFT JOIN ticket_metrics tm ON t.ticket_id = tm.ticket_id
GROUP BY a.agent_id, a.agent_name
ORDER BY avg_satisfaction DESC;

-- 3. Customers with most support tickets
SELECT 
    c.customer_name,
    c.region,
    COUNT(t.ticket_id) as total_tickets,
    COUNT(CASE WHEN t.status = 'Resolved' THEN 1 END) as resolved_tickets,
    COUNT(CASE WHEN t.status = 'Open' THEN 1 END) as open_tickets,
    AVG(tm.customer_satisfaction) as avg_satisfaction
FROM customers c
LEFT JOIN tickets t ON c.customer_id = t.customer_id
LEFT JOIN ticket_metrics tm ON t.ticket_id = tm.ticket_id
GROUP BY c.customer_id, c.customer_name, c.region
HAVING total_tickets > 0
ORDER BY total_tickets DESC;

-- 4. Team performance comparison
SELECT 
    tm.team_name,
    COUNT(DISTINCT a.agent_id) as agent_count,
    COUNT(t.ticket_id) as total_tickets,
    AVG(tm2.resolution_time) as avg_resolution_time,
    AVG(tm2.customer_satisfaction) as avg_satisfaction,
    COUNT(CASE WHEN t.status = 'Resolved' THEN 1 END) * 100.0 / COUNT(t.ticket_id) as resolution_rate
FROM teams tm
LEFT JOIN agents a ON tm.team_id = a.team_id
LEFT JOIN tickets t ON a.agent_id = t.agent_id
LEFT JOIN ticket_metrics tm2 ON t.ticket_id = tm2.ticket_id
GROUP BY tm.team_id, tm.team_name
ORDER BY avg_satisfaction DESC;

-- 5. Ticket resolution time by priority
SELECT 
    t.priority,
    COUNT(t.ticket_id) as total_tickets,
    AVG(tm.resolution_time) as avg_resolution_time_minutes,
    MIN(tm.resolution_time) as min_resolution_time,
    MAX(tm.resolution_time) as max_resolution_time,
    AVG(tm.customer_satisfaction) as avg_satisfaction
FROM tickets t
JOIN ticket_metrics tm ON t.ticket_id = tm.ticket_id
WHERE t.status = 'Resolved'
GROUP BY t.priority
ORDER BY avg_resolution_time_minutes;

-- 6. Customer satisfaction analysis
SELECT 
    t.category,
    t.priority,
    COUNT(t.ticket_id) as ticket_count,
    AVG(tm.customer_satisfaction) as avg_satisfaction,
    COUNT(CASE WHEN tm.customer_satisfaction >= 4 THEN 1 END) * 100.0 / COUNT(t.ticket_id) as satisfaction_rate
FROM tickets t
JOIN ticket_metrics tm ON t.ticket_id = tm.ticket_id
GROUP BY t.category, t.priority
ORDER BY avg_satisfaction DESC; 