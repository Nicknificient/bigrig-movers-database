--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-brm-select.sql

--Student ID:35135913
--Student Name:Nicholas Wong Wei Junn

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

/* (a) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
-- For customers with more than one quote, show the customer
-- number, display name, number of quotes, and average quoted
-- cost. Only customers above the overall quote average are shown.
SELECT
    c.cust_no AS cust_no,
    CASE
        WHEN c.cust_bname IS NOT NULL THEN
            c.cust_bname
        ELSE
            TRIM(NVL(c.cust_gname, '') || ' ' || NVL(c.cust_fname, ''))
    END AS customer_name,
    COUNT(q.quote_no) AS num_quotes,
    TO_CHAR(AVG(q.quote_cost), '$999,990.00') AS avg_quoted_cost
FROM
    customer c
    JOIN quote q ON c.cust_no = q.cust_no
GROUP BY
    c.cust_no,
    c.cust_bname,
    c.cust_gname,
    c.cust_fname
HAVING
    COUNT(q.quote_no) > 1
    AND AVG(q.quote_cost) > (
        SELECT
            AVG(quote_cost)
        FROM
            quote
    )
ORDER BY
    AVG(q.quote_cost) DESC,
    c.cust_no;



/* (b) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
-- For each employee, show employee details, manager name,
-- and the number of jobs scheduled for truck dispatchers only.
-- Employees without a manager are displayed as No Manager.
SELECT
    e.emp_no AS emp_no,
    TRIM(NVL(e.emp_gname, '') || ' ' || NVL(e.emp_fname, '')) AS emp_name,
    CASE e.emp_role
        WHEN 'B' THEN
            'Manager'
        WHEN 'T' THEN
            'Truck Dispatcher'
        WHEN 'M' THEN
            'Mechanic'
        WHEN 'D' THEN
            'Driver'
    END AS emp_role_full,
    CASE
        WHEN m.emp_no IS NULL THEN
            'No Manager'
        ELSE
            TRIM(NVL(m.emp_gname, '') || ' ' || NVL(m.emp_fname, ''))
    END AS manager_name,
    CASE
        WHEN e.emp_role = 'T' THEN
            TO_CHAR(COUNT(j.job_no))
        ELSE
            ''
    END AS jobs_dispatched
FROM
    employee e
    LEFT OUTER JOIN employee m ON e.emp_no_manager = m.emp_no
    LEFT OUTER JOIN job j ON e.emp_no = j.schd_emp_no
GROUP BY
    e.emp_no,
    e.emp_gname,
    e.emp_fname,
    e.emp_role,
    m.emp_no,
    m.emp_gname,
    m.emp_fname
ORDER BY
    e.emp_no;


/* (c) */
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
-- For each truck/trailer combination, show job usage, total
-- quoted cost, and usage classification. Combinations with no
-- jobs are retained by using LEFT OUTER JOIN.
SELECT
    co.truck_vin AS truck_vin,
    t.truck_rego AS truck_rego,
    co.trailer_code AS trailer_code,
    LPAD(TO_CHAR(tr.trailer_purchase_cost, '$999,990.00'), 21, ' ') AS trailer_purchase_cost,
    COUNT(j.job_no) AS num_jobs,
    CASE
        WHEN COUNT(j.job_no) = 0 THEN
            LPAD('No jobs', 17, ' ')
        ELSE
            LPAD(TO_CHAR(SUM(q.quote_cost), '$999,990.00'), 17, ' ')
    END AS total_quoted_cost,
    CASE
        WHEN COUNT(j.job_no) = 0 THEN
            'Never Used'
        WHEN COUNT(j.job_no) > (
            SELECT
                AVG(job_count)
            FROM
                (
                    SELECT
                        COUNT(*) AS job_count
                    FROM
                        job
                    GROUP BY
                        truck_vin,
                        trailer_code
                )
        ) THEN
            'High Use'
        ELSE
            'Standard Use'
    END AS usage
FROM
    combination co
    JOIN truck t ON co.truck_vin = t.truck_vin
    JOIN trailer tr ON co.trailer_code = tr.trailer_code
    LEFT OUTER JOIN job j ON co.truck_vin = j.truck_vin
                           AND co.trailer_code = j.trailer_code
    LEFT OUTER JOIN quote q ON j.quote_no = q.quote_no
GROUP BY
    co.truck_vin,
    t.truck_rego,
    co.trailer_code,
    tr.trailer_purchase_cost
ORDER BY
    COUNT(j.job_no) DESC,
    co.truck_vin,
    co.trailer_code;
