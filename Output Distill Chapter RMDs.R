library(data.table)
library(stringr)
library(glue)
library(rmarkdown)

source("R/utils.R")

togs = as.data.table(
  openxlsx::read.xlsx("figureinfo/TOGS-lof5.xlsx")
)

distill_setup = readLines("Distill Page Setup.txt")

chap_rmds = list.files(path = "Synopsis RMDs", pattern = "ch.+\\.Rmd")

for (f in chap_rmds) {
  
  chapnum = as.numeric(str_extract(f, "[0-9]+"))
  
  in_rmd = readLines(str_c("Synopsis RMDs/",f))
  
  rmd_mod = c(distill_setup, in_rmd, "")
  
  rmd_mod[2] = glue(rmd_mod[2])
  
  in_chunks = readLines("ChunkTemplate.txt")
  
  in_chunks[5] = glue(in_chunks[5])
  rmd_mod = c(rmd_mod, in_chunks)
  
  outrmd = file(glue("{f}"))
  
  writeLines(rmd_mod, outrmd)

}