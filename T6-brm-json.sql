/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-brm-json.sql

--Student ID: 35135913
--Student Name: Nicholas Wong Wei Junn

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

SET PAGESIZE 100

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
-- Generate one JSON document per customer who has quote records.
-- Each document stores the customer details, customer-level
-- quote/job statistics, and an array of the customer's quotes.

SELECT
    JSON_OBJECT(
        '_id' VALUE c.cust_no,

        'customer_name' VALUE
            CASE
                WHEN c.cust_gname IS NOT NULL
                     AND c.cust_fname IS NOT NULL THEN
                    c.cust_gname || ' ' || c.cust_fname
                WHEN c.cust_gname IS NOT NULL THEN
                    c.cust_gname
                ELSE
                    c.cust_fname
            END,

        'customer_business' VALUE
            CASE
                WHEN c.cust_bname IS NULL THEN
                    '-'
                ELSE
                    c.cust_bname
            END,

        'customer_address' VALUE
            c.cust_street || ', ' || c.cust_town || ', ' || c.cust_pcode,

        'customer_phone' VALUE c.cust_contact_no,

        'customer_stats' VALUE JSON_OBJECT(
            'number_of_quotes' VALUE (
                SELECT
                    COUNT(*)
                FROM
                    quote q1
                WHERE
                    q1.cust_no = c.cust_no
            ),

            'number_of_jobs' VALUE (
                SELECT
                    COUNT(j1.job_no)
                FROM
                    quote q2
                    JOIN job j1 ON q2.quote_no = j1.quote_no
                WHERE
                    q2.cust_no = c.cust_no
            ),

            'total_paid_jobcost' VALUE (
                SELECT
                    CASE
                        WHEN SUM(NVL(j2.job_cost, q3.quote_cost)) IS NULL THEN
                            '-'
                        ELSE
                            '$' || TO_CHAR(SUM(NVL(j2.job_cost, q3.quote_cost)), 'FM9999990.00')
                    END
                FROM
                    quote q3
                    JOIN job j2 ON q3.quote_no = j2.quote_no
                WHERE
                    q3.cust_no = c.cust_no
                    AND j2.job_payment_made = 'Y'
            ),

            'total_unpaid_jobcost' VALUE (
                SELECT
                    CASE
                        WHEN SUM(NVL(j3.job_cost, q4.quote_cost)) IS NULL THEN
                            '-'
                        ELSE
                            '$' || TO_CHAR(SUM(NVL(j3.job_cost, q4.quote_cost)), 'FM9999990.00')
                    END
                FROM
                    quote q4
                    JOIN job j3 ON q4.quote_no = j3.quote_no
                WHERE
                    q4.cust_no = c.cust_no
                    AND j3.job_payment_made = 'N'
            )
        ),

        'quotes' VALUE (
            SELECT
                JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'quote_no' VALUE q.quote_no,

                        'quote_prepared_on' VALUE
                            TO_CHAR(q.quote_prepared_date, 'DD-Mon-YYYY'),

                        'preferred_start_date' VALUE
                            TO_CHAR(q.quote_pref_start_date, 'DD-Mon-YYYY'),

                        'start_location' VALUE q.quote_start_location,

                        'end_location' VALUE q.quote_end_location,

                        'quote_cost' VALUE
                            '$' || TO_CHAR(q.quote_cost, 'FM9999990.00'),

                        'assigned_to_job' VALUE
                            CASE
                                WHEN j.job_no IS NULL THEN
                                    'N'
                                ELSE
                                    'Y'
                            END,

                        'job_cost' VALUE
                            CASE
                                WHEN j.job_no IS NULL THEN
                                    '-'
                                ELSE
                                    '$' || TO_CHAR(NVL(j.job_cost, q.quote_cost), 'FM9999990.00')
                            END
                    )
                    ORDER BY q.quote_no
                )
            FROM
                quote q
                LEFT OUTER JOIN job j ON q.quote_no = j.quote_no
            WHERE
                q.cust_no = c.cust_no
        ) FORMAT JSON
    )
    || ','
FROM
    customer c
WHERE
    c.cust_no IN (
        SELECT
            cust_no
        FROM
            quote
    )
ORDER BY
    c.cust_no;
