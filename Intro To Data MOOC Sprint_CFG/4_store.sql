CREATE DATABASE store;

USE store;

SELECT * FROM customers;
SELECT * FROM clubcard_signups;

-- inner join
SELECT
	a.customer_id,
    a.first_name,
    a.last_name,
    a.phone,
    b.email,
    b.clubcard_holder
FROM customers AS a
INNER JOIN clubcard_signups AS b
ON
a.customer_id = b.customer_id;


-- left join
SELECT
	a.customer_id,
    a.first_name,
    a.last_name,
    a.phone,
    b.email,
    b.clubcard_holder
FROM customers AS a
LEFT JOIN clubcard_signups AS b
ON
a.customer_id = b.customer_id;


-- RIGHT JOIN
SELECT
	a.customer_id,
    a.first_name,
    a.last_name,
    a.phone,
    b.email,
    b.clubcard_holder
FROM customers AS a
RIGHT JOIN clubcard_signups AS b
ON
a.customer_id = b.customer_id;