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

codefiles <- data.frame(
           chapter=as.numeric(codesplt[,1]), 
           figc=codesplt[,2], 
           codefile=codefn,
           stringsAsFactors = FALSE)
#str(codefiles)

# make fig numeric, to match what it is in the figureinfo file

figc <- codefiles[,"figc"]

fig <- as.numeric(str_extract(figc, "\\d+"))
fig

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

library(dplyr)
cf %>% 
  group_by(fignum) %>% 
  summarise(codefile = paste0(codefile, collapse = ', '), .groups = 'drop')

# now merge/join with figureinfo

figureinfo2 <- left_join(figureinfo, 
                         codefiles[, c(1:3)], 
                         by=c("chapter", "fignum")) %>%
		relocate(codefile, .after = filename)

View(figureinfo2)

