-- Table : select * from Flights

-- Expected Outout :
-- cust_id  | origin   | final_destination
-- 1	    | Delhi	   | Mangalore
-- 2	    | Mumbai   | Delhi

drop table if exists #temp
select ROW_NUMBER() OVER(PARTITION BY A.cust_id ORDER BY A.cust_id ASC) rw,
A.cust_id,A.origin,b.destination
into #temp
from Flights a join flights b on A.cust_id=b.cust_id
where a.destination=B.origin
;with cte as(
select *,LEAD(destination, 1, destination) OVER(partition by cust_id   ORDER BY destination) AS final_destination from #temp
)
select cust_id,origin,final_destination from cte  where rw=1