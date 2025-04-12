--DROP TABLE IF EXISTS dbo.running_total;
--CREATE TABLE running_total
--(
--MeasurementDateTime DATETIME,
--MeasurementPoint VARCHAR(12),
--MeasuredValue DECIMAL(3,1)
--);

--INSERT INTO running_total
--(MeasurementDateTime, MeasurementPoint, MeasuredValue)
--VALUES
--('2020-12-01', 'A1', 2.0),
--('2020-12-02', 'A1', 3.0),
--('2020-12-03', 'A1', 4.3),
--('2020-11-01', 'A1', 2.0),
--('2020-11-02', 'A1', 3.0),
--('2020-11-03', 'A1', 4.3),
--('2020-12-01', 'B1', 12.0),
--('2020-12-02', 'B1', 13.0),
--('2020-12-03', 'B1', 14.3)
--;

SELECT 
MeasurementPoint, MeasurementDateTime, MeasuredValue, 
--Running sum, WITHOUT using the ROWS BETWEEN UNBOUNDED PRECEDING clause
SUM(MeasuredValue) OVER(PARTITION BY MeasurementPoint ORDER BY MeasurementDateTime) As RunSum_Without_Unbounded,
--... and running sum, WITH that clause
SUM(MeasuredValue) OVER(PARTITION BY MeasurementPoint ORDER BY MeasurementDateTime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) As RunSum_WITH_Unbounded
FROM 
running_total
ORDER BY MeasurementDateTime;