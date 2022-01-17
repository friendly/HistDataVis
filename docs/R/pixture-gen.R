library(here)
library(stringr)
library(dplyr)
library(glue)

# remotes::install_github('royfrancis/pixture')

image_folder <- "figs-web"                # where the figs live
code_folder  <- "fig-code"

all_figs <- list.files(here(image_folder))

ch <- 0:10
chf <- sprintf("%02d", ch)

chfigs <- function(ch) {
  chf <- sprintf("%02d", ch)
  figfn <- str_subset(all_figs, glue("^{chf}"))
  paths <- file.path(image_folder, figfn)
  data.frame(paths, figfn)
}



