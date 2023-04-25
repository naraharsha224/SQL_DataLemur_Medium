/*
https://datalemur.com/questions/mean-median-mode

You're given a list of numbers representing the number of emails in the inbox of Microsoft Outlook users. Before the Product Management team can start developing features related to bulk-deleting email or achieving inbox zero, they simply want to find the mean, median, and mode for the emails.

Display the output of mean, median and mode (in this order), with the mean rounded to the nearest integer. It should be assumed that there are no ties for the mode.
*/

-- Solution 
SELECT ROUND(SUM(email_count)/COUNT(user_id)) AS mean,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY email_count) AS median,
       MODE() WITHIN GROUP (ORDER BY email_count) AS mode
FROM inbox_stats


-- Explanation

-- The ROUND function is used to round the result of the division between SUM(email_count) and COUNT(user_id) to the nearest integer. This calculation gives us the mean of the email_count column.

-- The PERCENTILE_CONT function is used to find the median of the email_count column. The 0.5 argument passed to this function specifies that we want to find the value at the 50th percentile, which is the median. The WITHIN GROUP clause is used to order the email_count values before calculating the median.

-- The MODE function is used to find the mode of the email_count column. The WITHIN GROUP clause is used to order the email_count values before calculating the mode.
