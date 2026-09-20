--===============================================================
--CREATE VIEW USER ACTIVITY
--===============================================================
CREATE OR REPLACE VIEW `netflix-database-pipeline.netflix_analytical.VW_user_activity` 
AS 
SELECT 
    user_id, 
    COUNT(*) AS total_ratings, 
    COUNT(DISTINCT movie_id) AS unique_movies_rated, 
    AVG(rating) AS avg_rating, 
    VAR_SAMP(rating) AS rating_variance, 
    MIN(rating_ts) AS first_activity, 
    MAX(rating_ts) AS last_activity 
FROM `netflix-database-pipeline.netflix_database-pipeline.netflix_analytical.fact_ratings` 
GROUP BY user_id;

--===============================================================
--CREATE VIEW MOVIES KPIs
--===============================================================
CREATE OR REPLACE VIEW `netflix-database-pipeline.netflix_analytical.Movies_KPIs` 
AS 
SELECT 
    f.movie_id, 
    d.title, 
    d.genres, 
    d.release_year, 
    COUNT(f.rating) AS total_ratings, 
    AVG(f.rating) AS average_rating, 
    STDDEV(f.rating) AS rating_stddev, 
    MIN(f.rating_ts) AS first_rating, 
    MAX(f.rating_ts) AS last_rating 
FROM `netflix-database-pipeline.netflix_analytical.fact_ratings` f 
LEFT JOIN `netflix-database-pipeline.netflix_analytical.dim_movies` d 
    ON f.movie_id = d.movie_id 
GROUP BY 1, 2, 3, 4;

--===============================================================
--CREATE VIEW TOP MOVIES
--===============================================================
CREATE OR REPLACE VIEW `netflix-database-pipeline.netflix_analytical.Top_Movies` 
AS 
SELECT 
    title, 
    average_rating, 
    total_ratings 
FROM `netflix-database-pipeline.netflix_analytical.Movies_KPIs` 
WHERE total_ratings >= 20 
ORDER BY average_rating DESC, total_ratings DESC 
LIMIT 10;

--===============================================================
--CREATE VIEW TOP MOVIES
--===============================================================
CREATE OR REPLACE VIEW `netflix-database-pipeline.netflix_analytical.Performance_by_Genre` 
AS
WITH genres_exploded 
AS ( 
    SELECT f.rating, genre 
    FROM `netflix-database-pipeline.netflix_analytical.fact_ratings` f 
    JOIN `netflix-database-pipeline.netflix_analytical.dim_movies` d 
        ON f.movie_id = d.movie_id, 
    UNNEST(SPLIT(d.genres, '|')) AS genre 
) 
SELECT 
    genre, 
    COUNT(*) AS total_ratings, 
    AVG(rating) AS avg_rating 
FROM genres_exploded 
WHERE genre NOT IN ('(no genres listed)', '') 
GROUP BY genre 
ORDER BY total_ratings DESC;

--===============================================================
--CREATE VIEW RATINGS EVOLUTION
--===============================================================
CREATE OR REPLACE VIEW `netflix-database-pipeline.netflix_analytical.VW_ratings_evolution` 
AS 
SELECT 
    EXTRACT(YEAR FROM rating_ts) AS year, 
    EXTRACT(MONTH FROM rating_ts) AS month_number, 
    FORMAT_TIMESTAMP('%b', rating_ts) AS month_name, 
    COUNT(*) AS total_ratings 
FROM `netflix-database-pipeline.netflix_analytical.fact_ratings` 
GROUP BY 1, 2, 3 
ORDER BY 1, 2;