/*
We need to Find department wise minimum salary empname and maximum salary empname 
*/

--CREATE TABLE emps_tbl (emp_name VARCHAR(50), dept_id INT, salary INT);
--INSERT INTO emps_tbl VALUES ('Siva', 1, 30000), ('Ravi', 2, 40000), ('Prasad', 1, 50000), ('Sai', 2, 20000), ('Anna', 2, 10000);

-- Solution Used : FIRST_VALUE / Last_Value

;with cte as(
select *, FIRST_VALUE(emp_name) OVER (partition by dept_id ORDER BY salary ASC) AS Min_Sal_Emp
,Last_VALUE(emp_name) OVER (partition by dept_id ORDER BY salary desc) AS Max_Sal_Emp
,ROW_NUMBER () over (partition by dept_id ORDER BY salary desc) rw
from emps_tbl)
SELECT dept_id,Min_Sal_Emp,Max_Sal_Emp from cte where rw=1