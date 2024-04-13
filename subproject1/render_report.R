here::i_am(
  "subproject1/render_report.R"
)

library(rmarkdown)

render(
  "subproject1/report.Rmd",
  knit_root_dir = here::here()
)
