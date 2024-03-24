combined_report.html: render_combined_report.R \
  combined_report.Rmd subproject1/report.Rmd subproject2/report.Rmd
	Rscript render_combined_report.R

subproject1/output/table_one.rds: subproject1/code/01_make_table1.R data/data_clean.rds
	Rscript subproject1/code/01_make_table1.R

subproject1/output/scatterplot.png: subproject1/code/02_make_scatter.R data/data_clean.rds
	Rscript subproject1/code/02_make_scatter.R

subproject2/output/both_regression_tables.rds: subproject2/code/01_models.R data/data_clean.rds
	Rscript subproject2/code/01_models.R