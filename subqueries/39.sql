/*
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
Each movie has a unique title.
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:
- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/

WITH NumberRated AS (
    SELECT u.name, COUNT(r.movie_id) AS number
    FROM Users u
    JOIN MovieRating r
    ON u.user_id = r.user_id
    GROUP BY u.user_id, u.name
),
AverageRating AS (
    SELECT m.title, AVG(r.rating) AS rating
    FROM Movies m
    JOIN MovieRating r
    ON m.movie_id = r.movie_id
    WHERE r.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.movie_id, m.title
)

(SELECT name AS results
FROM NumberRated
ORDER BY number DESC, name ASC
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM AverageRating
ORDER BY rating DESC, title ASC
LIMIT 1)