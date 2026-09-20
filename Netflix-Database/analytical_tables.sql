--===============================================================
--CREATE TABLE DIM MOVIES
--===============================================================
CREATE OR REPLACE TABLE `netflix-database-pipeline.netflix_analytical.dim_movies` AS
SELECT 
    SAFE_CAST(movieID AS INT64) AS movie_id, 
    title, 
    genres, 
    SAFE_CAST(REGEXP_EXTRACT(title, r'\\((\d{4})\\)') AS INT64) AS release_year 
FROM `netflix-database-pipeline.netflix_raw.raw_movies`;

--===============================================================
--CREATE TABLE FACT RATINGS
--===============================================================
CREATE OR REPLACE TABLE `netflix-database-pipeline.netflix_analytical.fact_ratings` AS
WITH all_ratings AS (
    SELECT userId, movieId, rating, timestamp, 'history' as source 
    FROM `netflix-database-pipeline.netflix_raw.raw_user_rating_history`
    UNION ALL
    SELECT userId, movieId, rating, timestamp, 'additional' as source 
    FROM `netflix-database-pipeline.netflix_raw.raw_user_additional_rating`
)

--===============================================================
--CREATE TABLE FACT RATINGS
--===============================================================
CREATE OR REPLACE TABLE `netflix-database-pipeline.netflix_analytical.fact_ratings` AS
WITH all_ratings AS (
    SELECT userId, movieId, rating, timestamp, 'history' as source 
    FROM `netflix-database-pipeline.netflix_raw.raw_user_rating_history`
    UNION ALL
    SELECT userId, movieId, rating, timestamp, 'additional' as source 
    FROM `netflix-database-pipeline.netflix_raw.raw_user_additional_rating`
)
SELECT 
    SAFE_CAST(userId AS INT64) AS user_id, 
    SAFE_CAST(movieId AS INT64) AS movie_id, 
    SAFE_CAST(NULLIF(rating, 'NA') AS FLOAT64) AS rating,
    TIMESTAMP_SECONDS(SAFE_CAST(timestamp AS INT64)) AS rating_ts,
    source 
FROM all_ratings 
WHERE userId IS NOT NULL 
    AND movieId IS NOT NULL 
    AND rating <> 'NA';