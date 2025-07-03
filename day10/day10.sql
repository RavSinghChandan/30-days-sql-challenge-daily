

    select name salary,
    case
    when salary >= 70000 then 'A'
    when salary >= 50000 then 'B'
    else  'C'
    end
    as grade
    from employees;

SELECT
    name,
    hire_date,
    CASE
        WHEN hire_date >= DATE('now', '-90 days') THEN 'New Joiner'
        ELSE 'Tenured'
    END AS employee_status
FROM employees;

-

select
case
when s.amount >=20000 then 'Excellent'
when s.amount >= 15000 then 'Good'
when s.amount >= 10000 then 'Average'
else 'Below average'
end as performance_category
from sales s join employees e on s.employee_id = e.employee_id;

-
select project_name , status,
case priority
when 'High' then 'Urgent'
when 'Medium' then 'Important'
when 'Low' then 'Normal'
else 'Undefined'
end as priority_description
from projects;


-- 6. Categorize employees by department and salary range
SELECT 
    d.department_name,
    e.name,
    e.salary,
    CASE 
        WHEN e.salary >= 70000 THEN 'High Earner'
        WHEN e.salary >= 50000 THEN 'Mid Level'
        WHEN e.salary >= 35000 THEN 'Entry Level'
        ELSE 'Junior'
    END as salary_category
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.salary DESC; 