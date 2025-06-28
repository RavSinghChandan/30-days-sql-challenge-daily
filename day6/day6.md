# Day 6: Basic Joins

## 🧱 Schema Creation

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

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
```

## 📥 Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Marketing'),
(5, 'Finance');

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
(110, 'Judy', 62000, 1),
(111, 'Kevin', 65000, NULL);

INSERT INTO projects (project_id, project_name, department_id) VALUES
(1, 'Employee Portal', 2),
(2, 'Recruitment System', 1),
(3, 'CRM Implementation', 3),
(4, 'Brand Campaign', 4),
(5, 'Budget Planning', 5);
```

## 📌 Questions

1. INNER JOIN: employees + departments
2. LEFT JOIN: departments even if no employee
3. RIGHT JOIN: employees even if no department
4. Show all employees with their department names using INNER JOIN
5. Show all departments and their employees (including departments with no employees)
6. Show all employees and their departments (including employees with no department) 


- 🔍 `INNER JOIN` = Intersection (ONLY match)
- ➡️ `LEFT JOIN` = Left table is **master**, even if no match
- ↪️ `RIGHT JOIN` = Right table is **master**, even if no match
- 🔄 Always prefer `LEFT JOIN` over `RIGHT JOIN` for readability
- 🧹 Use `COALESCE()` to clean `NULL`s after outer joins
- 📊 Use `JOIN + GROUP BY` to aggregate data across relationships
- ❌ `CROSS JOIN` can explode rows! Use wisely.

---

## 🧠 Bonus Reminders

- Always **join on indexed keys** for performance
- Use table aliases (`e`, `d`) for clarity
- **Join condition is a must** — else you’ll get a cartesian product!
- Watch out for `NULL` values during joins
