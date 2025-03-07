CREATE TABLE IF NOT EXISTS covid_data (
    country VARCHAR(100),
    date DATE,
    total_cases INT,
    new_cases INT,
    new_cases_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths INT,
    new_deaths INT,
    new_deaths_smoothed FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    excess_mortality FLOAT,
    excess_mortality_cumulative FLOAT,
    excess_mortality_cumulative_absolute FLOAT,
    excess_mortality_cumulative_per_million FLOAT,
    hosp_patients INT,
    hosp_patients_per_million FLOAT,
    weekly_hosp_admissions INT,
    weekly_hosp_admissions_per_million FLOAT,
    icu_patients INT,
    icu_patients_per_million FLOAT,
    weekly_icu_admissions INT,
    weekly_icu_admissions_per_million FLOAT,
    stringency_index FLOAT,
    reproduction_rate FLOAT,
    total_tests BIGINT,
    new_tests INT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed INT,
    new_tests_smoothed_per_thousand FLOAT,
    positive_rate FLOAT,
    tests_per_case FLOAT,
    total_vaccinations BIGINT,
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    total_boosters BIGINT,
    new_vaccinations INT,
    new_vaccinations_smoothed INT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    total_boosters_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,
    new_people_vaccinated_smoothed INT,
    new_people_vaccinated_smoothed_per_hundred FLOAT,
    code VARCHAR(10),
    continent VARCHAR(50),
    population BIGINT,
    population_density FLOAT,
    median_age FLOAT,
    life_expectancy FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    diabetes_prevalence FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    human_development_index FLOAT
);


ALTER TABLE covid_data ALTER COLUMN total_vaccinations TYPE FLOAT USING total_vaccinations::FLOAT;

ALTER TABLE covid_data ALTER COLUMN people_vaccinated TYPE NUMERIC USING people_vaccinated::NUMERIC;

ALTER TABLE covid_data ALTER COLUMN new_vaccinations_smoothed TYPE NUMERIC USING new_vaccinations_smoothed::NUMERIC;

ALTER TABLE covid_data 
ALTER COLUMN new_people_vaccinated_smoothed TYPE NUMERIC USING new_people_vaccinated_smoothed::NUMERIC;

ALTER TABLE covid_data 
ALTER COLUMN people_fully_vaccinated TYPE NUMERIC USING people_fully_vaccinated::NUMERIC;

ALTER TABLE covid_data 
ALTER COLUMN new_vaccinations TYPE NUMERIC USING new_vaccinations::NUMERIC,
ALTER COLUMN people_fully_vaccinated TYPE NUMERIC USING people_fully_vaccinated::NUMERIC,
ALTER COLUMN new_vaccinations_smoothed TYPE NUMERIC USING new_vaccinations_smoothed::NUMERIC,
ALTER COLUMN new_people_vaccinated_smoothed TYPE NUMERIC USING new_people_vaccinated_smoothed::NUMERIC;




COPY covid_data FROM '/Users/horizons/Desktop/SQL_Projects/COVID-19_DATA_ANALYSIS_SQL/compact.csv' 
DELIMITER ',' 
CSV HEADER 
QUOTE '"' 
ESCAPE '"' 
NULL '';


select * from covid_data limit 10;
