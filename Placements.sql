SELECT s.Name
FROM Students s 
JOIN Friends f ON s.id = f.id 
JOIN Packages p1 ON s.id = p1.id
JOIN Packages p2 ON f.Friend_id = p2.id
WHERE p2.salary > p1.salary
ORDER BY p2.Salary;
