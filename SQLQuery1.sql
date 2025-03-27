Create database asses
use asses

CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50) NOT NULL
);

INSERT INTO LOCATION (Location_ID, City) VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

CREATE TABLE DEPARTMENT (
    Department_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Location_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
);
INSERT INTO DEPARTMENT (Department_ID, Name, Location_ID) VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);
SELECT * from DEPARTMENT;

Create table JOB(
Job_ID INT PRIMARY KEY,
Designation Varchar(50)
);

INSERT INTO JOB (Job_ID,Designation) VALUES
(667,'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670 ,'Sales Person'),
(671,'Manager'),
(672,' President');

SELECT * from JOB;

Create table EMPLOYEE(
Employee_ID INT,
Last_name Varchar(50),
First_Name Varchar(50),
Middle_Name Varchar(50),
Job_ID Int Foreign Key (Job_ID) References JOB(Job_ID),
Hire_Date Date,
Salary INT,
Commission INT,
Department_ID INT Foreign Key (Department_ID) References DEPARTMENT(Department_ID)
);

INSERT INTO EMPLOYEE(Employee_ID,Last_name,First_Name,Middle_Name,Job_ID,Hire_Date,Salary,Commission,Department_ID) VALUES
(7369,'Smith',' John', 'Q ',667, '17-Dec-84', 800 ,Null ,20),
(7499,' Allen', 'Kevin ','J', 670, '20-Feb-85', 1600, 300, 30),
(755, 'Doyle', 'Jean', 'K ',671, '04-Apr-85', 2850 ,Null, 30),
(756, 'Dennis', 'Lynn',' S', 671 ,'15-May-85',2750, Null, 30),
(757,'Baker',' Leslie', 'D ',671,'10-Jun-85', 2200, Null, 40),
(7521,'Wark','Cynthia','D ',670, '22-Feb-85', 1250, 50,30);
SELECT * from EMPLOYEE;

--1. List all the employee details.
SELECT * from EMPLOYEE;

--2. List all the department details.
SELECT * from DEPARTMENT;

--3. List all job details.
SELECT * from JOB;

--4. List all the locations.
SELECT * from LOCATION;

--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT First_name, Last_name, Salary,commission from EMPLOYEE;