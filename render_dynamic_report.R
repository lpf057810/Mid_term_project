here::i_am(
  "render_dynamic_report.R"
)

library(rmarkdown)

render(
  "dynamic_report.Rmd",
  knit_root_dir = here::here()
)