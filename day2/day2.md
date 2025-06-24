# 📅 Day 2: ORDER BY, LIMIT, OFFSET

Today’s focus is on sorting results, limiting the number of rows returned, and paginating through data.

---

## 🧱 Schema Recap

```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Marketing');

INSERT INTO employees (employee_id, name, salary, department_id) VALUES
(101, 'Alice', 60000, 2),
(102, 'Bob', 45000, 1),
(103, 'Charlie', 52000, 3),
(104, 'David', 70000, 2),
(105, 'Eva', 30000, 4),
(106, 'Frank', 55000, 1),
(107, 'Grace', 75000, 2),
(108, 'Helen', 40000, 3),
(109, 'Ian', 47000, 4),
(110, 'Judy', 62000, 1);


# 📅 Day 2: ORDER BY, LIMIT, OFFSET – Questions Only

## 🔢 Questions to Practice

1. Get top 5 highest-paid employees.

2. Get bottom 5 employees by joining date  
   *(Assume `employee_id` reflects joining order)*.

3. Fetch page 2 results assuming 10 records per page.

4. Fetch page 3 results assuming 10 records per page.

---

## 🚀 Bonus Challenges

5. Get top 3 highest-paid employees in each department.

6. Get 2 most recent joiners in the 'IT' department.

