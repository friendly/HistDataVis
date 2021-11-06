#' ---
#' title: "04_10: Line graph of Nightingale's data"
#' author: "Michael Friendly"
#' date: "29 Oct 2021"
#' ---
library(here)

data(Nightingale, package="HistData")


## What if she had made a set of line graphs?

# these plots are best viewed with width ~ 2 * height 

# now figure 4.10

w <- 15.3
h <-  7.7
png("04_10-nightingale-line.png", width=w, height=h, units="in", res=300)
#svg("04_10-nightingale-line.svg", width=w, height=h)

op <- par(mar=c(4, 4, 2, 1) + .1, bty="l")
colors <- c("blue", "red", "black")                          
with(Nightingale, {
	plot(Date, Disease.rate, type="n", cex.lab=1.25, 
		ylab="Annual Death Rate", xlab="Date", xaxt="n",
		main="Causes of Mortality of the British Army in the East")
	# background, to separate before, after
	rect(as.Date("1854/4/1"), -10, as.Date("1855/3/1"), 
		1.02*max(Disease.rate), col=gray(.90), border="transparent")
	text( as.Date("1854/4/1"), .95*max(Disease.rate), "Before Sanitary\nCommission", pos=4, cex=1.25)
	text( as.Date("1855/4/1"), .95*max(Disease.rate), "After Sanitary\nCommission", pos=4, cex=1.25)
	# plot the data
	points(Date, Disease.rate, type="b", col=colors[1], lwd=3, pch=16, cex=1.4)
	points(Date, Wounds.rate, type="b", col=colors[2], lwd=2, pch=17, cex=1.4)
	points(Date, Other.rate, type="b", col=colors[3], lwd=2, pch=15, cex=1.4)
	}
)
# add custom Date axis and legend
axis.Date(1, at=seq(as.Date("1854/4/1"), as.Date("1856/3/1"), "3 months"), format="%b %Y")
legend(as.Date("1855/10/01"), 900, 
	c("Preventable disease", "Wounds and injuries", "Other"),
	col=colors, pch=c(16, 17, 15),  #fill=colors, 
	title="Cause of death", cex=1.25, pt.cex=1.5,
	 bg="#FAE8C1")

par(op)

dev.off()
