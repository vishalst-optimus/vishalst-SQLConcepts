--ASSIGNMENT 1

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
	Order_Total int,
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
	Prod_ID int FOREIGN KEY REFERENCES Products(Prod_ID)
);


--Insert Customer Values
INSERT INTO Customers VALUES
	(2, 'Amit Singh', '9936471902', 'amt@yahoo.com', '2021-07-23'),
	(3, 'Ashutosh Pandey', '8842836210', 'ash@hotmail.com', '2022-12-12'),
	(4, 'Arunima', '8934567809', 'arn@gmail.com', '2023-08-09'),
	(5, 'Bhagat Singh', '9835672310', 'bhg@yahoo.com', '2021-06-07'),
	(6, 'Aman Chauhan', '7836239056', 'aman@hotmail.com', '2021-01-05');

Select * from Customers;

--Insert Order values
INSERT INTO Orders (Cust_ID, Order_Total, Order_Date) VALUES
	(2, 10000, '2022-01-23'),
	(1, 7000, '2022-03-11'),
	(6, 11000, '2021-11-11'),
	(1, 30000, '2021-01-18'),
	(4, 15000, '2022- 04-11'),
	(5, 14000, '2021-11-19'),
	(1, 14000, '2022-10-04'),
	(3, 16000, '2021-11-17'),
	(5, 19000, '2022-11-12'),
	(2, 45000, '2021-05-01');


--Query-1: Retrieve the names of customers who have placed orders totaling more than ₹50,000.
SELECT c.C_Name FROM Customers AS c LEFT JOIN orders AS o ON c.c_id = o.CUST_id GROUP BY c.C_name 
HAVING SUM(o.order_total) > 50000;

--Query-2: List the orders placed in the year 2022, along with the customer's name and order total. 
SELECT c.C_Name, SUM(Order_Total) as Order_Total FROM Customers AS c LEFT JOIN orders AS o ON o.CUST_ID = c.c_ID WHERE YEAR(o.Order_date) = 2022 GROUP BY c.C_Name;

--Query-3: Calculate the average order value for each customer. 
SELECT c.C_Name, AVG(Order_Total) as Average_Order_Value FROM Customers AS c LEFT JOIN orders AS o ON o.CUST_ID = c.c_ID GROUP BY c.C_Name;

/*Query-4:
	Show the discount for orders based on total order amount: 

		a)If the order total is greater than ₹20,000, apply a 10% discount. 

		b)If the order total is between ₹10,000 and ₹20,000, apply a 5% discount. 

		c)Otherwise, no discount is applied. 
*/

SELECT Order_ID, Order_Total, 
CASE 
	WHEN Order_Total > 20000 THEN 0.1*(Order_Total)
	WHEN Order_Total BETWEEN 10000 AND 20000 THEN 0.05*(Order_Total)
	ELSE 0
END AS Discount
FROM Orders;

/* Query-5: 
	Categorize orders as follows: 

		a)Orders with a total amount greater than ₹15,000 should be labeled as 'High Value.' 

		b)Orders with a total amount between ₹10,000 and ₹15,000 should be labeled as 'Medium Value.'
		
		c)Orders with a total amount less than or equals to ₹7,000 should be labeled as 'Low Value.'	
*/

--Case 1: If we consider total orders of a particular customer and then categorize them
SELECT SUM(Order_Total) AS Total_Amount, Cust_ID,
CASE 
	WHEN SUM(Order_Total) > 15000 THEN 'High Value'
	WHEN SUM(Order_Total) BETWEEN 10000 AND 15000 THEN 'Medium Value'
	WHEN SUM(Order_Total) <= 7000 THEN 'Low Value'
	ELSE 'None'
END AS Category
FROM Orders GROUP BY Cust_ID;

--Case 2: If we categorise each order individually
SELECT Order_ID, Order_Total,
CASE 
	WHEN Order_Total > 15000 THEN 'High Value'
	WHEN Order_Total BETWEEN 10000 AND 15000 THEN 'Medium Value'
	WHEN Order_Total <= 7000 THEN 'Low Value'
	ELSE 'None'
END AS Category
FROM Orders;