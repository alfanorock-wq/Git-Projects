--===============================================================
--CREATE TABLE RAW MOVIES
--===============================================================
CREATE OR REPLACE external TABLE `netflix-database-pipeline.netflix_raw.raw_movies` ( movieid string, title string, genres string ) 
    options ( 
        format = 'CSV', 
        uris = ['gs://netflix-database/bronze/movies.csv'], 
        skip_leading_rows = 1, 
        allow_quoted_newlines = TRUE, 
        allow_jagged_rows = TRUE 
    );

--===============================================================
--CREATE TABLE RAW USER RATING HISTORY
--===============================================================
CREATE OR REPLACE EXTERNAL TABLE `netflix-database-pipeline.netflix_raw.raw_user_rating_history` (
    userId STRING, 
    movieId STRING, 
    rating STRING, 
    timestamp STRING
    ) 
    OPTIONS (
        format = 'CSV',
        uris = ['gs://netflix-database/bronze/user_rating_history.csv'],
        skip_leading_rows = 1,
        allow_quoted_newlines = TRUE,
        allow_jagged_rows = TRUE
    );

--===============================================================
--CREATE TABLE RAW USER ADDITIONAL RATING
--===============================================================
CREATE OR REPLACE EXTERNAL TABLE `netflix-database-pipeline.netflix_raw.raw_user_additional_rating` (
    userId STRING, 
    movieId STRING, 
    rating STRING, 
    timestamp STRING
    ) 
    OPTIONS (
        format = 'CSV',
        uris = ['gs://netflix-database/bronze/user_additional_rating.csv'],
        skip_leading_rows = 1,
        allow_quoted_newlines = TRUE,
        allow_jagged_rows = TRUE
    );

--===============================================================
--CREATE TABLE RAW BELIEF DATA
--===============================================================
CREATE OR REPLACE EXTERNAL TABLE `netflix-database-pipeline.netflix_raw.raw_belief_data` (
    userId STRING, 
    movieId STRING, 
    isSeen STRING, 
    watchDate STRING, 
    userElicitRating STRING, 
    userPredictRating STRING, 
    userCertainty STRING, 
    tstamp STRING, 
    month_idx STRING, 
    source STRING, 
    systemPredictRating STRING
    ) 
    OPTIONS (
        format = 'CSV',
        uris = ['gs://netflix-database/bronze/belief_data.csv'],
        skip_leading_rows = 1,
        allow_quoted_newlines = TRUE,
        allow_jagged_rows = TRUE
    );

--===============================================================
--CREATE TABLE RAW MOVIE ELICITATION SET
--===============================================================
CREATE OR REPLACE EXTERNAL TABLE `netflix-database-pipeline.netflix_raw.raw_movie_elicitation_set` (
    movieId STRING, 
    month_idx STRING, 
    source STRING, 
    tstamp STRING
    ) 
    OPTIONS (
        format = 'CSV',
        uris = ['gs://netflix-database/bronze/movie_elicitation_set.csv'],
        skip_leading_rows = 1,
        allow_quoted_newlines = TRUE,
        allow_jagged_rows = TRUE
    );

--===============================================================
--CREATE TABLE RAW USER RECOMMENDATION HISTORY
--===============================================================
CREATE OR REPLACE EXTERNAL TABLE `netflix-database-pipeline.netflix_raw.raw_user_recommendation_history` (
    userId STRING, 
    tstamp STRING, 
    movieId STRING, 
    predictedRating STRING
    ) 
    OPTIONS (
        format = 'CSV',
        uris = ['gs://netflix-database/bronze/user_recommendation_history.csv'],
        skip_leading_rows = 1,
        allow_quoted_newlines = TRUE,
        allow_jagged_rows = TRUE
    );