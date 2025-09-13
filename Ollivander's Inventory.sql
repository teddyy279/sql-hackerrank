SELECT id, age, coins_needed, power
FROM(
    SELECT w.id, wp.age, w.coins_needed, w.power,
    ROW_NUMBER() OVER(
        PARTITION BY w.power, wp.age 
        ORDER BY w.coins_needed ASC, w.id ASC
        )AS rn
    FROM Wands w 
    JOIN Wands_Property wp
      ON w.code = wp.code
    WHERE wp.is_evil = 0
) x
WHERE rn = 1
ORDER BY power DESC, age DESC, id ASC;


--WITH MinPrice AS (
--    SELECT w.power, wp.age, MIN(w.coins_needed) AS min_coins
--    FROM Wands w
--    JOIN Wands_Property wp
--      ON w.code = wp.code
--    WHERE wp.is_evil = 0
--    GROUP BY w.power, wp.age
--)
--SELECT w.id, wp.age, w.coins_needed, w.power
--FROM Wands w
--JOIN Wands_Property wp
--  ON w.code = wp.code
--JOIN MinPrice m
--  ON w.power = m.power
-- AND wp.age = m.age
-- AND w.coins_needed = m.min_coins
--WHERE wp.is_evil = 0
--ORDER BY w.power DESC, wp.age DESC, w.id ASC;



--WITH MinPrice AS (
--    SELECT w.power, wp.age, MIN(w.coins_needed) AS min_coins
--    FROM Wands w
--    JOIN Wands_Property wp
--      ON w.code = wp.code
--    WHERE wp.is_evil = 0
--    GROUP BY w.power, wp.age
--)
--SELECT w.id, wp.age, w.coins_needed, w.power
--FROM Wands w
--JOIN Wands_Property wp
--  ON w.code = wp.code
--JOIN MinPrice m
--  ON w.power = m.power
-- AND wp.age = m.age
-- AND w.coins_needed = m.min_coins
--WHERE wp.is_evil = 0
--ORDER BY w.power DESC, wp.age DESC, w.id ASC;
