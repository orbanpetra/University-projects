SELECT
    year,
    AVG(happiness_score) AS avg_happiness,
    AVG(social_support) AS avg_social_support,
    corr(happiness_score, social_support) AS corr
FROM happiness_report
WHERE happiness_score IS NOT NULL
  AND social_support IS NOT NULL
GROUP BY year
ORDER BY year;
