SELECT
    CASE 
        WHEN g.Grade < 8 THEN 'NULL'
        ELSE s.Name
    END AS NAME,
    g.Grade,
    s.Marks
FROM Students s 
JOIN Grades g 
ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY 
    g.Grade DESC,
    CASE WHEN g.Grade >= 8 THEN s.name END ASC,
    CASE WHEN g.Grade < 8 THEN s.Marks END ASC;
