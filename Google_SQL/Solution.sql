/*
Every successful transaction will have two row entries into the table with two different transaction_id but 
in ascending order sequence, 
(a) the first one for the seller where their customer_id will be registered, 
(b) the second one for the buyer where their customer_id will be registered. 
   The amount and date_time for both will however be the same.
Write an sql query to find the 5 top seller-buyer combinations who have had maximum transactions between them.
Condition - Please disqualify the sellers who have acted as buyers and also the buyers who have acted as sellers for this condition.
*/
drop table if exists #temp
;with cte 
as(
select *,ROW_NUMBER() OVER(ORDER BY transaction_id ASC) AS rw FROM transactions_g 
)
select transaction_id,customer_id,amount,tran_Date,CASE WHEN rw%2=1 THEN 'Seller' ELSE 'Buyer' END [TType] 
into #temp
from cte order by  transaction_id

delete from #temp where customer_id in ( 
select distinct A.customer_id from #temp A join #temp b on A.customer_id=B.customer_id and A.TType <> B.TType)
;with sell as
(select * from #temp where TType='Seller')
,buyer as
(select * from #temp where TType='Buyer')
select a.customer_id,b.customer_id,count(1) from sell a inner join buyer b on a.tran_Date=b.tran_Date
group by a.customer_id,b.customer_id