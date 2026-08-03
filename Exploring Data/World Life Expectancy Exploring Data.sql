#Investingating the Life expectancy

# Going over the Life expectancy increase over the years (2007 - 2022)
SELECT country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)- MIN(`Life expectancy`),1) AS Life_increase
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) <> 0
 AND MAX(`Life expectancy`) <> 0
ORDER BY Life_increase DESC;

#Looking at the Average Life expectancy for each year total.
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

# Life expectancy versus the GDP and seeing the correlation
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0 AND GDP > 0
ORDER BY GDP DESC;

#Comparing the Higher GDP countries and Lower GDP countries and their Life expectancy
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_expectancy
FROM world_life_expectancy;

# Looking at Status and their Life expectancy
SELECT *
FROM world_life_expectancy;

SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT(Country)), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

#Looking into BMI and Life expectancy relationship

SELECT *
FROM world_life_expectancy;

SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0 AND BMI > 0
ORDER BY BMI ASC;

# Using Rolling total for the Adult Mortality

SELECT country, year, `Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%';














