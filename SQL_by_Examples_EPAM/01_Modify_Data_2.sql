### JOINs, Insertion, Merging, 
## JOIN, SUBQUERY, AGGREGATION, COMPAUND CONDITION,
## DATA INSERTION, UPDATE, Conditional Data Modification

# 34
# 1
# Show human-readable info about all books (title, author, genre)
# m2m_books_authors, m2m_books_genres
SELECT books.b_name,
    authors.a_name,
    genres.g_name
FROM books
JOIN m2m_books_authors AS ma ON books.b_id = ma.b_id	/*USING(`b_id`)*/
JOIN authors ON  ma.a_id = authors.a_id					/*USING(`a_id`)*/
JOIN m2m_books_genres AS mg ON books.b_id = mg.b_id		/*USING(`b_id`)*/
JOIN genres ON mg.g_id = genres.g_id;					/*USING(`g_id`)*/



# 35
# 2
# Show human-readable info about all subscriptions
# (books title, subscribers name, s_id, sb_start, sb_finish)
SELECT books.b_name,
	subscribers.s_name,
    subscribers.s_id,
    subscriptions.sb_start, 
    subscriptions.sb_finish
FROM books
JOIN subscriptions ON books.b_id = subscriptions.sb_book
JOIN subscribers ON subscriptions.sb_subscriber = subscribers.s_id;



# 36* ???
# Write SQL queries to show books written by more than one author
SELECT books.b_name,
	COUNT(authors.a_name) AS authors
FROM books
JOIN m2m_books_authors AS ma ON books.b_id = ma.b_id
JOIN authors ON ma.a_id =  authors.a_id
GROUP BY books.b_id
HAVING COUNT(a_name) >1;

# 37* ???
# Write SQL queries to show books that are written in exactly one genre
SELECT books.b_name,
	COUNT(genres.g_name) AS genre
FROM books
JOIN m2m_books_genres AS mg ON books.b_id = mg.b_id	
JOIN genres ON mg.g_id = genres.g_id
GROUP BY books.b_id
HAVING COUNT(g_name) =1;



# 38
# Show all books along with treir authors (books titles duplication is not allowed)
SELECT books.b_name,
	GROUP_CONCAT(
		authors.a_name
        ORDER BY authors.a_name
        SEPARATOR ', '
        ) AS authors
FROM books
JOIN m2m_books_authors AS ma ON books.b_id = ma.b_id
JOIN authors ON ma.a_id = authors.a_id
GROUP BY books.b_id
ORDER BY books.b_name;



# 39
# Show all books along with treir authors (books titles duplication is not allowed)
SELECT books.b_name,
	GROUP_CONCAT(
		authors.a_name
        ORDER BY authors.a_name
        SEPARATOR ', '
        ) AS authors
FROM books
JOIN m2m_books_authors AS ma ON books.b_id = ma.b_id
JOIN authors ON ma.a_id = authors.a_id
GROUP BY books.b_id
ORDER BY books.b_name;



# 40
# Show all books along with treir authors and genres (books titles
# and/or authors duplication is not allowed)
SELECT books.b_name,
	GROUP_CONCAT(
		DISTINCT authors.a_name 
        ORDER BY authors.a_name
        SEPARATOR ', '
		) AS authors,
	GROUP_CONCAT(
		DISTINCT genres.g_name
        ORDER BY genres.g_name
        SEPARATOR ', '
		) AS genres
FROM books
JOIN m2m_books_authors AS ma ON books.b_id = ma.b_id
JOIN authors ON ma.a_id = authors.a_name
JOIN m2m_books_genres AS mg ON books.b_id = mg.b_id	
JOIN genres ON mg.g_id = genres.g_id	
GROUP BY books.b_id
ORDER BY books.b_name;



