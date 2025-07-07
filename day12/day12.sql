-- 1. Rank employees by salary within department



--Brute Force
    select e1.employee_id, e1.name, d.department_name, e1.salary, count(e2.salary) as salary_rank
    from employees e1 join employees e2 on e1.department_id = e2.department_id
    and e2.salary >= e1.salary
    join departments d on e1.department_id= d.department_id group by
e1.employee_id, e1.name, d.department_name, e1.salary;

-- window function = rank() over()
    select e.employee_id,e.name,d.department_name, e.salary,
    rank() over (
		 partition by e.department_id
		order by e.salary desc ) as salary_rank
    from employees e join departments d
	on e.department_id = d.department_id;




-- 2. Running total of salaries



select  e1.employee_id, e1.name, e1.salary , e1.hire_date,
 ( select sum(e2.salary) from employees e2 where e2.hire_date <= e1.hire_date ) as running_totol
  from employees e1 order by e1.hire_date;

  -- Optimized
   select employee_id, name, department_id, salary ,
  	rank() over( partition by department_id order by salary desc ) as salary ;


-- 3. Difference between max salary and each employee's salary
-- Brute Force
-- 1.select max(salary) from employees;
--2. select employee_id, name, salary ,(select max(salary) from employees ) as max_salary from employees;
 --3. select employee_id, name, salary ,(select max(salary) from employees ) - salary as salary_gap from employees;

 -- Optimized
 --select employee_id, name, salary,max(salary) over() as max_salary from employees;
 --select employee_id, name, salary,max(salary) over()- salary  as salary_gap from employees;


-- 4. Calculate moving average of sales amounts
select s1.sale_id, s1.amount, s1.sale_date from sales s1 join sales s2
on s2.sale_date between date_sub( s1.sale_date, interval 2 day) and s1.sale_date   s1.sale_id, s1.sale_date, s1.amount
ORDER BY
  s1.sale_date;

-- 5. Find employees with top 2 salaries in each department
WITH RankedEmployees AS (
    SELECT 
        name,
        salary,
        department_name,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id 
            ORDER BY salary DESC
        ) as salary_rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT 
    department_name,
    name,
    salary,
    salary_rank
FROM RankedEmployees
WHERE salary_rank <= 2
ORDER BY department_name, salary_rank;

-- 6. Calculate cumulative sum of order amounts by region
SELECT 
    order_id,
    total_amount,
    region,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY region 
        ORDER BY order_date 
        ROWS UNBOUNDED PRECEDING
    ) as cumulative_amount,
    SUM(total_amount) OVER (PARTITION BY region) as total_region_amount
FROM orders
ORDER BY region, order_date; 