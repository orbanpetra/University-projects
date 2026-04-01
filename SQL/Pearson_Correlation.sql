SELECT
    corr(happiness_score, gdp_per_capita)                  AS gdp_corr,
    corr(happiness_score, social_support)                  AS social_support_corr,
    corr(happiness_score, healthy_life_expectancy)         AS life_expectancy_corr,
    corr(happiness_score, freedom_to_make_life_choices)    AS freedom_corr,
    corr(happiness_score, generosity)                      AS generosity_corr,
    corr(happiness_score, perceptions_of_corruption)       AS corruption_corr
FROM happiness_report;

SELECT
    corr(happiness_score, gdp_per_capita)                  AS gdp_corr,
    corr(happiness_score, social_support)                  AS social_support_corr,
    corr(happiness_score, healthy_life_expectancy)         AS life_expectancy_corr,
    corr(happiness_score, freedom_to_make_life_choices)    AS freedom_corr,
    corr(happiness_score, generosity)                      AS generosity_corr,
    corr(happiness_score, perceptions_of_corruption)       AS corruption_corr
FROM happiness_report
WHERE country_name = 'Austria';
