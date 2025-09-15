WITH max_scores AS(
    SELECT h.hacker_id, h.name, s.challenge_id, MAX(s.score) AS max_score
    FROM Hackers h 
    JOIN Submissions s 
    ON h.hacker_id = s.hacker_id
    GROUP BY h.hacker_id, h.name, s.challenge_id
 ),
 
 total_scores AS(
    SELECT ms.hacker_id, ms.name, SUM(ms.max_score) AS total_score
    FROM max_scores ms
    GROUP BY ms.hacker_id, ms.name
 )

SELECT ts.hacker_id, ts.name, ts.total_score
FROM total_scores ts
WHERE ts.total_score > 0
ORDER BY ts.total_score DESC, ts.hacker_id ASC
