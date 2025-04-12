-- Main Query : select * from order_new
-- (1) Find top 3 outlets by cusine type without using limit and top function
-- (1) Find top 1 outlets by cusine type without using limit and top function
--with cte as
--(select Restaurant_id,Cuisine,count(1)cnt 
--from order_new group by  Restaurant_id,Cuisine 
--),
--cal as
--(
--select Row_Number() OVER(partition by Cuisine ORDER BY cnt desc) AS Rank,*
--from cte 
--)
--select Rank,Restaurant_id,Cuisine from cal 
----where rank <=3
--where rank =1

--(2) Find the daily new customer count from the launch date(evereday how many new customers we are acquring)
--with cte as
--(select Customer_code,Placed_at,convert(varchar(12),Placed_at,112)Order_Date from order_new 
--),dt as
--(select Row_Number() OVER(partition by Customer_code ORDER BY Order_Date asc) AS Rank,* from cte)
--select Order_Date,count(1)New_Customer_Count from dt where Rank=1 group by Order_Date order by Order_Date

--(3) Count of all the users who were acquired in Jan 2025 and only placed one order in Jan and did not place any other order 
--  We divide the question into 3 Parts
-- (a) who were acquired in Jan 2025
-- (b) Placed only one order in Jan
-- (c) did not place any other other later
--with Maincte
--as(
--select Customer_code,count(1) Jan_Order_Count FROM order_new where MONTH(Placed_at)=1 
--group by Customer_code
--having count(1)=1 
--),
--orders as
--(select * from order_new where MONTH(Placed_at) !=1)
--select A.Customer_code from Maincte a left join orders b on A.Customer_code=B.Customer_code
--where b.Order_id is null

-- (4) List all the customers with no order in the last 7 days 
--  but were acquired one month ago with the first order on promo
--with cte
--as(
--select Customer_code,min(Placed_at)Min_OrderDate from order_new where Promo_code_Name IS NOT NULL
--group by Customer_code
--)
--,custlst
--as(
--select Customer_code from cte 
--WHERE MONTH(Min_OrderDate)=MONTH(GETDATE()) -1
--)
--,final as(
--select MAX(Placed_at)MAX_OrderDate,A.Customer_code from order_new a INNER JOIN custlst B ON A.Customer_code=B.Customer_code
--group by A.Customer_code
--)
--select * from final where MAX_OrderDate < DATEADD(day, -7, GETDATE())

-- (5)
-- Growth team is planning to create a trigger that 
-- will target customers after their every third order with a personalized communication
-- and they have asked you to create a query for this 
--with cte as
--(
--select Row_Number() OVER(partition by Customer_code ORDER BY Placed_at asc) AS Rank,* from order_new
--)
--select * from cte  where Rank%3=0

--(6) List customers who placed more than 1 order and all their orders on a promo only
--select Customer_code,count(Order_id) Ordercnt,count(Promo_code_Name)Promocnt 
--from order_new 
--group by Customer_code 
--HAVING count(Order_id) >1  -- placed more than 1 order
--AND (count(Order_id)=count(Promo_code_Name)) -- all their orders on a promo only

--(7) What percent of customer where organically acquired in Jan 2025
     --(Placed their first order without promo code)

--;with total
--as(
-- select count(distinct Customer_code)total_cnt FROM order_new where MONTH(Placed_at)=1)
--,jandata as
--(
-- select Row_Number() OVER(partition by Customer_code ORDER BY Placed_at asc) AS Rank,
--* FROM order_new where MONTH(Placed_at)=1 
--),jan_filtered as
--(select count(distinct Customer_code)jan_cnt from jandata where Rank=1 and Promo_code_Name is null
--)
--select (jan_cnt*1.0 /total_cnt*1.0)*100.00 from total,jan_filtered
