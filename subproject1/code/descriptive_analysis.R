here::i_am(
  "subproject1/code/descriptive_analysis.R"
)
#Please fill this section with data cleaning 
pacman::p_load(
  dplyr, tidyr, ggplot2,gtsummary
)
data_clean<-readRDS(
  file=here::here("data/data_clean.rds")
)
# Create the contingency table
table_one <- data_clean %>%
  select(-DATE_DIED,-CLASIFFICATION_FINAL)%>%
  tbl_summary(
    by=PREGNANT) %>%
  modify_header(label="**VARIABLE**")

saveRDS(
  table_one,
  file = here::here("subproject1/output/descriptive_output", "table_one.rds")
)


# Create the bar plot and save it 
table <- data_clean %>%
  select(SEX, PNEUMONIA, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION,
         CARDIOVASCULAR, RENAL_CHRONIC, OTHER_DISEASE, OBESITY) %>%
  pivot_longer(cols = -SEX, names_to = "Disease", values_to = "Present") %>%
  filter(Present=="Yes")%>%
  group_by(SEX, Disease, Present) %>%
  summarise(Count = n()) %>%
  ungroup()

ggsave(
  plot = ggplot(table, aes(x = Disease, y = Count, fill = SEX)) +
    geom_bar(stat = "identity", position = "dodge") +
    geom_text(aes(label=Count), vjust=-0.5)+
    scale_fill_manual(values=c("Female"="black"))+
    labs(title="Disease Count by Gender", x = "Disease", y = "Count", fill = "Gender") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(hjust=0.5)),
  device = "png",
  file.path(here::here("subproject1/output/descriptive_output", "bar_plot.png")),
  width = 10,
  height = 6
) 





# If you have multiply outputs, feel free to change the `save` function