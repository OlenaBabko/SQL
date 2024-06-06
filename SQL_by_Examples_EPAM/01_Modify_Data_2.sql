### JOINs, Insertion, Merging, 
## JOIN, SUBQUERY, AGGREGATION

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



# 41 ***
# Write SQL queries to show all books along with their genres 
#(books’ titles duplication is not allowed);
SELECT books.b_name,
	GROUP_CONCAT(
    genres.g_name
    ORDER BY genres.g_name
    SEPARATOR ', '
    ) AS genres
FROM books
JOIN m2m_books_genres AS mg ON books.b_id = mg.b_id	
JOIN genres ON mg.g_id = genres.g_id	
GROUP BY b_name
ORDER BY b_name;


# 42 ***
# Write SQL queries to show all authors along with their books and genres 
# (authors’ names and/or books’ titles duplication is not allowed).
SELECT authors.a_name,
	GROUP_CONCAT(
		books.b_name
        ORDER BY books.b_name
        SEPARATOR ', '
        ) AS books,
    GROUP_CONCAT(
		genres.g_name
        ORDER BY genres.g_name
        SEPARATOR ', '
        ) AS genres
FROM authors
JOIN m2m_books_authors AS ma ON authors.a_id = ma.a_id
JOIN books ON ma.b_id = books.b_id
JOIN m2m_books_genres AS mg ON books.b_id = mg.b_id
JOIN genres ON mg.g_id = genres.g_id
GROUP BY authors.a_name
ORDER BY authors.a_name;



# 43
# Show all subscribers who have ever taken a book from rhe library (with Join)
SELECT
	DISTINCT subscribers.s_id,
	subscribers.s_name
FROM subscribers
JOIN subscriptions ON subscribers.s_id = subscriptions.sb_subscriber
ORDER BY subscribers.s_id;



# 44
# Show all subscribers who have ever taken a book from rhe library (not Join)
SELECT
	DISTINCT s_id,
	s_name
FROM subscribers
WHERE s_id IN (
	SELECT DISTINCT sb_subscriber
    FROM subscriptions)
ORDER BY s_id;



# 45
# Show all subscribers who have never taken a book from rhe library (with Join)
SELECT
	DISTINCT subscribers.s_id,
	subscribers.s_name
FROM subscribers
LEFT JOIN subscriptions ON subscribers.s_id = subscriptions.sb_subscriber
WHERE subscriptions.sb_subscriber IS NULL
ORDER BY subscribers.s_id;



# 46
# Show all subscribers who have never taken a book from rhe library (not Join)
SELECT	
	DISTINCT s_id,
	s_name
FROM subscribers
WHERE s_id NOT IN (
	SELECT DISTINCT sb_subscriber
    FROM subscriptions)
ORDER BY s_id;



# 47 
# a) Write SQL queries to show all books ever taken from the library (use JOIN);
SELECT books.b_name
FROM books
JOIN subscriptions ON books.b_id = subscriptions.sb_book
GROUP BY books.b_name;

# b) Write SQL queries to show all books ever taken from the library (do not use JOIN);
SELECT books.b_name
FROM books
WHERE b_id IN (
	SELECT sb_book
	FROM subscriptions
    )
GROUP BY books.b_name;


# 48
# a) Write SQL queries to show all books never taken from the library (use JOIN);
SELECT books.b_name
FROM books
LEFT JOIN subscriptions ON books.b_id = subscriptions.sb_book
WHERE subscriptions.sb_book IS NULL
GROUP BY books.b_name;

# b) Write SQL queries to show all books never taken from the library (do not use JOIN).
SELECT books.b_name
FROM books
WHERE b_id NOT IN (
	SELECT sb_book
	FROM subscriptions
    )
GROUP BY books.b_name;



# 49
# a) Show all subscribers who doesnot have a book now (use JOIN)
SELECT subscribers.s_id, subscribers.s_name
FROM subscribers
LEFT JOIN subscriptions ON subscribers.s_id = subscriptions.sb_subscriber
GROUP BY subscribers.s_id
HAVING COUNT(IF(subscriptions.sb_is_active = "Y", subscriptions.sb_is_active, NULL)) =0;

# b) Show all subscribers who doesnot have a book now (do not use JOIN)
SELECT subscribers.s_id, subscribers.s_name
FROM subscribers
WHERE subscribers.s_id NOT IN (
	SELECT DISTINCT subscriptions.sb_subscriber
    FROM subscriptions
    WHERE subscriptions.sb_is_active = "Y"
    );
    
   
   
   
    
# 50* ??? still dont know
# Write an SQL query to show all such books that not a single copy
# of which is now taken by any subscriber





# 51    page 95
# Show all books from Programing and\or Classic genres
# do not use JOIN, genres IDs are known
SELECT b_name
FROM books
WHERE b_id IN ( 
	SELECT DISTINCT b_id
    FROM m2m_books_genres
    WHERE g_id IN (2, 5)
);



# 52 
# Show all books from Programing and\or Classic genres
# do not use JOIN, genres IDs are unknown
SELECT b_name
FROM books
WHERE b_id IN ( 
	SELECT DISTINCT b_id
    FROM m2m_books_genres
    WHERE g_id IN (
		SELECT g_id
        FROM genres
        WHERE g_name IN("Programing", "Classic")
));



# 53
# Show all books from Programing and\or Classic genres
# use JOIN, genres IDs are known
SELECT DISTINCT b_name
FROM books
JOIN m2m_books_genres USING(b_id)
WHERE g_id IN (2, 5);



# 54
# Show all books from Programing and\or Classic genres
# use JOIN, genres IDs are unknown
SELECT DISTINCT b.b_name,
	g.g_name
FROM books AS b
JOIN m2m_books_genres AS mbg USING(b_id)
JOIN genres AS g USING(g_id)
WHERE g_name IN("Programing", "Classic");

# OR
SELECT DISTINCT b.b_name
FROM books AS b
JOIN m2m_books_genres AS mbg USING(b_id)
WHERE g_id IN (
	SELECT g_id
    FROM genres
    WHERE g_name IN ("Programing", "Classic")
);



# 55*
# Write SQL queries to show all books written by Alexander Pushkin
# and/or Isaac Asimov (either individually or as co-authors);
SELECT books.b_name,
	authors.a_name
FROM books
JOIN m2m_books_authors USING(b_id)
JOIN authors USING(a_id)
WHERE a_name IN ("Alexander Pushkin", "Isaac Asimov");

# OR
SELECT b_name
FROM books
JOIN m2m_books_authors USING(b_id)
WHERE a_id IN (
	SELECT a_id
    FROM authors
    WHERE a_name IN ("Alexander Pushkin", "Isaac Asimov")
);

# 56* ?
# Show all books written by Dale Carnegie AND Bjarne Stroustrup (as co-authors).
SELECT b_name
FROM books
JOIN m2m_books_authors USING(b_id)
JOIN authors USING(a_id)
WHERE a_name = "Dale Carnegie" AND a_name = "Bjarne Stroustrup";



# 57 page 101
# Show all books having more than 1 author
SELECT b_id,
	b_name,
    COUNT(mba.a_id) AS authors
FROM books
JOIN m2m_books_authors AS mba USING(b_id)
GROUP BY b_id
HAVING  authors > 1;



