#' ---
#' title: "04_4: Farr's Inverse Natural Law of Cholera and Elevation"
#' author: "Michael Friendly"
#' date: "09 Dec 2016"
#' ---


library(car)
library(here)
path <- "ch04-vital/fig"


data(Cholera, package="HistData")

a <- 12.8  # offset
Cholera$elev_inv <- 1/(Cholera$elevation + a)
# Farr's mortality - elevation law

elev <- c(0, 10, 30, 50, 70, 90, 100, 350)
mort <- c(174, 99, 53, 34, 27, 22, 20, 6)
elevinv <- 1/(elev + a)

mod <- lm(mort ~ elevinv)
summary(mod)

#' linear regression of mortality on inverse elevation
#'  NB: this should probably be a weighted regression
fit_inv <- lm(cholera_drate ~ elev_inv, data=Cholera)
summary(fit_inv)

# Figure 4.4

png(file="cholera-elev-inv.png", width=6, height=5, res=300, units="in")
#png(file=here(path, "cholera-elev-inv.png"), width=6, height=5, res=300, units="in")
#svg(filename="cholera-elev-inv.svg", width=6, height=5)


op <- par(mar=c(5,4,1,1)+.1)

plot(cholera_drate ~ elev_inv, data=Cholera, 
	pch=16, cex.lab=1.2, cex=1.2,
	xlab="1 / Elevation above high water mark (1/ft)",
	ylab="Deaths from cholera in 1849 per 10,000")

#abline(mod, col="red", lwd=2, lty=2)
lines(mort ~ elevinv, type="b", pch=15, col="blue", lwd=2)

# compare with loess
# with(Cholera, lines(loess.smooth(elev_inv, cholera_drate), lwd=2, col="red", lty=2))
#abline(fit, col="red", lty=2, lwd=2)

ids <- c(1, 2, 5, 7, 38)

with(Cholera, text(elev_inv[ids], cholera_drate[ids], district[ids], 
                   pos=c(2, 4, 3, 1, 3), xpd=TRUE))
par(op)
dev.off()

## earlier version


scatterplot(cholera_drate ~ elev_inv, data=Cholera, 
	pch=16, cex.lab=1.2, cex=1.2, 
	id = list(n=4), 
	smooth=FALSE, boxplots=FALSE,
	xlab="1 / Elevation above high water mark (1/ft)",
	ylab="Deaths from cholera in 1849 per 10,000")
	
## other fits

fit <- lm(cholera_drate ~ elevation, data=Cholera)
boxCox(fit)

fit_log <- lm(log2(cholera_drate) ~ elevation, data=Cholera)
plot(log2(cholera_drate) ~ elev_inv, data=Cholera, 
	pch=16, cex.lab=1.2, cex=1.2,
	xlab="Elevation above high water mark (ft)",
	ylab="log Deaths from cholera in 1849 per 10,000")

boxTidwell(cholera_drate ~ I(elevation + a), data=Cholera)

