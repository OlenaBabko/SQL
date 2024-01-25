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

