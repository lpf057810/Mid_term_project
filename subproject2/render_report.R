here::i_am(
  "subproject2/render_report.R"
)

library(rmarkdown)

render(
  "subproject2/report.Rmd",
  knit_root_dir = here::here()
)
