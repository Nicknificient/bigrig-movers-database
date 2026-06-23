--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-brm-dm.sql

--Student ID: 35135913
--Student Name: Nicholas Wong Wei Junn

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--3(a)
-- Create sequences for EMPLOYEE, QUOTE and JOB primary keys.
-- The DROP SEQUENCE statements allow this script section to be rerun.
DROP SEQUENCE employee_seq;

DROP SEQUENCE quote_seq;

DROP SEQUENCE job_seq;

CREATE SEQUENCE employee_seq
    START WITH 300
    INCREMENT BY 5;

CREATE SEQUENCE quote_seq
    START WITH 300
    INCREMENT BY 5;

CREATE SEQUENCE job_seq
    START WITH 300
    INCREMENT BY 5;

--3(b)
-- Add Aurello Brown as a new Truck Dispatcher reporting to
-- manager Sarah Mitchell.
INSERT INTO employee (
    emp_no,
    emp_gname,
    emp_fname,
    emp_contact_no,
    emp_licenceno,
    emp_role,
    emp_no_manager
) VALUES (
    employee_seq.NEXTVAL,
    'Aurello',
    'Brown',
    '0431952053',
    NULL,
    'T',
    (
        SELECT emp_no
        FROM employee
        WHERE upper(emp_gname) = upper('Sarah')
          AND upper(emp_fname) = upper('Mitchell')
          AND emp_role = 'B'
    )
);

COMMIT;

--3(c)
-- Record the quote prepared by Aurello Brown for VICTORIA ELLA
-- from Flintstone Store, then schedule the accepted quote as a job.
-- The quote and job inserts are one transaction.
INSERT INTO quote (
    quote_no,
    quote_prepared_date,
    quote_pref_start_date,
    quote_start_location,
    quote_end_location,
    quote_cost,
    cust_no,
    emp_no
) VALUES (
    quote_seq.NEXTVAL,
    TO_DATE('17-May-2026', 'dd-Mon-yyyy'),
    TO_DATE('25-May-2026', 'dd-Mon-yyyy'),
    '29 Kuranda Road, Adelaide SA 5030',
    '9 Albatros Drive, Mount Gambier SA 5270',
    1000,
    (
        SELECT cust_no
        FROM customer
        WHERE upper(cust_gname) = upper('VICTORIA')
          AND upper(cust_fname) = upper('ELLA')
          AND upper(cust_bname) = upper('Flintstone Store')
    ),
    (
        SELECT emp_no
        FROM employee
        WHERE upper(emp_gname) = upper('Aurello')
          AND upper(emp_fname) = upper('Brown')
          AND emp_role = 'T'
    )
);

INSERT INTO job (
    job_no,
    job_pickup_dt,
    job_intended_dropoff_dt,
    job_cost,
    job_payment_made,
    quote_no,
    schd_emp_no,
    driver_emp_no,
    trailer_code,
    truck_vin
) VALUES (
    job_seq.NEXTVAL,
    TO_DATE('25-May-2026 09:00', 'dd-Mon-yyyy hh24:mi'),
    TO_DATE('25-May-2026 14:00', 'dd-Mon-yyyy hh24:mi'),
    NULL,
    'Y',
    quote_seq.CURRVAL,
    (
        SELECT emp_no
        FROM employee
        WHERE upper(emp_gname) = upper('Aurello')
          AND upper(emp_fname) = upper('Brown')
          AND emp_role = 'T'
    ),
    (
        SELECT emp_no
        FROM employee
        WHERE upper(emp_gname) = upper('Michael')
          AND upper(emp_fname) = upper('Johnson')
          AND emp_role = 'D'
    ),
    'TRL08',
    '1HGBH41JXMN109186'
);

COMMIT;



--3(d)
-- Shift VICTORIA ELLA's pickup time from 9 AM to 2 PM.
-- The intended drop-off is also shifted to preserve the 5 hour trip.
-- The job cost is updated to 20% higher than the original quote cost.
UPDATE job
SET
    job_pickup_dt = TO_DATE('25-May-2026 14:00', 'dd-Mon-yyyy hh24:mi'),
    job_intended_dropoff_dt = TO_DATE('25-May-2026 19:00', 'dd-Mon-yyyy hh24:mi'),
    job_cost = (
        SELECT quote_cost * 1.2
        FROM quote
        WHERE quote.quote_no = job.quote_no
    ),
    job_payment_made = 'Y'
WHERE quote_no = (
    SELECT quote_no
    FROM quote
    WHERE quote_prepared_date = TO_DATE('17-May-2026', 'dd-Mon-yyyy')
      AND cust_no = (
          SELECT cust_no
          FROM customer
          WHERE upper(cust_gname) = upper('VICTORIA')
            AND upper(cust_fname) = upper('ELLA')
            AND upper(cust_bname) = upper('Flintstone Store')
      )
);

COMMIT;

--3(e)
-- Cancel the job for VICTORIA ELLA's 17-May-2026 quote.
-- The quote remains in the system, but the scheduled job is removed.
DELETE FROM job
WHERE quote_no = (
    SELECT quote_no
    FROM quote
    WHERE quote_prepared_date = TO_DATE('17-May-2026', 'dd-Mon-yyyy')
      AND cust_no = (
          SELECT cust_no
          FROM customer
          WHERE upper(cust_gname) = upper('VICTORIA')
            AND upper(cust_fname) = upper('ELLA')
            AND upper(cust_bname) = upper('Flintstone Store')
      )
);

COMMIT;

