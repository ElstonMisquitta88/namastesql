Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
UPDATE A
SET A.city=null
from Orders a where order_id in ('CA-2020-161389','US-2021-156909')



2- write a query to find orders where city is null (2 rows)
SELECT * FROM Orders WHERE city IS NULL


3- write a query to get total profit, first order date and latest order date for each category
SELECT 
	   category
	   ,SUM(profit) [total profit]
	   ,MIN(order_date) [first order date]
	   ,MAX(order_date) [latest order date]
FROM Orders
GROUP BY category


4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
SELECT 
	   sub_category
FROM Orders
GROUP BY sub_category
HAVING AVG(profit) > (MAX(profit)/2)



5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

write a query to find students who have got same marks in Physics and Chemistry.
select 
	student_id
from exams where subject in ('Physics','Chemistry')
group by student_id
HAVING count(1)=2 AND count(distinct marks)=1

6- write a query to find total number of products in each category.
select 
category,
COUNT(DISTINCT product_id) Count
from Orders
GROUP BY category


7- write a query to find top 5 sub categories in west region by total quantity sold
select 
TOP 5
sub_category,
SUM(quantity) [TotalQty]
from Orders
WHERE region='West'
GROUP BY sub_category
ORDER BY  SUM(quantity) DESC

8- write a query to find total sales for each region and ship mode combination for orders in year 2020
select 
	region,
	ship_mode,
	SUM(sales) [Totalsales]
FROM Orders
WHERE DATEPART(year, order_date)='2020'
GROUP BY region,ship_mode
ORDER BY region