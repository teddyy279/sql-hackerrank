SELECT DISTINCT CITY 
FROM STATION
WHERE 
    LEFT(CITY, 1) NOT IN ('a', 'i', 'o', 'e', 'u')
OR
    RIGHT(CITY, 1) NOT IN ('a', 'i', 'o', 'e', 'u');
--ORDER BY ASC;
