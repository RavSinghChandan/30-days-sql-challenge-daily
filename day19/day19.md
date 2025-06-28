# Day 19: Triggers

## Schema Creation

```sql
-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

-- Create employee_audit table for tracking changes
CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    action_type VARCHAR(20),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_by VARCHAR(100),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create salary_history table
CREATE TABLE salary_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    change_reason VARCHAR(200)
);

-- Create department_stats table for maintaining statistics
CREATE TABLE department_stats (
    department_id INT PRIMARY KEY,
    employee_count INT DEFAULT 0,
    total_salary DECIMAL(12,2) DEFAULT 0,
    avg_salary DECIMAL(10,2) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employee_audit ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE salary_history ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE department_stats ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
```

## Sample Data

```sql
-- Insert departments
INSERT INTO departments VALUES (1, 'Engineering', 'New York');
INSERT INTO departments VALUES (2, 'Marketing', 'Los Angeles');
INSERT INTO departments VALUES (3, 'Finance', 'Chicago');
INSERT INTO departments VALUES (4, 'HR', 'Boston');

-- Insert employees
INSERT INTO employees VALUES (1, 'John Smith', 75000, 1, '2020-01-15', 'Active');
INSERT INTO employees VALUES (2, 'Sarah Johnson', 65000, 2, '2019-03-20', 'Active');
INSERT INTO employees VALUES (3, 'Mike Davis', 80000, 1, '2018-11-10', 'Active');
INSERT INTO employees VALUES (4, 'Lisa Brown', 70000, 3, '2021-06-05', 'Active');
INSERT INTO employees VALUES (5, 'David Wilson', 90000, 1, '2017-09-12', 'Active');
INSERT INTO employees VALUES (6, 'Emily Taylor', 60000, 2, '2022-02-28', 'Active');
INSERT INTO employees VALUES (7, 'Tom Anderson', 85000, 3, '2019-08-15', 'Inactive');
INSERT INTO employees VALUES (8, 'Jessica Lee', 72000, 4, '2020-12-01', 'Active');

-- Initialize department_stats
INSERT INTO department_stats (department_id, employee_count, total_salary, avg_salary)
SELECT 
    d.department_id,
    COUNT(e.employee_id),
    SUM(e.salary),
    AVG(e.salary)
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id AND e.status = 'Active'
GROUP BY d.department_id;
```

## Questions

1. **Create a trigger to audit salary changes**
   - Trigger: BEFORE UPDATE on employees
   - Action: Log old and new salary in employee_audit table

2. **Create a trigger to maintain salary history**
   - Trigger: AFTER UPDATE on employees
   - Action: Insert record in salary_history table

3. **Create a trigger to update department statistics**
   - Trigger: AFTER INSERT/UPDATE/DELETE on employees
   - Action: Update department_stats table

4. **Create a trigger to prevent salary reduction**
   - Trigger: BEFORE UPDATE on employees
   - Action: Prevent salary from being reduced by more than 10%

5. **Create a trigger to validate department assignment**
   - Trigger: BEFORE INSERT/UPDATE on employees
   - Action: Ensure department exists and is valid

6. **Create a trigger to log employee status changes**
   - Trigger: BEFORE UPDATE on employees
   - Action: Log status changes in employee_audit table 