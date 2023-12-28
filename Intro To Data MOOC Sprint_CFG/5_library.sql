CREATE DATABASE library;

USE library;

CREATE TABLE YoungAdultBooks (
	ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    ReleaseYear INT,
    ISBN VARCHAR(13)
);

INSERT INTO YoungAdultBooks (ID, Title, Author, ReleaseYear, ISBN)
VALUES
	(1, 'The Hunger Games', 'Suzanne Collins', 2008, '9780439023481'),
    (2, 'Divergent', 'Veronica Roth', 2011, '9780062024022'),
    (3, 'The Fault in Our Stars', 'John Green', 2012, '9780525478812'),
    (4, 'Six of Crows', 'Leigh Bardugo', 2015, '9781627792127'),
    (5, 'The Maze Runner', 'James Dashner', 2009, '9780385737951'),
    (6, 'The Book Thief', 'Markus Zusak', 2005, '9780375831003'),
    (7, 'City of Bones', 'Cassandra Clare', 2007, '9781416955078'),
    (8, 'The Lightning Thief', 'Rick Riordan', 2005, '9780786838653'),
    (9, 'Highly Suspicious and Unfairly Cute', 'Talia Hibbert', 2007, '9781234567890'),
    (10, 'The Perks of Being a Wallflower', 'Stephen Chbosky', 1999, '9780671027346'),
    (11, 'Crooked Kingdom', 'Leigh Bardugo', 2016, '9781627792134'),
    (12, 'Catching Fire', 'Suzanne Collins', 2009, '9780439023498'),
    (13, 'The Inheritance Games', 'Jennifer Lynn Barnes', 2019, '9781368052405'),
    (14, 'Legendborn', 'Tracy Deonn', 2020, '9781534441606'),
    (15, 'We Hunt The Flame', 'Hafsah Faizal', 2019, '9780374311544'),
    (16, 'Ace of Spades', 'Faridah Abike-Iyimide', 2021, '9781471409939'),
    (17, 'Shatter Me', 'Tahereh Mafi', 2011, '9780062085504'),
    (18, 'To All the Boys I''ve Loved Before', 'Jenny Han', 2014, '9781442426719'),
    (19, 'The Screaming Staircase', 'Jonathan Stroud', 2013, '9782226311979'),
    (20, 'Skulduggery Pleasant', 'Derek Landy', 2007, '9780007241620');

SELECT * FROM YoungAdultBooks;

-- Title, Author, ReleaseYear, order by author
SELECT Title, Author, ReleaseYear
FROM YoungAdultBooks
ORDER BY Author;

-- most recent relese first
SELECT * FROM YoungAdultBooks
ORDER BY ReleaseYear DESC;
