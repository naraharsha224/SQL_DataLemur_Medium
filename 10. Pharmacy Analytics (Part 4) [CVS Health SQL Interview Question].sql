/*
https://datalemur.com/questions/top-drugs-sold

CVS Health is trying to better understand its pharmacy sales, and how well different drugs are selling.

Write a query to find the top 2 drugs sold, in terms of units sold, for each manufacturer. List your results in alphabetical order by manufacturer.

*/

-- Solution

WITH CTE1 AS(
SELECT manufacturer, drug, units_sold,
       RANK() OVER(PARTITION BY manufacturer ORDER BY units_sold DESC) AS rn
FROM pharmacy_sales)

SELECT manufacturer, drug AS top_drugs
FROM CTE1
WHERE rn IN (1,2)
