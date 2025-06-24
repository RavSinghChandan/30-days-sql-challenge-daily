
# 📅 Day 3: Filtering with BETWEEN, IN, LIKE

Today’s focus is on **filtering rows** using conditional operators like `BETWEEN`, `IN`, and `LIKE`.

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

## 🔢 Questions to Practice

1. Get employees with salary **between 50,000 and 80,000**.

2. Get employees in **'Sales'** or **'Support'** departments.

3. Get employees whose **name starts with 'A'** or **ends with 'n'**.

---

## 🚀 Bonus Challenges

4. Get employees whose name **contains double letters** (like ‘Aaron’, ‘Jesse’).

5. Get employees with salary **not between 40,000 and 70,000**.
