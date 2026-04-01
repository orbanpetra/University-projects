DROP TABLE IF EXISTS happiness_report;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS year;


-- Create country table:
CREATE TABLE country (
    country_name TEXT PRIMARY KEY,
    region_name TEXT
);

-- Create year table:
CREATE TABLE year (
    year INT PRIMARY KEY
);

-- Create happiness report table:  
CREATE TABLE happiness_report (  
    ranking INT,  
    country_name TEXT NOT NULL,    
    happiness_score NUMERIC,  
    gdp_per_capita NUMERIC,  
    social_support NUMERIC,  
    healthy_life_expectancy NUMERIC,  
    freedom_to_make_life_choices NUMERIC,  
    generosity NUMERIC,  
    perceptions_of_corruption NUMERIC,  
    year INT NOT NULL, 

	PRIMARY KEY (country_name, year),

    FOREIGN KEY (country_name) REFERENCES country(country_name),
    FOREIGN KEY (year) REFERENCES year(year)
);  

-- Create temporary table for import:   
CREATE TEMP TABLE temp_happiness_report_raw (  
    ranking TEXT,  
    country_name TEXT, 
	region_name TEXT,
    happiness_score TEXT,  
    gdp_per_capita TEXT,  
    social_support TEXT,  
    healthy_life_expectancy TEXT,  
    freedom_to_make_life_choices TEXT,  
    generosity TEXT,  
    perceptions_of_corruption TEXT,  
    year TEXT  
);  
  
-- Data import into the temporary table:   
COPY temp_happiness_report_raw(  
    ranking,  
    country_name,  
    region_name,  
    happiness_score,  
    gdp_per_capita,  
    social_support,  
    healthy_life_expectancy,  
    freedom_to_make_life_choices,  
    generosity,  
    perceptions_of_corruption,
    year  
)  
FROM '/Users/Shared/WorldHappiness/world_happiness_combined.csv' CSV HEADER DELIMITER ';';  
  
-- Convert and insert data into the table:
INSERT INTO country (country_name, region_name)
SELECT DISTINCT
    country_name,
    MIN(region_name) --takes concistente region
FROM temp_happiness_report_raw
WHERE country_name IS NOT NULL
GROUP BY country_name;

INSERT INTO year (year)
SELECT DISTINCT
    year::INT
FROM temp_happiness_report_raw
WHERE year IS NOT NULL;

INSERT INTO happiness_report (  
    ranking,  
    country_name,   
    happiness_score,  
    gdp_per_capita,  
    social_support,  
    healthy_life_expectancy,  
    freedom_to_make_life_choices,  
    generosity,  
    perceptions_of_corruption,      
	year  
)  

SELECT  
    ranking::INT,  
    country_name,  
    REPLACE(happiness_score, ',', '.')::NUMERIC,  
    REPLACE(gdp_per_capita, ',', '.')::NUMERIC,  
    REPLACE(social_support, ',', '.')::NUMERIC,  
    REPLACE(healthy_life_expectancy, ',', '.')::NUMERIC,  
    REPLACE(freedom_to_make_life_choices, ',', '.')::NUMERIC,  
    REPLACE(generosity, ',', '.')::NUMERIC,  
    REPLACE(perceptions_of_corruption, ',', '.')::NUMERIC,  
    year::INT  
FROM temp_happiness_report_raw;  
  
-- Delete temporary table:  
DROP TABLE temp_happiness_report_raw;  
