#' ---
#' title: "03_7: Reproduction of Guerry's six maps"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---

library(Guerry)
library(sp)
library(here)
library(RColorBrewer)
#library(rgeos)

data(Guerry, package="Guerry")

# make some separate maps
spplot(gfrance, "Crime_pers")
spplot(gfrance, "Crime_prop")
spplot(gfrance, "Literacy")


my.palette <- rev(brewer.pal(n = 9, name = "PuBu"))

gf <- gfrance

gf$Crime_pers  <- rank(gfrance$Crime_pers)
gf$Crime_prop  <- rank(gfrance$Crime_prop)
gf$Literacy    <- rank(gfrance$Literacy)
gf$Donations   <- rank(gfrance$Donations)
gf$Infants     <- rank(gfrance$Infants)
gf$Suicides    <- rank(gfrance$Suicides)



# transform to ranks
vars <- c("Crime_pers", "Crime_prop", "Literacy", "Donations", "Infants", "Suicides") 
for (var in vars) {
	gf@data[[var]] <- rank(gf@data[[var]])
}


path <- "ch03-data/fig"
png(filename=here(path, "guerrymap.png"), res=300, width=9, height=6, units="in")
#svg(filename=here(path, "guerrymap.svg"), width=9, height=6)


spplot(gf, 
       c("Crime_pers", "Crime_prop", "Literacy", "Donations", "Infants", "Suicides"),
       names.attr = c("Personal crime", "Property crime", "% Read & Write",
                      "Donations to Poor", "Out of Wedlock", "Suicides"),
  layout=c(3,2), as.table=TRUE, 
  col.regions = my.palette, cuts = 8, # col = "transparent",
  main="Guerry's main moral variables")

dev.off()


