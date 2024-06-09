create schema mysqlpro;
use mysqlpro;
select*from mobile;

-- check mobile features and price list --
select phone_name, price from mobile; 

-- find out the price of 5 most expensive phones --
select*from mobile order by price desc limit 5;

-- find out the price of 5 most cheapest phones --
select*from mobile order by price asc limit 5; 

-- list of top 5 samsung phones with price and all features --
select*from mobile where brands = "samsung" order by price desc limit 5;
 
 -- must have android phone list then top 5 high price android phones --
 select*from mobile where operating_system_type = "android" order by price desc limit 5;
 
 -- must have android phone list then top 5 low price android phones --
 select*from mobile where operating_system_type = "android" order by price asc limit 5;
 
 -- must have ios phone list then top 5 high price ios phones --
 select*from mobile where operating_system_type= "ios" order by price desc limit 5;
 
 -- must have ios phone list then top 5 high price ios phones --
  select*from mobile where operating_system_type= "ios" order by price asc limit 5;
  
  -- write a query which phone support 5g and also top 5 phone with 5g support --
  select* from mobile where 5g_availability = "yes" order by price desc limit 5;
  
  -- total price of all mobile is to be found with brand name --
  select brands, sum(price) from mobile group by brands ;
  
  