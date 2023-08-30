CREATE DATABASE travel;
USE travel;

CREATE TABLE planes (
num INTEGER PRIMARY KEY,
Country_start CHAR(25),
Country_arrival CHAR(25)
);

INSERT INTO planes VALUES (5, 'France', 'USA');
INSERT INTO planes VALUES (10, 'Canada', 'Mexico');
INSERT INTO planes VALUES (21, 'Ukraine', 'Spain');
INSERT INTO planes VALUES (2, 'China', 'Japan');



