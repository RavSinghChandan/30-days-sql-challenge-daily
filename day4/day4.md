# 📅 Day 4: Aggregate Functions in SQL

Today’s focus is on **aggregate functions** that help summarize data.

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
```

### Sample Data

```sql
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Marketing'),
(5, 'Support');

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
(111, 'Aaron', 51000, 5),
(112, 'Adrian', 80000, 5);
```

---

## 🔢 Aggregate Function Queries

### 1.  Total salary of all employees

### 2.  Average salary

### 3.  Minimum and Maximum salary

### 4. Count of all active employees

Assuming all rows are active (no status column):


---

Practice running these queries and try modifying them to filter per department, or using GROUP BY to see aggregates department-wise! 💡