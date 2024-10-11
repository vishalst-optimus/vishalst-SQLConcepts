CREATE DATABASE Assignment;
USE Assignment;

--QUESTION 1
CREATE TABLE t_product_master(
	Product_ID VARCHAR(10) PRIMARY KEY,
	Product_Name VARCHAR(255),
	Cost_Per_Item INT		--In rupees
	);

INSERT INTO t_product_master VALUES
	('P1','Pen',10),
	('P2','Scale',15),
	('P3','Note Book',25);

CREATE TABLE t_user_master(
	User_ID VARCHAR(10) PRIMARY KEY,
	User_Name VARCHAR(255)
	);

INSERT INTO t_user_master VALUES
	('U1','Alfred Lawrence'),
	('U2','William Paul'),
	('U3','Edward Fillip');

CREATE TABLE t_transaction(
	User_ID VARCHAR(10) FOREIGN KEY REFERENCES t_user_master(User_ID),
	Product_ID VARCHAR(10) FOREIGN KEY REFERENCES t_product_master(Product_ID),
	Transaction_Date DATE,
	Transaction_Type VARCHAR(255),    --Orders are in quantity and payments are in rupees
	Transaction_Amount INT
	);

INSERT INTO t_transaction VALUES
	('U1','P1','2010-10-25','Order',150),
	('U1','P1','2010-11-20','Payment',750),
	('U1','P1','2010-11-20','Order',200),
	('U1','P3','2010-11-25','Order',50),
	('U3','P2','2010-11-26','Order',100),
	('U2','P1','2010-12-15','Order',75),
	('U3','P2','2011-01-15','Payment',250);

SELECT * FROM t_product_master;
SELECT * FROM t_transaction;
SELECT * FROM t_user_master;


--Query-1
SELECT temp4.USer_Name, p.Product_Name, temp4.Ordered_Quantity, 
IIF(Amount_Paid IS NULL, 0, Amount_Paid) AS Amount_Paid,
temp4.Last_Transaction_Date,
IIF(Amount_Paid IS NULL, (temp4.Ordered_Quantity*p.Cost_Per_Item), (temp4.Ordered_Quantity*p.Cost_Per_Item)-temp4.Amount_Paid) AS Balance
FROM t_product_master AS p 
INNER JOIN
(SELECT User_name, temp3.* FROM t_user_master AS u
INNER JOIN
(SELECT temp1.product_id, temp1.user_id, temp1.Ordered_Quantity, temp2.Amount_Paid,
IIF(temp1.Last_Transaction_Date > temp2.Last_Transaction_Date OR temp2.Last_Transaction_Date is null, temp1.Last_Transaction_Date, temp2.Last_Transaction_Date) AS Last_Transaction_Date
FROM
(SELECT product_id, user_id, sum(transaction_amount) as Ordered_quantity, MAX(transaction_date) as Last_Transaction_Date
from t_transaction
where transaction_type = 'order'  
group by product_id, user_id) as temp1
LEFT JOIN
(SELECT product_id, user_id, sum(transaction_amount) as Amount_Paid, MAX(transaction_date) as Last_Transaction_Date
from t_transaction
where transaction_type = 'payment'
group by product_id, user_id) as temp2 
ON temp1.product_id = temp2.product_id AND temp1.User_ID = temp2.User_ID) as temp3
ON u.User_ID = temp3.User_ID) as temp4
ON p.Product_ID = temp4.Product_ID
ORDER BY USER_ID;




--Query-2
CREATE TABLE Employee(
	Employee_ID INT Primary Key,
	Name VARCHAR(255),
	Department VARCHAR(255),
	Hire_Date DATE
	);

CREATE TABLE Departments(
	Department_ID INT PRIMARY KEY,
	Department_Name VARCHAR(255)
	);

CREATE TABLE Sales(
	Sale_ID INT PRIMARY KEY,
	Employee_ID INT FOREIGN KEY REFERENCES Employee(Employee_ID),
	Sale_Date DATE,
	Amount FLOAT
	);

CREATE TABLE Performance_Reviews(
	Review_ID INT PRIMARY KEY,
	Employee_ID INT FOREIGN KEY REFERENCES Employee(Employee_ID),
	Review_Date DATE,
	Score INT
	);

INSERT INTO Employee VALUES
	(101, 'Vishal Singh Thapa', 'Technical', '2025-05-01'),
	(102, 'Dipesh Mehta', 'HR', '2024-01-04'),
	(103, 'Amit Singh', 'IT', '2023-01-11'),
	(104, 'Arunima', 'Sales', '2023-08-01'), 
	(105, 'Bhagat Singh', 'Technical', '2021-05-10'),
	(106, 'Ashmeeta', 'HR', '2022-07-04');

INSERT INTO Departments VALUES
	(1011, 'Technial'),
	(1012, 'IT'),
	(1013, 'Sales'),
	(1014, 'HR');

Insert INTO Sales VALUES
	(1, 105, '2024-06-09', 25000.87),
	(2, 102, '2024-01-01', 46000.76),
	(3, 106, '2024-03-03', 50000.54),
	(4, 101, '2024-01-09', 230000),
	(5, 105, '2024-12-12', 67000),
	(6, 104, '2024-09-11', 87000.23);

INSERT INTO Performance_Reviews VALUES
	(1, 101, '2024-12-12', 8),
	(2, 102, '2024-12-01', 9),
	(3, 103, '2024-12-03', 9),
	(4, 104, '2024-12-05', 8),
	(5, 106, '2024-12-07', 7);

Select * from Employee;
Select * from Departments;
Select * from Sales;
Select * from Performance_Reviews;

--Query-1: 

WITH Details AS 
(SELECT Sum(Amount) as Sales_total, Employee_ID
from sales group by employee_id)
SELECT Name, Sales_Total, RANK() OVER
(Order by Sales_Total desc)
AS RANKS
FROM Employee INNER JOIN Details 
ON Details.Employee_ID = Employee.Employee_ID;

 
--Query-2: 
WITH Employee_Details As
(SELECT e.Employee_ID, e.Department, AVG(score) AS Avg_Performance_Review_Score
FROM Performance_Reviews as p INNER JOIN
Employee as e ON e.Employee_ID = p.Employee_ID GROUP BY
e.Employee_ID, e.Department)
SELECT Employee_ID, DENSE_RANK() 
OVER (Partition by Department ORDER BY Avg_Performance_Review_Score DESC)
AS DenseRank FROM Employee_Details;


--Query-3:
WITH Top_Employees AS 
(SELECT e.Employee_ID, e.Department, Sum(Amount) as total FROM Sales 
INNER JOIN 
Employee AS e ON e.Employee_ID = Sales.Employee_ID GROUP BY e.Employee_ID, e.Department)
SELECT Employee_ID, Total, Department,ROW_NUMBER() OVER (PARTITION BY Department 
ORDER BY total DESC) AS Row_Num FROM Top_Employees;


--Query-4:
WITH temp AS
(SELECT e.Name, SUM(Amount) AS Total_Sales_Amount, e.Department AS Department,
ROW_NUMBER() OVER(PARTITION BY e.Department ORDER BY SUM(Amount) DESC)
AS Ranking FROM Sales AS s INNER JOIN Employee AS e
ON s.Employee_ID = e.Employee_ID GROUP BY e.Department, e.Name)
SELECT temp.Name, Total_Sales_Amount, Department FROM temp 
WHERE Ranking = 1;

