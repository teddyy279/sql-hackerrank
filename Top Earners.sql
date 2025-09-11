--METHOD1

--SELECT salary * months AS total_earning, COUNT (*) AS num_employees
--FROM Employee 
--GROUP BY salary * months
--HAVING salary * months = (SELECT MAX(salary * months) FROM Employee);

--METHOD2

--SELECT TOP 1
--    salary * months AS total_earnings,
--    COUNT (*) AS num_employees
--FROM Employee 
--GROUP BY salary * months
--ORDER BY total_earnings DESC
