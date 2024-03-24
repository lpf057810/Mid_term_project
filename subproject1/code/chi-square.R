pacman::p_load(
  ggplot2
)# This code can check whether you have the desired package and load the package after installing.

here::i_am(
  "subproject1/code/chi-square.R"
)


saveRDS(
  table,
  file = here::here("subproject1/output/chi-square/table.rds")
)

ggsave(
  plot = barchart,
  device = "png",
  file.path(here::here("subproject1/output/chi-square/barchart.png")),
  width=10,
  height=6
)

# If you have multiply outputs, feel free to change the `save` function
