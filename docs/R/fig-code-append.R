# append info on figs-code to the figure info

library(readr)
library(stringr)
library(glue)
library(openxlsx)
library(dplyr)

setwd("C:/R/Rprojects/HistDataVis")

figureinfo <- openxlsx::read.xlsx("figureinfo/TOGS-lof6.xlsx")

# read code file names
codefn <- list.files("fig-code", pattern="^[01]")

codesplt <- str_split_fixed(codefn, "[_-]", 3)

library(dplyr)
codefiles <- data.frame(
           chapter=as.numeric(codesplt[,1]), 
           figc=codesplt[,2], 
           codefile=codefn,
           stringsAsFactors = FALSE)
#str(codefiles)

# make fig numeric, to match what it is in the figureinfo file

figc <- codefiles[,"figc"]
fig <- as.numeric(str_extract(figc, "\\d+"))

# handle plates
plate <- str_detect(figc, "P")

fignum <- rep("", nrow(codefiles))
for (i in 1:nrow(codefiles)) {
	if (plate[i])
		fignum[i] <- paste0("P.", fig[i])
	else
		fignum[i] <- paste0(codefiles[i, "chapter"], ".", fig[i])
}

codefiles <- cbind(codefiles, fig, fignum)
codefiles <- codefiles[,c(1, 5, 3, 2, 4)]

codefiles <- 
  codefiles %>% 
  group_by(chapter, fignum) %>% 
  summarise(codefile = paste0(codefile, collapse = ', '), .groups = 'drop')

# now merge/join with figureinfo

figureinfo2 <- left_join(figureinfo, 
                         codefiles[, c(1:3)], 
                         by=c("chapter", "fignum")) %>%
		relocate(codefile, .after = filename)


View(figureinfo2)

openxlsx::write.xlsx(figureinfo2, "figureinfo/TOGS-lof7.xlsx")

######################


### This is just for testng
code_folder  <- "fig-code"
# function to make links from code file names
make_links <- function(codefn) {
  code_str <- ""
  if (!is.na(codefn)) {
    comma_count = str_count(codefn, ",")+1    
    if (comma_count > 1) {
      codefns = str_trim(
        str_split(codefn, ",")[[1]])
      for (fn in codefns) {
        final_fn = glue("{code_folder}/{fn}")
        code_str = str_c(code_str, 
                         glue("<b>Rcode</b>: <a href='{code_folder}/{fn}'> {fn} </a>\n"),
                         sep = "\n")
      }
    }
      else {
      code_str <- glue("<b>Rcode</b>: <a href='{code_folder}/{codefn}'> {codefn} </a>\n")
    }
  }
  return(code_str)
}

for (i in 8:12) {
  cat(make_links(codefiles[i,"codefile"]), "\n")
}
