Project Title: User Activity Analysis Using SQL 

Project Overview:
This project focuses on analyzing user activity data from two tables, `users_id` and `logins`. 
The goal is to provide valuable insights into user engagement, activity patterns, and overall usage trends over time. 

Analytical Questions: 

---  Database : namastesql
--- Tables : LOGINS / users


1. Which users did not log in during the past 5 months?
drop table if exists #temp
;with cte
as
(
select user_id,MONTH(LOGIN_TIMESTAMP) MONTH,YEAR(LOGIN_TIMESTAMP)YEAR from LOGINS 
group by user_id,MONTH(LOGIN_TIMESTAMP),YEAR(LOGIN_TIMESTAMP)
)
select user_id,count(MONTH) Login_count 
into #temp
from cte
where YEAR =2024 
AND MONTH>1
group by user_id

select A.* from users A left join #temp B on A.USER_ID=B.USER_ID
where B.USER_ID is null
drop table if exists #temp


2. How many users and sessions were there in each quarter, ordered from newest to oldest?
DROP TABLE IF EXISTS #Temp
SELECT  DATEPART(QUARTER,LOGIN_TIMESTAMP) QUARTER
		,* 
INTO #Temp
from LOGINS
order by LOGIN_TIMESTAMP


;WITH CTE
AS
(
select QUARTER,count(SESSION_ID) count_SESSION_ID,count(distinct USER_ID) count_USER_ID from #Temp 
group by QUARTER
)
select * from CTE


3. Which users logged in during January 2024 but did not log in during November 2023?
;WITH CTE_JAN
AS (SELECT  
		* 
FROM LOGINS
WHERE YEAR(LOGIN_TIMESTAMP)=2024 AND MONTH(LOGIN_TIMESTAMP)=1
)
,CTE_NOV
AS
(SELECT  
		* 
FROM LOGINS
WHERE YEAR(LOGIN_TIMESTAMP)=2023 AND MONTH(LOGIN_TIMESTAMP)=11
)
SELECT * FROM CTE_JAN A LEFT JOIN CTE_NOV B ON A.USER_ID=B.USER_ID
where B.USER_ID is null


4. What is the percentage change in sessions from the last quarter?
DROP TABLE IF EXISTS #Temp
;WITH SUBCTE
AS (
	SELECT  DATEPART(QUARTER,LOGIN_TIMESTAMP) QUARTER
			,* 
	from LOGINS
)
,CTE
AS
(
select QUARTER,count(SESSION_ID) count_SESSION_ID from SUBCTE 
group by QUARTER
)
select * INTO #Temp from CTE
;WITH MAIN
AS
(
SELECT *,Lag(count_SESSION_ID, 1) OVER(ORDER BY QUARTER ASC) AS [Previous_count_SESSION_ID] FROM #Temp 
)

SELECT *,100.0 * (count_SESSION_ID - Previous_count_SESSION_ID) / Previous_count_SESSION_ID AS PercentDiff FROM MAIN


5. Which user had the highest session score each day?
WITH CTE_DATA
AS
(SELECT USER_ID
	,convert(VARCHAR(12), LOGIN_TIMESTAMP, 112) LOGIN_TIMESTAMP
	,SESSION_SCORE
FROM LOGINS
)
,
CTE_MAIN
AS
(
SELECT USER_ID,LOGIN_TIMESTAMP,SUM(SESSION_SCORE)SESSION_SCORE FROM CTE_DATA GROUP BY USER_ID,LOGIN_TIMESTAMP
)
,
CTE_Output
AS
(SELECT *,DENSE_RANK() OVER(PARTITION BY LOGIN_TIMESTAMP ORDER BY SESSION_SCORE DESC) AS Row FROM CTE_MAIN
)
SELECT B.USER_NAME,A.LOGIN_TIMESTAMP,A.SESSION_SCORE FROM CTE_Output A LEFT JOIN users B ON A.USER_ID=B.USER_ID WHERE Row=1
Order by LOGIN_TIMESTAMP


6. Which users have had a session every single day since their first login?
DROP TABLE IF EXISTS #Temp
select *,LAG(LOGIN_TIMESTAMP, 1) OVER(PARTITION BY user_id ORDER BY user_id , LOGIN_TIMESTAMP ASC) AS EndDate 
INTO #Temp
from LOGINS  Order by LOGIN_TIMESTAMP

;WITH CTE
AS
(
SELECT *, ISNULL(DATEDIFF(day, CONVERT(VARCHAR(12), EndDate, 112), CONVERT(VARCHAR(12), LOGIN_TIMESTAMP, 112)),1) DayDifference 
FROM #Temp
)
,Main
AS
(
SELECT USER_ID,SUM(1) Row_Count,SUM(DayDifference)  DayDifference_Total
FROM CTE
GROUP BY USER_ID
)
SELECT A.USER_ID,B.USER_NAME FROM Main A LEFT JOIN users B ON A.USER_ID=B.USER_ID
WHERE Row_Count=DayDifference_Total


7. On what dates were there no logins at all?
-- Assumpiton  :  Considering Date Range Between - MIN(LOGIN_TIMESTAMP) AND MAX(LOGIN_TIMESTAMP)  

DECLARE @SDATE DATE = '',@EDATE DATE = '';
SELECT @SDATE=MIN(LOGIN_TIMESTAMP),@EDATE=MAX(LOGIN_TIMESTAMP) FROM LOGINS
DROP TABLE IF EXISTS #Date_Calender
;WITH DATES_CTE (DATE) AS (
    SELECT @SDATE 
    UNION ALL
    SELECT DATEADD(DAY, 1, DATE)
    FROM DATES_CTE
    WHERE DATE < @EDATE
)
SELECT CONVERT(VARCHAR(12),DATE,112) DateRange
INTO #Date_Calender
FROM DATES_CTE
option (maxrecursion 0)

SELECT A.DateRange FROM #Date_Calender A LEFT JOIN LOGINS B ON A.DateRange=CONVERT(VARCHAR(12),B.LOGIN_TIMESTAMP,112)
WHERE B.USER_ID IS NULL
Order by A.DateRange
