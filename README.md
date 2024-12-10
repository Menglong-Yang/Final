# Final Project: Analysis of Diabetic Patient Data

## Data

This project uses the **Diabetes 130-US hospitals for years 1999-2008 Data Set**. This dataset contains patient data from 130 hospitals across the United States, focusing on diabetes-related hospitalizations. The data includes information on patient demographics, medical conditions, treatments, and outcomes. The `data/` folder contains the raw dataset used for analysis.

## Code Structure

### `code/00_clean_data.R`

-   Reads in the raw dataset
-   Creates an `age_numeric` variable that converts age ranges in the `age` column to approximate numeric midpoint values
-   Saves dataset with `age_numeric` variable as `dat_clean.rds` in `output/` folder

### `code/01_make_table.R`

-   Creates `table1` summary table with descriptive statistics on age, length of stay, medications, procedures, gender, and race
-   Saves `table1` as `table1.rds` in `output/` folder

### `code/02_make_boxplot.R`

-   Creates a box plot visualizing the distribution of hospital length of stay across age groups
-   Saves the figure as `boxplot.png` in `output/` folder

### `code/03_render_report.R`

-   Renders the report

### `report.Rmd`

-   Produces a descriptive table
-   Produces a box plot

## Synchronize Package Repository

This project uses **renv** to manage R package dependencies.  
Run the following command in your terminal to install all the required R packages specified in the file **renv.lock**.

The **Makefile**, **report.Rmd**, and HTML report will be in the root directory of the project. The Rmarkdown will contain the tables and figures produced in the analysis.

## Docker Setup

- To build the Docker image, use **make docker-build**.
- To generate the report and retrieve the output, use **make docker-run**.
