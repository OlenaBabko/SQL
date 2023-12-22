USE bobbisRentals;

SELECT * FROM bobbis_customer_rentals;

CREATE TABLE normalised_bobbis_cars (
	car_id int,
    car_licence varchar(6),
    model varchar(50),
    manufacturer varchar(50),
    type_car varchar(50),
    car_condition varchar(50),
    color varchar(50)
);

-- copy data from bobbis_customers_rentals to normalised_bobbis_cars
INSERT INTO normalised_bobbis_cars
SELECT DISTINCT car_id, car_license, model, manufacturer, type_car, car_condition, color
FROM bobbis_customer_rentals;

SELECT * FROM normalised_bobbis_cars;

-- remove colums from bobbis_customer_rentals
ALTER TABLE normalised_bobbis_cars
DROP COLUMN car_license,
DROP COLUMN model,
DROP COLUMN manufacturer,
DROP COLUMN type_car,
DROP COLUMN car_condition,
DROP COLUMN color;
 
SELECT * FROM bobbis_customer_rentals;
SELECT * FROM normalised_bobbis_cars;


-- setting primary key and foreign key
-- customer_id into primary key
ALTER TABLE bobbis_customer_rentals
ADD PRIMARY KEY (customer_id);

ALTER TABLE normalised_bobbis_cars
ADD PRIMARY KEY (car_id);

-- in normalised - customer_id into foreign key
ALTER TABLE bobbis_customer_rentals
ADD FOREIGN KEY (car_id) REFERENCES normalised_bobbis_cars(car_id);