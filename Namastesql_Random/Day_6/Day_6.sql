Note: please do not use any functions which are not taught in the class.
 you need to solve the questions only with the concepts that have been discussed so far.

Run the following command to add and update dob column in employee table
alter table  employee add dob date;
update employee set dob = dateadd(year,-1*emp_age,getdate())

1- write a query to print emp name , their manager name and diffrence in their age (in days) 
  for employees whose year of birth is before their managers year of birth
SELECT	
		A.emp_name [emp name],
		B.emp_name [manager name]
		,A.dob [EMP DOB]
		,B.dob [Manager DOB]
		,DATEDIFF(DAY, A.dob, B.dob)
FROM employee A INNER JOIN employee B ON A.manager_id=B.emp_id
WHERE DATEPART(Year,A.dob) < DATEPART(Year,b.dob)

2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
SELECT 
		sub_category
		FROM Orders Ord LEFT JOIN returns RT on Ord.order_id=RT.order_id
WHERE DATEPART(MONTH,order_date)=11
GROUP BY sub_category
HAVING COUNT(RT.order_id)= 0


3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.

select customer_name,order_id,count(order_id) from Orders
group by customer_name,order_id
Having count(order_id) =1
order by customer_name


4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
SELECT  
		MAX(B.emp_name)+ ' : '+STRING_AGG(a.emp_name, ',') WITHIN GROUP (ORDER BY a.salary) [Manager_Emp_Details]
FROM employee A INNER JOIN employee B ON A.manager_id=B.emp_id
GROUP BY A.manager_id


------------------------------------
------------------------------------
------------------------------------


-- TOOD
5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only


-- TOOD
6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
select 
		category,
		SUM(SALES) [total_sales],
		SUM(case when b.order_id is not null then sales end) [total sales of returned orders]
from Orders A LEFT JOIN returns B ON a.order_id=B.order_id
group by category



7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
SELECT 
		CATEGORY,
		SUM(CASE WHEN DATEPART(YEAR,ORDER_DATE)='2019' THEN SALES END) [TOTAL_SALES_2019],
		SUM(CASE WHEN DATEPART(YEAR,ORDER_DATE)='2020' THEN SALES END) [TOTAL_SALES_2020]
FROM ORDERS A 
WHERE DATEPART(YEAR,ORDER_DATE) In ('2019','2020')
GROUP BY CATEGORY


8- write a query print top 5 cities in west region by average no of days between order date and ship date.
SELECT 
		top 5
		City,
		AVG(DATEDIFF(Day,order_date,ship_date)) [average no of days]
FROM ORDERS A 
WHERE region='West'
GROUP BY City
Order by [average no of days] desc


9- write a query to print emp name, manager name and senior manager name (senior manager is managers manager)
SELECT 
		A.EMP_NAME,
		B.EMP_NAME [MANAGER NAME],
		C.EMP_NAME [SENIOR MANAGER NAME]
FROM EMPLOYEE A 
		JOIN EMPLOYEE B ON A.MANAGER_ID=B.EMP_ID
		JOIN EMPLOYEE C ON  B.MANAGER_ID=C.EMP_ID