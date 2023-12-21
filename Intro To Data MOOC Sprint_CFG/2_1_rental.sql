CREATE DATABASE bobbisRentals;

USE bobbisRentals;

SELECT * FROM bobbis_customer_rentals;
SELECT * FROM bobbis_customers;
SELECT * FROM bobbis_rental_cars;

CREATE TABLE normalised_bobbis_customers_rentals (
	customer_id int,
    car_license varchar(100),
    invoice_id varchar(100)			-- because there is commas
);

INSERT INTO normalised_bobbis_customers_rentals
SELECT customer_id, cars_rented, invoice_id
FROM bobbis_customers;

SELECT * FROM normalised_bobbis_customers_rentals;

SET SQL_SAFE_UPDATES = 0;

-- redo wrong values
DELETE FROM normalised_bobbis_customers_rentals
WHERE customer_id = 779 OR customer_id = 780 OR customer_id = 781;

SELECT * FROM normalised_bobbis_customers_rentals;
SELECT * FROM bobbis_customers;

-- separating
INSERT INTO normalised_bobbis_customers_rentals
VALUES
(779, "5H5MD7", "2903"),
(779, "6CH&LY", "3490"),
(779, "775MBW", "1021"),
(780, "5H5MD7", "7890"),
(780, "8KL5J4", "4494"),
(781, "775MBW", "6656"),
(781, "6CH&LY", "4587");

SELECT * FROM normalised_bobbis_customers_rentals;

-- invoice_id into int
ALTER TABLE normalised_bobbis_customers_rentals
CHANGE invoice_id invoice_id int;
 
SELECT * FROM bobbis_customers;

-- remove colums
ALTER TABLE bobbis_customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;

SELECT * FROM normalised_bobbis_customers_rentals;
SELECT * FROM bobbis_customers;

-- customer_id into primary key
ALTER TABLE bobbis_customers
ADD PRIMARY KEY (customer_id);

-- in normalised - customer_id into foreign key
ALTER TABLE normalised_bobbis_customers_rentals
ADD FOREIGN KEY (customer_id) REFERENCES bobbis_customers(customer_id);

