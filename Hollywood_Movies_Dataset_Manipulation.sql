-- Looking for the top 5 highest grossing movies

SELECT DISTINCT "[Year]",
SUM("[World Wide Sales (in $)]") total_revenue
FROM movies m 
GROUP BY "[Year]" 
ORDER BY total_revenue DESC 
LIMIT 5

-- Looking for the top 5 years by income/film

SELECT AVG("[World Wide Sales (in $)]") income_per_film,
"[Year]"
FROM movies m 
GROUP BY "[Year]" 
ORDER BY income_per_film DESC
LIMIT 5

-- More profitable to create comedies or dramas


SELECT AVG("[World Wide Sales (in $)]") as av_sales,
CASE 
	WHEN Genre LIKE '%Drama%' THEN 'Drama'
	WHEN Genre LIKE '%Comedy%' THEN 'Comedy' 
END AS drama_comedy,
SUM("[World Wide Sales (in $)]") as total_rev
FROM movies m 
GROUP BY drama_comedy

-- Looking for the first film from every distibutor

WITH RankedMovies AS (
    SELECT 
        Title,
        "[Year]",
        Distributor,
        ROW_NUMBER() OVER (PARTITION BY Distributor ORDER BY "[Year]") AS number
    FROM 
        movies m 
)
SELECT 
    Title,
    "[Year]",
    Distributor
FROM 
    RankedMovies
WHERE 
    number = 1
ORDER BY 
    "[Year]"

-- looking for what is more profitable to create - films with duration more then 2 hours or more then 3 hours 

SELECT 
    CASE 
        WHEN "[Running Time]" LIKE '%2 hr%' THEN '2 hours'
        WHEN "[Running Time]" LIKE '%3 hr%' THEN '3 hours'
    END AS time_category,
    AVG("[World Wide Sales (in $)]") AS avg_sales
FROM 
    movies m 
GROUP BY 
    time_category
    
-- movies are released more often and bring more profit in July or December   
    
 SELECT 
 CASE 
 	when "[Release Date]" like '%Jul%' then 'July'
 	when "[Release Date]" like '%Dec%' then 'December'
 END as months,
 COUNT(Title) as amount,
 AVG("[World Wide Sales (in $)]") as avg_sales
  FROM movies m 
GROUP BY
months









