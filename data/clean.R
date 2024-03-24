pacman::p_load(
  here
)
here::i_am(
  "covid_sub.csv"
)
absolute_path<-here::here("covid_sub.csv")
data<-read.csv(absolute_path,header = TRUE)
data_clean<-na.omit(data)
summary(data_clean)

saveRDS(
  data_clean,"data_clean.rds"
)

