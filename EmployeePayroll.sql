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