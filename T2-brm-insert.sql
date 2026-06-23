/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-brm-insert.sql

--Student ID:35135913
--Student Name:Nicholas Wong Wei Junn

/*
Indicate if AI was used (Yes/No): Yes

If AI was used:
I used <<ChatGPT>>[https://chatgpt.com/share/6a100a31-de34-83ec-90be-ecc0007421cc]
I used these prompts:
Using Oracle SQL only, generate sample INSERT statements for the FIT2094 BigRig Movers Task 2 file T2-brm-insert.sql. 
The data must insert only into EMPLOYEE, QUOTE and JOB. Do not modify CUSTOMER, TRUCK, TRAILER or COMBINATION data. 
Use one transaction with COMMIT at the end. Primary key values must be hardcoded and numeric primary keys must be below 100. 
All dates must be between 1 May 2026 and 31 July 2026 and use TO_DATE. Generate at least 10 employees with at least 2 managers, 
2 truck dispatchers, 1 mechanic and 2 drivers. Generate 30 quotes involving at least 5 different existing customers and 2 truck 
dispatchers, with at least 2 customers placing at least 2 quotes. Generate 20 jobs involving at least 10 existing truck/trailer 
combinations, at least 5 combinations used in at least 2 jobs, at least 2 quotes not converted to jobs, at least 5 jobs with cost 
different from the quote cost, and at least 5 jobs with the same cost as the quote. Ensure every job aligns with its quote, 
pickup/drop-off dates are sensible, only Driver employees are used as job drivers, and only Truck Dispatcher employees are used 
for quote preparation and job scheduling.
*/

--------------------------------------
--INSERT INTO employee
--------------------------------------
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (1, 'Grace', 'Bennett', '0400000001', NULL, 'B', NULL);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (2, 'Marcus', 'Tan', '0400000002', NULL, 'B', NULL);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (3, 'Ava', 'Singh', '0400000003', NULL, 'T', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (4, 'Lucas', 'Nguyen', '0400000004', NULL, 'T', 1);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (5, 'Ethan', 'Patel', '0400000005', NULL, 'M', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (6, 'Mia', 'Roberts', '0400000006', 'VICD000001', 'D', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (7, 'Noah', 'Wilson', '0400000007', 'VICD000002', 'D', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (8, 'Lily', 'Chen', '0400000008', 'VICD000003', 'D', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (9, 'Oscar', 'Martin', '0400000009', 'VICD000004', 'D', 2);

INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (10, 'Ruby', 'Brown', '0400000010', 'VICD000005', 'D', 2);

INSERT INTO employee (emp_no,emp_gname,emp_fname,emp_contact_no,emp_licenceno,emp_role,emp_no_manager) 
VALUES (11,'Sarah','Mitchell','0411000001',NULL,'B',NULL);

INSERT INTO employee (emp_no,emp_gname,emp_fname,emp_contact_no,emp_licenceno,emp_role,emp_no_manager) 
VALUES (12,'Michael','Johnson','0411000006','LIC00000006','D', 1);

--------------------------------------
--INSERT INTO quote
--------------------------------------
INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (1, TO_DATE('01-May-2026', 'dd-Mon-yyyy'), TO_DATE('05-May-2026', 'dd-Mon-yyyy'), '55 Lonsdale Street, Melbourne', '42 Collins Street, Melbourne', 1250.00, 1, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (2, TO_DATE('02-May-2026', 'dd-Mon-yyyy'), TO_DATE('06-May-2026', 'dd-Mon-yyyy'), '15 George Street, Sydney', '127 Parramatta Road, Sydney', 1850.00, 2, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (3, TO_DATE('03-May-2026', 'dd-Mon-yyyy'), TO_DATE('07-May-2026', 'dd-Mon-yyyy'), '23 Murray Street, Perth', '38 Wellington Street, Perth', 1425.00, 3, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (4, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('09-May-2026', 'dd-Mon-yyyy'), '56 Bourke Street, Melbourne', '18 Chapel Street, Melbourne', 980.00, 4, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (5, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('10-May-2026', 'dd-Mon-yyyy'), '61 Ann Street, Brisbane', '72 Cavill Avenue, Brisbane', 1320.00, 5, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (6, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('12-May-2026', 'dd-Mon-yyyy'), '29 Barrack Street, Perth', '88 Queen Street, Brisbane', 3950.00, 6, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (7, TO_DATE('07-May-2026', 'dd-Mon-yyyy'), TO_DATE('13-May-2026', 'dd-Mon-yyyy'), '72 Cavill Avenue, Brisbane', '34 Adelaide Street, Brisbane', 1160.00, 7, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (8, TO_DATE('08-May-2026', 'dd-Mon-yyyy'), TO_DATE('14-May-2026', 'dd-Mon-yyyy'), '42 Collins Street, Melbourne', '55 Lonsdale Street, Melbourne', 1085.00, 8, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (9, TO_DATE('09-May-2026', 'dd-Mon-yyyy'), TO_DATE('16-May-2026', 'dd-Mon-yyyy'), '67 King William Street, Adelaide', '45 Rundle Mall, Adelaide', 920.00, 9, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (10, TO_DATE('10-May-2026', 'dd-Mon-yyyy'), TO_DATE('17-May-2026', 'dd-Mon-yyyy'), '45 Rundle Mall, Adelaide', '94 Henley Beach Road, Adelaide', 1035.00, 10, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (11, TO_DATE('11-May-2026', 'dd-Mon-yyyy'), TO_DATE('19-May-2026', 'dd-Mon-yyyy'), '55 Lonsdale Street, Melbourne', '56 Bourke Street, Melbourne', 875.00, 1, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (12, TO_DATE('12-May-2026', 'dd-Mon-yyyy'), TO_DATE('20-May-2026', 'dd-Mon-yyyy'), '15 George Street, Sydney', '92 Oxford Street, Sydney', 1210.00, 2, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (13, TO_DATE('13-May-2026', 'dd-Mon-yyyy'), TO_DATE('22-May-2026', 'dd-Mon-yyyy'), '23 Murray Street, Perth', '29 Barrack Street, Perth', 995.00, 3, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (14, TO_DATE('14-May-2026', 'dd-Mon-yyyy'), TO_DATE('23-May-2026', 'dd-Mon-yyyy'), '56 Bourke Street, Melbourne', '42 Collins Street, Melbourne', 760.00, 4, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (15, TO_DATE('15-May-2026', 'dd-Mon-yyyy'), TO_DATE('25-May-2026', 'dd-Mon-yyyy'), '61 Ann Street, Brisbane', '88 Queen Street, Brisbane', 1475.00, 5, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (16, TO_DATE('16-May-2026', 'dd-Mon-yyyy'), TO_DATE('27-May-2026', 'dd-Mon-yyyy'), '29 Barrack Street, Perth', '23 Murray Street, Perth', 810.00, 6, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (17, TO_DATE('17-May-2026', 'dd-Mon-yyyy'), TO_DATE('29-May-2026', 'dd-Mon-yyyy'), '72 Cavill Avenue, Brisbane', '61 Ann Street, Brisbane', 1185.00, 7, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (18, TO_DATE('18-May-2026', 'dd-Mon-yyyy'), TO_DATE('31-May-2026', 'dd-Mon-yyyy'), '42 Collins Street, Melbourne', '18 Chapel Street, Melbourne', 990.00, 8, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (19, TO_DATE('19-May-2026', 'dd-Mon-yyyy'), TO_DATE('02-Jun-2026', 'dd-Mon-yyyy'), '67 King William Street, Adelaide', '83 Jetty Road, Adelaide', 1130.00, 9, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (20, TO_DATE('20-May-2026', 'dd-Mon-yyyy'), TO_DATE('04-Jun-2026', 'dd-Mon-yyyy'), '45 Rundle Mall, Adelaide', '67 King William Street, Adelaide', 945.00, 10, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (21, TO_DATE('21-May-2026', 'dd-Mon-yyyy'), TO_DATE('06-Jun-2026', 'dd-Mon-yyyy'), '34 Adelaide Street, Brisbane', '72 Cavill Avenue, Brisbane', 1295.00, 11, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (22, TO_DATE('22-May-2026', 'dd-Mon-yyyy'), TO_DATE('08-Jun-2026', 'dd-Mon-yyyy'), '38 Wellington Street, Perth', '29 Barrack Street, Perth', 1040.00, 12, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (23, TO_DATE('23-May-2026', 'dd-Mon-yyyy'), TO_DATE('10-Jun-2026', 'dd-Mon-yyyy'), '88 Queen Street, Brisbane', '61 Ann Street, Brisbane', 1505.00, 13, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (24, TO_DATE('24-May-2026', 'dd-Mon-yyyy'), TO_DATE('12-Jun-2026', 'dd-Mon-yyyy'), '101 Pitt Street, Sydney', '15 George Street, Sydney', 1360.00, 14, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (25, TO_DATE('25-May-2026', 'dd-Mon-yyyy'), TO_DATE('14-Jun-2026', 'dd-Mon-yyyy'), '78 Hay Street, Perth', '23 Murray Street, Perth', 1175.00, 15, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (26, TO_DATE('26-May-2026', 'dd-Mon-yyyy'), TO_DATE('16-Jun-2026', 'dd-Mon-yyyy'), '92 Oxford Street, Sydney', '127 Parramatta Road, Sydney', 1245.00, 16, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (27, TO_DATE('27-May-2026', 'dd-Mon-yyyy'), TO_DATE('18-Jun-2026', 'dd-Mon-yyyy'), '18 Chapel Street, Melbourne', '55 Lonsdale Street, Melbourne', 890.00, 17, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (28, TO_DATE('28-May-2026', 'dd-Mon-yyyy'), TO_DATE('20-Jun-2026', 'dd-Mon-yyyy'), '94 Henley Beach Road, Adelaide', '45 Rundle Mall, Adelaide', 1075.00, 18, 4);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (29, TO_DATE('29-May-2026', 'dd-Mon-yyyy'), TO_DATE('22-Jun-2026', 'dd-Mon-yyyy'), '83 Jetty Road, Adelaide', '67 King William Street, Adelaide', 1195.00, 19, 3);

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (30, TO_DATE('30-May-2026', 'dd-Mon-yyyy'), TO_DATE('24-Jun-2026', 'dd-Mon-yyyy'), '127 Parramatta Road, Sydney', '15 George Street, Sydney', 1285.00, 20, 4);


--------------------------------------
--INSERT INTO job
--------------------------------------

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (1, TO_DATE('05-May-2026 08:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('05-May-2026 14:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 1, 3, 6, 'TRL01', '1HGBH41JXMN109186');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (2, TO_DATE('06-May-2026 07:30', 'dd-Mon-yyyy hh24:mi'), TO_DATE('07-May-2026 15:30', 'dd-Mon-yyyy hh24:mi'), 1950.00, 'Y', 2, 4, 7, 'TRL02', '2FMDK3GC8BBA12345');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (3, TO_DATE('07-May-2026 09:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('07-May-2026 16:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 3, 3, 8, 'TRL03', '3VWFE21C04M000001');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (4, TO_DATE('09-May-2026 10:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('09-May-2026 13:00', 'dd-Mon-yyyy hh24:mi'), 1040.00, 'N', 4, 4, 9, 'TRL04', '4T1BF1FK5CU123456');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (5, TO_DATE('10-May-2026 08:30', 'dd-Mon-yyyy hh24:mi'), TO_DATE('10-May-2026 18:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 5, 3, 10, 'TRL05', '5FNRL5H40BB098765');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (6, TO_DATE('12-May-2026 06:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('14-May-2026 17:00', 'dd-Mon-yyyy hh24:mi'), 4100.00, 'N', 6, 4, 6, 'TRL06', '1FTFW1ET5DFC10112');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (7, TO_DATE('13-May-2026 08:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('13-May-2026 15:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 7, 3, 7, 'TRL07', '2C4RDGCG8ER123789');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (8, TO_DATE('14-May-2026 11:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('14-May-2026 17:30', 'dd-Mon-yyyy hh24:mi'), 1125.00, 'Y', 8, 4, 8, 'TRL08', '5XYKT3A69CG234567');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (9, TO_DATE('16-May-2026 07:45', 'dd-Mon-yyyy hh24:mi'), TO_DATE('16-May-2026 12:30', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 9, 3, 9, 'TRL05', '1HGBH41JXMN109186');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (10, TO_DATE('17-May-2026 09:15', 'dd-Mon-yyyy hh24:mi'), TO_DATE('17-May-2026 14:45', 'dd-Mon-yyyy hh24:mi'), 980.00, 'N', 10, 4, 10, 'TRL08', '2FMDK3GC8BBA12345');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (11, TO_DATE('19-May-2026 08:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('19-May-2026 11:30', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 11, 3, 6, 'TRL01', '1HGBH41JXMN109186');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (12, TO_DATE('20-May-2026 10:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('20-May-2026 18:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 12, 4, 7, 'TRL02', '2FMDK3GC8BBA12345');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (13, TO_DATE('22-May-2026 08:30', 'dd-Mon-yyyy hh24:mi'), TO_DATE('22-May-2026 14:30', 'dd-Mon-yyyy hh24:mi'), 1085.00, 'N', 13, 3, 8, 'TRL03', '3VWFE21C04M000001');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (14, TO_DATE('23-May-2026 12:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('23-May-2026 16:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 14, 4, 9, 'TRL04', '4T1BF1FK5CU123456');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (15, TO_DATE('25-May-2026 07:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('25-May-2026 19:00', 'dd-Mon-yyyy hh24:mi'), 1540.00, 'Y', 15, 3, 10, 'TRL05', '5FNRL5H40BB098765');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (16, TO_DATE('27-May-2026 09:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('27-May-2026 13:30', 'dd-Mon-yyyy hh24:mi'), NULL, 'N', 16, 4, 6, 'TRL06', '1FTFW1ET5DFC10112');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (17, TO_DATE('29-May-2026 08:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('29-May-2026 16:30', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 17, 3, 7, 'TRL07', '2C4RDGCG8ER123789');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (18, TO_DATE('31-May-2026 10:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('31-May-2026 15:00', 'dd-Mon-yyyy hh24:mi'), 1035.00, 'Y', 18, 4, 8, 'TRL08', '5XYKT3A69CG234567');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (19, TO_DATE('02-Jun-2026 07:30', 'dd-Mon-yyyy hh24:mi'), TO_DATE('02-Jun-2026 13:30', 'dd-Mon-yyyy hh24:mi'), 1200.00, 'N', 19, 3, 9, 'TRL05', '1HGBH41JXMN109186');

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, schd_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (20, TO_DATE('04-Jun-2026 09:00', 'dd-Mon-yyyy hh24:mi'), TO_DATE('04-Jun-2026 14:00', 'dd-Mon-yyyy hh24:mi'), NULL, 'Y', 20, 4, 10, 'TRL08', '2FMDK3GC8BBA12345');

COMMIT;



