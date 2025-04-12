-- select * from products
-- select * from colors
-- select * from sizes
-- select * from transactions
USE namastesql;
WITH Master_Data AS(
SELECT  A.name [ProductName]
		,B.color
		,C.size
FROM products A
	,colors b
	,sizes c
),
Sales AS(SELECT product_name,color,size,SUM(amount)amount FROM transactions GROUP BY product_name,color,size)
SELECT 
		A.ProductName [Product Name]
		,A.color [Color]
		,A.size [Size]
		,ISNULL(B.amount,0) Amount
FROM Master_Data A LEFT JOIN Sales B  ON A.ProductName=B.product_name AND A.color=B.color
AND A.size=B.size
Order by [Product Name],[Color]