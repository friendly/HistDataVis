#' ---
#' title: "06_15: Galton's method for finding contours of equal frequency"
#' author: "Michael Friendly"
#' date: "01 Nov 2021"
#' ---

# Sample plots of Galton's data, here plotting x=child, y=parent to comform to Galton's table.
# The figures in the book were done years ago using SAS

library(car)
library(dplyr)
library(ggplot2)

data(Galton, package="HistData")

#' Limits for X & Y
lim <- c(61,75)

#' ## plot frequencies in cells as in Fig 6.15

counts <- Galton %>% 
	count(parent, child)
		
p <-
ggplot(Galton, aes(x=child, y=parent)) + 
	geom_density_2d(adjust=1.5, size=1.25) +
	geom_text(data=counts, aes(x=child, y=parent, label=n) ) + 
	lims(x = lim, y = lim) + 
	labs(x = "Child height", y = "Parent height") +
	theme_bw()

p + scale_x_continuous(n.breaks = 7) + scale_y_continuous(n.breaks = 7)
	
#' ## Sunflower plot

with(Galton, 
	{
	sunflowerplot(y=parent, x=child, 
		xlim=lim, ylim=lim, 
		seg.col="gray30", cex=1.2, cex.fact=1.2,
		ylab="Parent height", xlab="Child height", cex.lab=1.4)
	reg <- lm(parent ~ child)
	abline(reg)
	lines(lowess(y=parent, x=child), col="blue", lwd=4)
	dataEllipse(y=parent, x=child, 
		xlim=lim, ylim=lim, 
		levels = c(0.40, 0.68, 0.95),
		plot.points=FALSE, fill=TRUE, fill.alpha=0.1)
  })



library(KernSmooth)

kde2d <- bkde2D(Galton[,2:1], bandwidth=c(0.8,0.8))

clrs=colorRampPalette(c(rgb(0,0,1,0), rgb(0,0,1,.8)), alpha = TRUE)(20)

op <-par(mar=c(4,4,1,1)+.1)
contour(x=kde2d$x1, y=kde2d$x2, z=kde2d$fhat, 
		ylab="Parent height", xlab="Child height")
image(x=kde2d$x1, y=kde2d$x2, z=kde2d$fhat, add=TRUE, col=clrs)
with(Galton, 
	{
  reg <- lm(parent ~ child)
	abline(reg, col="brown", lwd=2)
	lines(lowess(y=parent, x=child), col="red", lwd=2)
#	dataEllipse(parent, child, plot.points=FALSE)
  })

par(op)

#' ## Jittered points plus 2D density contours
p <- ggplot(Galton, aes(y = parent, x = child)) +
 geom_jitter() 

p + geom_density2d(n=16) + 
	stat_smooth(method="lm") +
	theme_bw()


