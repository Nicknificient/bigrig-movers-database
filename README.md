# BigRig Movers (BRM) — Relational & NoSQL Database Design

A full-lifecycle database project for **BigRig Movers**, a fictional trucking company that hires out trucks and trailers to customers. Built from a logical data model and a business scenario, this project covers everything from schema design through to transactional DML, live schema evolution, advanced reporting SQL, and a relational → document-store remodel in MongoDB.

> Built for FIT2094 Databases (Monash University). Identifying details (student ID, cohort-specific boilerplate) have been removed for public sharing — the SQL/NoSQL logic is otherwise unchanged from my submission.

---

## Why this project

Most "SQL practice" repos are a single query against a toy table. This one isn't. It's modelled as a real operational system: a Truck Dispatcher quotes a job, a customer accepts (or doesn't), a truck/trailer/driver combination gets assigned, the job cost can diverge from the quoted cost, and the business later needs to evolve the schema *without breaking what's already live*. Each task in this repo represents a stage that a real backend/data engineer would actually hit:

| Stage | What it simulates |
|---|---|
| Schema design | Translating an ER model into enforceable DDL |
| Data loading | Seeding a database with realistic, constraint-valid test data |
| Transactional DML | Handling state changes (a quote becoming a job, a job being rescheduled, a cancellation) safely |
| Live schema migration | Adding new business requirements to a database that already has data and dependents, without downtime or data loss |
| Reporting SQL | Turning raw operational data into the kind of summary a manager would actually ask for |
| NoSQL remodeling | Re-shaping the same data for a document store, and querying it MongoDB-style |

---

## The scenario

BigRig Movers pairs **trucks** (VIN, rego, kilometres, service history) with **trailers** (purchase cost, purchase date) into **combinations**. **Employees** hold one of four roles — Manager, Truck Dispatcher, Mechanic, or Driver — and report up a management chain.

The core business flow:

1. A **customer** calls in and a **Truck Dispatcher** prepares a **quote** — preferred dates, pickup/drop-off locations, and a price. No truck or trailer is assigned yet.
2. If the customer accepts, the dispatcher converts the quote into a **job**: a truck/trailer combination and a driver are assigned, and the *actual* job cost is recorded only if it differs from the quote.
3. Jobs can be rescheduled, cancelled, or marked paid/unpaid — and the *quote always stays in the system as a record*, even if the job built on top of it changes or disappears.

This "quote vs. job" split — where one entity can exist without the other, and the relationship between them can change after the fact — is the trickiest modelling decision in the project, and it drives a lot of the constraint and query design below.

**Entity model:**

```
EMPLOYEE ──manages──> EMPLOYEE (self-referencing, reporting line)
EMPLOYEE ──prepares──> QUOTE ──requests──< CUSTOMER
EMPLOYEE ──schedules─> JOB <──becomes── QUOTE (1:0..1)
EMPLOYEE ──drives────> JOB
TRUCK ──is_used_in──> COMBINATION <──is_combined── TRAILER
COMBINATION ──used_for──> JOB
```

---

## Repository structure

```
T1-brm-schema.sql        Task 1 — DDL: table creation, constraints, FKs
T2-brm-insert.sql        Task 2 — Test data load (single transaction)
T3-brm-dm.sql            Task 3 — Transactional DML on a "live" system
T4-brm-mods.sql          Task 4 — Schema evolution on a live, populated database
T5-brm-select.sql        Task 5 — Reporting / analytical SQL
T6-brm-json.sql          Task 6a — Relational → JSON document generation
T6-brm-mongo.mongodb.js  Task 6b-d — MongoDB collection creation & queries
brm-schema-insert.sql    Base schema + seed data (provided starting point — not authored by me)
```

---

## Task 1 — Schema Design (DDL)

Three tables — `EMPLOYEE`, `QUOTE`, `JOB` — were missing from the supplied partial schema and had to be designed from the ER diagram and built by hand (no scaffolding/ORM tools — this was a hard-coded DDL exercise).

Design decisions worth calling out:

- **Self-referencing FK for the reporting line.** `EMPLOYEE.emp_no_manager` references `EMPLOYEE.emp_no` — every non-manager reports to a manager, and managers themselves have a `NULL` manager (they report to "the business owner," who isn't modelled as an employee).
- **Conditional NOT NULL via CHECK, not application logic.** A driver's licence number is mandatory *only* if their role is Driver:
  ```sql
  ALTER TABLE employee
      ADD CONSTRAINT chk_emp_licenceno CHECK (
          ( emp_role = 'D' AND emp_licenceno IS NOT NULL )
          OR
          ( emp_role <> 'D' AND emp_licenceno IS NULL )
      );
  ```
  This pushes a business rule into the data layer instead of trusting every future caller to enforce it correctly.
- **The quote/job relationship is optional, not mandatory, and 1:1 — not 1:many.** A `UNIQUE` constraint on `job.quote_no` (alongside the FK) enforces that a quote can become *at most one* job, matching the brief's requirement that quotes and jobs are paired one-to-one, while still letting a quote exist with zero jobs (unfulfilled).
- **Default delete rule everywhere.** No `ON DELETE CASCADE` — deleting a referenced row is *blocked* unless dependents are removed first. This was a hard constraint from the brief and reflects how I'd want a production system to behave: silent cascading deletes are a common source of real data-loss incidents.
- **FK constraints added at the end of the script, in dependency order** — tables are created first, then wired together, avoiding "table doesn't exist yet" ordering errors.

---

## Task 2 — Populating a Constraint-Valid Test Dataset

Loading test data sounds trivial until the constraints from Task 1 are actually live. This task is really about proving the schema works under realistic load:

- 12 employees spanning all four roles and at least two layers of the reporting hierarchy.
- 30 quotes across multiple customers and dispatchers, including customers with repeat business (needed later for Task 5's "customers with more than one quote" query).
- 20 jobs deliberately engineered to cover every edge case the brief calls for: jobs costing *more* than the quote, jobs costing *less*, jobs costing the *same*, unpaid jobs, and — critically — **quotes that are never converted to a job at all** (these show up again in Task 4's status flag and Task 6's `"assigned_to_job": "N"` documents).
- The entire load is wrapped in a single transaction with one `COMMIT` at the end — the brief frames this as "setting up the initial state of the database," so partial application of test data was treated as an invalid state.

---

## Task 3 — Transactional DML on a Live System

This task simulates the actual day-to-day operations of the business — and it's deliberately written so that **nothing is hardcoded except the literal facts given in the question**. Every primary key, every lookup, every cross-reference is resolved *inside* SQL:

```sql
INSERT INTO employee (emp_no, emp_gname, emp_fname, ..., emp_no_manager)
VALUES (
    employee_seq.NEXTVAL,
    'Aurello', 'Brown', ...,
    ( SELECT emp_no FROM employee
      WHERE upper(emp_gname) = upper('Sarah')
        AND upper(emp_fname) = upper('Mitchell')
        AND emp_role = 'B' )
);
```

Why this matters: the brief is explicit that this is a **multi-user system with a constantly changing dataset** — you cannot assume a manager's ID is "37" because you happened to see that in a SELECT five minutes ago. The only safe approach is to look the value up *at the time the statement runs*, every time. That's the difference between a script that works once on a snapshot and one that's safe to run against production.

The sub-tasks chain together as one realistic story:

| Step | Business event | DB operation |
|---|---|---|
| (a) | New PK sequences needed | `CREATE SEQUENCE` (start 300, increment 5) |
| (b) | New employee hired | `INSERT` into `EMPLOYEE`, manager resolved by name lookup |
| (c) | Quote prepared → customer accepts → job scheduled | `INSERT` into `QUOTE` and `JOB`, treated as **one transaction** |
| (d) | Customer reschedules, cost renegotiated | `UPDATE JOB` — new pickup/drop-off, cost recalculated as `quote_cost * 1.2` *in SQL*, not by hand |
| (e) | Customer cancels | `DELETE FROM JOB` — the quote itself is preserved, only the job is removed (matching the brief: a cancelled job ≠ a cancelled quote) |

Step (d) in particular is a good example of "don't compute it on a calculator and paste the number in" — the 20% uplift is a derived value, calculated by the database from the existing quote cost at UPDATE time, not a literal I typed in after doing the maths myself.

---

## Task 4 — Evolving a Live Schema Without Breaking It

This is the part of the project that looks most like real platform/backend work: **the database already has data and dependents, and the schema still has to change.**

**(a) Adding quote status tracking.** BRM wants to know, for every quote, whether it ever became a job — and if not, why. Two new columns, with a CHECK constraint that *encodes the business rule directly*:

```sql
ALTER TABLE quote
    ADD CONSTRAINT quote_not_assigned_reason_chk CHECK (
        ( quote_assigned = 'Y' AND quote_not_assigned_reason IS NULL )
        OR
        quote_assigned = 'N'
    );
```
i.e. you're not allowed to mark a quote "assigned" *and* still give it an unassigned-reason — the constraint makes that state physically unrepresentable in the data, rather than relying on every future `UPDATE` statement to remember not to do it.

The harder part: the column has to be **backfilled correctly from existing data** the moment it's added — not just defaulted to `'N'` for everyone:

```sql
ALTER TABLE quote ADD quote_assigned CHAR(1) DEFAULT 'N' NOT NULL;
...
UPDATE quote SET quote_assigned = 'Y'
WHERE quote_no IN ( SELECT quote_no FROM job );
```

**(b) Modelling truck servicing — a brand-new 1:many:many structure.** BRM now wants to record truck services (start/end date-time) and, within each service, a list of individual tasks (oil change, brake check, etc.), each completed by a specific mechanic with a free-text note. This needed three new tables:

```
MECHANIC (subset of EMPLOYEE — only emp_no, FK-constrained to employees with role 'M')
SERVICE_TASK (a growing catalogue of task types — oil change, tyre rotation, etc.)
TRUCK_SERVICE (one row per service event on a truck)
TRUCK_SERVICE_TASK (junction table: which tasks were done, by whom, in which service)
```

`MECHANIC` is the interesting design call here — rather than re-deriving "is this employee a mechanic" from `EMPLOYEE.emp_role = 'M'` every time (and risk that check silently going stale if a mechanic's role is ever changed), it's modelled as its own table with a FK back to `EMPLOYEE`, so `TRUCK_SERVICE_TASK` has a referential guarantee, not a query-time assumption.

Tables with downstream dependents (`truck_service_task`, which references three different parents) are dropped child-first, in the right order, so the rebuild never fails on a dangling reference — and every drop is placed directly above the `CREATE TABLE` it belongs to, so the script reads as a clear before/after pair rather than a wall of drops up front.

---

## Task 5 — Reporting SQL

Three queries, each modelling a question a real ops manager would ask, with output formatted to a specific reporting standard (not just "whatever the query happens to return"):

**(a) High-value repeat customers.** Customers with more than one quote, whose *average* quoted cost beats the *company-wide* average — a correlated subquery comparing a per-group aggregate against a global one:

```sql
HAVING COUNT(q.quote_no) > 1
   AND AVG(q.quote_cost) > ( SELECT AVG(quote_cost) FROM quote )
```

Currency is formatted to `$#,##0.00` via `TO_CHAR`, and the customer display name falls back from business name → full personal name depending on what's actually populated.

**(b) Org chart with role-conditional metrics.** Every employee, their manager's name (or `'No Manager'` — handled via `LEFT OUTER JOIN` plus `CASE`, not a NULL leaking into the output), and a jobs-scheduled count that's *only meaningful for Truck Dispatchers* — for every other role, the column is deliberately left blank rather than showing a misleading `0`:

```sql
CASE
    WHEN e.emp_role = 'T' THEN TO_CHAR(COUNT(j.job_no))
    ELSE ''
END AS jobs_dispatched
```

**(c) Fleet utilisation classification.** For every truck/trailer combination — including ones that have *never* been used — compute job count, total quoted revenue, and a `High Use` / `Standard Use` / `Never Used` label, where "high" is defined *relative to the fleet's own average utilisation*, not a hardcoded threshold:

```sql
WHEN COUNT(j.job_no) > (
    SELECT AVG(job_count) FROM (
        SELECT COUNT(*) AS job_count FROM job
        GROUP BY truck_vin, trailer_code
    )
) THEN 'High Use'
```

This is a self-relative benchmark (this quarter's average vs. each combination), which is a more honest way to flag "is this asset under- or over-utilised" than an arbitrary fixed number — and it required nesting an aggregate-of-an-aggregate without using a CTE (the brief restricts the task to non-`WITH` syntax, so this is solved with a derived-table subquery instead). Unused combinations are kept in the result via `LEFT OUTER JOIN` rather than silently dropped, and currency/zero-job cases are formatted with fixed-width padding to match an exact output specification.

> **A constraint worth noting:** this entire project — Tasks 1 through 6 — was restricted to SQL/NoSQL syntax actually covered in the unit. No CTEs (`WITH`), no views, no PL/SQL blocks (`BEGIN...END`). Every multi-step calculation above had to be expressed as nested subqueries and `JOIN`s instead — which, if anything, is a more useful constraint to practice under, since plenty of production environments restrict CTEs/views for performance or tooling reasons too.

---

## Task 6 — Relational → Document Store Remodeling (MongoDB)

The last stage of the project asks a different kind of question: given a normalized relational schema, **how would this data actually look if a customer-facing app queried it as a single document instead of five joined tables?**

**(a) Generating the document shape in SQL.** Rather than exporting rows and reshaping them in application code, the JSON documents are built *inside* Oracle using `JSON_OBJECT` and `JSON_ARRAYAGG` — one document per customer, with quote-level and job-level statistics pre-aggregated into the document itself:

```sql
'customer_stats' VALUE JSON_OBJECT(
    'number_of_quotes' VALUE ( SELECT COUNT(*) FROM quote q1 WHERE q1.cust_no = c.cust_no ),
    'total_paid_jobcost' VALUE ( ... CASE WHEN SUM(...) IS NULL THEN '-' ELSE '$' || TO_CHAR(...) END )
),
'quotes' VALUE (
    SELECT JSON_ARRAYAGG( JSON_OBJECT( 'quote_no' VALUE q.quote_no, ... ) ORDER BY q.quote_no )
    FROM quote q LEFT OUTER JOIN job j ON q.quote_no = j.quote_no
    WHERE q.cust_no = c.cust_no
) FORMAT JSON
```

This is the core modelling decision of the whole task: a customer with 5 quotes becomes **one document with an embedded array of 5 quote sub-objects**, rather than 5 separate rows that need a join to reassemble. It's a direct, hands-on demonstration of the relational-vs-document tradeoff — normalize for write consistency, or denormalize for read-locality — applied to the same dataset.

**(b)–(d) Querying the document store.** Once loaded into MongoDB:

- A filter query combining a nested-field comparison with a regex match on an embedded address string:
  ```js
  db.brmcustomer.find({
      "customer_stats.number_of_quotes": { "$gt": 1 },
      "customer_address": /.*Melbourne.*/
  }, { /* projection */ });
  ```
- A full **insert → update → embedded-array push** lifecycle for onboarding a new customer and recording their first quote, demonstrating that document stores aren't just "for reads" — they support the same create/update operational flow as the relational side, just shaped differently (`$set` on nested fields + `$push` into the embedded `quotes` array, rather than a second `INSERT` into a child table).

---

## A note on scope and originality

Per the assignment's academic integrity rules, AI assistance was permitted **only** for generating placeholder test data in Task 2 (and is acknowledged in that file, with the tool and prompt disclosed). All schema design, constraint logic, transactional DML, schema migrations, reporting SQL, and the MongoDB remodeling (Tasks 1, 3, 4, 5, and 6) were hand-written.

`brm-schema-insert.sql` was supplied as a starting point (the base schema for `CUSTOMER`, `TRUCK`, `TRAILER`, and `COMBINATION`, plus their seed data) and is included here only for the project to run end-to-end — it is not part of my submitted work.

---

## Running this project

1. Run `brm-schema-insert.sql` first — creates and seeds the base tables.
2. Run `T1-brm-schema.sql` — adds `EMPLOYEE`, `QUOTE`, `JOB` and all constraints.
3. Run `T2-brm-insert.sql` — loads test data.
4. Run `T3-brm-dm.sql` → `T4-brm-mods.sql` → `T5-brm-select.sql` in order — each depends on the live state left by the previous one.
5. Run `T6-brm-json.sql` in Oracle to generate the JSON output, then load the equivalent documents into MongoDB and run `T6-brm-mongo.mongodb.js`.

Tested against Oracle Database 19c.

---

## Self-rating: 8/10 SQL proficiency

What's covered here — constraint-driven schema design, multi-step transactional DML against an assumed-concurrent dataset, live ALTER-based migrations with correct backfill, nested subquery analytics without CTEs, and relational-to-document remodeling — reflects confidence with the *intermediate-to-advanced* end of SQL. What would push this further: window functions, query performance tuning/execution plans, and stored procedure/trigger-based logic, none of which were in scope for this unit but are the natural next layer.
