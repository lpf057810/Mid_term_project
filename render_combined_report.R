here::i_am(
  "render_combined_report.R"
)

library(rmarkdown)

render(
  "combined_report.Rmd",
  knit_root_dir = here::here()
)