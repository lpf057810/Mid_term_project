here::i_am(
"subproject1/code/data_clean.R"
)
#Please fill this section with data cleaning 

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