create table emp(
	emp_id int,
	emp_name varchar(10),
	salary int ,
	manager_id int);

insert into emp values(1,'Ankit',10000,4);
insert into emp values(2,'Mohit',15000,5);
insert into emp values(3,'Vikas',10000,4);
insert into emp values(4,'Rohit',5000,2);
insert into emp values(5,'Mudit',12000,6);
insert into emp values(6,'Agam',12000,2);
insert into emp values(7,'Sanjay',9000,2);
insert into emp values(8,'Ashish',5000,2);

select * from emp;

/*
You are given an employee table where:
Each employee has a manager_id
manager_id refers to emp_id of the same table
👉 Write a SQL query to find employees whose salary is greater than their manager’s salary.
This is a self join scenario because:
One column (manager_id) references another column (emp_id) of the same table
*/

/* Find employees with salary more than their manager salary */

SELECT
	e.emp_name, e.salary as emp_salary,
	m.emp_name as mng_name, m.salary as mng_salary
from emp e 
inner join emp m 
on e. manager_id = m. emp_id
where e.salary > m.salary

/* give the manager's name for each employee */

select 
	e.emp_name, 
	m.emp_name as manager_name
from emp e
inner join emp m
on e.manager_id = m.emp_id
