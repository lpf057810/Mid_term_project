report.html: render_report.R report.Rmd 
	Rscript render_report.R
	
subproject2/output/model/model_table.rds: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model/model_upsampled_table.rds: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model/stepwise_model_table.rds: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model/QQplot.png: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model/model_upsampled.png: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model/stepwise_model.png: subproject2/code/model.R data/data_clean.rds
	Rscript subproject2/code/model.R
	
subproject2/output/model_evaluation/ROC_Curve_Comparison.png: subproject2/code/model_evaluation.R data/data_clean.rds
	Rscript subproject2/code/model_evaluation.R
	
subproject2/output/model_evaluation/metrics_comparison_table.rds: subproject2/code/model_evaluation.R data/data_clean.rds
	Rscript subproject2/code/model_evaluation.R