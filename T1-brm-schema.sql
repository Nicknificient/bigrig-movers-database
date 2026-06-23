--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-brm-schema.sql

--Student ID: 35135913
--Student Name: Nicholas Wong Wei Junn

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/


/* drop table statements - do not remove*/

DROP TABLE employee CASCADE CONSTRAINTS PURGE;

DROP TABLE job CASCADE CONSTRAINTS PURGE;

DROP TABLE quote CASCADE CONSTRAINTS PURGE;

-- Task 1 Add Create table statements for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- EMPLOYEE- create employee table 
CREATE TABLE employee (
    emp_no         NUMBER(3) NOT NULL,
    emp_gname      VARCHAR2(30),
    emp_fname      VARCHAR2(30),
    emp_contact_no CHAR(10) NOT NULL,
    emp_licenceno  VARCHAR2(11),
    emp_role       CHAR(1) NOT NULL,
    emp_no_manager NUMBER(3)
);

COMMENT ON COLUMN employee.emp_no IS
    'Employee number';

COMMENT ON COLUMN employee.emp_gname IS
    'Employee given name';

COMMENT ON COLUMN employee.emp_fname IS
    'Employee family name';

COMMENT ON COLUMN employee.emp_contact_no IS
    'Employee contact number';

COMMENT ON COLUMN employee.emp_licenceno IS
    'Employee licence number, recorded only for drivers';

COMMENT ON COLUMN employee.emp_role IS
    'Employee role: Manager (B), Truck Dispatcher (T), Mechanic (M), or Driver (D)';

COMMENT ON COLUMN employee.emp_no_manager IS
    'Employee number of the manager this employee reports to';

ALTER TABLE employee
    ADD CONSTRAINT employee_pk PRIMARY KEY ( emp_no );

ALTER TABLE employee
    ADD CONSTRAINT chk_emp_role CHECK (
        emp_role IN ( 'B', 'T', 'M', 'D' )
    );

ALTER TABLE employee
    ADD CONSTRAINT chk_emp_licenceno CHECK (
        ( emp_role = 'D' AND emp_licenceno IS NOT NULL )
        OR
        ( emp_role <> 'D' AND emp_licenceno IS NULL )
    );


-- JOB-create job table
CREATE TABLE job (
    job_no                  NUMBER(5) NOT NULL,
    job_pickup_dt           DATE NOT NULL,
    job_intended_dropoff_dt DATE NOT NULL,
    job_cost                NUMBER(6,2),
    job_payment_made        CHAR(1) NOT NULL,
    quote_no                NUMBER(5) NOT NULL,
    schd_emp_no             NUMBER(3) NOT NULL,
    driver_emp_no           NUMBER(3) NOT NULL,
    trailer_code            CHAR(5) NOT NULL,
    truck_vin               CHAR(17) NOT NULL
);

COMMENT ON COLUMN job.job_no IS
    'Job number';

COMMENT ON COLUMN job.job_pickup_dt IS
    'Job scheduled pick up date and time';

COMMENT ON COLUMN job.job_intended_dropoff_dt IS
    'Job intended drop-off date and time';

COMMENT ON COLUMN job.job_cost IS
    'The actual job cost if different from the quote cost';

COMMENT ON COLUMN job.job_payment_made IS
    'Flag to note whether the job has been paid, Y or N';

COMMENT ON COLUMN job.quote_no IS
    'Quote number';

COMMENT ON COLUMN job.schd_emp_no IS
    'Employee number of the truck dispatcher who scheduled the job';

COMMENT ON COLUMN job.driver_emp_no IS
    'Employee number of the driver assigned to the job';

COMMENT ON COLUMN job.trailer_code IS
    'Trailer code';

COMMENT ON COLUMN job.truck_vin IS
    'Vehicle Identification Number of the truck';

ALTER TABLE job
    ADD CONSTRAINT job_pk PRIMARY KEY ( job_no );

ALTER TABLE job
    ADD CONSTRAINT job_quote_uq UNIQUE ( quote_no );

ALTER TABLE job
    ADD CONSTRAINT chk_job_payment_made CHECK (
        job_payment_made IN ( 'Y', 'N' )
    );

ALTER TABLE job
    ADD CONSTRAINT chk_job_cost CHECK (
        job_cost IS NULL OR job_cost > 0
    );

ALTER TABLE job
    ADD CONSTRAINT chk_job_dropoff_dt CHECK (
        job_intended_dropoff_dt > job_pickup_dt
    );



-- QUOTE-create quote table
CREATE TABLE quote (
    quote_no              NUMBER(5) NOT NULL,
    quote_prepared_date   DATE NOT NULL,
    quote_pref_start_date DATE NOT NULL,
    quote_start_location  VARCHAR2(50) NOT NULL,
    quote_end_location    VARCHAR2(60) NOT NULL,
    quote_cost            NUMBER(6,2) NOT NULL,
    cust_no               NUMBER(4) NOT NULL,
    emp_no                NUMBER(3) NOT NULL
);

COMMENT ON COLUMN quote.quote_no IS
    'Quote number';

COMMENT ON COLUMN quote.quote_prepared_date IS
    'The date the quote was prepared';

COMMENT ON COLUMN quote.quote_pref_start_date IS
    'The preferred start date for the quote';

COMMENT ON COLUMN quote.quote_start_location IS
    'The start location for the quote';

COMMENT ON COLUMN quote.quote_end_location IS
    'The end location for the quote';

COMMENT ON COLUMN quote.quote_cost IS
    'The quoted cost';

COMMENT ON COLUMN quote.cust_no IS
    'Customer number';

COMMENT ON COLUMN quote.emp_no IS
    'Employee number of the truck dispatcher who prepared the quote';

ALTER TABLE quote
    ADD CONSTRAINT quote_pk PRIMARY KEY ( quote_no );

ALTER TABLE quote
    ADD CONSTRAINT chk_quote_cost CHECK (
        quote_cost > 0
    );

ALTER TABLE quote
    ADD CONSTRAINT chk_quote_start_date CHECK (
        quote_pref_start_date >= quote_prepared_date
    );

-- Add all missing FK Constraints below here
ALTER TABLE employee
    ADD CONSTRAINT manager_employee_fk FOREIGN KEY ( emp_no_manager )
        REFERENCES employee ( emp_no );

ALTER TABLE quote
    ADD CONSTRAINT customer_quote_fk FOREIGN KEY ( cust_no )
        REFERENCES customer ( cust_no );

ALTER TABLE quote
    ADD CONSTRAINT employee_quote_fk FOREIGN KEY ( emp_no )
        REFERENCES employee ( emp_no );

ALTER TABLE job
    ADD CONSTRAINT quote_job_fk FOREIGN KEY ( quote_no )
        REFERENCES quote ( quote_no );

ALTER TABLE job
    ADD CONSTRAINT employee_job_scheduler_fk FOREIGN KEY ( schd_emp_no )
        REFERENCES employee ( emp_no );

ALTER TABLE job
    ADD CONSTRAINT employee_job_driver_fk FOREIGN KEY ( driver_emp_no )
        REFERENCES employee ( emp_no );

ALTER TABLE job
    ADD CONSTRAINT combination_job_fk FOREIGN KEY ( trailer_code, truck_vin )
        REFERENCES combination ( trailer_code, truck_vin );

