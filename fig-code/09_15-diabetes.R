#' ---
#' title: "09_15: Diabetes data from Reaven and Miller"
#' author: "Michael Friendly"
#' date: "05 Nov 2021"
#' ---

# Reaven & Miller- diabetes

data(Diabetes, package="heplots")

# close to fig 2 & similar to fig 6 from R&M 1968 

png(filename="09_15-diabetes1.png", width=480, height=360)

op <- par(mar=c(5,5,1,1)+.1)
plot(instest ~ glutest, data=Diabetes, pch=16,
	cex.lab=1.25,
	xlab="Glucose response",
	ylab="Insulin response")
par(op)

dev.off()


# Other plots: showing group membership

cols <- c("blue", "red", "darkgreen")
pchs <- c(16,15,17)
col <- cols[Diabetes$group]
pch <- pchs[Diabetes$group]


png(filename="diabetes2.png", width=480, height=360)
op <- par(mar=c(5,5,1,1)+.1)
plot(instest ~ glutest, data=Diabetes, pch=pch, col=col,
	cex.lab=1.25,
	xlab="Glucose response",
	ylab="Insulin response")
legend("topright", legend=levels(Diabetes$group), 
	title="Group",
	col=cols, pch=pchs,
	pt.cex=1.2)
par(op)
dev.off()


# With data ellipses for each group
library(car)

png(filename="diabetes3.png", width=480, height=360)
op <- par(mar=c(5,5,1,1)+.1)
scatterplot( instest ~ glutest | group, data=Diabetes, pch=pchs, col=cols,
	smooth=FALSE, grid=FALSE, 
	legend.coords="topright", legend.title="Group",
	cex.lab=1.25,
	xlab="Glucose response",
	ylab="Insulin response",
	lwd=3,
	robust=FALSE,
	ellipse=TRUE, levels=0.5)
par(op)
dev.off()


