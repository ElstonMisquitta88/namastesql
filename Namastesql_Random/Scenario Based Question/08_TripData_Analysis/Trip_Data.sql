DROP TABLE IF EXISTS #Temp_Start,#Temp_End
SELECT start_loc,customer INTO #Temp_Start FROM travel_data 
SELECT end_loc,customer INTO #Temp_End FROM travel_data  

;WITH CTE_Start AS(
SELECT A.customer,A.start_loc FROM #TEMP_START A LEFT JOIN #TEMP_END B ON A.CUSTOMER=B.CUSTOMER AND A.START_LOC=B.END_LOC
WHERE B.END_LOC IS NULL
),
CTE_END AS(
SELECT A.customer,A.end_loc FROM #TEMP_END  A LEFT JOIN  #TEMP_START B ON A.CUSTOMER=B.CUSTOMER AND A.END_LOC=B.START_LOC
WHERE B.START_LOC IS NULL
),
CTE_Total AS
(
	SELECT COUNT(start_loc) Cnt,customer
	FROM
	(SELECT start_loc,customer FROM #Temp_Start
	UNION 
	SELECT end_loc,customer FROM #Temp_End
	)T
	GROUP BY customer
)
SELECT 
		A.customer,
		A.start_loc,
		B.end_loc,
		C.Cnt FROM CTE_Start A 
LEFT JOIN CTE_END B ON A.customer=B.customer
LEFT JOIN CTE_Total C On A.customer=C.customer
Order by A.customer