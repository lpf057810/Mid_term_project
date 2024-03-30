pacman::p_load(
  knitr, ggplot2, patchwork
) # This code can check whether you have the desired package and load the package after installing.

here::i_am(
  "subproject1/code/chi-square.R"
)

data_clean <- readRDS(
  here::here("data/data_clean.rds") 
) # read the cleaned data

data_ctg <- subset(data_clean, 
                   select = c(PNEUMONIA, COPD, DIABETES, CARDIOVASCULAR, RENAL_CHRONIC, ICU)
                   ) # keep only the wanted categorical variables

sum_table <- data.frame(matrix(ncol = 4, nrow = 0)) # empty dataframe to store Chi-square test outputs

for (i in 1:(ncol(data_ctg)-1)) {
  chisq_result <- chisq.test(data_ctg$ICU, data_ctg[[i]])
  output <- c(names(data_ctg)[i], round(chisq_result$statistic, 4), chisq_result$parameter, round(chisq_result$p.value, 4))
  sum_table <- rbind(sum_table, output)
} # for loop that conducts Chi-square tests 

colnames(sum_table) <- c("Variable", "Chi-square", "df", "p-value") # add dataframe column names

chisq_table <- kable(sum_table, caption = "Table. Chi-square Test Results" )

saveRDS(
  chisq_table,
  file = here::here("subproject1/output/chi-square/table.rds")
) # save Chi-square test output table to designated location

####################

barcharts <- list()

for (i in 1:(ncol(data_ctg)-1)) {
  variable_name <- names(data_ctg)[i]
  barchart <- ggplot(data_ctg, aes_string(x = variable_name, fill = 'ICU')) + 
    geom_bar(position = "dodge") +
    geom_text(stat='count', aes(label=..count..), vjust=-0.5, position=position_dodge(width=0.9)) +
    xlab(variable_name) +
    ylab("Count") +
    ylim(0,4500) +
    labs(title = paste0("Bar Chart for ", variable_name)) +
    theme(plot.title = element_text(hjust = 0.5), 
          plot.margin = margin(6, 6, 6, 6))  
  
  
  barcharts[[i]] <- barchart
}

design <- "#AABB#
           CCDDEE"
layout <- barcharts[[1]] + barcharts[[2]] + barcharts[[3]] + barcharts[[4]] + barcharts[[5]] +
  plot_layout(design = design)

ggsave(
  plot = layout,
  file.path(here::here("subproject1/output/chi-square", "combined_barcharts.png")),
  width = 20,
  height = 15,  
  device = "png"
)