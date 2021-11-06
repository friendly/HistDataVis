#' ---
#' title: "06_18: Hertzsprung-Russel diagrams for stars in the CYG OB1 cluster"
#' author: "Michael Friendly"
#' date: "02 Nov 2021"
#' ---

#library(dplyr)
library(car)

# data on stars in the CYG cluster
data(starsCYG, package="robustbase")
# rename: log.Te -> logtemp
#         log.light -> loglight
colnames(starsCYG) <- c("logtemp", "loglight")

# classify by logtemp
starsCYG$type <- ifelse(starsCYG$logtemp < 3.6, 'Red Giant', "Main Sequence")

w <- 7
h <- 7
#png("06_18a-hertzsprung1.png", width=w, height=h, units="in", res=300)
#svg("06_18a-hertzsprung1.svg", width=w, height=h)

op <- par(mar=c(5,4,1,1)+.2)
with(starsCYG, {
	plot(loglight ~ logtemp, pch=16, 
	     cex=1.5, 
		   cex.lab=1.5,
		   xlab="log Surface Temperature", ylab="log Light Intensity", 
		   main=NULL)
	text(4.3, 6.2, "Hertzsprung-Russell diagram\nof star cluster CYG", cex=1.6)
	reg <- lm(loglight ~ logtemp)
	abline(reg, col="red", lwd=2)
	dataEllipse(logtemp, loglight, 
	            levels=0.5, ellipse.label="All data", 
		          plot.points=FALSE, 
		          fill=TRUE, fill.alpha=0.1, 
		          cex=1.8, col="red")
	})
par(op)
#dev.off()


# Robust methods

#png("06_18b-hertzsprung2.png", width=w, height=h, units="in", res=300)
#svg("06_18b-hertzsprung2.svg", width=w, height=h)

op <- par(mar=c(5,4,1,1)+.2)
with(starsCYG, {
	plot(loglight ~ logtemp, pch=16, 
	     cex=1.5, 
		   xlab="log Surface Temperature", ylab="log Light Intensity", 
		   cex.lab=1.5,
		   main=NULL)
	dataEllipse(logtemp, loglight, 
	            levels=0.5, ellipse.label="Robust estimate", 
		          plot.points=FALSE, fill=TRUE, fill.alpha=0.1, 
		          robust=TRUE, 
		          col="blue", cex=1.5)

	reg <- lm(loglight ~ logtemp, subset=type=="Main Sequence")
	abline(reg, col="blue", lwd=2)
	})
par(op)
#dev.off()

