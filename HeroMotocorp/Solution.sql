-- 1. We need to mask first 12 digits of card number.
-- select  REPLICATE('*', 12)+SUBSTRING(cast(card_number as varchar(20)),13,16),* from cards 


-- 2. Need to select employee names with same salary.
--select A.ename from Employee_H A join Employee_H B on A.salary=B.salary and A.ename !=B.ename