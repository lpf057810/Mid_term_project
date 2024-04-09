pacman::p_load(
  here,
  dplyr
)


absolute_path <- here::here("data/covid_sub.csv")
data<-read.csv(absolute_path,header = TRUE)

data_clean <- data %>% 
  filter(!is.na(ICU))

data_clean <- data_clean %>%
  mutate(CLASSIFIED =  ifelse(data_clean$CLASIFFICATION_FINAL >= 1 &
                                data_clean$CLASIFFICATION_FINAL <=3, 
                              "Positive", "Inconclusive")
  )

# encode categorical varibles

columns_to_encode <- names(data_clean)[sapply(data_clean, function(column) {
  all(c('Yes', 'No') %in% unique(column))
})]

data_clean <- data_clean %>%
  mutate(across(all_of(columns_to_encode), ~if_else(.x == 'Yes', 1, 0)))

data_clean <- data_clean %>%
  mutate(SEX = recode(SEX, 'female' = 1, 'male' = 0))

data_clean <- data_clean %>%
  mutate(CLASSIFIED = recode(CLASSIFIED, 'Positive' = 1, 'Inconclusive' = 0))

# add a new variable DIED to indicate if the patient died 

data_clean <- data_clean %>%
  mutate(DIED = if_else(!is.na(DATE_DIED), 1, 0))

saveRDS(
  data_clean,"data/data_clean.rds"
) 
