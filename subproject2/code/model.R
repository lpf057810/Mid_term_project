here::i_am(
  "subproject2/code/model.R"
)

saveRDS(
  table,
  file = here::here("subproject2/output/model/table.rds")
)

ggsave(
  plot = scatterplot,
  device = "png",
  file.path(here::here("subproject2/output/model/scatterplot.png")),
  width=10,
  height=6
)

# If you have multiply outputs, feel free to change the `save` function
