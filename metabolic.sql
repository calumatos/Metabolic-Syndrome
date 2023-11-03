-- MINI-PROJECT WEEK 3

-- Carmen Matos and Elisa Cerdá Doñate

-- SQL SCRIPT FOR DATABASE CREATION AND QUERYING BASED ON METABOLIC DATA



-- Database creation

CREATE DATABASE metabolic_syndrome;

DROP TABLE metabolic_data;

-- Now go to Table >  Data > Import Wizard
-- Then select your CSV file created from pandas


USE metabolic_syndrome;
 
-- Initial data exploration

SELECT * FROM metabolic;


-- Note that our database consists of a single table, as there are no repeating values
-- A possibility to create different tables would be, for example, 
-- having a new table including age as primary key, and then a second column which would be age_group
-- This second column would group together the different ages in smaller groups



-- Average age by sex for the whole sample

SELECT AVG(age) AS avg_age, sex
FROM metabolic
GROUP BY sex;


--  Patient count, BMI and waist circumference divided by sex and age group

SELECT COUNT(sex) AS people_count, ROUND(AVG(BMI),2) as avg_bmi, ROUND(MIN(BMI),2) as min_bmi, ROUND(MAX(BMI),2) as max_bmi, ROUND(AVG(waistcirc),2) as avg_waist, ROUND(MIN(waistcirc),2) as min_waist, ROUND(MAX(waistcirc),2) as max_waist, sex,
CASE
	WHEN age >= 20 AND age <30 THEN 'age 20-29'
	WHEN age >= 30 AND age <40 THEN 'age 30-39'
	WHEN age >= 40 AND age <50 THEN 'age 40-49'
	WHEN age >= 50 AND age <60 THEN 'age 50-59'
	WHEN age >= 60 AND age <70 THEN 'age 60-69'
	WHEN age >= 70 AND age <80 THEN 'age 70-79'
	WHEN age >= 80 AND age <90 THEN 'age 80-89'
    ELSE 'not present'
END AS age_group
FROM metabolic
GROUP BY sex, age_group
ORDER BY age_group ASC;


-- Metabolic syndrome presence or lack thereof in female patients by age group

SELECT COUNT(sex) AS women_count, metabolicsyndrome,
CASE
	WHEN age >= 20 AND age <30 THEN 'age 20-29'
	WHEN age >= 30 AND age <40 THEN 'age 30-39'
	WHEN age >= 40 AND age <50 THEN 'age 40-49'
	WHEN age >= 50 AND age <60 THEN 'age 50-59'
	WHEN age >= 60 AND age <70 THEN 'age 60-69'
	WHEN age >= 70 AND age <80 THEN 'age 70-79'
	WHEN age >= 80 AND age <90 THEN 'age 80-89'
    ELSE 'not present'
END AS age_group
FROM metabolic
WHERE sex = 'female'
GROUP BY sex, age_group, metabolicsyndrome
ORDER BY age_group ASC;



-- Metabolic syndrome presence or lack thereof as columns in female patients by age group

SELECT
  CASE
    WHEN age >= 20 AND age < 30 THEN 'age 20-29'
    WHEN age >= 30 AND age < 40 THEN 'age 30-39'
    WHEN age >= 40 AND age < 50 THEN 'age 40-49'
    WHEN age >= 50 AND age < 60 THEN 'age 50-59'
    WHEN age >= 60 AND age < 70 THEN 'age 60-69'
    WHEN age >= 70 AND age < 80 THEN 'age 70-79'
    WHEN age >= 80 AND age < 90 THEN 'age 80-89'
    ELSE 'not present'
  END as age_group,
  SUM(CASE WHEN metabolicsyndrome = 1 THEN 1 ELSE 0 END) as with_metabolic_syndrome,
  SUM(CASE WHEN metabolicsyndrome = 0 THEN 1 ELSE 0 END) as without_metabolic_syndrome
FROM metabolic
WHERE sex = 'Female'  
GROUP BY age_group
ORDER BY age_group ASC;


-- Metabolic syndrome presence or lack thereof in female patients by age group as percentage within group

WITH female_age AS (
SELECT
  CASE
    WHEN age >= 20 AND age < 30 THEN 'age 20-29'
    WHEN age >= 30 AND age < 40 THEN 'age 30-39'
    WHEN age >= 40 AND age < 50 THEN 'age 40-49'
    WHEN age >= 50 AND age < 60 THEN 'age 50-59'
    WHEN age >= 60 AND age < 70 THEN 'age 60-69'
    WHEN age >= 70 AND age < 80 THEN 'age 70-79'
    WHEN age >= 80 AND age < 90 THEN 'age 80-89'
    ELSE 'not present'
  END as age_group,
  SUM(CASE WHEN metabolicsyndrome = 1 THEN 1 ELSE 0 END) as with_metabolic_syndrome,
  SUM(CASE WHEN metabolicsyndrome = 0 THEN 1 ELSE 0 END) as without_metabolic_syndrome
FROM metabolic
WHERE sex = 'Female'
GROUP BY age_group
ORDER BY age_group ASC)
SELECT age_group,
with_metabolic_syndrome,
without_metabolic_syndrome,
round(with_metabolic_syndrome/(with_metabolic_syndrome + without_metabolic_syndrome)*100, 2) as perc_with_metabolic,
round(without_metabolic_syndrome/(with_metabolic_syndrome + without_metabolic_syndrome)*100, 2) as perc_without_metabolic
FROM female_age;


-- Metabolic syndrome presence or lack thereof by marital status

SELECT COUNT(marital) AS people_count, marital, metabolicsyndrome
FROM metabolic
GROUP BY marital, metabolicsyndrome
ORDER BY marital ASC;


-- Presence of metabolic syndrome based on income group

SELECT COUNT(sex) AS person_count, metabolicsyndrome,
CASE
	WHEN income >= 0 AND income <1000 THEN '0-1 K'
    WHEN income >= 1000 AND income <2000 THEN '1-2 K'
    WHEN income >= 2000 AND income <3000 THEN '2-3 K'
	WHEN income >= 3000 AND income <4000 THEN '3-4 K'
	WHEN income >= 4000 AND income <5000 THEN '4-5 K'
	WHEN income >= 5000 AND income <6000 THEN '5-6 K'
	WHEN income >= 6000 AND income <7000 THEN '6-7 K'
	WHEN income >= 7000 AND income <8000 THEN '7-8 K'
	WHEN income >= 8000 AND income <=9000 THEN '8-9 K'
    ELSE 'not present'
END AS income_group
FROM metabolic
GROUP BY income_group, metabolicsyndrome
ORDER BY income_group ASC;


-- Metabolic syndrome presence or lack thereof by BMI group

SELECT COUNT(sex) AS person_count, metabolicsyndrome,
CASE
	WHEN BMI >= 10 AND BMI <15 THEN 'BMI 10-15'
    WHEN BMI >= 15 AND BMI <20 THEN 'BMI 15-20'
    WHEN BMI >= 20 AND BMI <25 THEN 'BMI 20-25'
	WHEN BMI >= 25 AND BMI <30 THEN 'BMI 25-30'
	WHEN BMI >= 30 AND BMI <35 THEN 'BMI 30-35'
	WHEN BMI >= 35 AND BMI <40 THEN 'BMI 35-40'
	WHEN BMI >= 40 AND BMI <45 THEN 'BMI 40-45'
	WHEN BMI >= 45 AND BMI <50 THEN 'BMI 45-50'
    ELSE 'not present'
END AS BMI_group
FROM metabolic
GROUP BY BMI_group, metabolicsyndrome
ORDER BY BMI_group ASC;


-- Metabolic syndrome presence or lack thereof by BMI group as percentage within group

WITH female_bmi AS (
SELECT
  CASE
    WHEN BMI >= 10 AND BMI <15 THEN 'BMI 10-15'
    WHEN BMI >= 15 AND BMI <20 THEN 'BMI 15-20'
    WHEN BMI >= 20 AND BMI <25 THEN 'BMI 20-25'
	WHEN BMI >= 25 AND BMI <30 THEN 'BMI 25-30'
	WHEN BMI >= 30 AND BMI <35 THEN 'BMI 30-35'
	WHEN BMI >= 35 AND BMI <40 THEN 'BMI 35-40'
	WHEN BMI >= 40 AND BMI <45 THEN 'BMI 40-45'
	WHEN BMI >= 45 AND BMI <50 THEN 'BMI 45-50'
    ELSE 'not present'
  END as bmi_group,
  SUM(CASE WHEN metabolicsyndrome = 1 THEN 1 ELSE 0 END) as with_metabolic_syndrome,
  SUM(CASE WHEN metabolicsyndrome = 0 THEN 1 ELSE 0 END) as without_metabolic_syndrome
FROM metabolic
WHERE sex = 'Female'
GROUP BY bmi_group
ORDER BY bmi_group ASC)
SELECT bmi_group,
with_metabolic_syndrome,
without_metabolic_syndrome,
round(with_metabolic_syndrome/(with_metabolic_syndrome + without_metabolic_syndrome)*100, 2) as perc_with_metabolic,
round(without_metabolic_syndrome/(with_metabolic_syndrome + without_metabolic_syndrome)*100, 2) as perc_without_metabolic
FROM female_bmi;
