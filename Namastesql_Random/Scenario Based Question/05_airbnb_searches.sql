--PROBLEM STATEMENT : Find the room type that are searched most no. of times. 
--Output the room type alongside the number of searches for it. 
--If the filter for room types has more than one room type,
--consider each unique room type as a separate row.
--Sort the result based on no. of searches in descending order.

-- STRING_SPLIT
-- cross apply

select * from airbnb_searches


;WITH CTE
AS
(select date_searched, cs.Value [filter_room_types]
from airbnb_searches
cross apply STRING_SPLIT (filter_room_types, ',') cs
)
SELECT filter_room_types,COUNT(date_searched)[No_Of_Serach] FROM CTE group by filter_room_types
order by [No_Of_Serach] desc