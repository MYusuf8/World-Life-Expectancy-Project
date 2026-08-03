SELECT * FROM world_life_expectancy;

#Checking for duplicates
SELECT Country, year, CONCAT(Country,year), COUNT(CONCAT(Country,year))
FROM world_life_expectancy
GROUP BY Country, year, CONCAT(Country,year)
HAVING COUNT(CONCAT(Country,year)) > 1;

SELECT *
FROM (
 SELECT Row_ID,
 CONCAT(Country,year),
 ROW_NUMBER() OVER(PARTITION BY CONCAT(Country,year) ORDER BY CONCAT(Country,year)) AS Row_Num
 FROM world_life_expectancy
 ) AS row_table
 WHERE Row_Num > 1;

DELETE FROM world_life_expectancy
WHERE Row_ID IN (
 SELECT Row_ID
 FROM (
 SELECT Row_ID,
 CONCAT(Country,year),
 ROW_NUMBER() OVER(PARTITION BY CONCAT(Country,year) ORDER BY CONCAT(Country,year)) AS Row_Num
 FROM world_life_expectancy
 ) AS row_table
 WHERE Row_Num > 1
);

-- Cleaning Up status 
SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> '';

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
  ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
  ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed';

SELECT *
FROM world_life_expectancy
WHERE status = '';

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` ='';

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` =''
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`, 
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
 ON t1.country = t2.country
  AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
 ON t1.country = t3.country
  AND t1.Year = t3.Year +1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
 ON t1.country = t2.country
  AND t1.Year = t2.Year -1
JOIN world_life_expectancy t3
 ON t1.country = t3.country
  AND t1.Year = t3.Year +1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = '';

SELECT * 
FROM world_life_expectancy;
