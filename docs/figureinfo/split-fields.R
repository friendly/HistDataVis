# cleanup fields in TOGS-lof
# -- extract chapter as a separate field
# -- split subtitle, extracting Source: as a separate field

library(readr)
library(stringr)
library(xlsx)


setwd("C:/Users/friendly/Dropbox/Documents/DataVisHistory/figureinfo/")

lof <- read_csv("TOGS-lof2-JZA.csv")

# get chapter number
ch <- str_extract(lof$fignum, "(P|\\d+)")

# separate subtitle & source
src <- str_split_fixed(lof$subtitle, "Source: ", 2)
colnames(src) <- c("subtitle", "source")

# create new version
newlof <- data.frame(chapter=ch, fignum=lof$fignum, title=lof$title, src)

head(newlof)

## something weird happens to special characters when this is opened in excel
#write_csv(newlof, "TOGS-lof3.csv")

write.xlsx(newlof, "TOGS-lof3.xlsx", row.names=FALSE)



