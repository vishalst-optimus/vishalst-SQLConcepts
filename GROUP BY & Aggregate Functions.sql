--GROUP BY 
--Aggregate Functions

--1. Count()
--Write an SQL Query to fetch count of workers working in 'Admin' Department
SELECT department, COUNT(*) AS Number_Of_Workers FROM Worker WHERE department = 'Admin' GROUP BY department;
SELECT department, COUNT(*) AS Number_Of_Workers FROM Worker GROUP BY department HAVING department = 'Admin';

--2. SUM()
--Write an SQL Query to print sum of salaries of all the departments
SELECT department, SUM(Salary) AS Total_Salary FROM Worker GROUP BY department;

--3. AVG()
--Write an SQL Query to print average salary of workers of each department 
SELECT department, AVG(Salary) AS Average_Salary FROM Worker GROUP BY department;

--4. MIN() & MAX()
--Write an SQL Query to print Maximum and Minimum Salary of each department
SELECT department, MIN(Salary) AS Minimum_Salary, MAX(Salary) AS Maximum_Salary FROM Worker GROUP BY department;