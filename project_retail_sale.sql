create database project;
use project;


CREATE TABLE retails_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(50),
    age INT,
    category VARCHAR(40),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

USE project;


select *
from retails_sales

where 
	transactions_id is null
or
	sale_date is null
or
	sale_time is null
or
	customer_id is null
or 
	gender is null
or 
	age is null
or 
	category  is null
or
	price_per_unit is null
or
	cogs is null
or 
	total_sale is null
    ;
	
    
    
    SET SQL_SAFE_UPDATES = 0;
    
-- data cleaning


delete from retails_sales
where transactions_id is null
or
	sale_date is null
or
	sale_time is null
or
	customer_id is null
or 
	gender is null
or 
	age is null
or 
	category  is null
or
	price_per_unit is null
or
	cogs is null
or 
	total_sale is null
    ;
	
    
    -- data exploration-- 
    
    

    
  --   how many sales/ record we have
    
    select count(*) total_sale 
    from retails_sales;
    
    
--     how many unique customer do we have 

		select count( distinct customer_id) as unique_customer
	   from retails_sales;



  -- how many category do we have-- 
  
  select distinct category 
  as diffrent_category
  from retails_sales;
  





select count(category), category
 from retails_sales
 group by category;
	
 




-- Data analysis and business problem



-- Q1 Write a query to retrieve all columnn for sale made on '2022-11-05';



select *
from retails_sales
where sale_date = '2022-11-05';




-- Q2 Write a query to retrieve all all transaction where category is clothing and the quantity is more than 4 in the month of nov-2022

select * 
from retails_sales
where category='Clothing'
and quantiy>=4
and sale_date>='2022-11-01'
and sale_date<'2022-12-01'
;





-- Q3 select a sql query to calculate the total sales for each caegory-- 


select category,
 sum(total_sale )as net_sale
from retails_sales
group by category;




-- Q4 write a sql query to find the average age of customer who purchased item from the 'beuty' category


select category,
round(avg(age) ,2)as average_age
from retails_sales
where category ='Beauty'

;





-- Q5 write an sql query to find all trasnction where total_sale is greater than 1000

select count(*)
from retails_sales
where total_sale>=1000;


-- Q6 write an sql query  to find the total number of transaction(transaction_id) made by each gender in each category;

select category ,
gender,
count(*) as total_trans
from retails_sales
group by category,gender
order by gender;

-- Q7 write an sql query to calculate the average sale for each month. find out best selling month in each year

select * from(
	select
	year(sale_date) as year,
	month(sale_date ) as month,
	avg(total_sale) as averages,
	rank()over (partition by year(sale_date) order by avg(total_sale) desc) as rankk
	from retails_sales
	group by 1 ,2
) as t1
where rankk=1;




-- Q8 write an sql query to find the top 5 customer based on the highest total sale

select customer_id ,
sum(total_sale) as summm
from retails_sales
group by customer_id
order by summm desc
limit 5;



-- Q9 write an sql query to find the number of unique customer who purchase item from each category;


select category,
count(distinct customer_id) as unique_cust
from retails_sales
group by category;



-- Q10 write an sql query to create each shift and number of orders (example morning<=12,afternoon between 12& 17, evening>17)

with hourly_sale
as(
select * ,
case 
when hour(sale_time) <12 then 'morning'
when hour (sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shifts
from retails_sales

)


select shifts,
count(*) as total_orders
from hourly_sale
group by shifts





-- end of  project
