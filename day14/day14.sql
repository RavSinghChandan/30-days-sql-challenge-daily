-- 1. Employees joined in last 3 months
SELECT name, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- 2. Calculate age of each employee
SELECT 
    name, 
    birth_date,
    FLOOR(DATEDIFF(CURDATE(), birth_date) / 365) as age,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) as age_accurate
FROM employees;

-- 3. Days remaining for next work anniversary
SELECT 
    name, 
    hire_date,
    DATEDIFF(
        DATE_ADD(hire_date, INTERVAL YEAR(CURDATE()) - YEAR(hire_date) + 1 YEAR),
        CURDATE()
    ) as days_to_anniversary,
    DATE_ADD(hire_date, INTERVAL YEAR(CURDATE()) - YEAR(hire_date) + 1 YEAR) as next_anniversary
FROM employees;

-- 4. Projects that started in current year
SELECT 
    project_name,
    start_date,
    end_date,
    status
FROM projects
WHERE YEAR(start_date) = YEAR(CURDATE());

-- 5. Employees with upcoming birthdays (next 30 days)
SELECT 
    name,
    birth_date,
    DATE_FORMAT(birth_date, '%M %d') as birthday_month_day,
    DATEDIFF(
        DATE_ADD(birth_date, INTERVAL YEAR(CURDATE()) - YEAR(birth_date) + 1 YEAR),
        CURDATE()
    ) as days_until_birthday
FROM employees
WHERE DATEDIFF(
    DATE_ADD(birth_date, INTERVAL YEAR(CURDATE()) - YEAR(birth_date) + 1 YEAR),
    CURDATE()
) BETWEEN 0 AND 30
ORDER BY days_until_birthday;

-- 6. Average project duration by status
SELECT 
    status,
    COUNT(*) as project_count,
    AVG(DATEDIFF(end_date, start_date)) as avg_duration_days,
    MIN(DATEDIFF(end_date, start_date)) as min_duration_days,
    MAX(DATEDIFF(end_date, start_date)) as max_duration_days
FROM projects
WHERE end_date IS NOT NULL
GROUP BY status
ORDER BY avg_duration_days DESC; 