SELECT * FROM covid_data LIMIT 100;

SELECT COUNT (*) AS total_rows FROM covid_data;

SELECT column_name , data_type FROM information_schema.columns WHERE 
table_name = 'covid_data';

--TASK1  Total COVID Cases & Deaths per Country
SELECT country , MAX(total_cases) AS total_cases, MAX(total_deaths) AS total_deaths
FROM covid_data
GROUP BY 1
ORDER BY total_cases DESC;

--TASK2 Daily New Cases Trend Over Time (Global)
SELECT date, SUM(new_cases) AS total_new_cases
FROM covid_data
WHERE new_cases IS NOT NULL
GROUP BY date
ORDER BY date ;

--TASK3 Highest Daily Cases in a Country
SELECT country , date , new_cases
FROM covid_data 
WHERE new_cases IS NOT NULL
ORDER BY new_cases DESC
LIMIT 200;

--TASK4 Top 10 Countries by Vaccination Progress
SELECT country, MAX(people_vaccinated) AS total_vaccinated, MAX(total_vaccinations) AS total_doses
FROM covid_data
WHERE people_vaccinated IS NOT NULL
GROUP BY country
ORDER BY total_vaccinated DESC
;

--TASK5 Vaccination Rate Over Time (Global)
SELECT date, SUM(new_vaccinations) AS daily_vaccinations
FROM covid_data
WHERE new_vaccinations IS NOT NULL
GROUP BY 1
ORDER BY 1;

--TASK 6 Mortality Rate (Deaths / Cases) Per Country
SELECT country,
	   MAX(total_cases) AS total_cases,
	   MAX(total_deaths) AS total_deaths ,
	   (MAX(total_deaths)*100.0 / NULLIF(MAX(total_cases),0)) AS mortality_rate
FROM covid_data
GROUP BY country
ORDER BY mortality_rate DESC;

-- TASK 7 Stringency Index vs. Cases (Did lockdowns help?) 
SELECT country, date, stringency_index, new_cases
FROM covid_data 
WHERE stringency_index IS NOT NULL AND country = 'India'
ORDER BY country , date;

--TASK 8 TASK 8: Case Fatality Rate Over Time (Global ,Monthly)
SELECT TO_CHAR(date,'YYYY_MM') as month , SUM(total_deaths) * 100.0 / NULLIF(SUM(total_cases),0) AS global_case_fatality_rate
FROM covid_data
GROUP BY TO_CHAR(date,'YYYY_MM')
ORDER BY month;

--TASK 9: Countries with the Highest Hospitalization Rates
SELECT country , MAX(hosp_patients_per_million) AS max_hospitalization_rate
FROM covid_data
WHERE hosp_patients_per_million IS NOT NULL
GROUP BY country 
ORDER BY max_hospitalization_rate DESC
LIMIT 100;
	   
--TASK 10: ICU Admissions vs. Total Cases
SELECT country , 
MAX(total_cases) AS total_cases,
MAX(icu_patients) AS total_icu_patients,
(MAX(icu_patients)*100.0/NULLIF(MAX(total_cases),0)) AS icu_admission_rate
FROM covid_data
GROUP BY country
ORDER BY icu_admission_rate ASC;

--TASK 11: Excess Mortality Analysis
SELECT country , 
	MAX(total_deaths) AS reported_deaths,
	MAx(excess_mortality_cumulative_absolute) AS excess_deaths,
	(MAX(excess_mortality_cumulative_absolute) - MAX(total_deaths)) AS discrepency
	FROM covid_data
	GROUP BY country 
	ORDER BY discrepency ASC;


-- TASK 12: Vaccination Coverage vs. New Cases. To check if higher vaccination coverage correlates with lower new cases.
SELECT country , 
		MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
		AVG(new_cases_per_million) AS avg_new_cases_per_million
		FROM covid_data
		GROUP BY country 
		ORDER BY vaccination_coverage ASC;


-- TASK 13: Testing Rates vs. Positive Cases
SELECT country , 
		MAX(total_tests_per_thousand) AS tests_per_thousand,
		MAX(positive_rate) AS positive_rate
		FROM covid_data
		GROUP BY country 
		ORDER BY tests_per_thousand;


-- TASK 14: Impact of Median Age on Mortality Rate
SELECT country , 
		median_age , 
		(MAX(total_deaths)*100.0 / NULLIF(MAX(total_cases),0)) AS mortality_rate
		FROM covid_data 
		GROUP BY country , median_age
		ORDER BY mortality_rate ;


-- TASK 15: Weekly Hospital Admissions vs. Stringency Index
-- To check if stricter lockdowns (higher stringency index) led to fewer hospital admissions
		
SELECT country , 
AVG(stringency_index) AS avg_stringency_index ,
AVG(weekly_hosp_admissions_per_million) AS avg_weekly_hosp_admissions
FROM covid_data 
GROUP BY country 
ORDER BY avg_stringency_index;


-- TASK 16: Booster Doses vs. New Cases

SELECT country , 
		MAX(total_boosters_per_hundred) AS booster_coverage,
		AVG(new_cases_per_million) AS avg_new_cases_per_million
FROM covid_data
GROUP BY country 
ORDER BY booster_coverage DESC;

-- TASK 17: Life Expectancy vs. Mortality Rate
-- Investigating if countries with higher life expectancy have lower COVID-19 mortality rates.

SELECT country, 
       life_expectancy, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, life_expectancy
ORDER BY life_expectancy DESC;

--TASK 18 : GDP per Capita vs. Vaccination Progress
SELECT country,
		gdp_per_capita ,
		MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage
		FROM covid_data
		GROUP BY country,gdp_per_capita 
		ORDER BY gdp_per_capita DESC;

-- TASK 19: Diabetes Prevalence vs. Mortality Rate
SELECT country, 
       diabetes_prevalence, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, diabetes_prevalence
ORDER BY diabetes_prevalence DESC;

-- TASK 20: Hospital Beds per Thousand vs. Mortality Rate
SELECT country, 
       hospital_beds_per_thousand, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, hospital_beds_per_thousand
ORDER BY hospital_beds_per_thousand DESC;

