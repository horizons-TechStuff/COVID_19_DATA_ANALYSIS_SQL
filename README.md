


---

# COVID-19 Data Analysis Project

This project is a comprehensive analysis of COVID-19 data using SQL. It includes **35 tasks** that cover various aspects of the pandemic, such as case trends, vaccination progress, mortality rates, and the impact of government policies. Below is a detailed explanation of each task and its corresponding SQL query.

---

## **Tasks and Queries**

### **Main Tasks (1-20)**

#### **TASK 1: Total COVID Cases & Deaths per Country**
**Objective**: Calculate the total number of COVID-19 cases and deaths for each country.

**Query**:
```sql
SELECT country, 
       MAX(total_cases) AS total_cases, 
       MAX(total_deaths) AS total_deaths
FROM covid_data
GROUP BY country
ORDER BY total_cases DESC;
```

---

#### **TASK 2: Daily New Cases Trend Over Time (Global)**
**Objective**: Analyze the global trend of daily new COVID-19 cases over time.

**Query**:
```sql
SELECT date, SUM(new_cases) AS total_new_cases
FROM covid_data
WHERE new_cases IS NOT NULL
GROUP BY date
ORDER BY date;
```

---

#### **TASK 3: Highest Daily Cases in a Country**
**Objective**: Identify the days with the highest number of new cases in each country.

**Query**:
```sql
SELECT country, date, new_cases
FROM covid_data 
WHERE new_cases IS NOT NULL
ORDER BY new_cases DESC
LIMIT 200;
```

---

#### **TASK 4: Top 10 Countries by Vaccination Progress**
**Objective**: Identify the top 10 countries with the highest vaccination progress.

**Query**:
```sql
SELECT country, 
       MAX(people_vaccinated) AS total_vaccinated, 
       MAX(total_vaccinations) AS total_doses
FROM covid_data
WHERE people_vaccinated IS NOT NULL
GROUP BY country
ORDER BY total_vaccinated DESC
LIMIT 10;
```

---

#### **TASK 5: Vaccination Rate Over Time (Global)**
**Objective**: Analyze the global trend of daily vaccinations over time.

**Query**:
```sql
SELECT date, SUM(new_vaccinations) AS daily_vaccinations
FROM covid_data
WHERE new_vaccinations IS NOT NULL
GROUP BY date
ORDER BY date;
```

---

#### **TASK 6: Mortality Rate (Deaths / Cases) per Country**
**Objective**: Calculate the mortality rate (deaths per cases) for each country.

**Query**:
```sql
SELECT country,
       MAX(total_cases) AS total_cases,
       MAX(total_deaths) AS total_deaths,
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country
ORDER BY mortality_rate DESC;
```

---

#### **TASK 7: Stringency Index vs. Cases (Did Lockdowns Help?)**
**Objective**: Analyze the relationship between the stringency index and new cases in India.

**Query**:
```sql
SELECT country, date, stringency_index, new_cases
FROM covid_data 
WHERE stringency_index IS NOT NULL AND country = 'India'
ORDER BY country, date;
```

---

#### **TASK 8: Case Fatality Rate Over Time (Global, Monthly)**
**Objective**: Calculate the global case fatality rate on a monthly basis.

**Query**:
```sql
SELECT TO_CHAR(date, 'YYYY_MM') AS month, 
       SUM(total_deaths) * 100.0 / NULLIF(SUM(total_cases), 0) AS global_case_fatality_rate
FROM covid_data
GROUP BY TO_CHAR(date, 'YYYY_MM')
ORDER BY month;
```

---

#### **TASK 9: Countries with the Highest Hospitalization Rates**
**Objective**: Identify countries with the highest hospitalization rates per million people.

**Query**:
```sql
SELECT country, 
       MAX(hosp_patients_per_million) AS max_hospitalization_rate
FROM covid_data
WHERE hosp_patients_per_million IS NOT NULL
GROUP BY country 
ORDER BY max_hospitalization_rate DESC
LIMIT 100;
```

---

#### **TASK 10: ICU Admissions vs. Total Cases**
**Objective**: Analyze the relationship between ICU admissions and total cases.

**Query**:
```sql
SELECT country, 
       MAX(total_cases) AS total_cases,
       MAX(icu_patients) AS total_icu_patients,
       (MAX(icu_patients) * 100.0 / NULLIF(MAX(total_cases), 0)) AS icu_admission_rate
FROM covid_data
GROUP BY country
ORDER BY icu_admission_rate ASC;
```

---

#### **TASK 11: Excess Mortality Analysis**
**Objective**: Analyze the discrepancy between reported deaths and excess mortality.

**Query**:
```sql
SELECT country, 
       MAX(total_deaths) AS reported_deaths,
       MAX(excess_mortality_cumulative_absolute) AS excess_deaths,
       (MAX(excess_mortality_cumulative_absolute) - MAX(total_deaths)) AS discrepancy
FROM covid_data
GROUP BY country 
ORDER BY discrepancy ASC;
```

---

#### **TASK 12: Vaccination Coverage vs. New Cases**
**Objective**: Analyze the correlation between vaccination coverage and new cases.

**Query**:
```sql
SELECT country, 
       MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
       AVG(new_cases_per_million) AS avg_new_cases_per_million
FROM covid_data
GROUP BY country 
ORDER BY vaccination_coverage ASC;
```

---

#### **TASK 13: Testing Rates vs. Positive Cases**
**Objective**: Analyze the relationship between testing rates and positive cases.

**Query**:
```sql
SELECT country, 
       MAX(total_tests_per_thousand) AS tests_per_thousand,
       MAX(positive_rate) AS positive_rate
FROM covid_data
GROUP BY country 
ORDER BY tests_per_thousand;
```

---

#### **TASK 14: Impact of Median Age on Mortality Rate**
**Objective**: Analyze the impact of median age on the mortality rate.

**Query**:
```sql
SELECT country, 
       median_age, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data 
GROUP BY country, median_age
ORDER BY mortality_rate;
```

---

#### **TASK 15: Weekly Hospital Admissions vs. Stringency Index**
**Objective**: Analyze the relationship between weekly hospital admissions and the stringency index.

**Query**:
```sql
SELECT country, 
       AVG(stringency_index) AS avg_stringency_index,
       AVG(weekly_hosp_admissions_per_million) AS avg_weekly_hosp_admissions
FROM covid_data 
GROUP BY country 
ORDER BY avg_stringency_index;
```

---

#### **TASK 16: Booster Doses vs. New Cases**
**Objective**: Analyze the relationship between booster doses and new cases.

**Query**:
```sql
SELECT country, 
       MAX(total_boosters_per_hundred) AS booster_coverage,
       AVG(new_cases_per_million) AS avg_new_cases_per_million
FROM covid_data
GROUP BY country 
ORDER BY booster_coverage DESC;
```

---

#### **TASK 17: Life Expectancy vs. Mortality Rate**
**Objective**: Analyze the relationship between life expectancy and mortality rate.

**Query**:
```sql
SELECT country, 
       life_expectancy, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, life_expectancy
ORDER BY life_expectancy DESC;
```

---

#### **TASK 18: GDP per Capita vs. Vaccination Progress**
**Objective**: Analyze the relationship between GDP per capita and vaccination progress.

**Query**:
```sql
SELECT country,
       gdp_per_capita,
       MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage
FROM covid_data
GROUP BY country, gdp_per_capita 
ORDER BY gdp_per_capita DESC;
```

---

#### **TASK 19: Diabetes Prevalence vs. Mortality Rate**
**Objective**: Analyze the relationship between diabetes prevalence and mortality rate.

**Query**:
```sql
SELECT country, 
       diabetes_prevalence, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, diabetes_prevalence
ORDER BY diabetes_prevalence DESC;
```

---

#### **TASK 20: Hospital Beds per Thousand vs. Mortality Rate**
**Objective**: Analyze the relationship between hospital beds per thousand and mortality rate.

**Query**:
```sql
SELECT country, 
       hospital_beds_per_thousand, 
       (MAX(total_deaths) * 100.0 / NULLIF(MAX(total_cases), 0)) AS mortality_rate
FROM covid_data
GROUP BY country, hospital_beds_per_thousand
ORDER BY hospital_beds_per_thousand DESC;
```

---

### **Medium-Level Tasks (M1-M8)**

#### **M1: Rolling 7-Day Average of New Cases**
**Objective**: Calculate the rolling 7-day average of new cases for each country.

**Query**:
```sql
SELECT country, 
       date,
       new_cases,
       AVG(new_cases) OVER (PARTITION BY country ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg_new_cases
FROM covid_data
ORDER BY country, date;
```

---

#### **M2: Rank Countries by Vaccination Progress**
**Objective**: Rank countries based on their vaccination progress.

**Query**:
```sql
SELECT country,
       MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
       RANK() OVER (ORDER BY MAX(people_fully_vaccinated_per_hundred) DESC) AS rank
FROM covid_data
WHERE people_fully_vaccinated_per_hundred IS NOT NULL
GROUP BY country 
ORDER BY rank;
```

---

#### **M3: Cumulative Vaccinations Over Time (India)**
**Objective**: Analyze the cumulative vaccinations over time in India.

**Query**:
```sql
SELECT country,
       date,
       new_vaccinations,
       SUM(new_vaccinations) OVER (PARTITION BY country ORDER BY date) AS cumulative_vaccinations
FROM covid_data
WHERE new_vaccinations IS NOT NULL AND country = 'India'
ORDER BY country, date;
```

---

#### **M4: Top 5 Days with Highest New Cases for Each Country**
**Objective**: Identify the top 5 days with the highest new cases for each country.

**Query**:
```sql
WITH ranked_days AS (
    SELECT country,
           date,
           new_cases,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY new_cases DESC) AS rank
    FROM covid_data
    WHERE new_cases IS NOT NULL
)
SELECT country, date, new_cases
FROM ranked_days 
WHERE rank <= 5
ORDER BY country, rank;
```

---

#### **M5: Percentage Change in New Cases (LAG)**
**Objective**: Calculate the percentage change in new cases compared to the previous day for each country.

**Query**:
```sql
SELECT country, 
       date, 
       new_cases,
       LAG(new_cases) OVER (PARTITION BY country ORDER BY date) AS prev_day_cases,
       (new_cases - LAG(new_cases) OVER (PARTITION BY country ORDER BY date)) * 100.0 / NULLIF(LAG(new_cases) OVER (PARTITION BY country ORDER BY date), 0) AS pct_change
FROM covid_data
ORDER BY country, date;
```

---

#### **M6: Countries with the Highest Testing Rates Relative to Cases**
**Objective**: Identify countries with the highest testing rates relative to cases.

**Query**:
```sql
SELECT country, 
       AVG(tests_per_case) AS avg_tests_per_case
FROM covid_data 
WHERE tests_per_case IS NOT NULL
GROUP BY country 
HAVING AVG(tests_per_case) > (SELECT AVG(tests_per_case) FROM covid_data WHERE tests_per_case IS NOT NULL)
ORDER BY avg_tests_per_case DESC;
```

---

#### **M7: Weekly Trends in Hospital Admissions**
**Objective**: Analyze the weekly trends in hospital admissions.

**Query**:
```sql
SELECT DATE_TRUNC('week', date) AS week_start, 
       SUM(weekly_hosp_admissions) AS total_weekly_admissions
FROM covid_data
GROUP BY DATE_TRUNC('week', date)
ORDER BY week_start;
```

---

#### **M8: Countries with the Highest Excess Mortality**
**Objective**: Identify countries with the highest cumulative excess mortality relative to their population.

**Query**:
```sql
WITH excess_mortality AS (
    SELECT country,
           MAX(excess_mortality_cumulative_per_million) AS max_excess_mortality
    FROM covid_data
    GROUP BY country
)
SELECT country, max_excess_mortality 
FROM excess_mortality
ORDER BY max_excess_mortality 
LIMIT 200;
```

---

### **Hard-Level Tasks (H1-H7)**

#### **H1: Moving Average of Deaths with a 14-Day Lag**
**Objective**: Calculate the 7-day moving average of deaths with a 14-day lag.

**Query**:
```sql
WITH moving_avg_deaths AS (
    SELECT country, 
           date, 
           new_deaths,
           AVG(new_deaths) OVER (PARTITION BY country ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_deaths
    FROM covid_data
)
SELECT country, 
       date, 
       new_deaths,
       moving_avg_deaths,
       LAG(moving_avg_deaths, 14) OVER (PARTITION BY country ORDER BY date) AS moving_avg_deaths_lagged_14_days
FROM moving_avg_deaths
ORDER BY country, date;
```

---

#### **H2: Vaccination Progress Compared to Global Average**
**Objective**: Compare each country's vaccination progress to the global average.

**Query**:
```sql
WITH country_vaccination AS (
    SELECT country, 
           MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage
    FROM covid_data
    GROUP BY country
)
SELECT country, 
       vaccination_coverage,
       (SELECT AVG(vaccination_coverage) FROM country_vaccination) AS global_avg_vaccination
FROM country_vaccination
ORDER BY vaccination_coverage DESC;
```

---

#### **H3: Days with the Highest Stringency Index and Their Impact on Cases**
**Objective**: Identify the days with the highest stringency index and analyze their impact on new cases.

**Query**:
```sql
WITH max_stringency AS (
    SELECT country, 
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
```

---

#### **H4: Countries with the Highest ICU Burden Relative to Hospital Beds**
**Objective**: Identify countries with the highest ICU burden relative to hospital beds.

**Query**:
```sql
SELECT country, 
       MAX(icu_patients_per_million) / NULLIF(MAX(hospital_beds_per_thousand), 0) AS icu_burden
FROM covid_data
GROUP BY country
ORDER BY icu_burden DESC
LIMIT 200;
```

---

#### **H5: Cumulative Vaccinations vs. Cumulative Cases**
**Objective**: Analyze the relationship between cumulative vaccinations and cumulative cases.

**Query**:
```sql
SELECT country, 
       date, 
       SUM(new_vaccinations) OVER (PARTITION BY country ORDER BY date) AS cumulative_vaccinations,
       SUM(new_cases) OVER (PARTITION BY country ORDER BY date) AS cumulative_cases
FROM covid_data
ORDER BY country, date;
```

---

#### **H6: Countries with the Most Consistent Testing Rates**
**Objective**: Identify countries with the most consistent testing rates.

**Query**:
```sql
SELECT country, 
       STDDEV(tests_per_case) AS testing_consistency
FROM covid_data
WHERE tests_per_case IS NOT NULL
GROUP BY country 
ORDER BY testing_consistency 
LIMIT 100;
```

---

#### **H7: Impact of GDP on Vaccination Progress**
**Objective**: Analyze the impact of GDP on vaccination progress.

**Query**:
```sql
SELECT country, 
       gdp_per_capita, 
       MAX(people_fully_vaccinated_per_hundred) AS vaccination_coverage,
       CORR(gdp_per_capita, people_fully_vaccinated_per_hundred) AS correlation
FROM covid_data
GROUP BY country, gdp_per_capita
ORDER BY correlation DESC;
```

---

