WITH Indexed AS(
    SELECT LAT_N,
        ROW_NUMBER() OVER (ORDER BY LAT_N) AS rn,
        COUNT(*) OVER() AS cnt
    FROM STATION
)

SELECT(CAST(ROUND(AVG(LAT_N), 4) AS DECIMAL(18, 4)))
FROM Indexed
WHERE rn in ((cnt + 1) / 2, (cnt + 2) / 2)
