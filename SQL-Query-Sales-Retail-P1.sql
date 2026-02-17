--SQL Retail Sales Analysis Project 1\
DROP Table If Exists retail_sales;
create table retail_sales (
transactions_id INT Primary Key,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR (15),
age INT,
category VARCHAR (15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
)

--Data Cleaning

select * from retail_sales limit 10

select count (*) from retail_sales

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_time is null

select * from retail_sales
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
category is null
or 
quantiy is null 
or 
price_per_unit is null 
or 
cogs is null 
or 
total_sale is null

Delete from retail_sales
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
category is null
or 
quantiy is null 
or 
price_per_unit is null 
or 
cogs is null 
or 
total_sale is null

--Data Exploration
--How many sales do we have

select count (*) from retail_sales

--how many unique customers do we have

select count (distinct (customer_id)) from retail_sales

--how many categories do wehave

select distinct category from retail_sales

--Data Analysis and Business Key Problems
--Q.1 write a sql query to retrieve all the columns where sales where made on '2022-11-05'

select * from retail_sales

select *
from retail_sales
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all the transactions where the category is 'clothing' and the quantity sold 
-- is more than 10 in the month of november 2022

select * from retail_sales
where
category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND 
quantiy >= 4

--Q3. Write SQL query to calculate the total sales for each category

select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by category

--Q4. Write a SQL query to find the avg age of customers who purchased items from 'Beauty' category
select round(avg(age),2)
from retail_sales
where category = 'Beauty'

--Q5. Write a SQL Query to find all the transactions where to total_sale is greater than 1000

select * from retail_sales
where total_sale >1000

--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender
-- in each category

select category, gender,
count(*) as total_trans
from retail_sales
group by category, gender
order by category

--Q7. write a sql query to calculate the average sale for each month. Find out the best selling month in
-- each year


select year, month, avg_sale from(
select
EXTRACT(YEAR from sale_date) as year,
EXTRACT(MONTH from sale_date) as month,
avg(total_sale) as avg_sale,
RANK() OVER (PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY Avg(total_sale) desc)
from retail_sales
group by year, month) as t1
where rank = 1

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales

select * from retail_Sales

select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5

--Q9. Write a SQL query to find the number of unique customers who purchased items from
--each category

select * from retail_sales

select category,
count(distinct customer_id) as cnt_unique_customers
from retail_sales
group by category

--Q10. Write a SQL query to create each shift and number of orders (Ex morning <12, afternoon between 12 and 17, evening  >17)
WITH hourly_sale
AS
(
select *,
  CASE
      WHEN EXTRACT (HOUR from sale_time)< 12 THEN 'Morning'
	  WHEN EXTRACT (HOUR from sale_time) Between 12 and 17 THEN 'Afternoon'
	  ELSE 'Evening'
  END as shift
from retail_sales
)
select shift,
count (*) as total_orders
from hourly_sale
group by shift 

--END OF PROJECT












