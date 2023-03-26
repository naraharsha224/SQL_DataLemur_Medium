/*
https://datalemur.com/questions/sql-highest-grossing

Assume you are given the table containing information on Amazon customers and their spending on products in various categories.

Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.
*/

-- Solution

WITH CTE1 AS (
SELECT DISTINCT category,
       product,
       SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date)=2022
GROUP BY category, product),
CTE2 AS (
SELECT category, product, total_spend,
ROW_NUMBER() OVER(PARTITION BY category ORDER BY total_spend DESC) AS rn
FROM CTE1)

SELECT category, product, total_spend
FROM CTE2
WHERE rn IN (1,2)
