--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-brm-mods.sql

--Student ID: 35135913
--Student Name: Nicholas Wong Wei Junn

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

-- ============================================================
-- 4(a)
-- Add attributes to record whether a quote has been assigned
-- to a job, and why an unassigned quote was not converted.
-- ============================================================

ALTER TABLE quote
    ADD quote_assigned CHAR(1) DEFAULT 'N' NOT NULL;

ALTER TABLE quote
    ADD quote_not_assigned_reason VARCHAR2(200);

COMMENT ON COLUMN quote.quote_assigned IS
    'Flag to indicate whether the quote has been assigned to a job, Y or N';

COMMENT ON COLUMN quote.quote_not_assigned_reason IS
    'Reason why the quote was not converted to a job';

ALTER TABLE quote
    ADD CONSTRAINT quote_assigned_chk CHECK (
        quote_assigned IN ( 'Y', 'N' )
    );

ALTER TABLE quote
    ADD CONSTRAINT quote_not_assigned_reason_chk CHECK (
        ( quote_assigned = 'Y' AND quote_not_assigned_reason IS NULL )
        OR
        quote_assigned = 'N'
    );

-- Initialise quote_assigned to 'Y' for quotes that have been assigned to a job
UPDATE quote
SET quote_assigned = 'Y'
WHERE quote_no IN (
    SELECT quote_no
    FROM job
);

COMMIT;

DESC quote;

SELECT
    quote_no,
    quote_prepared_date,
    quote_pref_start_date,
    quote_assigned,
    quote_not_assigned_reason
FROM
    quote
ORDER BY
    quote_no;


-- ============================================================
-- 4(b)
-- Add structures to record truck services and the individual
-- service tasks completed during each service.
-- Drop child table first (truck_service_task) before dropping
-- parent tables, then each DROP is placed directly above its
-- matching CREATE TABLE.
-- ============================================================

-- Drop child table first as it references all three parent tables
DROP TABLE truck_service_task CASCADE CONSTRAINTS PURGE;

-- Drop and create mechanic
DROP TABLE mechanic CASCADE CONSTRAINTS PURGE;

CREATE TABLE mechanic (
    emp_no NUMBER(3) NOT NULL
);

COMMENT ON COLUMN mechanic.emp_no IS
    'Employee number of an employee who is a mechanic';

ALTER TABLE mechanic
    ADD CONSTRAINT mechanic_pk PRIMARY KEY ( emp_no );

ALTER TABLE mechanic
    ADD CONSTRAINT employee_mechanic_fk FOREIGN KEY ( emp_no )
        REFERENCES employee ( emp_no );

-- Populate mechanic from existing employees with role M
INSERT INTO mechanic (
    SELECT emp_no
    FROM employee
    WHERE emp_role = 'M'
);

-- Drop and create service_task
DROP TABLE service_task CASCADE CONSTRAINTS PURGE;

CREATE TABLE service_task (
    task_code CHAR(4) NOT NULL,
    task_desc VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN service_task.task_code IS
    'Service task code';

COMMENT ON COLUMN service_task.task_desc IS
    'Service task description';

ALTER TABLE service_task
    ADD CONSTRAINT service_task_pk PRIMARY KEY ( task_code );

ALTER TABLE service_task
    ADD CONSTRAINT service_task_task_desc_uq UNIQUE ( task_desc );

-- Drop and create truck_service
DROP TABLE truck_service CASCADE CONSTRAINTS PURGE;

CREATE TABLE truck_service (
    service_no       NUMBER(5) NOT NULL,
    truck_vin        CHAR(17) NOT NULL,
    service_start_dt DATE NOT NULL,
    service_end_dt   DATE
);

COMMENT ON COLUMN truck_service.service_no IS
    'Truck service number';

COMMENT ON COLUMN truck_service.truck_vin IS
    'Vehicle Identification Number of the truck being serviced';

COMMENT ON COLUMN truck_service.service_start_dt IS
    'Date and time the truck service started';

COMMENT ON COLUMN truck_service.service_end_dt IS
    'Date and time the truck service ended';

ALTER TABLE truck_service
    ADD CONSTRAINT truck_service_pk PRIMARY KEY ( service_no );

ALTER TABLE truck_service
    ADD CONSTRAINT truck_service_dt_chk CHECK (
        service_end_dt IS NULL
        OR service_end_dt > service_start_dt
    );

ALTER TABLE truck_service
    ADD CONSTRAINT truck_truck_service_fk FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );

-- Create truck_service_task (child of truck_service, service_task, mechanic)
CREATE TABLE truck_service_task (
    service_no        NUMBER(5) NOT NULL,
    task_code         CHAR(4) NOT NULL,
    emp_no            NUMBER(3) NOT NULL,
    service_task_note VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN truck_service_task.service_no IS
    'Truck service number';

COMMENT ON COLUMN truck_service_task.task_code IS
    'Service task code';

COMMENT ON COLUMN truck_service_task.emp_no IS
    'Employee number of the mechanic who completed the service task';

COMMENT ON COLUMN truck_service_task.service_task_note IS
    'Free text note explaining the service task';

ALTER TABLE truck_service_task
    ADD CONSTRAINT truck_service_task_pk PRIMARY KEY (
        service_no,
        task_code
    );

ALTER TABLE truck_service_task
    ADD CONSTRAINT truck_service_task_service_fk FOREIGN KEY ( service_no )
        REFERENCES truck_service ( service_no );

ALTER TABLE truck_service_task
    ADD CONSTRAINT service_task_truck_service_task_fk FOREIGN KEY ( task_code )
        REFERENCES service_task ( task_code );

ALTER TABLE truck_service_task
    ADD CONSTRAINT mechanic_truck_service_task_fk FOREIGN KEY ( emp_no )
        REFERENCES mechanic ( emp_no );

COMMIT;

DESC mechanic;

SELECT
    emp_no
FROM
    mechanic
ORDER BY
    emp_no;

DESC service_task;

DESC truck_service;

DESC truck_service_task;