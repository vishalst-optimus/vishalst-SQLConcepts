--SQL SERVER FUNCTIONS

CREATE TABLE Dummy(id int primary key, Name VARCHAR(255), age int not null, Adm_Date DATE);
INSERT INTO Dummy VALUES
(1, 'Vishal', 23, '2022-08-05'),
(2, 'Arunima', 22, '2021-06-01'),
(3, 'Amit', 21, '2023-04-01'),
(4, 'Pranab', 22, '2021-04-06'),
(5, 'Dhananjay', 23, '2022-07-02'),
(6, 'Jayant', 25, '2023-01-01');

--1. STRING FUNCTIONS
--a. ASCII: Returns the ASCII Code of first character in Name 
SELECT ASCII(Name) FROM Dummy;

--b. CHAR
SELECT CHAR(91) AS NewCharacter;

--c. CHARINDEX: Gives position of a character in each Name 
SELECT CHARINDEX('a', Name) AS Position FROM Dummy;

--d. CONCAT
SELECT CONCAT(Name, ' ','Student') As New_Name FROM DUMMY;

--e. Concat with + 
SELECT Name + ' ' + 'Student' FROM DUMMY;

--f. CONCAT_WS
SELECT CONCAT_WS('@', Name, 'Student') FROM DUMMY;

--g. DATALENGTH
SELECT DATALENGTH(Name) AS Length FROM Dummy;

--h. LEN(): It does not count trailing whitespaces, but DATALENGTH does
SELECT len('  VISHAL  ');

--i. DIFFERENCE
SELECT d1.Name, d2.Name, DIFFERENCE(d1.Name, d2.Name) FROM Dummy AS d1 CROSS JOIN Dummy AS d2;

--j. FORMAT
DECLARE @d DATETIME = '12/01/2011'
SELECT FORMAT(@d, 'd', 'en-US'),
FORMAT(@d, 'd', 'no'),
FORMAT(@d, 'd', 'zu');

--k. LEFT
SELECT LEFT(Name, 4) AS First_Four FROM Dummy;

--l. LOWER
SELECT LOWER(Name) AS LowerCaseName FROM Dummy;

--m. UPPER 
SELECT UPPER(Name) AS UpperCaseName FROM Dummy;

--n.LTRIM: Removes Leading whitespaces
SELECT LTRIM('   VISHAL  ');

--o. RTRIM: Removes Trailing Whitespaces
SELECT RTRIM('   VISHAL   ');

--p. NCHAR: Returns the UNICODE characteer based on number code
SELECT NCHAR(2334) AS U_CODE;

--q. PATINDEX: Returns the index of pattern in string
SELECT PATINDEX('%v%', Name) FROM Dummy;

--r. QUOTESTRING
SELECT QUOTENAME(Name, '""') FROM Dummy;

--s. REPLACE
SELECT REPLACE(Name, 'sh','xy') FROM Dummy;

--t. REPLICATE
SELECT REPLICATE(Name, 2) FROM Dummy;

--u. REVERSE
SELECT REVERSE(Name) FROM Dummy;

--v. RIGHT
SELECT RIGHT(Name, 3) FROM Dummy;

--w. STR
SELECT STR(id) FROM Dummy;

--x. SUBSTRING
SELECT SUBSTRING(Name, 2,5) FROM Dummy;

--y. TRIM
SELECT DATALENGTH(TRIM('   Vishal  '));

--z. UNICODE
SELECT UNICODE(Name) FROM Dummy;



--2. MATH/NUMERIC Functions
--a.CEILING
SELECT CEILING(99.01);

--b. POWER
SELECT POWER(id, 3) FROM Dummy;

--c. EXP
SELECT EXP(id) FROM Dummy;

--d. SIGN
SELECT SIGN(age) FROM Dummy;

--e. SUM
SELECT SUM(age) FROM Dummy;

--f. SQUARE
SELECT SQUARE(id) FROM Dummy;


--3. SERVER DATE Functions
--a. CURRENT_TIMESTAMP
SELECT CURRENT_TIMESTAMP;

--b. DATEADD
SELECT DATEADD(year, 2, Adm_Date) FROM Dummy;

--c. DATEDIFF
SELECT DATEDIFF(year, d1.Adm_date, d2.Adm_date) AS Year_Diff FROM Dummy d1 CROSS JOIN
Dummy d2;

--d. DATEFROMPARTS
SELECT DATEFROMPARTS(2021, 09, 01);

--e. DATENAME
SELECT DATENAME(Day, Adm_Date) FROM Dummy;

--f. DATEPART
SELECT DATEPART(Month, Adm_Date) FROM Dummy;

--g. GETDATE
SELECT GETDATE();

--h. GETUTCDATE
SELECT GETUTCDATE();

--i. ISDATE
SELECT ISDATE('2022-11-02');
SELECT ISDATE('2022-34-65');

--j. SYSDATETIME
SELECT SYSDATETIME();


--3. ADVANCE FUNCTIONS

--a. CAST
--Converted Name datatype from varchar to char
SELECT CAST(Name AS char) FROM Dummy;

--b. COLAESCE
INSERT INTO Dummy Values (8, NULL, 32, '2023-05-07');

SELECT COALESCE(NULL, NULL, NULL, 'Vishal', 'Amit', NULL, 'Ashutosh');

--c. CONVERT
SELECT CONVERT(DATE, CONVERT(VARCHAR(8), 20220906), 112);

--d. CURRENT_USER
SELECT CURRENT_USER;

--e. IIF
SELECT IIF(LEN(Name)>6, 'Long Name', 'Small Name') FROM Dummy;

--f. ISNULL
SELECT ISNULL(Name, 'Null Name Not Allowed') FROM Dummy;

--g. ISNUMERIC
SELECT ISNUMERIC(Age) FROM Dummy;

--h. NULLIF
INSERT INTO Dummy Values (21, 'Ashwin', 21, '2011-01-02');
SELECT NULLIF(id, age) FROM Dummy;

--i. SESSION_USER
SELECT SESSION_USER;

--j. USER_NAME
SELECT USER_NAME();