WITH challenge_counts AS (
    SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS total
    FROM Hackers h
    JOIN challenges c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
), 

duplicates AS (
    SELECT total
    FROM challenge_counts
    GROUP BY total
    HAVING COUNT(*) > 1
) 

SELECT cc.hacker_id, cc.name, cc.total
FROM challenge_counts cc
WHERE
    cc.total = (SELECT MAX(total) FROM challenge_counts)
    OR cc.total NOT IN (SELECT total FROM duplicates)
ORDER BY cc.total DESC, cc.hacker_id;

/*WITH challenge_counts AS (
    SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS total
    FROM Hackers h
    JOIN challenges c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
), 

max_count AS(
    SELECT MAX(total) AS max_total
    FROM challenge_counts
),

duplicates AS (
    SELECT total
    FROM challenge_counts
    GROUP BY total
    HAVING COUNT(*) > 1
)

SELECT cc.hacker_id, cc.name, cc.total
FROM challenge_counts cc
JOIN max_count mc 
  ON 1 = 1 
WHERE
    cc.total = mc.max_total
    OR cc.total NOT IN (SELECT total FROM duplicates)
ORDER BY cc.total DESC, cc.hacker_id;*/
