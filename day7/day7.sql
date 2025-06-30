select e.name as e_name,m.name as m_name, d.department_name
from employees e
left join employees m on e.manager_id = m.employee_id
left join departments d on e.department_id = d.department_id;

select o.order_id,c.customer_name, cn.country_name
from orders o
left join customers c on o.customer_id=c.customer_id
left join countries cn on c.country_id = cn.country_id;

select t.status as t_status, a.agent_name as agent_name, tms.team_name as team_name
from tickets t
left join agents a on t.agent_id = a.agent_id
left join teams tms on a.team_id = tms.team_id;


select m.name, count(e.employee_id)
from employees e
join employees m on e.manager_id = m.employee_id
group by m.name;

SELECT DISTINCT c.customer_name
FROM customers c
JOIN tickets t ON c.customer_id = t.customer_id
JOIN orders o ON c.customer_id = o.customer_id;