--PROBLEM STATEMENT : 
-- Find the company who have at least 2 users who speaks English and German both the languages.
-- select * from company_users
-- where language IN ('English','German') AND company_id=1


;WITH CTE
AS
(
select company_id,user_id,count(1) cnt from company_users
where language IN ('English','German') 
group by company_id,user_id
)
,Main
AS
(
SELECT company_id,ROW_NUMBER() OVER(PARTITION BY company_id ORDER BY cnt ASC) RwCnt FROM CTE where cnt=2
)
SELECT company_id FROM Main WHERE RwCnt>1