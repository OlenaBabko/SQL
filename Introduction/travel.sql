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



SELECT * FROM planes;

SELECT * FROM planes ORDER BY Country_start;

SELECT * FROM planes LIMIT 4;

SELECT Country_start AS 'start' FROM planes;

CREATE TABLE Ftype
(num INTEGER PRIMARY KEY,
Flight_type CHAR(25),
Food_on_plane CHAR(25),
Plane_num INTEGER,
FOREIGN KEY (Plane_num) REFERENCES planes(num)
);

INSERT INTO Ftype VALUES ('1','Direct','yes','5');
INSERT INTO Ftype VALUES ('2','Direct','no','10');
INSERT INTO Ftype VALUES ('3','1 stop','yes','21');
INSERT INTO Ftype VALUES ('4','2 stops','no','2');


SELECT * FROM Ftype;
SELECT * FROM planes;

SELECT * FROM Ftype
WHERE  num > 2;

SELECT * FROM planes
WHERE country_start like '%ca%';

UPDATE Ftype
SET Food_on_plane = "no"
WHERE  num = 3;

SELECT * FROM Ftype
WHERE food_on_plane LIKE '%y%' AND flight_type LIKE '%Di%';

SELECT * FROM planes
WHERE country_start LIKE '%Ca%' OR country_arrival LIKE '%Ja%';


SELECT * FROM Ftype
WHERE num BETWEEN 1 AND 2;