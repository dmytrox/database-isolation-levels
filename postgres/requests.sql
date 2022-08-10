\set AUTOCOMMIT off;

----------------------------------------------------
-- Dirty reads
START TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT current_setting('transaction_isolation');

/* Query 1 */
SELECT age
FROM transactions.public.users
WHERE id = 1;
/* will read 20 */

/* Query 3 */
SELECT age
FROM transactions.public.users
WHERE id = 1;
/* will read 20, all good */
----------------------------------------------------


----------------------------------------------------
-- Lost updates
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT current_setting('transaction_isolation');

START TRANSACTION;
/* Query 1 */
SELECT age
FROM transactions.public.users
WHERE id = 1;

/* Query 3 with commit */
UPDATE transactions.public.users
SET age = (SELECT age FROM transactions.public.users WHERE id = 1) + 1
WHERE id = 1; -- we read 20 before
COMMIT;
/* will write 21 */
----------------------------------------------------


----------------------------------------------------
-- Non-repeatable reads
START TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT current_setting('transaction_isolation');

START TRANSACTION;
/* Query 1 */
SELECT *
FROM transactions.public.users
WHERE id = 1;
/* will read 20 */

/* Query 3 */
SELECT *
FROM transactions.public.users
WHERE id = 1;
/* will read 21, but should read 20 */
COMMIT;
----------------------------------------------------


----------------------------------------------------
-- Phantom reads
START TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT current_setting('transaction_isolation');

START TRANSACTION;
/* Query 1 */
SELECT *
FROM transactions.public.users
WHERE age BETWEEN 10 AND 30;

/* Query 3 */
SELECT *
FROM transactions.public.users
WHERE age BETWEEN 10 AND 30;
COMMIT;
----------------------------------------------------


----------------------------------------------------
-- Serialization anomaly
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT current_setting('transaction_isolation');

/* Query 1 */
SELECT *
FROM transactions.public.users;

/* Query 3 */
SELECT sum(age)
FROM transactions.public.users;
/* will return 45 */

/* Query 5 with commit */
INSERT INTO transactions.public.users (id, name, age)
SELECT nextval('user_sequence'), 'users', sum(age) FROM transactions.public.users;
COMMIT;

\set AUTOCOMMIT off;

----------------------------------------------------
-- Dirty reads
START TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT current_setting('transaction_isolation');

/* Query 2 */
UPDATE transactions.public.users
SET age = 21
WHERE id = 1;
/* No commit here */

ROLLBACK;
/* lock-based DIRTY READ */
----------------------------------------------------


----------------------------------------------------
-- Lost updates
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT current_setting('transaction_isolation');

START TRANSACTION;
/* Query 2 */
SELECT age
FROM transactions.public.users
WHERE id = 1;

/* Query 4 with commit */
UPDATE transactions.public.users
SET age = 20 + 1
WHERE id = 1; -- we read 20 before
COMMIT;
/* will write 21, but should write 22 */
----------------------------------------------------


----------------------------------------------------
-- Non-repeatable reads
START TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT current_setting('transaction_isolation');

/* Query 2 */
UPDATE transactions.public.users
SET age = 21
WHERE id = 1;
COMMIT;
----------------------------------------------------


----------------------------------------------------
-- Phantom reads
START TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT current_setting('transaction_isolation');

/* Query 2 */
INSERT INTO transactions.public.users(id, name, age)
VALUES (3, 'Bob', 27);
COMMIT;
----------------------------------------------------


----------------------------------------------------
-- Serialization anomaly
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT current_setting('transaction_isolation');

/* Query 2 */
SELECT *
FROM transactions.public.users;

/* Query 4 */
SELECT sum(age)
FROM transactions.public.users;
/* will return 45 */

/* Query 6 with commit */
INSERT INTO transactions.public.users (id, name, age)
SELECT nextval('user_sequence'), 'users', sum(age) FROM transactions.public.users;
COMMIT;
