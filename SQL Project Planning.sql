WITH numbered AS (
    SELECT 
        Start_Date, 
        End_Date,
        ROW_NUMBER() OVER(ORDER BY Start_Date) AS rn 
    FROM Projects
),

grouped_projects AS (
    SELECT 
        Start_Date, 
        End_Date, 
        DATEADD(DAY, -rn, Start_Date) AS grp
    FROM numbered
)

SELECT 
    MIN(Start_Date) AS Project_Start_Date, 
    MAX(End_Date) AS Project_End_Date
FROM grouped_projects 
GROUP BY grp
ORDER BY 
    DATEDIFF(day, MIN(Start_Date), MAX(End_Date)),
    MIN(Start_Date);
