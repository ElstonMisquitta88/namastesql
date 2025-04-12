Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

1- write a query to get region wise count of return orders
SELECT	B.region [Region],
		COUNT(A.Order_ID) [count of return order]
FROM returns A INNER JOIN Orders B ON A.order_id=B.order_id
GROUP BY B.region


2- write a query to get category wise sales of orders that were not returned
SELECT 
		category,
		SUM(sales) SUM_Sales
FROM Orders A LEFT JOIN returns B 
ON A.order_id=B.order_id
WHERE B.order_id IS NULL
GROUP BY A.category

3- write a query to print dep name and average salary of employees in that dep .
SELECT 
		B.DEP_NAME,
		AVG(A.SALARY) [AVGSALARY]
FROM EMPLOYEE A INNER JOIN DEPT B 
ON A.DEPT_ID=B.DEP_ID
GROUP BY DEP_NAME


4- write a query to print dep names where none of the emplyees have same salary.
SELECT 
		B.dep_name
FROM EMPLOYEE A inner JOIN DEPT B 
ON A.DEPT_ID=B.DEP_ID
GROUP BY B.dep_name
HAVING COUNT(A.emp_id)=COUNT(DISTINCT A.salary)


5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
SELECT	
		A.sub_category,
		COUNT(DISTINCT B.return_reason) [kinds of returns]
FROM Orders A INNER JOIN returns  B ON A.order_id=B.order_id
GROUP BY A.sub_category
HAVING COUNT(DISTINCT B.return_reason)=3


6- write a query to find cities where not even a single order was returned.
SELECT	
			city,
			count(B.order_id)
 FROM Orders A LEFT JOIN returns  B ON A.order_id=B.order_id
 GROUP BY city
 having count(B.order_id)=0


7- write a query to find top 3 subcategories by sales of returned orders in east region
SELECT	
			TOP 3
			A.SUB_CATEGORY
			,SUM(SALES) [sales of returned orders]
 FROM ORDERS A INNER JOIN RETURNS B ON A.ORDER_ID=B.ORDER_ID
 WHERE REGION='EAST'
 GROUP BY A.SUB_CATEGORY
 ORDER BY SUM(SALES) DESC


8- write a query to print dep name for which there is no employee
SELECT A.dep_name FROM DEPT A LEFT JOIN EMPLOYEE B ON a.dep_id=B.dept_id
WHERE B.dept_id IS NULL

9- write a query to print employees name for dep id is not avaiable in dept table
SELECT 
		A.emp_name
FROM EMPLOYEE A LEFT JOIN DEPT B 
ON A.DEPT_ID=B.DEP_ID
WHERE B.DEP_ID IS NULL