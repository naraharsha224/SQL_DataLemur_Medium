/*
https://datalemur.com/questions/frequently-purchased-pairs

Given the Walmart transaction and product tables, write a query to determine the count of unique product combinations that are purchased together in the same transaction, considering that there must be a minimum of two products in the transaction. Display the output in ascending order of the product combinations.

For instance, if there are two transactions where apples and bananas are bought together, and another transaction where bananas and soy milk are bought together, the total count of unique combinations would be 2.

Psst, you may or may not need to use the products table.

*/

-- Solution 1
WITH CTE AS (
SELECT transaction_id,
       ARRAY_AGG(CAST(product_id AS TEXT) ORDER BY product_id) AS combination
FROM transactions
GROUP BY transaction_id)

SELECT DISTINCT combination
FROM CTE 
WHERE ARRAY_LENGTH(combination,1)>1
ORDER BY combination

-- Solution 2

WITH CTE AS (
    SELECT transaction_id,
           ARRAY_AGG(CAST(product_id AS TEXT) ORDER BY product_id) AS combination
    FROM transactions
    GROUP BY transaction_id
)
SELECT DISTINCT combination
FROM CTE
WHERE cardinality(combination) > 1
ORDER BY combination;
