--QUESTION 1
SELECT DISTINCT YEAR(release_date) AS Year, COUNT(*) AS Movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY YEAR(release_date)
ORDER BY YEAR(release_date);  

--QUESTION 2
SELECT DISTINCT g.name AS Genre, COUNT(*) AS Movies_per_genre
FROM genre g 
    JOIN hasGenre hg ON hg.genre_id = g.id
	JOIN movie m ON hg.movie_id = m.id
WHERE m.budget > 1000000 OR runtime > 120
GROUP BY g.name
ORDER BY COUNT(*);

--QUESTION 3
SELECT YEAR(release_date) AS Year, g.name AS Genre, COUNT(*) AS Movies_per_gy
FROM genre g 
    JOIN hasGenre hg ON hg.genre_id = g.id
    JOIN movie m ON hg.movie_id = m.id
GROUP BY YEAR(release_date), g.name
    HAVING YEAR(release_date) > 0
ORDER BY YEAR(release_date);

--QUESTION 4 (Antonio Banderas)
SELECT DISTINCT YEAR(release_date) AS Year, SUM(revenue) AS Revenues_per_year 
FROM movie m 
    JOIN movie_cast mc ON mc.movie_id = m.id
WHERE mc.person_id = 3131   --Antonio Banderas
GROUP BY YEAR(release_date)
ORDER BY YEAR(release_date);

--QUESTION 5
SELECT DISTINCT YEAR(release_date) AS Year, MAX(budget) AS Max_budget
FROM movie
WHERE budget > 0
GROUP BY YEAR(release_date)
ORDER BY YEAR(release_date);

--QUESTION 6
SELECT c.name AS Trilogy_name
FROM collection c
    JOIN belongsTocollection bc ON bc.collection_id = c.id
GROUP BY c.name
    HAVING COUNT(bc.collection_id) = 3;

--QUESTION 7
SELECT AVG(rating) AS Avg_rating, COUNT(user_id) AS Rating_count
FROM ratings
GROUP BY user_id;

--QUESTION 8
SELECT TOP(10) title AS movie_title, budget
FROM movie
GROUP BY budget, title
ORDER BY budget DESC;

--QUESTION 9
SELECT DISTINCT YEAR(m1.release_date) AS Year , Movies_with_max_budget =
    (SELECT TOP(1) title
    FROM movie m2
    WHERE budget > 0 AND YEAR(m1.release_date) = YEAR(m2.release_date)
    ORDER BY budget DESC)
FROM movie m1
ORDER BY YEAR(m1.release_date);

--QUESTION 10 (Popular_Movie_Pairs)
Create View Popular_Movie_Pairs AS 
    SELECT m1.id AS movie_id1, m2.id AS movie_id2, COUNT(DISTINCT r1.user_id) AS pair_popularity
    FROM movie m1
    JOIN movie m2 ON m1.id < m2.id
    JOIN ratings r1 ON r1.movie_id = m1.id
    JOIN ratings r2 ON r2.movie_id = m2.id AND r2.user_id = r1.user_id
    WHERE r1.rating > 4 AND r2.rating > 4
    GROUP BY m1.id, m2.id
    HAVING COUNT(DISTINCT r1.user_id) > 10;