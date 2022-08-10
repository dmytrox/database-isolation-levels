USE transactions;

CREATE TABLE users
(
    id   integer primary key auto_increment,
    name varchar(20),
    age  integer
);

INSERT IGNORE INTO users (id, name, age) VALUES
(1, 'Alex', 23),
(2, 'Andrew', 27);
