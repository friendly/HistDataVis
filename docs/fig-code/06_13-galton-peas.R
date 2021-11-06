#' ---
#' title: "06_13: Galton's visual argument for regression"
#' author: "Michael Friendly"
#' date: "31 Oct 2021"
#' ---

#install.packages("psychTools")
library(psychTools)
data(peas, package="psychTools")


#cd("C:/Dropbox/Documents/TOGS/ch06-scat/fig")

peas.mod <- lm(child ~ parent, data=peas)
mx <- mean(peas$parent)
my <- mean(peas$child)

png(file="06_13-galton-peas.png", height=6, width=8.7, units="in", res=300)
#svg(file="06_13-galton-peas.svg", height=6, width=8.7)


op <- par(mar=c(5, 4, 1, 1)+.1)
plot(jitter(child) ~ jitter(parent), data=peas,
	pch=16, cex.lab=1.25, 
	asp=1, xlim=c(14, 23),
	xlab="Parent seed diameter (0.01 in.)", ylab="Child seed diameter (0.01 in.)")

# Draw predicted line, but just over the dta range using predict
pred <- 14:23
lines(pred, predict(peas.mod, data.frame(parent=pred)), col="blue", lwd=3)

txt <- paste("child =", round(coef(peas.mod)[1], 1), "+", round(coef(peas.mod)[2], 2), "parent")
#text(15 , 22, txt, pos=4, cex=1.4)

#line of unit slope
mx <- mean(peas$parent)
my <- mean(peas$child)
xp <- 14:22
yp <- my + (xp - mx)

lines(xp, yp, col="darkgray", lwd=3, lty="longdash")
text(23.2, yp[9], "child ~ 1 * parent", cex=1.4, col="darkgray")
text(23, y=18.3, "child ~0.34 * parent", cex=1.4, col="blue")
abline(v=mx, h=my, col="grey")

# add line of means
means <- aggregate(child ~ parent, data=peas, FUN=mean)
lines (child ~ parent, data=means, type="b", pch="+", cex=2, lwd=7, col="darkgreen")
text(15, 15.3, "means", col="darkgreen", cex=1.4, pos=2)

par(op)
dev.off()






