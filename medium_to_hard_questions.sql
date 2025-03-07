-- M1: Rolling 7-Day Average of New Cases (Window Functions)
--Calculating the rolling 7-day average of new cases for each country.
SELECT country , 
		date,
		new_cases,
		AVG(new_cases) OVER (PARTITION BY country ORDER BY date ROWS BETWEEN 6
		PRECEDING AND CURRENT ROW) AS rolling_avg_new_cases
		FROM covid_data
		ORDER BY country , date ;

		


--M2: Rank Countries by Vaccination Progress

SELECT 
		country ,
		MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
		RANK() OVER (ORDER BY MAX(people_fully_vaccinated_per_hundred) DESC) AS rank
		FROM covid_data
		WHERE people_fully_vaccinated_per_hundred IS NOT NULL
		GROUP BY country 
		ORDER BY rank;

-- M3: Cumulative Vaccinations Over Time (Window Functions) of India
SELECT country,
		date,
		new_vaccinations,
		SUM(new_vaccinations) OVER (PARTITION BY country ORDER BY date) AS  cumulative_vaccinations
		
		FROM covid_data
		WHERE new_vaccinations IS NOT NULL AND country = 'India'
		ORDER BY country, date ;

-- M4: Top 5 Days with Highest New Cases for Each Country 
WITH ranked_days AS (
SELECT 
	country,
	date,
	new_cases,
	ROW_NUMBER() OVER (PARTITION BY country ORDER BY new_cases DESC) AS 
	rank
	FROM covid_data
	WHERE new_cases IS NOT NULL
)
SELECT country , date , new_cases
FROM ranked_days 
WHERE rank <= 5
ORDER BY country, rank;


-- M5: Percentage Change in New Cases (LAG)
-- Calculating the percentage change in new cases compared to the previous day for each country.
SELECT 
    country, 
    date, 
    new_cases,
    LAG(new_cases) OVER (PARTITION BY country ORDER BY date) AS prev_day_cases,
    (new_cases - LAG(new_cases) OVER (PARTITION BY country ORDER BY date)) * 100.0 / NULLIF(LAG(new_cases) OVER (PARTITION BY country ORDER BY date), 0) AS pct_change
FROM covid_data
ORDER BY country, date;


-- M6: Countries with the Highest Testing Rates Relative to Cases 
SELECT country , 
		AVG(tests_per_case) AS avg_tests_per_case
FROM covid_data 
WHERE tests_per_case IS NOT NULL
GROUP BY country 
HAVING AVG(tests_per_case) > (SELECT AVG(tests_per_case) FROM covid_data WHERE tests_per_case IS NOT NULL)
ORDER BY avg_tests_per_case DESC;


-- M7: Weekly Trends in Hospital Admissions
SELECT 
	DATE_TRUNC('week',date) AS week_start , 
	SUM(weekly_hosp_admissions) AS total_weekly_admissions
	FROM covid_data
	GROUP BY DATE_TRUNC('week', date)
	ORDER BY WEEK_START;


-- M8: Countries with the Highest Excess Mortality
-- Identifying countries with the highest cumulative excess mortality relative to their population.

WITH excess_mortality AS (
SELECT country ,
MAX(excess_mortality_cumulative_per_million) AS max_excess_mortality
FROM covid_data
GROUP BY country
)
SELECT country , max_excess_mortality 
FROM excess_mortality
ORDER BY max_excess_mortality 
LIMIT 200;

--now solving more advanced or hard problems 
-- H1 Moving Average of Deaths with a 14-Day Lag
--Calculating the 7-day moving average of deaths with a 14-day lag to analyze delayed reporting effects.

WITH moving_avg_deaths AS (
    SELECT 
        country, 
        date, 
        new_deaths,
        AVG(new_deaths) OVER (PARTITION BY country ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_deaths
    FROM covid_data
)
SELECT 
    country, 
    date, 
    new_deaths,
    moving_avg_deaths,
    LAG(moving_avg_deaths, 14) OVER (PARTITION BY country ORDER BY date) AS moving_avg_deaths_lagged_14_days
FROM moving_avg_deaths
ORDER BY country, date;


-- H2: Vaccination Progress Compared to global average
WITH country_vaccination AS (
    SELECT 
        country, 
        MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage
    FROM covid_data
    GROUP BY country
)
SELECT 
    cv.country, 
    cv.vaccination_coverage,
    (SELECT AVG(vaccination_coverage) FROM country_vaccination) AS global_avg_vaccination
FROM country_vaccination cv
ORDER BY cv.vaccination_coverage DESC;

-- H3: Days with the Highest Stringency Index and Their Impact on Cases
WITH max_stringency AS (
    SELECT 
        country, 
        date, 
        stringency_index,
        new_cases,
        RANK() OVER (PARTITION BY country ORDER BY stringency_index DESC) AS rank
    FROM covid_data
    WHERE stringency_index IS NOT NULL
)
SELECT country, date, stringency_index, new_cases
FROM max_stringency
WHERE rank = 1
ORDER BY country;

--H4: Countries with the Highest ICU Burden Relative to Hospital Beds
SELECT country , 
MAX(icu_patients_per_million) / NULLIF(MAX(hospital_beds_per_thousand),0) AS icu_burden
FROM covid_data
GROUP BY country 
ORDER BY icu_burden 
LIMIT 200;


-- H5: Cumulative Vaccinations vs. Cumulative Cases
SELECT 
    country, 
    date, 
    SUM(new_vaccinations) OVER (PARTITION BY country ORDER BY date) AS cumulative_vaccinations,
    SUM(new_cases) OVER (PARTITION BY country ORDER BY date) AS cumulative_cases
FROM covid_data
ORDER BY country, date;

-- H6 : Countries with the Most Consistent Testing Rates 
SELECT country , STDDEV(tests_per_case) AS testing_consistency
FROM covid_data
WHERE tests_per_case IS NOT NULL
GROUP BY country 
ORDER BY testing_consistency 
LIMIT 100;

-- H7: Impact of GDP on Vaccination Progress

SELECT 
    country, 
    gdp_per_capita, 
    MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
    CORR(gdp_per_capita, people_fully_vaccinated_per_hundred) AS correlation
FROM covid_data
GROUP BY country, gdp_per_capita
ORDER BY correlation DESC;

