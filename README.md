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
1. Make sure you have installed the `renv` package (`install.packages("renv")`)
2. Use `make install` under the main folder to synchroniz packages
3. Use `make` under the main folder to get  the dynamic report
4. If you want to see different parts analysis, please change the `params` in yaml title by switching the value from `Subproject1` to `Subproject2` or change the plaha level.
5. Use `make` under the main folder to produce the report again.
   



