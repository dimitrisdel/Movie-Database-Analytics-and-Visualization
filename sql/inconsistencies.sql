--PERSON_IDs THAT APPEAR MORE THAN ONCE
SELECT person_id
FROM Person
GROUP BY person_id
    HAVING COUNT(*) > 1;

--UPDATE TABLE movie_cast FOR person_id = 47395
UPDATE movie_cast
SET NAME='Miles Malleson', gender= '0'
WHERE person_id = '47395';

--UPDATE TABLE movie_cast FOR person_id = 1785844
UPDATE movie_cast
SET NAME='Peter Malota', gender= '2'
WHERE person_id = '1785844';

--UPDATE TABLE movie_crew FOR person_id = 1785844
UPDATE movie_crew
SET NAME='Peter Malota', gender= '0'
WHERE person_id = '1785844';

--UPDATE TABLE movie_crew FOR person_id = 63574
UPDATE movie_crew
SET NAME='Ka-Fai Cheung', gender= '2'
WHERE person_id = '63574';