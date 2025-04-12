-- SQL Interview Question : Print Movie Stars (⭐ ⭐ ⭐ ⭐ ⭐) For best movie in each Genre.
-- Write a query to return a list of movie genre 
-- and the best movie in that genre based on maximum average review rating and print stars.

WITH MovieList
AS
(
SELECT title
	,genre
	,AVG(ISNULL(rating,0)) Avg_rating
	,Row_Number() OVER (
		partition by genre
		ORDER BY AVG(ISNULL(rating,0)) DESC
	) AS rating
FROM movies A
LEFT JOIN reviews B ON A.ID = B.Movie_id
GROUP BY title
	,genre
)
SELECT 
	title,
	genre,
	Avg_rating,
	replicate('*',ceiling(Avg_rating)) [Movie Stars]
from MovieList WHERE rating=1

