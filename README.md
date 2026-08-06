# Project
World Life Expectancy Analysis
Project Overview

This project explores global life expectancy trends using a real-world dataset covering 193 countries from 2007 to 2022. The project is split into two parts: data cleaning and exploratory data analysis (EDA), both performed using MySQL.

The goal was to take a raw, messy dataset, clean it into a reliable format, and then use SQL to uncover patterns and relationships between life expectancy and factors such as GDP, BMI, development status, and adult mortality.

Data Cleaning
Steps taken to clean the raw dataset -

Identified and removed duplicate records using ROW_NUMBER() partitioned over a concatenation of Country and Year, keeping only the first occurrence of each country/year combination.
Standardised the Status column (Developed/Developing) by self-joining the table on Country to backfill blank values using existing, non-blank entries for the same country.


Part 2 Exploratory Data Analysis
Key questions explored -

How much has life expectancy increased per country between 2007 and 2022? Calculated the difference between each country's minimum and maximum life expectancy to rank countries by improvement.

What is the global average life expectancy trend over time? Aggregated average life expectancy for each year to observe the overall global trend.

Does GDP correlate with life expectancy? Compared average life expectancy against average GDP per country, and used conditional aggregation (CASE statements) to compare outcomes between high-GDP and low-GDP countries.
