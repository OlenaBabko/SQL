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



