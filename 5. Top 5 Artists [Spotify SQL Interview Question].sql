/*

https://datalemur.com/questions/top-fans-rank

Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".

Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.

For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

Assumptions:

If two artists' songs have the same number of appearances, the artists should have the same rank.
The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).

*/

-- Solution

WITH sCount AS (
SELECT s.artist_id,
       COUNT(s.song_id) AS songCount
FROM songs s
JOIN global_song_rank gsr ON gsr.song_id=s.song_id
WHERE gsr.rank <= 10
GROUP BY s.artist_id),
artist_rank AS (
SELECT artist_id,
       DENSE_RANK() OVER(ORDER BY songCount DESC) AS artistRank
FROM sCount)

SELECT a.artist_name,
       ar.artistRank
FROM artist_rank ar 
JOIN artists a ON a.artist_id=ar.artist_id
WHERE ar.artistRank <= 5
ORDER BY ar.artistRank, a.artist_name
