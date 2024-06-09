use classicmodels;

              #day 3: question -1

select customernumber,customername,state,creditlimit from customers
where state is not null and creditLimit between 50000 and  100000
order by creditLimit desc;

           #day 3: question -2
       
select * from products;
select distinct productline from products where productLine like "%cars";
    
         #day4 : question -1
         
select ordernumber,status,case when comments is null then "-" else comments end from orders where status ="shipped";

         #day4 : question -2
		
select employeenumber, firstname, jobtitle , 
CASE when jobtitle = "President" THEN "P"
	 when jobtitle like "Sales Manager%" THEN "SM"
     when jobtitle like "Sales Rep" THEN "SR"
     when jobtitle like "VP%" THEN "VP"
Else jobtitle END as jobtitle_abbr from employees ;

		#day5 : question -1
        
select year(paymentdate), min(amount) 
from payments group by year(paymentdate) order by year(paymentdate);  

	  #day5 : question -2
   
select year(orderdate) as year, 
concat("Q", quarter(orderdate)) as Quarter, 
Count(distinct customernumber) as Distinct_Customers, 
count(ordernumber) as Total_orders
from orders  group by year, quarter 
order by year;

     #day5 : question -3
     
select monthname(paymentdate) as Month, concat(round(sum(amount)/1000,0),"K") as Formatted_amount 
from payments group by monthname(paymentdate)
order by sum(amount) desc;   
    
	#day6: question -1
    
create table journey
(Bus_ID int not null, 
Bus_Name varchar(30) not null,
Source_Station varchar(30) not null,
Destination varchar(30) not null,
Email varchar(30) unique);
desc journey;

	#day6: question -2
      
    Create table Vendor
(Vendor_ID int Primary key auto_increment,
Name varchar(30) not null,
Email varchar(30) unique,
Country varchar(30) default "N/A");
desc vendor; 

	#day6: question -3

CREATE TABLE movies (
  movie_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  release_year VARCHAR(4)  DEFAULT '-',
  cast VARCHAR(30) NOT NULL,
  gender CHAR(6)  check (gender = "Male" or gender = "Female"),
  no_of_shows INT NOT NULL DEFAULT 0
);
DESC MOVIES;

	 #day6: question -4
     
  create table suppliers(supplier_id int primary key auto_increment,
             supplier_name varchar(30),
             location varchar(30));
desc suppliers;

create table product(product_id int primary key auto_increment,
             product_name varchar(30), description varchar(100),
             supplier_id int, foreign key (supplier_id) references suppliers(supplier_id));
desc product;

create table stock(id int primary key auto_increment,
			 product_id int, foreign key(product_id) references product(product_id),
             balance_stock int);
desc stock;
alter table product modify product_name varchar(30) not null unique;
   
   #day7: question -1
   
select * from employees;
select * from customers;
desc customers;

select employeenumber, concat(firstname," ", lastname) as salesperson, count(customernumber) as uniquecustomer
from employees
inner join customers
on employees.employeenumber = customers. salesrepemployeenumber
group by salesrepemployeenumber order by uniquecustomer desc;

  #day7: question -2
  
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;
      
select customers.customernumber, customers.customername,
products.productcode, products.productname,
orderdetails.quantityordered, products.quantityinstock, 
(products.quantityinstock- orderdetails.quantityordered) as qtyleft
from customers
join orders
on customers.customernumber = orders.customernumber
join orderdetails
on orders.ordernumber = orderdetails.ordernumber
join products
on orderdetails.productcode = products.productcode
order by customers.customernumber;

#day7: question -3
  
create table Laptop(Laptop_Name varchar(100));
desc Laptop;
create table Colours( Colour_Name varchar(100));
desc colours;

insert into laptop values ("DELL");
insert into laptop values ("HP");
insert into laptop values ("ASUS");
insert into COLOURS values ("WHITE");
insert into COLOURS values ("SILVER");
insert into COLOURS values ("BLACK");
SELECT * FROM LAPTOP;
SELECT * FROM COLOURS;
SELECT * FROM COLOURS CROSS JOIN LAPTOP;

 #day7: question -4
 
create table project (employeeid int,fullname varchar(30),gender char(6),managerid int);
INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);
select * from project;
select e.fullname as manager_name,m.fullname as emp_name from project m
inner join project e on m.managerid=e.employeeid;
 
       #DAY 8
  
  Create table Facility
(Facility_ID int,
Name varchar(100) ,
State varchar(100),
Country varchar(100) );

alter table facility modify column facility_id int primary key auto_increment;
alter table facility add column City varchar(100) not null after name;
desc facility;

      #DAY 9
      
create table University
(ID int ,  Name varchar(100));

insert into university values(1, "Pune University"), 
               (2, "Mumbai University"),
              (3, "Delhi   University"),
              (4, "Madras University"),
              (5, "Nagpur University");
select * from university;
UPDATE UNIVERSITY SET NAME= TRIM(NAME);
update university set name = replace(name,"    ","");
update university set name = replace(name,"  "," ");
select * from university; 

  #DAY 10
  
  select * from orders;
select * from orderdetails;
set @count = (select count(productcode) from orderdetails);
select @count;
create view Product_Status as
select year(orderdate) as Years, concat( count(quantityordered),'
  (',ROUND((COUNT(ProductCode) / 2996) * 100, 0),'%)'
  )  as value
from orders
join orderdetails
on orders.ordernumber = orderdetails.ordernumber
group by year(orderdate)
order by year(orderdate);
select * from product_status;

    #DAY -11 NO -1
    
select * from customers;
call getcustomerlevel(119);  

#DAY -11 NO -2

select * from customers;
select * from payments;
select year(p.paymentdate) as year,c.country,concat(left(sum(p.amount)/1000,3),"K") as amt
from customers c join payments p on c.customernumber = p.customernumber
group by year,c.country;

call get_country_payments(2004,'Sweden');

#DAY -12 NO -1

select * from orders;
with cte as
(
select year(orderdate) as year,monthname(orderdate) as month,
count(ordernumber) as present,
lag(count(ordernumber)) over (order by year(orderdate)) as past 
from orders 
group by year,month
)
select year,month, present,concat(round(((present-past)/past)*100),'%') as '% YOY Change' from cte;

#DAY -12 NO -2

create table Emp_udf(Emp_id int primary key auto_increment, 
Name varchar(100), DOB date);
desc emp_udf;

INSERT INTO Emp_UDF(Name, DOB)
VALUES ("Piyush", "1990-03-30"), 
("Aman", "1992-08-15"), 
("Meena", "1998-07-28"), 
("Ketan", "2000-11-21"),
 ("Sanjay", "1995-05-21");
select * from emp_udf;
SET GLOBAL log_bin_trust_function_creators = 1;

select *,emp_udf(emp_id) from emp_udf;

   #DAY -13 NO -1

select customernumber,customername from customers
where customernumber not in (select customernumber from orders);

#DAY -13 NO -2

select c.customernumber,c.customername,count(o.ordernumber) as Total_Orders 
from customers c left join orders o on c.customernumber = o.customernumber  
group by  c.customernumber
union
select c.customernumber,c.customername,count(o.ordernumber) as Total_Orders 
from customers c right join orders o on c.customernumber = o.customernumber
group by c.customernumber;

#DAY -13 NO -3

select * from orderdetails;
with cta as
(
select ordernumber,quantityordered,
dense_rank() over (partition by ordernumber order by quantityordered desc) as rnk from orderdetails
)
select ordernumber,quantityordered from cta
where rnk = 2;

#DAY -13 NO -4

select * from orderdetails;
with max as(

select count(productcode) as max from orderdetails
group by ordernumber
)
select max(max) as MAX_TOTAL,min(max) as MIN_TOTAL from max;

#DAY -13 NO -5

select * from products;
 
select productline,count(buyprice)
from products where buyprice > ( select avg(buyprice) from products )
group by productline
order by count(buyprice) desc;

select * from orderdetails;

    #DAY -14
 
 create table emp_eh(empid int primary key,empname varchar(30),emailaddress varchar(100));
insert into emp_eh values(null,'Akanksha','ak@gmail.com');
call empeh(null,'jay','j@gmail,com');
call empeh (1,23,21);

   #DAY-15
   
create table emp_bit (name varchar(30),occupation varchar(30),working_date date,working_hours int);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  
select * from emp_bit;
INSERT INTO Emp_BIT VALUES('Ram','Engineer','2020-10-20',-13);