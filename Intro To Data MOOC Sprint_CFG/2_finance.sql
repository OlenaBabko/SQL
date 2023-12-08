CREATE DATABASE finance;

USE finance;

CREATE TABLE customers (
	FullName varchar(50),
    Adress varchar(50),
    Balance int,
    Credid int,
    Debit int
);

INSERT INTO customers
VALUES
	("Polly Moor", "123 Fake Street, Bristol, BS15BB", 10, NULL, 15),
	("Johnathan Lindfild", "1 Made up Street, London, LN1 5TB", 15, NULL, 11),
	("Lewis Hendry", "1 Fictitious Avenue, Glasgo, GL1 6HH", 20, 20, 20);

SELECT * FROM customers;


-- Update the record
UPDATE customers
SET Adress = "22 Not Real Lane, Glasgow, GLW 5BW"
WHERE FullName = "Lewis Hendry";

SELECT * FROM customers;

-- delete record
DELETE FROM Customers
WHERE Balance = 20;

SELECT * FROM customers;


