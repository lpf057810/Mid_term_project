pacman::p_load(
  here
)
here::i_am(
  "covid_sub.csv"
)

library(dplyr)
absolute_path<-here::here("covid_sub.csv")
data<-read.csv(absolute_path,header = TRUE)
data_clean<- data %>%
  mutate(CLASSIFIED =  ifelse(data$CLASIFFICATION_FINAL >= 1 &
                                data$CLASIFFICATION_FINAL <=3, 
                              "Positive", "Inconclusive")
  )

saveRDS(
  data_clean,"data_clean.rds"
) 

# I used the original data because omitting NA(s) remove all the male patients -Ngun



