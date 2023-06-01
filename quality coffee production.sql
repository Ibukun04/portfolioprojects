--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP (1000) [ID]
--      ,[Country_of_Origin]
--      ,[Aroma]
--      ,[Flavor]
--      ,[Aftertaste]
--      ,[Acidity]
--      ,[Body]
--      ,[Balance]
--      ,[Uniformity]
--      ,[Clean_Cup]
--      ,[Sweetness]
--      ,[Color]
--      ,[Expiration]
--  FROM [portfolio2].[dbo].[CoffeeData2]

select * 
from portfolio2..qualitycoffeedata$

select *
from portfolio2..coffeedata2

--sum total of branches in different countries and sum total of bags of coffee produced by different countries in MAY 2023 by different companies

select country_of_origin, count(country_of_origin) as numbersofbranches
from portfolio2..qualitycoffeedata$
group by country_of_origin

select country_of_origin, sum(number_of_bags) as totalsumofbags
from portfolio2..qualitycoffeedata$
group by country_of_origin

--to rate the percentage quality of coffee produced by each country, region and company

--the international standard for quality measurement and rating of a coffee is 10/10 and are from the following factors; aroma, flavor, aftertaste, 
--acidity, body, uniformity, balance, clean cup and sweetness


with PercentageRating as
(select QC.Country_of_Origin, company, region, flavor, aftertaste,acidity, body, 
 balance, aroma, uniformity, Clean_Cup, sweetness
from portfolio2..QualityCoffeeData$ as QC
inner join portfolio2..CoffeeData2 as CD
on QC.ID=CD.ID
)
 select *,flavor + aftertaste + acidity + body 
 + balance + aroma + uniformity + Clean_Cup + sweetness as ActualRating,
 case
  when flavor + aftertaste + acidity + body 
 + balance + aroma + uniformity + Clean_Cup + sweetness > 90 then 'complete'
  else 90
 end as TotalSumOfstandardInternationalRating,
  (flavor + aftertaste + acidity + body 
 + balance + aroma + uniformity + Clean_Cup + sweetness)/
  (case
  when flavor + aftertaste + acidity + body 
 + balance + aroma + uniformity + Clean_Cup + sweetness > 90 then 'complete'
  else 90
 end)*100 as PercentageRating
from PercentageRating


--drop table if exists #percentagerating
--create table #percentagerating
--(country_of_origin varchar(100),
--company varchar(100),
--region varchar(100),
-- flavor numeric,
-- aftertaste numeric,
-- acidity numeric,
-- body numeric,
-- balance numeric,
-- uniformity numeric,
-- clean_cup numeric,
-- aroma numeric,
-- sweetness numeric,
--)

--insert into #percentagerating 
--select QC.Country_of_Origin, company, region, flavor, aftertaste,acidity, body, 
-- balance, uniformity, Clean_Cup, aroma, sweetness
--from portfolio2..QualityCoffeeData$ as QC
--inner join portfolio2..CoffeeData2 as CD
--on QC.ID=CD.ID



