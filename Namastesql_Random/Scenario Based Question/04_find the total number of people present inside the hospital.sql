-- Write a SQL query to find the total number of people present inside the hospital.
--select * INTO #TEMP_IN from hospital where emp_id=2 AND action='IN'
--select * INTO #TEMP_OUT from hospital where emp_id=2 AND action='out'

DROP TABLE IF EXISTS #TEMP_IN,#TEMP_OUT
select * INTO #TEMP_IN from hospital where action='IN'
select * INTO #TEMP_OUT from hospital where action='out'

-- (1)
SELECT 
		A.emp_id,
		A.time [In_Time],
		CASE WHEN B.time > A.Time THEN B.time ELSE NULL END [Out_Time]
FROM #TEMP_IN A LEFT JOIN #TEMP_OUT B ON A.emp_id=B.emp_id AND B.time > A.Time 
where B.emp_id IS NULL

-- (2) Final Count
SELECT 
		count(CASE WHEN B.time > A.Time THEN B.time ELSE 1 END )[Out_Time]
FROM #TEMP_IN A LEFT JOIN #TEMP_OUT B ON A.emp_id=B.emp_id AND B.time > A.Time 
where B.emp_id IS NULL
