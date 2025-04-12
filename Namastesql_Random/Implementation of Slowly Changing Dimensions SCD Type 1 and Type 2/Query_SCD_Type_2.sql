--select * from product_stg
--select * from product_dim

--
--INSERT INTO product_stg(Product_id,Product_Name,Price)VALUES(1,'Iphone12',50000)
--INSERT INTO product_stg(Product_id,Product_Name,Price)VALUES(2,'Iphone13',60000)
--INSERT INTO product_stg(Product_id,Product_Name,Price)VALUES(3,'Iphone14',75000)

--DELETE FROM product_stg;
--INSERT INTO product_stg(Product_id,Product_Name,Price)VALUES(2,'Iphone13',30000)
--INSERT INTO product_stg(Product_id,Product_Name,Price)VALUES(4,'Iphone16',90000)


-- (1) Expire the Old Records
--UPDATE B
--	SET B.Price=A.Price,
--		B.end_date=GETDATE()-1
--FROM  product_stg A LEFT JOIN  product_dim B ON A.Product_id=B.Product_id 
--WHERE B.end_date='9999-12-31'


-- (2) Insert the New Records
--INSERT INTO product_dim(Product_id,Product_Name,Price,start_date,end_date)
--SELECT	
--			A.Product_id
--			,A.Product_Name
--			,A.Price
--			,GETDATE() [start_date]
--			,'9999-12-31' [end_date]
--FROM  product_stg A 

--(3) Output
SELECT * FROM PRODUCT_DIM 
SELECT * FROM PRODUCT_DIM WHERE PRODUCT_ID=2