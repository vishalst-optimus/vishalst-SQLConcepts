USE practice;

create table worker(
	Worker_ID int primary key, 
	First_Name varchar(255),
	Last_Name varchar(255), 
	Salary int, 
	Joining_Date date, 
	Department varchar(100));


create table bonus(
	Worker_ref_ID int,
	Bonus_Amount int,
	Bonus_Date date,
	FOREIGN KEY (Worker_ref_ID) REFERENCES worker(Worker_ID)
	);

create table title(
	Worker_ref_ID int,
	Worker_Title varchar(255),
	Affected_From date,
	FOREIGN KEY (Worker_ref_ID) REFERENCES worker(Worker_ID)
	);