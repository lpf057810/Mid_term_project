# Project description
The project aims to analyze Mexico's COVID-19 dataset to identify patterns, relationships, and impacts of the pandemic. The team will clean and preprocess the data, conduct statistical tests to explore associations between variables, and evaluate the performance of statistical models used in the analysis.

The process involves:
- **Data Pre-processing**: Cleaning and preparing the data for analysis.
- **Chi-square Analysis**: Testing the relationship between categorical variables.
- **Associations Analysis**: Using Logistic Regression to explore deeper associations in the data.
- **Model Evaluation**: Assessing the accuracy and effectiveness of our models.
- **Dynamic Report**: Compiling all findings into a comprehensive report, tailored to suit different audience needs.

 The goal is to provide insights into the COVID-19 impact in Mexico through detailed statistical analysis and modeling.

The Covid-19 report has been broken into two subprojects.

- `data/` contains the code, original file and output related to the project
    - `data/clean.R` produces the `data_clean.rds`
        - teammate can choose to use the original file or `data_clean.rds`
- `subproject1/` contains all code and output related to the descriptive analysis
	- `subproject1/code/descriptive_analysis.R` produces tables and plots
		- output should be saved to `subproject1/output/descriptive_output/`
	- `subproject1/code/chi-square.R` produces the chi-square results containing tables and plots
		- output should be saved to `subproject1/output/chi-square/`
	- `subproject1/report.Rmd` reads in output from `subproject1/output/` and creates the report for the descriptive
   analysis
        - `suproject1/render_report.R` renders the report for subproject1
        - `subproject1/Makefile` can help user produce the report for subproject1 using command line
- `subproject2/` contains all code and output related to the regression analysis and model evaluation
	- `subproject2/code/models.R` fits Multinominal Logistic Regression models
		- summary tables and plots should be saved to `subproject2/output/model/`
    - `subproject2/code/model_evaluation.R` evaluate the effectiveness of model
        - summary tables and plots should be saved to `subproject2/output/model_evaluation/`
	- `subproject2/report.Rmd` reads in output from `subproject2/output/` and creates the report for the regression analysis
        - `suproject2/render_report.R` renders the report for subproject2
        - `subproject2/Makefile` can help user produce the report for subproject2 using command line.
      
The subprojects are inserted into `dynamic_report.Rmd` dynamically. The user can change the `params` in yaml title by switching the value from `subproject1` to `subproject2` to show different parts of analysis.

# Produce report guildance:

1. Users are recommended to use `setwd()` to locate the `~Midterm_project` folder
2. Make sure you have installed the `renv` package (`install.packages("renv")`)
3. Use `source("renv/activate.R")` to check whether R packages have been installed
4. Use `renv::restore()` to install packages in the `renv.lock` file
5. Use `cd` go to `subproject1` and `subproject2` to generate reports for each subproject using `make` in the command line
6. Go back the main folder and use `make` to get the dynamic report.
7. If you want to see different parts analysis, please change the `params` in yaml title by switching the value from `subproject1` to `subproject2` and use `make` under the main folder to produce the report again
   



