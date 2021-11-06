library(car)
library(here)


data(Cholera, package="HistData")

path <- "ch04-vital/fig"


# Fig 4.6

setwd(folder)

# show separate regression lines for each water supply
png(file=file.path(path, "04_6a-cholera-elevation.png"), width=5, height=5, res=300, units="in")
#svg(filename=file.path(path, "04_6a-cholera-elevation.svg"), width=5, height=5)

op <- par(mar=c(5,4,1,1)+.1)
scatterplot(cholera_drate ~ elevation|water, data=Cholera, 
	smooth=FALSE, pch=15:17, lwd=2, cex=1.1,
	grid=FALSE,
	id=list(n=2, labels=sub(",.*", "", Cholera$district)), 
	cex.lab=1.25, xpd=TRUE,
	col=c("red", "darkgreen", "blue"),
	legend = list(coords="topright", title = "Water supply", cex=1.2),
	xlab="Elevation above high water mark (ft)",
	ylab="Deaths from cholera in 1849 per 10,000")
par(op)
dev.off()

#png(file="cholera-poorrate1.png", width=480, height=480)
png(file=file.path(path, "04_6b-cholera-poorrate.png"), width=5, height=5, res=300, units="in")
#svg(filename=file.path(path, "04_6b-cholera-poorrate.svg"), width=5, height=5)

op <- par(mar=c(5,4,1,1)+.1)
scatterplot(cholera_drate ~ poor_rate|water, data=Cholera, 
	smooth=FALSE, pch=15:17, lwd=2, cex=1.1,
	grid=FALSE,
	id=list(n=2, labels=sub(",.*", "", Cholera$district)), 
	cex.lab=1.25, xpd=TRUE,
	col=c("red", "darkgreen", "blue"),
	legend = list(coords="topleft", title = "Water supply", cex=1.2),
	xlab="Poor rate per pound of house value",
	ylab="Deaths from cholera in 1849 per 10,000")

par(op)
dev.off()

	


 
