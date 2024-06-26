# Queries to Select and Modify Data
# SELECT, COUNT, ORDER, GROUP


# 1 Show unique Id of subscribers, who visited the library at least once
SELECT DISTINCT sb_subscriber
FROM subscriptions;

# 2 Show the list of all subscribers, with counting their names
SELECT s_name,
 COUNT(*) AS people_count
FROM subscribers
GROUP BY s_name;


# 3*
# all ids (without duplication) of all books ever taken by subscribers;
SELECT DISTINCT sb_book
FROM subscriptions
WHERE sb_start IS True;


# 4*
# all books along with count of times each book was taken by a subscriber
SELECT sb_book,
	COUNT(sb_start) AS was_taken
FROM subscriptions
GROUP BY sb_book;



# 5 Write query to show how many subscribers are there in the library.
SELECT COUNT(s_id) AS total_subscribers
FROM subscribers;


# 6 how many books are there in the library.
SELECT COUNT(b_id) AS total_books
FROM books;


# 7 how many copies of books are taken by subscribers
SELECT COUNT(sb_book) AS copies_taken					/* "in_use" */
FROM subscriptions
WHERE sb_is_active = 'Y';


# 8 how many different books are taken by subscribers
SELECT COUNT(DISTINCT sb_book) AS books_taken			/* "in_use" */
FROM subscriptions
WHERE sb_is_active = 'Y';


# 9*
# how many times subscribers have taken books
SELECT sb_subscriber,
	COUNT(DISTINCT sb_book) AS books_taken
FROM subscriptions
GROUP BY sb_subscriber;

# 10*
# how many subscribers have taken books
SELECT COUNT(DISTINCT sb_subscriber) AS num_of_subscribers
FROM subscriptions;



# 11 Show total, min, max, average copies of books quantities
SELECT SUM(b_quantity) AS sum,
	MIN(b_quantity) AS min,
    MAX(b_quantity) AS max,
    AVG(b_quantity) AS avg
FROM books;


# 12 Write query to show the first and the last dates when a book was taken by a subscriber
SELECT sb_subscriber,
	MIN(sb_start) AS first_book_taken,
    MAX(sb_start) AS last_book_taken
FROM subscriptions
GROUP BY sb_subscriber;


# 13 Show all books ordered by issuing year(asc)
SELECT b_name, b_year
FROM books
ORDER BY b_year ASC;


# 14
# query to show the all authors ordered by their names descending (i.e., "Z -> A")
SELECT a_name
FROM authors
ORDER BY a_name DESC;


# 15
# Show all books issued (1990-2000) and represented with at least 3copies
SELECT b_name, b_year, b_quantity
FROM books
WHERE b_year BETWEEN 1990 AND 2000
	AND b_quantity >= 3;
    
# 16
# Show all subscritions that had occuerred in summer of 2012
SELECT sb_subscriber, sb_start
FROM subscriptions
WHERE sb_start >= 2012-06-01 AND sb_start < 2012-09-01;


# 17 
# Show books that have the number of their copies 
# less than average number of all books copies;
SELECT b_name,
	b_quantity
FROM books
WHERE b_quantity < (
	SELECT AVG(b_quantity)
    FROM books
);
/*
# 18* ???
# Show ids and dates of all subscriptions occurred during the
# first year of the library work (i.e., up to Dec 31st of 
# the year when the first subscription had happened)
SELECT sb_id,
	sb_start
FROM subscriptions
WHERE sb_start <= (
	SELECT MIN(sb_start)
    FROM subscriptions
    );
*/


# 19 
# Show one book, the number of copies of which is max (equal to max for all books)
SELECT b_name,
	b_quantity
FROM books
WHERE b_quantity = (
	SELECT MAX(b_quantity)
    FROM books)
LIMIT 1;
# OR
SELECT b_name,
	b_quantity
FROM books
ORDER BY b_quantity DESC
LIMIT 1;


# 20
# Show all books, the number of copies of which is max (= the same for all these books)
SELECT b_name,
	b_quantity
FROM books
WHERE b_quantity = (
	SELECT MAX(b_quantity)
    FROM books);
    
# 21
# Show books, if any, which has more copies than any other books
# ALL, subquery
SELECT b_name,
	b_quantity
FROM books AS external
WHERE b_quantity > ALL (
	SELECT b_quantity
    FROM books AS internal
    WHERE external.b_id != internal.b_id
    );
# OR
# RANK, cte
WITH ranked_cte AS (
	SELECT  b_name,
		b_quantity,
        RANK() OVER (
        ORDER BY b_quantity DESC) AS rank_position
	FROM books
    ),
    counted_cte AS (
		SELECT rank_position,
			COUNT(*) AS bigest
		FROM ranked_cte
        GROUP BY rank_position
        )
SELECT b_name,
	b_quantity
FROM ranked_cte
JOIN counted_cte
ON counted_cte.rank_position = 1 AND counted_cte.bigest = 1;


/*
# 22* ??? NOT WORKING
# Write SQL queries to show the identifier of one (any) 
#subscriber who has taken the most books from the library;
SELECT sb_subscriber
FROM subscriptions
WHERE sb_subscriber = (
	SELECT COUNT(sb_start)
    FROM subscriptions
    GROUP BY sb_subscriber
    )
LIMIT 1;

# 23* ???
# Write SQL queries to show the identifiers of all subscribers who
# has taken the most books from the library;

# 24* ???
# Write SQL queries to show the identifier of the "champion subscriber" 
# who has taken more books from the library than any other subscriber.

*/



# 25
# Show the average quantity of copies of books each reader currently has taken
SELECT AVG(copies_currently_taken) AS average_copies
FROM (
	SELECT COUNT(sb_book) AS copies_currently_taken
    FROM subscriptions
	WHERE sb_is_active = "Y"
	GROUP BY sb_subscriber
    )
    AS count_subquery;


# 26
# Show the average quantity of books each reader currently has taken
SELECT AVG(books_currently_taken) AS average_books
FROM (
	SELECT COUNT(DISTINCT sb_book) AS books_currently_taken
    FROM  subscriptions
	WHERE sb_is_active = "Y"
    GROUP BY sb_subscriber
    )
    AS count_books_subquery;


# 27 
# Show the average number of days a subscriber reads a book
# (only cases when a book was returned)
SELECT AVG(DATEDIFF(`sb_finish`, `sb_start`)) AS average_days
FROM subscriptions
WHERE sb_is_active = 'N';


# 28 ??? need think about
# Show the average number of days a subscriber reads a book
# (both cases when a book was returnwed and was not yet returned)

SELECT AVG(days) AS average_days
FROM (
	SELECT DATEDIFF(`sb_finish`, `sb_start`) AS days     /*_when_returned */
	FROM subscriptions
	WHERE sb_is_active = "N"
	UNION ALL
    SELECT DATEDIFF(CURDATE(), `sb_start`) AS days      /*_not_returned */
	FROM subscriptions
	WHERE sb_is_active = "Y"
    )
    AS all_days;

  
 
# 29*
# Write SQL queries to show average number of copies 
# of books registered in the library;
SELECT AVG(b_quantity)
FROM books
GROUP BY b_id;


# 30* ???
# show average number of days a subscriber 
# is registered in the library (the registration period starts with
# the first subscription date and ends with the current date).

SELECT 
	AVG(days_registered)
FROM subscriptions
WHERE (
	SELECT DATEDIFF(CURDATE(), MIN(sb_start)) AS days_registered
    FROM subscriptions
    GROUP BY sb_subscriber
    );


# 31
# For each year show how many books was taken by subscribers
SELECT YEAR(sb_start) AS `year`,
	COUNT(sb_id) AS `books_taken`
FROM subscriptions
GROUP BY `year`
ORDER BY `year`;


# 32
# For each year show how many subscribers were taking books
SELECT YEAR(sb_start) AS `year`,
	COUNT(DISTINCT sb_subscriber) AS `subscribers`
FROM subscriptions
GROUP BY `year`
ORDER BY `year`;


# 33
# Show how many books was returned / not returned to the library
SELECT
	COUNT(CASE WHEN sb_is_active = "N" THEN "returned" END) AS books_returned,
	COUNT(CASE WHEN sb_is_active = "Y" THEN "not_returned" END) AS books_not_returned
FROM subscriptions;

## or
SELECT 
	IF (
		sb_is_active = "Y", "not_returned", "returned"
        ) AS status,
	COUNT(sb_id) AS books
FROM subscriptions
GROUP BY status
ORDER BY status DESC;



# 34