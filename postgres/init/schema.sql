\c transactions;

CREATE TABLE transactions.public.users
(
    id   SERIAL PRIMARY KEY,
    name varchar(20),
    age  integer
);

CREATE SEQUENCE user_sequence
    start 3
    increment 1;

INSERT INTO transactions.public.users (id, name, age)
VALUES (1, 'Alex', 23),
       (2, 'Andrew', 27);
