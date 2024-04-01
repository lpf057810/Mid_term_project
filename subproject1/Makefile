report.html: render_report.R report.Rmd 
	Rscript render_report.R
	
subproject1/output/chi-square/table.rds: subproject1/code/chi-square.R data/data_clean.rds
	Rscript subproject1/code/chi-square.R

subproject1/output/chi-square/combined_barcharts.png: subproject1/code/chi-square.R data/data_clean.rds
	Rscript subproject1/code/chi-square.R
	
subproject1/output/descriptive_output/table_one.rds: subproject1/code/descriptive_analysis.R data/data_clean.rds
	Rscript subproject1/code/descriptive_analysis.R

subproject1/output/descriptive_output/bar_plot.png: subproject1/code/descriptive_analysis.R data/data_clean.rds
	Rscript subproject1/code/descriptive_analysis.R