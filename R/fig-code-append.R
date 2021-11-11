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
codefn <- str_subset(codefn, ".R$")

# split figure number string from the filename
codesplt <- str_split_fixed(codefn, "[_-]", 3)

codefiles <- data.frame(
           chapter=as.numeric(codesplt[,1]), 
           figc=codesplt[,2], 
           codefile=codefn,
           stringsAsFactors = FALSE)

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

##########################

# Generate a list of figure code files and their titles
# in HTML, ... 
# should re-do this to generate in rmarkdown, to be incorporated into an .Rmd file

titles <- NULL
for (i in 1:length(codefn)) {
	fn <- codefn[i]
	file <- glue("{code_folder}/{fn}")
#	cat(file, "\n")
	lines <- readLines(file)
	title_line <- str_which(lines, "title:")
	title <- lines[title_line]
	title <- str_replace(title, "#' title: ", "")
	title <- str_replace_all(title, '"', "")
	figtype <- if(str_detect(fn, "P")) "Plate" else "Figure"
	title <- glue("{figtype} {title}")
	link <- glue("<a href='{file}'> {fn} </a>")
	title <- glue("* {link} {title}")
	cat(title, "\n")
	titles <- c(titles, title)
}


titles <- NULL
for (i in 1:length(codefn)) {
	fn <- codefn[i]
	figtype <- if(str_detect(fn, "P")) "Plate" else "Figure"
	file <- glue("{code_folder}/{fn}")
	lines <- readLines(file)
	title_line <- str_which(lines, "title:")
	title <- lines[title_line]
	title <- str_replace(title, "#' title: ", "")
	title <- str_replace_all(title, '"', "")
	title <- glue("{figtype} {title}")
	link <- glue("[{title}]({file})")
	title <- glue("* {link}")
	cat(title, "\n")
	titles <- c(titles, title)
}
