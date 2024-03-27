here::i_am(
  "subproject1/code/descriptive_analysis.R"
)
#Please fill this section with data cleaning 
library(dplyr)
library(tidyr)
library(ggplot2)

# Create the contingency table
table_one <- data_clean %>%
  select(SEX, PNEUMONIA, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION,
         CARDIOVASCULAR, RENAL_CHRONIC, OTHER_DISEASE, OBESITY) %>%
  pivot_longer(cols = -SEX, names_to = "Disease", values_to = "Present") %>%
  group_by(SEX, Disease, Present) %>%
  summarise(Count = n()) %>%
  ungroup()

saveRDS(
  table_one,
  file = here::here("subproject1/output/descriptive_output", "table_one.rds")
)

#Contingency Table 2
icu_gender <- table(data_clean$CLASSIFIED, data_clean$SEX)
saveRDS(
  icu_gender,
  file = here::here("subproject1/output/descriptive_output", "icu_gender.rds")
)

# Create the bar plot and save it 
ggsave(
  plot = ggplot(table_one, aes(x = Disease, y = Count, fill = SEX)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = "Disease", y = "Count", fill = "Gender") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)),
  device = "png",
  file.path(here::here("subproject1/output/descriptive_output", "bar_plot.png")),
  width = 10,
  height = 6
)




saveRDS(
  table_one,
  file = here::here("subproject1/output/descriptive_output/table_one.rds")
)

ggsave(
  plot = scatterplot,
  device = "png",
  file.path(here::here("subproject1/output/descriptive_output/scatterplot.png")),
  width=10,
  height=6
)

# If you have multiply outputs, feel free to change the `save` function