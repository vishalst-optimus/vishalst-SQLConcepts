--JOINS

--INNER JOIN
--Write an SQL Query to print details of workers who are also managers
SELECT * FROM Worker AS w INNER JOIN
title AS t ON w.Worker_ID = t.Worker_ref_ID 
WHERE t.Worker_Title = 'Manager';

--LEFT JOIN
--Write an SQL Query to list worker_id's who does not get bonus
SELECT w.worker_id from worker w LEFT JOIN bonus b ON w.worker_id = b.Worker_ref_ID 
WHERE b.Worker_ref_ID IS NULL;

--RIGHT JOIN
--Write names of worker whose department is HR and who get bonus
SELECT w.First_Name from worker w RIGHT JOIN bonus b ON w.worker_id = b.Worker_ref_ID where Department = 'HR';

--CROSS JOIN
--Write an SQL Query to fetch list of workers with same salary
SELECT CONCAT(w1.First_name,' ',w1.last_name) AS Same_Salary from worker w1 CROSS JOIN worker w2 
WHERE w1.salary = w2.salary AND w1.Worker_ID != w2.Worker_ID;


--LIMIT OFFSET
--Write an SQL Query to get the data of worker having 5th highest salary
SELECT * FROM Worker ORDER BY Salary DESC OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY;



