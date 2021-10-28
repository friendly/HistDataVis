#' ---
#' title: "03_8: Enhanced scatterplot of crimes against persons vs literacy"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---

library(Guerry)
library(car)
library(here)
data(Guerry)

path <- "ch03-data/fig"
png(filename=here(path, "guerry-bivar1.png"), res=300, width=6, height=6, units="in")
#svg(filename=here(path, "guerry-bivar1.svg"), width=6, height=6)

op <- par(mar = (c(4, 4, 1, 1) +.1))
set.seed(12315)

with(Guerry,{
	dataEllipse(Literacy, Crime_pers,
		levels = 0.68,
  	ylim = c(0,40000), xlim = c(0, 80),
  	ylab="Pop. per crime against persons",
  	xlab="Percent who can read & write",
  	pch = 16,
  	grid = FALSE,
  	id = list(method="mahal", n = 8, labels=Department, location="avoid", cex=1.2),
  	center.pch = 3, center.cex=5,
  	cex.lab=1.5)
	dataEllipse(Literacy, Crime_pers,
		levels = 0.95, add=TRUE,
  	ylim = c(0,40000), xlim = c(0, 80),
  	lwd=2, lty="longdash",
  	col="gray",
  	center.pch = FALSE
  	)
  
  abline( lm(Crime_pers ~ Literacy), lwd=2)	
  lines(loess.smooth(Literacy, Crime_pers), col="red", lwd=3)
  }
  	)
par(op)
dev.off()


# redo this as crimes per 100,000 persons

Guerry$Crime_pers_rate <- 100000 / Guerry$Crime_pers

set.seed(12315)
png(filename=here("guerry-bivar2.png"), res=300, width=6, height=6, units="in")
#svg(filename=here(path, "guerry-bivar1.svg"), width=6, height=6)

op <- par(mar = (c(4, 4, 1, 1) +.1))
with(Guerry,{
	dataEllipse(Literacy, Crime_pers_rate,
		levels = 0.68,
  	ylim = c(-5,45), 
		xlim = c(-5, 80),
  	ylab = "Crimes against persons per 100,000 population",
  	xlab="Percent who can read & write",
  	pch = 16,
  	grid = FALSE,
  	id = list(method="mahal", n = 8, labels=Department, location="avoid", cex=1.2),
  	center.pch = 3, center.cex=5,
  	cex.lab=1.5)
	dataEllipse(Literacy, Crime_pers_rate,
		levels = 0.95, add=TRUE,
  	ylim = c(-5,45), 
  	xlim = c(-5, 80),
  	lwd=2, lty="longdash",
  	col="gray",
  	center.pch = FALSE
  	)
  
  abline( lm(Crime_pers_rate ~ Literacy), lwd=2)	
  lines(loess.smooth(Literacy, Crime_pers_rate), col="red", lwd=3)
  }
  	)
par(op)
dev.off()
