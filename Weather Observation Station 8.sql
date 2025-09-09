--C1
--SELECT CITY
--FROM STATION
--WHERE
--    LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u')
--AND
--    RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u')


SELECT CITY
FROM STATION
WHERE
    (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%')
AND
    (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u')
