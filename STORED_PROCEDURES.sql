--STORED PROCEDURES

CREATE TABLE p1(id int primary key, first_name VARCHAR(255), last_name VARCHAR(255), age int not null);
INSERT INTO p1 VALUES 
(1, 'Vishal', 'Singh', 21),
(2, 'Amit', 'Singh', 22),
(3, 'Ashutosh', 'Pandey', 23),
(4, 'Sumit','Jain', 22),
(5, 'Tammie', 'Jain', 23);

CREATE PROCEDURE getSameName 
	@l1_name VARCHAR(255), 
	@l2_name VARCHAR(255)
AS
SELECT * FROM p1 WHERE last_name = @l1_name OR last_name = @l2_name;
GO

EXEC getSameName @l1_name = 'Singh', @l2_name = 'Singh';


--Modify Existing Procedure
ALTER PROCEDURE getSameName
	@f_name VARCHAR(255)
AS 
Select * FROM p1 WHERE first_name = @f_name;
GO

EXEC getSameName @f_name = 'Vishal';


--DROP PROCEDURE
DROP PROCEDURE getSameName;



