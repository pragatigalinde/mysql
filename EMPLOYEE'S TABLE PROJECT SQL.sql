create database empinfo;
use  empinfo;

CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar(50),
Gender Char, 
Salary int,
City Char(20) );

INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura');

CREATE TABLE EmployeeDetail (
EmpID int NOT NULL,
Project Varchar(50),
EmpPosition Char(20),
DOJ date );

INSERT INTO EmployeeDetail
VALUES (1, 'P1', 'Executive', '2013-11-12'),
(2, 'P2', 'Executive', '2020-12-12'),
(3, 'P1', 'Lead', '2021-09-08'),
(4, 'P3', 'Manager', '2019-04-03'),
(5, 'P2', 'Manager', '2018-01-03');


#Q1(a): Find the list of employees whose salary ranges between 2L to 3L.
SELECT EmpName, Salary FROM Employee
WHERE Salary BETWEEN 200000 AND 300000;
select * from employee;

#Q1(b): Write a query to retrieve the list of employees from the same city.
SELECT * 
from employee e1 ,employee e2 
where e1.city = e2.city and e1.empid != e2.empid;

#Q1(c): Query to find the null values in the Employee table.
SELECT * FROM Employee
WHERE empID IS NULL;

------------#####------------------

#Q2(a): Query to find the cumulative sum of employee’s salary.altery.
SELECT EmpID, Salary, SUM(Salary) OVER (ORDER BY EmpID) AS CumulativeSum
FROM Employee;

#Q2(B): What’s the male and female employees ratio
SELECT 
    gender,
    COUNT(*) AS gender_count,
    COUNT(*) / (SELECT COUNT(*) FROM employee) AS gender_ratio
FROM employee
GROUP BY gender;

#Q2(c): Write a query to fetch 50% records from the Employee table.
SELECT * FROM Employee 
WHERE EmpID <= (SELECT COUNT(EmpID)/2 from Employee);

------------#####------------------

#Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’ i.e 12345 will be 123XX
SELECT CONCAT(LEFT(salary, LENGTH(salary) - 2), 'XX') AS masked_salary
FROM employee;

------------#####--------------

#Q4: Write a query to fetch even and odd rows from Employee table.
--#-Fetch even rows---
SELECT * FROM Employee 
WHERE MOD(EmpID,2)=0;

--#-Fetch odd rows----
SELECT * FROM Employee 
WHERE MOD(EmpID,2)=1;

------------#####--------------

#Q5(a): Write a query to find all the Employee names whose name:
#• Begin with ‘A’
#• Contains ‘A’ alphabet at second place
#• Contains ‘Y’ alphabet at second last place
#• Ends with ‘L’ and contains 4 alphabets 
#• Begins with ‘V’ and ends with 'A'

SELECT * FROM Employee WHERE EmpName LIKE 'A%';
SELECT * FROM Employee WHERE EmpName LIKE '_a%';
SELECT * FROM Employee WHERE EmpName LIKE '%y_';
SELECT * FROM Employee WHERE EmpName LIKE '____i';
SELECT * FROM Employee WHERE EmpName LIKE 'V%a';

#Q5(b): Write a query to find the list of Employee names which is:
#• starting with vowels (a, e, i, o, or u), without duplicates
#• ending with vowels (a, e, i, o, or u), without duplicates
#• starting & ending with vowels (a, e, i, o, or u), without duplicates

SELECT DISTINCT EmpName
FROM Employee
WHERE LOWER(EmpName) REGEXP '^[aeiou]';

SELECT DISTINCT EmpName
FROM Employee
WHERE LOWER(EmpName) REGEXP '[aeiou]$';

SELECT DISTINCT EmpName
FROM Employee
WHERE LOWER(EmpName) REGEXP 
'^[aeiou].*[aeiou]$';

------------#####--------------

#Q6: Find Nth highest salary from employee table with and without using the TOP/LIMIT keywords.

select * from employee 
order by salary desc;

select e1.salary from employee e1 
where 2 = (
 SELECT COUNT(DISTINCT Salary)
from employee e2 
where e2.salary > e1.salary );

------------#####--------------

#Q7(a): Write a query to find and remove duplicate records from a table.

SELECT EmpID, EmpName, gender, Salary, city, 
COUNT(*) AS duplicate_count
FROM Employee
GROUP BY EmpID, EmpName, gender, Salary, city
HAVING COUNT(*) > 1;

#Q7(b): Query to retrieve the list of employees working in same project.

WITH CTE AS 
(SELECT e.EmpID, e.EmpName, ed.Project
FROM Employee AS e
INNER JOIN EmployeeDetail AS ed 
ON e.EmpID = ed.EmpID)
SELECT c1.EmpName, c2.EmpName, c1.project 
FROM CTE c1, CTE c2
WHERE c1.Project = c2.Project AND c1.EmpID != c2.EmpID AND c1.EmpID < c2.EmpID;

------------#####--------------

#Q8: Show the employee with the highest salary for each projecT

SELECT ed.Project, MAX(e.Salary) AS ProjectSal
FROM Employee AS e
INNER JOIN EmployeeDetail AS ed
ON e.EmpID = ed.EmpID
GROUP BY Project
ORDER BY ProjectSal DESC;

------------#####--------------

#Q9: Query to find the total count of employees joined each year

SELECT EXTRACT(year FROM doj) AS JoinYear, COUNT(*) AS EmpCount
FROM Employee AS e
INNER JOIN EmployeeDetail AS ed ON e.EmpID = ed.EmpID
GROUP BY JoinYear
ORDER BY JoinYear ASC;

------------#####--------------

#Q10: Create 3 groups based on salary col, salary less than 1L is low, between 1-2L is medium and above 2L is High

SELECT EmpName, Salary,
CASE
WHEN Salary > 200000 THEN 'High'
WHEN Salary >= 100000 AND Salary <= 200000 THEN 'Medium'
ELSE 'Low'
END AS SalaryStatus
FROM Employee;

------------#####--------------

#Query to pivot the data in the Employee table and retrieve the total salary for each city. 
#The result should display the EmpID, EmpName, and separate columns for each city (Mathura, Pune, Delhi), containing the corresponding total salary.

SELECT
EmpID,
EmpName,
SUM(CASE WHEN City = 'Mathura' THEN Salary END) AS "Mathura",
SUM(CASE WHEN City = 'Pune' THEN Salary END) AS "Pune",
SUM(CASE WHEN City = 'Delhi' THEN Salary END) AS "Delhi"
FROM Employee
GROUP BY EmpID, EmpName;



