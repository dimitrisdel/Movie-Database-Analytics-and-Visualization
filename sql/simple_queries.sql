/*	Question 1: "Βρες μου τον τίτλο των ιταλικών και γαλλικών ταινιών που δημοσιεύτηκαν μεταξύ του 2000 και του 2005."
	Output: 117 rows 
*/

SElECT original_title AS title, release_date, original_language AS language
FROM movie
WHERE original_language IN ('it', 'fr')
GROUP BY release_date, original_title, original_language
	HAVING release_date BETWEEN '2000-01-01' AND '2005-12-31'
ORDER BY 2 DESC, 1;

/*	Question 2: "Βρες μου το μεγαλύτερο και το μικρότερο ποσό προϋπολογισμού,
				 καθώς και τα περισσότερα και λιγότερα έσοδα των ταινιών,
				 με το πρώτο γράμμα του τίτλου τους να είναι 'Τ', κατά το έτος 1995."
	Output: 1 row
*/
SELECT MAX(revenue) AS maxRevenue, MAX(budget) AS maxBudget, MIN(revenue) AS minRevenue, MIN(budget) AS minBudget
FROM movie
WHERE (release_date BETWEEN '1995-01-01' AND '1995-12-31')
	AND original_title LIKE 'T%';

/*	Question 3: Βρες μου τα ονόματα των χαρακτήρων της ταινίας American Beauty.
	Output: 40 rows
*/

SELECT mc.character, mc.name AS ActorName, m.original_title AS title
FROM movie_cast mc JOIN movie m
	ON mc.movie_id = m.id
WHERE m.original_title = 'American Beauty'
ORDER BY mc.character;

/*	Question 4: "Βρες μου τον τίτλο των 20 πιο σύντομων αγγλικών ταινιών που είναι περιπέτειες."
	Output: 20 rows
*/
SELECT TOP (20) m.original_title AS title, g.name AS genre, m.original_language AS language, m.runtime
FROM genre g
	JOIN hasGenre hg ON hg.genre_id = g.id
	JOIN movie m ON hg.movie_id = m.id
WHERE (g.name = 'Adventure') AND (m.original_language = 'en')
ORDER BY m.runtime, m.original_title;

/*	Question 5: "Βρες μου τις λέξεις κλειδιά και την περίληψη των γαλλικών ταινιών,
				 με έσοδα περισσότερα από 5000000."
	Output: 160 rows
*/
SELECT m.original_title AS title, k.name AS movie_keyword, m.original_language AS language, m.overview
FROM Keyword k
	JOIN hasKeyword hk ON hk.keyword_id = k.id
	JOIN movie m ON hk.movie_id = m.id
WHERE m.revenue > 5000000 AND m.original_language = 'fr'
GROUP BY k.name, m.original_title, m.overview, m.original_language;

/*	Question 6: "Βρες μου τον τίτλο των ταινιών που ανήκουν στην κατηγορία οικογένεια
				 και είναι οι 30 πιο επικερδείς."
	Output: 30 rows
*/
SELECT TOP (30) g.name AS genre, m.original_title AS title, m.revenue
FROM genre g
	JOIN hasGenre hg ON hg.genre_id = g.id
	JOIN movie m ON hg.movie_id = m.id
WHERE g.name = 'Family'
ORDER BY m.revenue DESC

/*	Question 7: "Βρες μου τον μέσο όρο διάρκειας όλων των ειδών των ταινιών."
	Output: 9 rows
*/

SELECT DISTINCT(g.name) AS genre, AVG(m.runtime) AS runtime
FROM genre g
	JOIN hasGenre hg ON hg.genre_id = g.id
	JOIN movie m ON hg.movie_id = m.id
GROUP BY g.name;

/*	Question 8: "Βρες μου τον τίτλο των ταινιών που έχουν σχέση με τον χορό."
	Output: 33 rows
*/

SELECT m.original_title AS title, k.name AS keyword
FROM Keyword k
	JOIN hasKeyword hk ON hk.keyword_id = k.id
	JOIN movie m ON hk.movie_id = m.id
WHERE k.name = 'dance'; 

/*	Question 9: "Βρες μου τον τίτλο των γερμανικών ταινιών με μέση βαθμολογία μεταξύ του 4 και 6."
	Output: 12 rows
*/
SELECT m.title, AVG(r.rating) AS averageRating, m.original_language AS language
FROM ratings r JOIN movie m 
	ON r.movie_id = m.id
WHERE r.rating BETWEEN 4 AND 6 AND m.original_language = 'de'
GROUP BY m.title, m.original_language;

/*	Question 10: "Βρες μου τους τίτλους των 20 πιο δαπανηρών ταινιών και την εταιρεία παραγωγής τους."
	Output: 20 rows
*/

SELECT TOP (20) pc.name AS productionCompany, m.budget, m.original_title AS title
FROM productioncompany pc
	JOIN hasProductioncompany hpc ON hpc.pc_id = pc.id
	JOIN movie m ON hpc.movie_id = m.id
ORDER BY m.budget DESC


/*	Question 11: "Βρες μου των αριθμό των ατόμων που κάνουν τις εργασίες στην ταινία Toy Story."
	Output: 44 rows
*/

SELECT mc.job, COUNT(mc.job) AS people
FROM movie_crew mc LEFT JOIN movie m
	ON mc.movie_id = m.id
WHERE m.title = 'Toy Story'
GROUP BY mc.job
ORDER BY 2, 1; 


/*	Question 12: "Βρες μου τους ηθοποιούς και τον χαρακτήρα που παίζουν σε σειρές που το όνομα τους αρχίζει απο A."
	Output: 10213 rows
*/
SELECT mc.name, mc.character, m.title
FROM movie_cast mc RIGHT JOIN movie m
	ON mc.movie_id = m.id
WHERE m.title LIKE 'A%'
ORDER BY mc.name;