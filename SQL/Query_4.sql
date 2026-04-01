SELECT
    year,
    happiness_score,
    social_support
FROM happiness_report
WHERE country_name = 'Austria'
  AND happiness_score IS NOT NULL
  AND social_support IS NOT NULL
ORDER BY year;
