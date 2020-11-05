--  UC1: creare a payroll database 
create database payroll_service;

Use payroll_service;

--  UC2: creare a table 

create Table employee_payroll
(
id int  NOT NULL identity(1,1) primary key,
name varchar(20)  NOT NULL,
salary decimal(10,2) NOT NULL,
start  Date Not null,
);



sp_help employee_payroll; --  shows the schema of table

--  UC3: Add employee details 

Insert into employee_payroll
(name,salary,start)
values('sai', 1000000.00, '2020-08-18')

Insert into employee_payroll
values('Bill', 500000.00, '2018-05-20')

Insert into employee_payroll
values('Charlie', 700000.00, '2018-02-10')


-- UC4: view contents in a table 
select * from employee_payroll;

/*Ability to retrieve salary data for a particular
employee as well as all employees who have
joined in a particular data range from the
payroll service database */

--  UC 5.1  get salary of an employee 
select salary from employee_payroll
where name = 'Sai'

--  UC 5.2  get salary between dates 
select salary from employee_payroll
WHERE start BETWEEN CAST('2018-01-01'
AS DATE) AND GETDATE();

--  UC 6.1 Alter table to add a new column gender
Alter table employee_payroll
add Gender varchar(1) not null default 'M';

--  UC 6.2 set the values for gender
Update employee_payroll
set  Gender='M' 
where name = 'Bill' or name = 'Charlie';

-- UC 7.1 get sum of salaries
SELECT SUM(salary) FROM employee_payroll
WHERE gender = 'M' 
Group By gender;

-- UC 7.2 get avarage of salaries
SELECT AVG(salary) FROM employee_payroll
WHERE gender = 'M' 
Group By gender;

-- UC 7.3 get Min of salaries
SELECT MIN(salary) FROM employee_payroll
WHERE gender = 'M' 
Group By gender;

-- UC 7.4 get Max of salaries
SELECT Max(salary) FROM employee_payroll
WHERE gender = 'M' 
Group By gender;


-- UC 8.1 Add phone number to table
Alter table employee_payroll
add phoneNumber varchar(13);

-- UC 8.2 Add adress to table
Alter table employee_payroll
add address varchar(100) not null default 'Mumbai';

-- UC 8.3 Add department to table
Alter table employee_payroll
add  department varchar(20) NOT NULL default 'IT' ;

-- UC 9.1 Rename the salary column to basic pay
EXEC sp_RENAME 'Employee_payroll.salary', 'basic_pay', 'COLUMN';

-- UC 9.2 Add deductions with default valeues 0

Alter table employee_payroll
add deductions decimal(10,2) not null default 0.0;

-- UC 9.3 Add income tax with default valeues 0
Alter table employee_payroll
add income_tax decimal(10,2) not null default 0.0;

-- UC 9.4 Add net with default valeues 0
Alter table employee_payroll
add net_salary decimal(10,2) not null default 0.0;



sp_help employee_payroll;

-- UC 10 insert details

insert employee_payroll
values('Anitha', '2019-02-14', 'F', '9087654321' , 'Chennai', 'Sales', 4000000.00, 2000.00, 0.00, 3880000); 

--UC 11 create an employee department and department table


--creating Department table to store the dept id and dept name;
create table DEPARTMENT
(
DeptId int primary key,
DeptName varchar(100)
);


select * from DEPARTMENT;
insert into DEPARTMENT VALUES(10,'IT');
INSERT INTO DEPARTMENT VALUES(11,'HR');
INSERT INTO DEPARTMENT VALUES(12,'Sales');


--creating employee department table to store employee id,dept id
create table Employee_department 
(
id int,
DeptId int ,
Primary key(id,DeptId)
);

insert into Employee_department values(1,10);
insert into Employee_department values(2,10);
insert into Employee_department values(3,11);
insert into Employee_department values(4,12);


select * from Employee_department;

--sp_help Employee_payroll

select * from Employee_payroll;

delete from Employee_payroll where id=6;
alter table Employee_payroll drop column department;

select EP.name,EP.department from 
Employee_payroll EP inner join Employee_department ED on EP.id=ED.id 
 inner join DEPARTMENT D on D.DeptId=ED.DeptId ;

select * from employee_payroll;

--UC12 Ensure all the operations working fine

select EP.name,EP.start,EP.gender,
EP.address,EP.department from 
Employee_payroll EP inner join Employee_department ED on EP.id=ED.id 
 inner join DEPARTMENT D on ED.DeptId=D.DeptId where D.DeptName='IT';


select EP.name,EP.start,EP.gender,
EP.address,EP.department from 
Employee_payroll EP inner join Employee_department ED on EP.id=ED.id 
 inner join DEPARTMENT D on ED.DeptId=D.DeptId where D.DeptName='HR';


--creating payments table to store the details about payments

 create table Payments (
 id int primary key,
 basicPay DECIMAL(10,2) NOT NULL,
 deductions decimal(10,2) not null default 0.0,
 taxable_pay decimal(10,2) not null default 0.0,
 tax decimal(10,2) not null default 0.0, 
 net_pay decimal(10,2) not null default 0.0);

insert into Payments
values (1,400000.00, 2000.00, 0.00,0.00, 398000)

insert into Payments
values (2,300000.00, 1000.00, 0.00,0.00, 399000)

insert into Payments
values (3,500000.00, 3000.00, 0.00,0.00, 499700)

insert into Payments
values (4,100000.00, 00.00, 0.00,0.00, 100000)

alter table Employee_payroll drop column basic_pay,address,deductions,income_tax,net_salary;

select EP.gender,sum(P.net_pay)SumOfSalaries 
from Employee_payroll EP inner join payments P on EP.id=P.id group by EP.gender ;

select a.gender,avg(b.net_pay)AvgOfSalaries
from Employee_payroll a inner join payments b on a.id=b.id group by a.gender;

select a.gender,max(b.net_pay)MaxOfSalaries 
from Employee_payroll a inner join payments b on a.id=b.id group by a.gender;

select a.gender,min(b.net_pay)MinOfSalaries 
from Employee_payroll a inner join payments b on a.id=b.id group by a.gender;
