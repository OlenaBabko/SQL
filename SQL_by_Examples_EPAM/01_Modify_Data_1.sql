# Queries to Select and Modify Data



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


