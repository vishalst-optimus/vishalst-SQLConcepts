-- Write an SQL Query to print details of workers whose salary lies between 100000 and 500000
/*
Commands used: SELECT, WHERE, BETWEEN, AND
*/
SELECT * FROM Worker WHERE Salary BETWEEN 100000 AND 500000;


--Write an SQL Query to print names of workers whose first name contains 'a'
/*
Commands Used: Pattern Searching/Wildcard
*/
SELECT * FROM Worker WHERE First_name like '%a%';


--Write an SQL Query to sort the workers in descending order of their respective salaries
/*
Commands used: ORDER BY
*/
SELECT * FROM Worker ORDER BY Salary DESC;


--Write an SQL Query to print details of worker excluding those having first_name as 'Vipul' and 'Satish'
/*
Commands used: NOT IN
*/
SELECT * FROM Worker WHERE First_name NOT IN ('Vipul', 'Satish');




