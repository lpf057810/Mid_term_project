pacman::p_load(
  here
)
here::i_am(
  "covid_sub.csv"
)

library(dplyr)
absolute_path<-here::here("covid_sub.csv")
data<-read.csv(absolute_path,header = TRUE)
data_clean<-na.omit(data)
data_clean<- data_clean %>%
  mutate(CLASSIFIED =  ifelse(data_clean$CLASIFFICATION_FINAL >= 1 &
                                data_clean$CLASIFFICATION_FINAL <=3, 
                              "Positive", "Inconclusive")
  )

saveRDS(
  data_clean,"data_clean.rds"
) 
 
