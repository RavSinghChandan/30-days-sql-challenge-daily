-- 1. Calculate moving averages for sales data
-- 3-month moving average for sales by employee
SELECT 
    e.name,
    DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
    SUM(s.sale_amount) as monthly_sales,
    AVG(SUM(s.sale_amount)) OVER (
        PARTITION BY s.employee_id 
        ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moving_avg_3month
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.name, s.employee_id, DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY e.name, sale_month;

-- Rolling average with different window sizes
SELECT 
    e.name,
    DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
    SUM(s.sale_amount) as monthly_sales,
    AVG(SUM(s.sale_amount)) OVER (
        PARTITION BY s.employee_id 
        ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) as moving_avg_2month,
    AVG(SUM(s.sale_amount)) OVER (
        PARTITION BY s.employee_id 
        ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moving_avg_3month,
    AVG(SUM(s.sale_amount)) OVER (
        PARTITION BY s.employee_id 
        ORDER BY DATE_FORMAT(s.sale_date, '%Y-%m')
        ROWS UNBOUNDED PRECEDING
    ) as cumulative_avg
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.name, s.employee_id, DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY e.name, sale_month;

-- 2. Implement cohort analysis for employee retention
-- Analyze retention by hire month cohorts
WITH employee_cohorts AS (
    SELECT 
        employee_id,
        hire_date,
        termination_date,
        DATE_FORMAT(hire_date, '%Y-%m') as cohort_month,
        CASE 
            WHEN termination_date IS NULL THEN DATEDIFF(CURDATE(), hire_date)
            ELSE DATEDIFF(termination_date, hire_date)
        END as days_employed
    FROM employee_retention
),
cohort_analysis AS (
    SELECT 
        cohort_month,
        COUNT(*) as cohort_size,
        COUNT(CASE WHEN days_employed >= 30 THEN 1 END) as retained_30_days,
        COUNT(CASE WHEN days_employed >= 90 THEN 1 END) as retained_90_days,
        COUNT(CASE WHEN days_employed >= 180 THEN 1 END) as retained_180_days,
        COUNT(CASE WHEN days_employed >= 365 THEN 1 END) as retained_365_days
    FROM employee_cohorts
    GROUP BY cohort_month
)
SELECT 
    cohort_month,
    cohort_size,
    ROUND((retained_30_days / cohort_size) * 100, 2) as retention_30_days_pct,
    ROUND((retained_90_days / cohort_size) * 100, 2) as retention_90_days_pct,
    ROUND((retained_180_days / cohort_size) * 100, 2) as retention_180_days_pct,
    ROUND((retained_365_days / cohort_size) * 100, 2) as retention_365_days_pct
FROM cohort_analysis
ORDER BY cohort_month;

-- 3. Create customer segmentation queries
-- RFM (Recency, Frequency, Monetary) analysis
WITH customer_rfm AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.segment,
        DATEDIFF(CURDATE(), MAX(s.sale_date)) as recency_days,
        COUNT(s.sale_id) as frequency,
        SUM(s.sale_amount) as monetary,
        NTILE(4) OVER (ORDER BY DATEDIFF(CURDATE(), MAX(s.sale_date))) as recency_score,
        NTILE(4) OVER (ORDER BY COUNT(s.sale_id)) as frequency_score,
        NTILE(4) OVER (ORDER BY SUM(s.sale_amount)) as monetary_score
    FROM customers c
    LEFT JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.customer_name, c.segment
)
SELECT 
    customer_name,
    segment,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    CASE 
        WHEN recency_score >= 3 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'High Value'
        WHEN recency_score >= 3 AND frequency_score >= 3 THEN 'Loyal'
        WHEN monetary_score >= 3 THEN 'Big Spender'
        WHEN recency_score >= 3 THEN 'Recent'
        ELSE 'At Risk'
    END as customer_segment
FROM customer_rfm
ORDER BY monetary DESC;

-- 4. Calculate year-over-year growth rates
-- Compare sales performance year-over-year
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(sale_date, '%Y-%m') as sale_month,
        SUM(sale_amount) as total_sales,
        COUNT(sale_id) as sale_count
    FROM sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
),
year_over_year AS (
    SELECT 
        sale_month,
        total_sales,
        sale_count,
        LAG(total_sales, 12) OVER (ORDER BY sale_month) as prev_year_sales,
        LAG(sale_count, 12) OVER (ORDER BY sale_month) as prev_year_count
    FROM monthly_sales
)
SELECT 
    sale_month,
    total_sales,
    sale_count,
    prev_year_sales,
    prev_year_count,
    CASE 
        WHEN prev_year_sales IS NOT NULL THEN ROUND(((total_sales - prev_year_sales) / prev_year_sales) * 100, 2)
        ELSE NULL
    END as sales_growth_pct,
    CASE 
        WHEN prev_year_count IS NOT NULL THEN ROUND(((sale_count - prev_year_count) / prev_year_count) * 100, 2)
        ELSE NULL
    END as count_growth_pct
FROM year_over_year
ORDER BY sale_month;

-- 5. Implement A/B testing analysis
-- Compare conversion rates between variants
SELECT 
    variant,
    COUNT(*) as sample_size,
    AVG(conversion_rate) as avg_conversion_rate,
    AVG(revenue) as avg_revenue,
    STDDEV(conversion_rate) as conversion_stddev,
    STDDEV(revenue) as revenue_stddev
FROM a_b_testing
GROUP BY variant
ORDER BY variant;

-- Statistical significance testing (simplified)
WITH variant_stats AS (
    SELECT 
        variant,
        COUNT(*) as n,
        AVG(conversion_rate) as mean,
        STDDEV(conversion_rate) as stddev
    FROM a_b_testing
    GROUP BY variant
),
significance_test AS (
    SELECT 
        a.variant as variant_a,
        b.variant as variant_b,
        a.mean as mean_a,
        b.mean as mean_b,
        a.stddev as stddev_a,
        b.stddev as stddev_b,
        a.n as n_a,
        b.n as n_b,
        ABS(a.mean - b.mean) / SQRT((a.stddev*a.stddev/a.n) + (b.stddev*b.stddev/b.n)) as z_score
    FROM variant_stats a
    CROSS JOIN variant_stats b
    WHERE a.variant < b.variant
)
SELECT 
    variant_a,
    variant_b,
    mean_a,
    mean_b,
    z_score,
    CASE 
        WHEN z_score > 1.96 THEN 'Significant (95% confidence)'
        WHEN z_score > 1.645 THEN 'Significant (90% confidence)'
        ELSE 'Not Significant'
    END as significance
FROM significance_test;

-- 6. Create predictive analytics queries
-- Predict employee retention likelihood (based on historical patterns)
WITH retention_patterns AS (
    SELECT 
        er.employee_id,
        er.hire_date,
        er.termination_date,
        er.retention_days,
        er.termination_reason,
        e.department_id,
        e.salary,
        CASE 
            WHEN er.termination_date IS NOT NULL THEN 1
            ELSE 0
        END as terminated,
        CASE 
            WHEN er.retention_days < 365 THEN 'High Risk'
            WHEN er.retention_days < 730 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END as retention_risk
    FROM employee_retention er
    LEFT JOIN employees e ON er.employee_id = e.employee_id
),
risk_analysis AS (
    SELECT 
        department_id,
        AVG(salary) as avg_salary,
        COUNT(*) as total_employees,
        SUM(terminated) as terminated_count,
        ROUND((SUM(terminated) / COUNT(*)) * 100, 2) as termination_rate
    FROM retention_patterns
    GROUP BY department_id
)
SELECT 
    d.department_name,
    ra.avg_salary,
    ra.total_employees,
    ra.terminated_count,
    ra.termination_rate,
    CASE 
        WHEN ra.termination_rate > 20 THEN 'High Risk Department'
        WHEN ra.termination_rate > 10 THEN 'Medium Risk Department'
        ELSE 'Low Risk Department'
    END as department_risk_level
FROM risk_analysis ra
JOIN departments d ON ra.department_id = d.department_id
ORDER BY ra.termination_rate DESC;

-- Forecast sales trends using historical data
WITH sales_trends AS (
    SELECT 
        DATE_FORMAT(sale_date, '%Y-%m') as sale_month,
        SUM(sale_amount) as total_sales,
        COUNT(sale_id) as sale_count,
        AVG(sale_amount) as avg_sale_amount
    FROM sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
),
trend_analysis AS (
    SELECT 
        sale_month,
        total_sales,
        sale_count,
        avg_sale_amount,
        LAG(total_sales, 1) OVER (ORDER BY sale_month) as prev_month_sales,
        LAG(total_sales, 2) OVER (ORDER BY sale_month) as prev_2month_sales,
        AVG(total_sales) OVER (ORDER BY sale_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg
    FROM sales_trends
)
SELECT 
    sale_month,
    total_sales,
    sale_count,
    avg_sale_amount,
    prev_month_sales,
    prev_2month_sales,
    moving_avg,
    CASE 
        WHEN prev_month_sales IS NOT NULL THEN ROUND(((total_sales - prev_month_sales) / prev_month_sales) * 100, 2)
        ELSE NULL
    END as month_over_month_growth,
    ROUND(moving_avg * 1.05, 2) as forecast_next_month
FROM trend_analysis
ORDER BY sale_month; 