#' ---
#' title: "02_3: Graphical inventions"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---

# Timeline of the invention of some basic forms for statistical graphs, 1600-1850

#graphics <- read.csv("graphic-forms.csv")
graph_forms <- '
Year,Form,Who
1644,1D dotplot,Michael van Langren
1669,bivariate curve,Christiaan Huygens
1701,contour map,Edmund Halley
1753,timeline,Jacques-Barbeu Durbourg
1786,bar chart,William Playfair
1786,line graph,William Playfair
1801,pie chart,William Playfair
1819,choropleth map,Charles Dupin
1829,polar area chart,Andre-Michel Guerry
1832,2D scatterplot,J.F.W. Herschel
1843,2D polar graph,Leon Lalanne
1846,log-log plots,Leon Lalanne
'

graphics <- read.csv(text=graph_forms, header=TRUE)


set.seed(124143)
graphics$height <- rep(c(1, -1), length=12) * 0.9*runif(12)

png(file="../fig/timeline-basic.png", height=5.8, width=10.2, units="in", res=300)

with(graphics, {
	op <- par(mar=c(2,0,2,1)+.1)
  plot(Year, height, type="h", lwd=2, col="blue",
  		xlim=c(1600, 1850), 
  		ylim=c(-1, +1),  
	  	axes=FALSE, ylab="", 
	  	main="Timeline of Invention of Basic Forms for Statistical Graphs", cex.main=1.5)
  points(Year, height, pch=95, font=5, cex=2, col=4)
  segments(1600, 0, 1850, 0, col="blue", lwd=3)
  abline(v=seq(1600,1850, 50), col="lightgray")
  axis(1, pos=-1, lwd=2, lwd.ticks=1, cex.axis=1.5)
  lab1 <- paste(Form, "\n")
  text(Year, height, lab1, pos= 1 + 2*(height>0), cex=1.2, xpd=TRUE)
  htWho <- ifelse(height>0, height+.4*strheight("XXX"), height-1.2*strheight("XXX"))
  text(Year, htWho, Who, pos= 1 + 2*(height>0), cex=0.8)
  par(op)
  }
  )
 
dev.off()
 

