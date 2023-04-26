/*
https://datalemur.com/questions/supercloud-customer

A Microsoft Azure Supercloud customer is a company which buys at least 1 product from each product category.

Write a query to report the company ID which is a Supercloud customer.

*/


-- Solution 1
WITH CTE AS (
SELECT cc.customer_id,
       COUNT(DISTINCT p.product_category) AS uniqueCount
FROM customer_contracts cc 
JOIN products p ON p.product_id = cc.product_id
GROUP BY cc.customer_id)

SELECT customer_id
FROM CTE 
WHERE uniqueCount = (SELECT COUNT(DISTINCT product_category) FROM products)
ORDER BY customer_id

-- Solution 2
SELECT customer_id
FROM customer_contracts cc 
JOIN products p ON p.product_id=cc.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category)
                                           FROM products)
ORDER BY CUSTOMER_ID


