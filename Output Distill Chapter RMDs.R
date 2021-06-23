library(data.table)
library(stringr)
library(glue)
library(rmarkdown)

source("utils.R")

togs = as.data.table(
  openxlsx::read.xlsx("figureinfo/TOGS-lof4.xlsx")
)

distill_setup = readLines("Distill Page Setup.txt")

chap_rmds = list.files(path = "Synopsis RMDs", pattern = "ch.+\\.Rmd")

for (f in chap_rmds) {
  
  chapnum = as.numeric(str_extract(f, "[0-9]+"))
  togs_chap = togs[chapter == chapnum]
  
  in_rmd = readLines(str_c("Synopsis RMDs/",f))
  
  rmd_mod = c(distill_setup, in_rmd, "")
  
  rmd_mod[2] = glue(rmd_mod[2])
  
  for (r in 1:nrow(togs_chap)) {
    
    newchunk = create_figure_chunk(togs_chap[r, filename],
                                   togs_chap[r, title], togs_chap[r, subtitle],
                                   togs_chap[r, fignum])
    
    rmd_mod = c(rmd_mod, "",
                       str_split(newchunk, "\n")[[1]], "")
  }
  
  outrmd = file(glue("{f}"))
  
  writeLines(rmd_mod, outrmd)

  #render(f)
}