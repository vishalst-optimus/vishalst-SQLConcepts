create table emp(emp_id int primary key, name varchar(200), man_id  int foreign key references emp(emp_id));

insert into emp values
	(1, 'Vishal', 3),
	(2, 'Amit', 1),
	(3, 'Ashutosh', 4),
	(4, 'Tammie', 1),
	(5, 'Zeno', 2);

select e1.name as employee, e2.name as manager 
from emp as e1 
LEFT JOIN
emp as e2 ON e1.man_id = e2.emp_id;