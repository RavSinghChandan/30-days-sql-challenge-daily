# Day 27: Data Migration & ETL

## Schema Creation

```sql
-- Source tables (old system)
CREATE TABLE old_employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    emp_salary VARCHAR(20),
    dept_code VARCHAR(10),
    start_date VARCHAR(20),
    emp_status VARCHAR(10)
);

CREATE TABLE old_departments (
    dept_code VARCHAR(10) PRIMARY KEY,
    dept_desc VARCHAR(100),
    dept_location VARCHAR(50)
);

-- Target tables (new system)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    hire_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

-- Audit and staging tables
CREATE TABLE migration_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    operation_type VARCHAR(20),
    records_processed INT,
    success_count INT,
    error_count INT,
    migration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE data_validation_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    validation_type VARCHAR(50),
    error_message TEXT,
    record_count INT,
    validation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE staging_employees (
    emp_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    emp_salary VARCHAR(20),
    dept_code VARCHAR(10),
    start_date VARCHAR(20),
    emp_status VARCHAR(10),
    validation_status VARCHAR(20) DEFAULT 'Pending',
    error_message TEXT
);

-- Add foreign key constraints
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
```

## Sample Data

```sql
-- Insert old system data (with data quality issues)
INSERT INTO old_departments VALUES ('ENG', 'Engineering Department', 'New York');
INSERT INTO old_departments VALUES ('MKT', 'Marketing Department', 'Los Angeles');
INSERT INTO old_departments VALUES ('FIN', 'Finance Department', 'Chicago');
INSERT INTO old_departments VALUES ('HR', 'Human Resources', 'Boston');

INSERT INTO old_employees VALUES (1, 'John', 'Smith', '75000.00', 'ENG', '2020-01-15', 'ACTIVE');
INSERT INTO old_employees VALUES (2, 'Sarah', 'Johnson', '65000', 'MKT', '2019-03-20', 'ACTIVE');
INSERT INTO old_employees VALUES (3, 'Mike', 'Davis', '80000.50', 'ENG', '2018-11-10', 'ACTIVE');
INSERT INTO old_employees VALUES (4, 'Lisa', 'Brown', '70000', 'FIN', '2021-06-05', 'ACTIVE');
INSERT INTO old_employees VALUES (5, 'David', 'Wilson', '90000.00', 'ENG', '2017-09-12', 'ACTIVE');
INSERT INTO old_employees VALUES (6, 'Emily', 'Taylor', '60000', 'MKT', '2022-02-28', 'ACTIVE');
INSERT INTO old_employees VALUES (7, 'Tom', 'Anderson', '85000', 'FIN', '2019-08-15', 'INACTIVE');
INSERT INTO old_employees VALUES (8, 'Jessica', 'Lee', '72000', 'HR', '2020-12-01', 'ACTIVE');
-- Data quality issues
INSERT INTO old_employees VALUES (9, 'Invalid', 'Salary', 'not_a_number', 'ENG', '2023-01-01', 'ACTIVE');
INSERT INTO old_employees VALUES (10, 'Invalid', 'Date', '75000', 'MKT', 'invalid_date', 'ACTIVE');
INSERT INTO old_employees VALUES (11, 'Unknown', 'Department', '65000', 'UNK', '2023-02-01', 'ACTIVE');
INSERT INTO old_employees VALUES (12, 'Duplicate', 'Record', '70000', 'HR', '2023-03-01', 'ACTIVE');
INSERT INTO old_employees VALUES (12, 'Duplicate', 'Record', '70000', 'HR', '2023-03-01', 'ACTIVE');

-- Insert target system data (clean)
INSERT INTO departments VALUES (1, 'Engineering', 'New York');
INSERT INTO departments VALUES (2, 'Marketing', 'Los Angeles');
INSERT INTO departments VALUES (3, 'Finance', 'Chicago');
INSERT INTO departments VALUES (4, 'HR', 'Boston');
```

## Questions

1. **Create data transformation procedures**
   - Transform old employee data to new format
   - Handle data type conversions and cleaning

2. **Implement incremental data loading**
   - Load only new or changed records
   - Track last migration timestamp

3. **Handle data type conversions**
   - Convert string salary to decimal
   - Parse date strings to proper DATE format
   - Map department codes to IDs

4. **Create data validation checks**
   - Validate salary ranges and formats
   - Check for required fields
   - Verify foreign key relationships

5. **Implement error handling for data loads**
   - Log validation errors
   - Handle duplicate records
   - Manage transaction rollbacks

6. **Create audit trails for data changes**
   - Track migration progress
   - Log successful and failed operations
   - Monitor data quality metrics 