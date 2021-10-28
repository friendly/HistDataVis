#' ---
#' title: "04_3: Farr's elevation - mortality data as a scatterplot"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---
library(car)
library(here)


data(Cholera, package="HistData")

path <- "ch04-vital/fig"

# Figure 4.3

png(file=here(path, "cholera-elev-law.png"), width=6, height=5, res=300, units="in")
#svg(filename=here(path, "cholera-elev-law.svg"), width=6, height=5)


op <- par(mar=c(5,4,1,1)+.1)

plot(cholera_drate ~ elevation, data=Cholera, 
	pch=16, cex.lab=1.2, cex=1.2,
	xlab="Elevation above high water mark (ft)",
	ylab="Deaths from cholera in 1849 per 10,000")

# Farr's mortality - elevation law
elev <- c(0, 10, 30, 50, 70, 90, 100, 350)
mort <- c(174, 99, 53, 34, 27, 22, 20, 6)
lines(mort ~ elev, lwd=2, col="blue")

# compare with loess
with(Cholera, lines(loess.smooth(elevation, cholera_drate), lwd=2, col="red", lty=2))
ids <- c(2, 5, 38)
with(Cholera, text(elevation[ids], cholera_drate[ids], district[ids], 
                   pos=c(4, 4, 3), xpd=TRUE))

legend("topright", legend=c("data", "law", "smooth"), 
	pch=c(16, NA, NA), col=c("black", "blue", "red"), lty=c(0, 1, 2),  lwd=c(0,3, 3),
	cex=1.2)

par(op)
dev.off()
