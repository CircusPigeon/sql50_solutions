/*
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

WITH sequenceGroups AS (
    SELECT
        num,
        id,
        id - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id ASC) AS groupId
    FROM Logs
)
SELECT DISTINCT num AS consecutiveNums
FROM sequenceGroups
GROUP BY num, groupId
HAVING COUNT(*) >= 3;