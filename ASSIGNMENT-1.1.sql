--Assignment 1.1

create database assignment;
use assignment;

--Create Customer Table
CREATE TABLE Customers(
	C_ID int primary key,
	C_Name VARCHAR(255) NOT NULL,
	Phone_Number CHAR(10),
	Email VARCHAR(255),
	C_Date DATETIME
);

--Create Orders Table
CREATE TABLE Orders(
	Order_ID int PRIMARY KEY IDENTITY(101, 1),
	Cust_ID int FOREIGN KEY REFERENCES Customers(C_ID),
	Order_Date DATETIME
);

--Create Products Table
CREATE TABLE Products(
	Prod_ID int Primary key,
	Prod_Name VARCHAR(255),
	Prod_Price int NOT NULL
);

--Create Order_Items Table
CREATE TABLE Order_Items(
	Order_ID int FOREIGN KEY REFERENCES Orders(Order_ID),
	Prod_ID int FOREIGN KEY REFERENCES Products(Prod_ID),
	Quantity int
);

--Insert Customer Values
INSERT INTO Customers VALUES
	(1, 'Vishal Singh Thapa', '8130532163', 'vst@gmail.com', '2022-01-05'),
	(2, 'Amit Singh', '9936471902', 'amt@yahoo.com', '2021-07-23'),
	(3, 'Ashutosh Pandey', '8842836210', 'ash@hotmail.com', '2022-12-12'),
	(4, 'Arunima', '8934567809', 'arn@gmail.com', '2023-08-09'),
	(5, 'Bhagat Singh', '9835672310', 'bhg@yahoo.com', '2021-06-07'),
	(6, 'Aman Chauhan', '7836239056', 'aman@hotmail.com', '2021-01-05');

--Insert Order values
INSERT INTO Orders (Cust_ID, Order_Date) VALUES
	(2, '2022-01-23'),
	(1, '2022-03-11'),
	(3, '2021-11-11'),
	(5, '2021-01-18'),
	(4, '2022- 04-11'),
	(6, '2021-11-19'),
	(1, '2022-10-04'),
	(3, '2021-11-17');


--Insert Product Values
INSERT INTO Products VALUES
	(1, 'Laptop', 4500),
	(2, 'Mouse', 50),
	(3, 'Keyboard', 80),
	(4, 'Speakers', 120),
	(5, 'Headphones', 150);

INSERT INTO Order_Items VALUES
	(102, 1, 5),
	(101, 5, 20),
	(105, 3, 11),
	(104, 2, 19),
	(102, 2, 20),
	(103, 1, 20),
	(106, 2, 25),
	(108, 4, 27),
	(107, 1, 23);

--Query-1: Retrieve the names of customers who have placed orders totaling more than ₹50,000. 
SELECT C_Name, SUM(temp.Order_Total) AS Total FROM Customers as c 
INNER JOIN Orders AS o 
ON c.C_ID = o.Cust_ID INNER JOIN 
(SELECT Order_ID, SUM(Quantity*Prod_Price) AS Order_Total FROM Order_Items as oi 
LEFT JOIN Products as p 
ON oi.prod_id = p.prod_id 
GROUP BY Order_ID) 
AS temp
ON o.Order_ID = temp.Order_ID 
GROUP BY C_Name HAVING SUM(temp.Order_Total) > 50000;


--Query-2: List the orders placed in the year 2022, along with the customer's name and order total. 
SELECT C_Name, SUM(temp.Order_Total) AS Total FROM Customers as c 
INNER JOIN Orders AS o 
ON c.C_ID = o.Cust_ID 
INNER JOIN 
(SELECT Order_ID, SUM(Quantity*Prod_Price) AS Order_Total FROM Order_Items as oi 
LEFT JOIN Products as p 
ON oi.prod_id = p.prod_id 
GROUP BY Order_ID) 
AS temp
ON o.Order_ID = temp.Order_ID WHERE YEAR(o.Order_Date) = 2022 GROUP BY C_Name;


--Query-3: Calculate the average order value for each customer. 
SELECT C_Name, AVG(temp.Order_Total) AS Total FROM Customers as c 
INNER JOIN Orders AS o 
ON c.C_ID = o.Cust_ID 
INNER JOIN 
(SELECT Order_ID, SUM(Quantity*Prod_Price) AS Order_Total FROM Order_Items as oi 
LEFT JOIN Products as p 
ON oi.prod_id = p.prod_id 
GROUP BY Order_ID) 
AS temp
ON o.Order_ID = temp.Order_ID GROUP BY C_Name;


/*Query-4
	Show the discount for orders based on total order amount: 

		a)If the order total is greater than ₹20,000, apply a 10% discount. 

		b)If the order total is between ₹10,000 and ₹20,000, apply a 5% discount. 

		c)Otherwise, no discount is applied. 
*/
SELECT Order_ID, SUM(Quantity*Prod_Price) AS Order_Total,
CASE	
	WHEN SUM(Quantity*Prod_Price) > 20000 THEN 0.1*(SUM(Quantity*Prod_Price))
	WHEN SUM(Quantity*Prod_Price) BETWEEN 10000 AND 20000 THEN 0.05*(SUM(Quantity*Prod_Price))
	ELSE 0
END AS Discount
FROM Order_Items as oi LEFT JOIN Products as p ON oi.prod_id = p.prod_id GROUP BY Order_ID;



/*Query-5: 
	Categorize orders as follows: 

		a)Orders with a total amount greater than ₹10,000 should be labeled as 'High Value.' 

		b)Orders with a total amount between ₹1,000 and ₹10,000 should be labeled as 'Medium Value.' 
		
		c)Orders with a total amount less than ₹1,000 should be labeled as 'Low Value.' 

*/

SELECT Order_ID,
CASE	
	WHEN SUM(Quantity*Prod_Price) > 10000 THEN 'High Value'
	WHEN SUM(Quantity*Prod_Price) BETWEEN 1000 AND 10000 THEN 'Medium Value'
	WHEN SUM(Quantity*Prod_Price) < 1000 THEN 'Low Value'
END AS Category
FROM Order_Items as oi LEFT JOIN Products as p ON oi.prod_id = p.prod_id GROUP BY Order_ID;
