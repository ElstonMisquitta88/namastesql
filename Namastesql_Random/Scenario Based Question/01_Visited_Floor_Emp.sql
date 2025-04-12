-- Q: Write a query to find the Most visited floor by the employee with resources used.
-- [1] Main Table
--select * from entries order by name

-- [2] OutPut
DROP TABLE IF EXISTS #FloorVisit
SELECT name
	,floor
	,DENSE_RANK() OVER (
		ORDER BY count(floor)
	) AS floor_Visit_Count
INTO #FloorVisit
FROM entries
GROUP BY name,floor

;WITH CTE
AS
(
SELECT name,max(floor_Visit_Count) floor_Visit_Count from #FloorVisit 
group by name
)
,CTE_Resource
AS (
SELECT distinct name, resources as resources
FROM entries
GROUP BY name,resources
)
,CTE_Resource_List
AS (
SELECT name, STRING_AGG (resources, ',') as resources
FROM CTE_Resource
GROUP BY name
)

SELECT A.name
	,A.floor
	,A.floor_Visit_Count
	,R.resources
FROM #FloorVisit A
INNER JOIN CTE B ON A.name = B.name AND A.floor_Visit_Count = B.floor_Visit_Count
INNER JOIN CTE_Resource_List R ON A.name=R.name
Order by A.name