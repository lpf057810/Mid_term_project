dynamic_report.html: render_dynamic_report.R dynamic_report.Rmd subproject1/report.html subproject2/report.html subproject1/output/**/*.rds subproject1/output/**/*.png subproject2/output/**/*.rds subproject2/output/**/*.png
	Rscript render_dynamic_report.R
	
subproject1/output/chi-square/table.rds subproject1/output/chi-square/combined_barcharts.png: subproject1/code/chi-square.R data/data_clean.rds
	Rscript subproject1/code/chi-square.R

subproject1/output/descriptive_output/table_one.rds subproject1/output/descriptive_output/bar_plot.png: subproject1/code/descriptive_analysis.R data/data_clean.rds
	Rscript subproject1/code/descriptive_analysis.R

subproject1/report.html: subproject1/report.Rmd subproject1/output/chi-square/table.rds subproject1/output/chi-square/combined_barcharts.png subproject1/output/descriptive_output/table_one.rds subproject1/output/descriptive_output/bar_plot.png
	Rscript -e "rmarkdown::render('subproject1/report.Rmd')"


subproject2/output/model/model_table.rds subproject2/output/model/model_upsampled_table.rds subproject2/output/model/stepwise_model_table.rds subproject2/output/model/QQplot.png subproject2/output/model/model_upsampled.png subproject2/output/model/stepwise_model.png: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R

subproject2/output/model_evaluation/ROC_Curve_Comparison.png subproject2/output/model_evaluation/metrics_comparison_table.rds: subproject2/code/model_evaluation.R data/data_clean.rds
	Rscript subproject2/code/model_evaluation.R

subproject2/report.html: subproject2/report.Rmd subproject2/output/model/model_table.rds subproject2/output/model/model_upsampled_table.rds subproject2/output/model/stepwise_model_table.rds subproject2/output/model/QQplot.png subproject2/output/model/model_upsampled.png subproject2/output/model/stepwise_model.png subproject2/output/model_evaluation/ROC_Curve_Comparison.png subproject2/output/model_evaluation/metrics_comparison_table.rds
	Rscript -e "rmarkdown::render('subproject2/report.Rmd')"

data/data_clean.rds: data/covid_sub.csv
	Rscript data/clean.R
	
.PHONY: clean
clean:
	rm -f dynamic_report.html subproject1/report.html subproject2/report.html subproject1/output/*/*.rds subproject1/output/*/*.png subproject2/output/*/*.rds subproject2/output/*/*.png data/data_clean.rds


.PHONY: install
install:
	Rscript -e "renv::restore(prompt= FALSE)"
