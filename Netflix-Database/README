# Netflix Data Pipeline: End-to-End Engineering on GCP

This project demonstrates a complete data engineering and analytics pipeline, moving from raw data ingestion to the creation of business intelligence dashboards[1][2]. It utilizes **Google Cloud Platform (GCP)** for infrastructure and **Docker** to orchestrate the visualization environment.

## 📊 Dataset Information

The project uses the **MovieLens ml\_belief\_2024** dataset provided by GroupLens Research[4]. It contains six CSV files encompassing movie metadata, user ratings, and recommendation histories.

* **Download the data here**: [MovieLens ml\_belief\_2024 Dataset](https://www.google.com/url?sa=E&amp;q=https%3A%2F%2Fgrouplens.org%2Fdatasets%2Fmovielens%2Fml%5Fbelief%5F2024%2F)

## 🚀 Architecture &amp; Workflow

The data pipeline follows a structured path through the **Land Zone** (Bronze/Raw) and **Analytical** (Gold) layers:

1. **Ingestion (GCS)**: Raw CSV files are uploaded to a **Google Cloud Storage** bucket, specifically within a folder named `bronze`.
2. **Raw Layer (BigQuery)**: **External Tables** are created to query the data directly from GCS without moving it into BigQuery, maintaining the data in its original "raw" format.
3. **Analytical Layer (BigQuery)**:
  * **Dimensional Modeling**: Data is transformed into **Fact and Dimension tables** (Star Schema) to optimize analytical queries.
  * **Data Cleaning**: Commands like `SAFE_CAST` are used for data typing, and `REGEXP_EXTRACT` is applied to pull release years from movie titles.
  * **Normalization**: The `UNNEST` and `SPLIT` functions are used to "explode" pipe-separated movie genres into individual rows for detailed analysis.
4. **Visualization (Docker &amp; Metabase)**:
  * **Metabase** is run via a **Docker** container, ensuring an isolated and reproducible environment without the need for manual dependency installation.
  * The connection to BigQuery is secured using a **Service Account** with specific IAM roles (BigQuery Job User and Data Viewer).

## 🛠️ Tech Stack

* **Cloud Platform**: Google Cloud Platform (GCP).
* **Storage**: Google Cloud Storage (GCS).
* **Data Warehouse**: BigQuery.
* **Containerization**: Docker.
* **Visualization**: Metabase.
* **Language**: SQL (Standard SQL).

## 📁 Repository Structure

* `raw_tables.sql`: DDL for external tables in the `netflix_raw` dataset.
* `analytical_tables.sql`: Script for Fact (`fact_ratings`) and Dimension (`dim_movies`) table creation.
* `views.sql`: Logic for analytical views, including user activity, KPIs, and genre performance.

## 📈 Dashboard Insights

The final dashboard includes several key visualizations:

* **Heatmap**: Showing the evolution of ratings over months and years.
* **Scatter Plots**: Correlating **Popularity vs. Quality** for both movies and genres.
* **Top 10 Rankings**: Identifying the best-rated movies with a minimum threshold of 20 reviews to ensure statistical relevance.

## 🛑 Project Cleanup (FinOps)

Following cloud best practices, all resources (BigQuery datasets, GCS buckets, and GCP projects) were deleted, and Docker containers were stopped upon project completion to prevent unnecessary costs.