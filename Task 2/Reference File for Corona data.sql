
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT
    SUM(CASE WHEN Province IS NULL THEN 1 ELSE 0 END) AS Null_Province,
    SUM(CASE WHEN [Country/Region] IS NULL THEN 1 ELSE 0 END) AS Null_Country_Region,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Null_Latitude,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Null_Longitude,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Null_Date,
    SUM(CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END) AS Null_Confirmed,
    SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS Null_Deaths,
    SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS Null_Recovered
FROM
    corona;

--Q2. If NULL values are present, update them with zeros for all columns. 
SELECT
   CASE WHEN Province IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Province,
   CASE WHEN [Country/Region] IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Country_Region,
   CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Latitude,
   CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Longitude,
   CASE WHEN Date IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Date,
   CASE WHEN Confirmed IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Confirmed,
   CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Deaths,
   CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END AS Null_TO_ZERO_Recovered
FROM
    corona;

-- Q3. check total number of rows
SELECT
	COUNT(*) as total_rows_count
FROM
	corona;

-- Q4. Check what is start_date and end_date
SELECT
	MIN(date) as start_date, MAX(date) as end_date
FROM
	corona;

-- Q5. Number of month present in dataset
SELECT
	COUNT(DISTINCT MONTH(date)) as Number_of_months  
FROM
	corona;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    AVG(Confirmed) AS Average_Confirmed,
    AVG(Deaths) AS Average_Deaths,
    AVG(Recovered) AS Average_Recovered
FROM 
    corona
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY
    Year,
    Month;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
WITH MonthlyCounts AS (
    SELECT
        MONTH(Date) AS Month,
        Confirmed,
        Deaths,
        Recovered,
        ROW_NUMBER() OVER (PARTITION BY MONTH(Date) ORDER BY COUNT(*) DESC) AS rn
    FROM
        corona
    GROUP BY
        MONTH(Date),
        Confirmed,
        Deaths,
        Recovered
)
SELECT
    Month,
    Confirmed,
    Deaths,
    Recovered
FROM
    MonthlyCounts
WHERE
    rn = 1
ORDER BY
	1;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year,
    MIN(Confirmed) AS Min_Confirmed,
    MIN(Deaths) AS Min_Deaths,
    MIN(Recovered) AS Min_Recovered
FROM 
    corona
GROUP BY 
    YEAR(Date);

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year,
    MAX(Confirmed) AS MAX_Confirmed,
    MAX(Deaths) AS MAX_Deaths,
    MAX(Recovered) AS MAX_Recovered
FROM 
    corona
GROUP BY 
    YEAR(Date);

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed) AS Total_Confirmed,
    SUM(Deaths) AS Total_Deaths,
    SUM(Recovered) AS Total_Recovered
FROM 
    corona
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY
    Year,
    Month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    SUM(Confirmed) AS Total_Confirmed_Cases,
    AVG(Confirmed) AS Average_Confirmed_Cases,
    VAR(Confirmed) AS Variance_Confirmed_Cases,
    STDEV(Confirmed) AS Stdev_Confirmed_Cases
FROM 
    corona;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Deaths) AS Total_Death_Cases,
    AVG(Deaths) AS Average_Death_Cases,
    VAR(Deaths) AS Variance_Death_Cases,
    STDEV(Deaths) AS Stdev_Death_Cases
FROM 
    corona
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    Year,
    Month;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Recovered) AS Total_Recovered_Cases,
    AVG(Recovered) AS Average_Recovered_Cases,
    VAR(Recovered) AS Variance_Recovered_Cases,
    STDEV(Recovered) AS Stdev_Recovered_Cases
FROM 
    corona
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    Year,
    Month;

-- Q14. Find Country having highest number of the Confirmed case
SELECT TOP 1
    [Country/Region] AS Country,
    MAX(Confirmed) AS Max_Confirmed
FROM 
    corona
GROUP BY 
    [Country/Region]
ORDER BY 
    Max_Confirmed DESC;

-- Q15. Find Country having lowest number of the death case
SELECT TOP 1 
    [Country/Region] AS Country,
    MIN(Deaths) AS Max_Deaths
FROM 
    corona
GROUP BY 
    [Country/Region]
ORDER BY 
    Max_Deaths;

-- Q16. Find top 5 countries having highest recovered case
SELECT TOP 5
    [Country/Region] AS Country,
    MAX(Recovered) AS Max_Recovered
FROM 
    corona
GROUP BY 
    [Country/Region]
ORDER BY 
    Max_Recovered DESC;