WITH numbered AS(
    SELECT X, Y,
    ROW_NUMBER() OVER(ORDER BY X, Y) AS rn 
    FROM Functions
)

SELECT n1.X, n1.Y
FROM numbered n1
JOIN numbered n2
ON n1.X = n2.Y
   AND n1.Y = n2.X
   AND n1.rn < n2.rn
WHERE n1.X <= n2.Y
ORDER BY n1.X
