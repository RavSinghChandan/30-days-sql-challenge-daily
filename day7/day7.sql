select e.name as e_name,m.name as m_name, d.department_name
from employees e
left join employees m on e.manager_id = m.employee_id
left join departments d on e.department_id = d.department_id;

select o.order_id,c.customer_name, cn.country_name
from orders o
left join customers c on o.customer_id=c.customer_id
left join countries cn on c.country_id = cn.country_id;
