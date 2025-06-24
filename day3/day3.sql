select * from employees where salary between 50000 and 80000;
select * from employees e join departments d on e.department_id = d.department_id
where department_name in ('Sales','Support');
select * from employees where name like 'A%' or like '%n';