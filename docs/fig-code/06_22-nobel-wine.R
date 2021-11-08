#' ---
#' title: "06_22: Wine, IKEA and Nobel prizes"
#' author: "Michael Friendly"
#' date: "04 Nov 2021"
#' ---

# import the Nobel data here
Nobel <- read.csv("Nobel.csv")

library(ggplot2)
library(ggrepel)

# two figures side-by-side
png(filename = "06_22-nobel-wine-ikea.png", w=10, h=5, units="in", res=300)

op <- par(mfrow=c(1,2), mar=c(5,4,1,1)+.2)
with(Nobel, {
	mod <- lm(Nobel ~ Wine)
	dataEllipse(Wine, Nobel, levels=c(0.5), pch=16, 
	            fill=TRUE, fill.alpha=0.10, col="red",
	            cex=1.2, cex.lab=1.4,
	            center.pch="+", center.cex=4, 
	            id=list( n=5, labels=Country), 
	            grid=FALSE,
	            xlab="Wine consumption per capita (liters/year)",
	            ylab="Nobel prize winners per 10M population")
	abline(mod, col="blue", lwd=2)
	text(7, 17, paste("r =", round(R[1, 6], 2), 
	                  "\nb =", round(coef(mod)[2], 2)), 
				cex=1.6)
	})



with(Nobel, {
	mod <- lm(Nobel ~ IKEA)
	dataEllipse(IKEA, Nobel, levels=c(0.5), pch=16, 
	            fill=TRUE, fill.alpha=0.10, col="red",
	            cex=1.2, cex.lab=1.4,
	            center.pch="+", center.cex=4, 
	            id=list( n=5, labels=Country), 
	            grid=FALSE,
	            xlab="IKEA stores per 10M population",
	            ylab="Nobel prize winners per 10M population")
	abline(mod, col="blue", lwd=2)
	text(16.5, 26, paste("r =", round(R[1, 2], 2), 
	                  "\nb =", round(coef(mod)[2], 2)),  
	     cex=1.6)
	})
par(op)

dev(off)
