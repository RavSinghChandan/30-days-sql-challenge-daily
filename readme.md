# 30-Day SQL Mastery Challenge for Java Backend Developer (Interview-Proof)

This is your **custom-crafted SQL training path** designed to:

* Make you **interview-ready** in 30 days
* Build **hands-on MySQL experience**
* Enable daily **GitHub commits**
* Provide you with **LinkedIn content** for visibility

> 🧠 Each day = 1 hour of focused SQL + 1 commit + 1 post
> 🚀 Outcome = Crack any SQL round for Java Backend Developer roles

---

## 🔧 Setup Guide (Do First)

* Use **MySQL 8+**, preferably with sample databases like **`employees`, `sakila`, or your own schema\`**
* Create a GitHub repo: `30-days-sql-challenge`
* Daily structure:

    * `sql/day_X.sql` → code
    * `notes/day_X.md` → explanation
    * Commit with: `Day X: Topic – What I learned`

---

## 📅 Challenge Roadmap

### 📘 Phase 1: Foundations (Day 1–10)

Learn the 80% of SQL basics that cover 80% of interview questions

#### Day 1: SELECT, WHERE, DISTINCT

* Fetch all employees
* Get unique department names
* Select only those with salary > 50000
* Select only those working in IT or HR

#### Day 2: ORDER BY, LIMIT, OFFSET

* Get top 5 highest-paid employees
* Get bottom 5 employees by joining date
* Fetch 2nd and 3rd page results assuming 10 per page

#### Day 3: Filtering with BETWEEN, IN, LIKE

* Employees with salary BETWEEN 50k and 80k
* Employees in departments 'Sales', 'Support'
* Employees whose name starts with 'A' or ends with 'n'

#### Day 4: Aggregate Functions

* Total salary of all employees
* Average salary
* Minimum and maximum salary
* Count of all active employees

#### Day 5: GROUP BY + HAVING

* Count of employees per department
* Average salary per department
* Departments with more than 5 employees
* Departments where average salary > 60000

#### Day 6: Basic Joins

* INNER JOIN: employees + departments
* LEFT JOIN: departments even if no employee
* RIGHT JOIN: employees even if no department

#### Day 7: Multi-Level Joins

* Employees + Managers (same table)
* Orders → Customers → Countries
* Tickets → Agents → Teams

#### Day 8: Subqueries

* Employees earning above overall average salary
* Employees who joined before their department head
* Departments where no one earns below 40k

#### Day 9: UNION vs UNION ALL

* Combine employee data from two tables (ex: old and new branches)
* Fetch all distinct and non-distinct employee records

#### Day 10: CASE & IF Logic

* Grade employees (A/B/C) by salary slabs
* Mark employees as 'New Joiner' if joined in last 90 days else 'Tenured'

---

### ⚙️ Phase 2: Intermediate/Backend SQL (Day 11–20)

Apply what backend developers face in apps

#### Day 11: CTE (Common Table Expressions)

* Find 2nd highest salary in each department
* Recursive CTE to find reporting hierarchy of an employee

#### Day 12: Window Functions

* Rank employees by salary within department
* Running total of salaries
* Difference between max salary and each employee's salary

#### Day 13: Aggregate + Joins

* Highest paid employee per department
* Count of open tickets per agent
* Total revenue by customer per region

#### Day 14: Date Functions

* Employees joined in last 3 months
* Calculate age of each employee
* Days remaining for next work anniversary

#### Day 15: String Functions

* Split full name to first & last name
* Extract domain from email
* Pad employee IDs with zeros

#### Day 16: EXISTS vs NOT EXISTS

* Employees assigned to at least one project
* Employees with no ticket in past month

#### Day 17: Views

* Create `view_active_employees`
* Create view to show department and average salary
* Query from both views

#### Day 18: Indexing & Performance

* Add index to employee\_id
* Compare query speed using `EXPLAIN`
* Simulate a slow query and optimize it

#### Day 19: Schema Design (Normalization)

* Design `product`, `order`, `customer` schema up to 3NF
* Identify functional dependencies

#### Day 20: Real Join Project (Ticket System)

* Tickets with agent name and open duration
* Average handling time per agent
* Customers with most support tickets

---

### 🔐 Phase 3: Advanced SQL & DevOps (Day 21–30)

Focus on real-world backend SQL challenges

#### Day 21: Transactions & Rollbacks

* Simulate update with failure and ROLLBACK
* Transfer amount between accounts (banking example)

#### Day 22: Stored Procedures

* Write stored procedure to calculate bonus
* Procedure to update employee status based on tenure

#### Day 23: Functions

* Create function to return years of service
* Create tax bracket function using CASE

#### Day 24: Triggers

* Trigger to log salary changes
* Trigger before deleting an employee to archive their data

#### Day 25: SQL for API Response

* Return nested JSON-like result using aliases
* Build flattened result for REST APIs

#### Day 26: Security & Role Management

* Create read-only role
* Restrict column access using view

#### Day 27: Error Handling

* Divide-by-zero simulation
* Error logging mechanism in stored procedure

#### Day 28: Query Optimization

* Use EXPLAIN, ANALYZE to debug a query
* Rewrite subqueries using JOINs

#### Day 29: Mock Interview Questions

* Top 5 recent high-paying job switchers
* Employees never assigned to any project
* Salary > department average
* Repeated phone/email addresses
* Customers with most orders in past 60 days

#### Day 30: Capstone Project – Flight Booking System

**Schema:**

* Flights, Passengers, Tickets, Bookings
  **Queries:**
* Find available seats per flight
* Frequent travelers in last 6 months
* Top 3 routes by revenue
* Monthly booking trends
* Top 5 customers by ticket volume

---

## 🏁 What You'll Achieve:

* ✅ Interview-ready in any SQL round
* ✅ Hands-on SQL fluency in MySQL
* ✅ 30 commits + 30 LinkedIn posts = personal brand

Let’s make every day count 🚀
