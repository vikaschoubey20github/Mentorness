use covid_mentorness;
select * from corona_virus_dataset;
-- Q1. Write a code to check NULL values
Select * FROM corona_virus_dataset  WHERE Deaths IS  NULL;
-- Q2. If NULL values are present, update them with zeros for all columns. 
UPDATE corona_virus_dataset 
SET Province = coalesce(Province, 0),Latitude = coalesce(Latitude, 0), Longitude = coalesce(Longitude, 0),
Date = coalesce(Date, 0),
Confirmed = coalesce(Confirmed, 0),
Deaths= coalesce(Deaths, 0),
Recovered = coalesce(Recovered, 0) 
WHERE Province IS NULL OR Latitude IS NULL OR Longitude IS NULL OR Date  IS NULL OR Confirmed IS NULL 
OR Deaths IS NULL OR  Recovered  IS NULL ;
-- Q3. check total number of rows
SELECT COUNT(*) AS TotalRows FROM corona_virus_dataset;
-- Q4. Check what is start_date and end_date
SELECT province FROM corona_virus_dataset WHERE start_date < end_date;
-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT MONTH(date_of)) AS num_months FROM corona_virus_dataset;
-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
  DATE_FORMAT(date_of, '%Y-%m') AS month,
  AVG(confirmed) AS avg_confirmed,
  AVG(deaths) AS avg_deaths,
  AVG(recovered) AS avg_recovered
FROM corona_virus_dataset;
--  Q7. Find most frequent value for confirmed, deaths, recovered each month 


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT Date_of, MIN(confirmed) AS min_confirmed, MIN(deaths) AS min_deaths, MIN(recovered) AS min_recovered
FROM corona_virus_dataset GROUP BY Date_of;
-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT Date_of, MAX(confirmed) AS max_confirmed, MAX(deaths) AS max_deaths, MAX(recovered) AS max_recovered
FROM corona_virus_dataset GROUP BY Date_of;
-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT EXTRACT(MONTH FROM date_of) AS month, SUM(confirmed) AS total_confirmed, SUM(deaths) AS total_deaths, 
SUM(recovered) AS total_recovered FROM corona_virus_dataset GROUP BY Date_of ORDER BY Date_of ASC;
-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
  COUNT(confirmed) AS total_confirmed,
  AVG(confirmed) AS avg_confirmed,
  STDDEV(confirmed) AS stddev_confirmed
FROM corona_virus_dataset;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
  EXTRACT(MONTH FROM date_of) AS month,
  COUNT(deaths) AS total_deaths,
  AVG(deaths)  AS avg_deaths,
  VARIANCE(deaths) AS variance_deaths,
  STDDEV(deaths) AS stddev_deaths
FROM corona_virus_dataset
GROUP BY month
ORDER BY month ASC;
-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
  EXTRACT(MONTH FROM date_of) AS month,
  COUNT(recovered) AS total_recovered,
  AVG(recovered)  AS avg_recovered,
  VARIANCE(recovered) AS variance_recovered,
  STDDEV(recovered)  AS stddev_recovered
FROM corona_virus_dataset

-- Q14. Find Country having highest number of the Confirmed case
SELECT country, max(confirmed) AS max_confirmed
FROM corona_virus_dataset
GROUP BY country
ORDER BY max_confirmed DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT country, min(Deaths) AS min_Deaths
FROM corona_virus_dataset
GROUP BY country
ORDER BY min DESC
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT country, max(Recovered) AS max_Recovered
FROM corona_virus_dataset
GROUP BY country
ORDER BY min DESC
LIMIT 5;
