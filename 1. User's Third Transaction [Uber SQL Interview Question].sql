/*
https://datalemur.com/questions/sql-third-transaction

Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

*/

-- Solution

WITH CTE1 AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rn
FROM transactions)

SELECT user_id, spend, transaction_date
FROM CTE1
WHERE rn=3

