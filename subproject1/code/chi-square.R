pacman::p_load(
  ggplot2
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
  output <- c(names(data_ctg)[i], chisq_result$statistic, chisq_result$parameter, chisq_result$p.value)
  sum_table <- rbind(sum_table, output)
} # for loop that conducts Chi-square tests 

colnames(sum_table) <- c("Variable", "Chi-square", "df", "p-value") # add dataframe column names

saveRDS(
  sum_table,
  file = here::here("subproject1/output/chi-square/table.rds")
) # save Chi-square test output table to designated location

for (i in 1:(ncol(data_ctg)-1)) {
  barchart <- ggplot(data_ctg, aes(x = data_ctg[[i]], fill = ICU)) + 
    geom_bar( position = "dodge") +
    xlab(names(data_ctg)[i]) +
    ylab("Count")
  barchart_name <- paste0("barchart_", names(data_ctg)[i], ".png")
  ggsave(
    plot = barchart,
    device = "png",
    file.path(here::here("subproject1/output/chi-square",barchart_name)),
    width=10,
    height=6
  )
} # for loop that creates bar chart for each pair of variables and saves to designated location


