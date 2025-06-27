# 📅 Day 5: GROUP BY + HAVING in SQL

Today’s focus is on grouping records and filtering aggregated results using **GROUP BY** and **HAVING** clauses.

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

---

## 🔢 Practical Queries

### 1. ✅ Count of employees per department

---

### 2. ✅ Average salary per department


---

### 3. ✅ Departments with more than 5 employees


---

### 4. ✅ Departments where average salary > 60000


---