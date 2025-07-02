-- 1. Employees earning above overall average salary
select name, salary
from Employees where salary > (select avg(salary) from Employees);


-- 2. Employees who joined before their department head

select e.name,e.salary, d.department_name
from employees e
join departments d on e.department_id= d.department_id
join employees h   on d.head_employee_id = h.employee_id
where h.hire_date > e.hire_date;

-- 3. Departments where no one earns below 40k
select d.department_name, d.department_id
from departments d
where not exists
( select 1
 from employees e
 where e.department_id= d.department_id
and e.salary < 40000);



-- 4. Find employees with salary higher than the average salary in their department
select e.name, d.department_name
from employees e
left join  departments d on e.department_id= d.department_id
where e.salary > ( select avg(salary) from employees where department_id = e.department_id);


-- 5. Find departments that have more employees than the average department
SELECT d.department_name, COUNT(e.employee_id) as employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > (
    SELECT AVG(emp_count) 
    FROM (
        SELECT COUNT(employee_id) as emp_count
        FROM employees 
        GROUP BY department_id
    ) as dept_counts
);


-- 6. Find employees who earn more than the highest salary in Marketing department
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT MAX(salary) 
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = 'Marketing'
); 