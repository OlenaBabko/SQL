CREATE DATABASE TeddysToys;

USE TeddysToys;

CREATE TABLE toyChest (
	toy_ID INT PRIMARY KEY,
    toy_name VARCHAR(50),
    category VARCHAR(50),
    price int
);

INSERT INTO toyChest (toy_ID, toy_name, category, price)
VALUES
  (001, 'Teddy Bear', 'Stuffed', 20),
  (002, 'Lego Set', 'Building', 30),
  (003, 'Barbie Doll', 'Doll', 15),
  (004, 'Remote Control Car', 'Action', 25),
  (005, 'Puzzle', 'Game', 10),
  (006, 'Action Figure', 'Doll', 18),
  (007, 'Board Game', 'Game', 20),
  (008, 'Play-Doh', 'Creative', 12),
  (009, 'Jump Rope', 'Action', 8),
  (010, 'Rubiks Cube', 'Puzzle', 15) ;
  
SELECT * FROM toyChest;
  
-- count toys
SELECT COUNT(toy_ID) AS total_toys
FROM toyChest;

-- calc total price of all toys
SELECT SUM(price) AS total_price 
FROM toyChest;
 
-- average price
SELECT AVG(price) AS avg_price 
FROM toyChest;

-- number of action toys
SELECT COUNT(*) AS num_of_action_toys 
FROM toyChest;

-- most cheap and expensive toys
SELECT
	MIN(price) AS most_cheap,
	MAX(price) AS most_expensive
FROM toyChest;
 
-- count by category
SELECT category,
	COUNT(*) AS toy_category
FROM toyChest
GROUP BY category;

-- total price by category
SELECT category,
	SUM(price) AS total_price_by_category
FROM toyChest
GROUP BY category
ORDER BY total_price_by_category;

-- average price by category
SELECT category,
	AVG(price) AS avg_price_by_category
FROM toyChest
GROUP BY category
ORDER BY avg_price_by_category;
 