#' ---
#' title: "06_5: Re-drawn version of Playfair's graph"
#' author: "Michael Friendly"
#' date: "31 Oct 2021"
#' ---

#library(HistData)
data(Wheat, package="HistData")
data(Wheat.monarchs, package="HistData")
folder <- file.path(dropbox_folder(), "Documents", "TOGS")
path <- "ch06-scat/fig"

cd(file.path(folder,path))

# Fig 6.5
# -----------------------------------------
# plot the labor cost of a quarter of wheat
# -----------------------------------------
Wheat1 <- within(na.omit(Wheat), {Labor=Wheat/Wages})

h=8  / 1.2
w=12 / 1.2
#png(file="06_5-wheat2.png", height=h, width=w, units="in", res=300)
#svg(file="06_5-wheat2.svg", height=h, width=w)

op <- par(mar=c(4,4.1,1,1)+.1)   # tight bounding box

with(Wheat1, {
	plot(Year, Labor, type='b', pch=16, cex=1.5, lwd=1.5, 
	     ylab="Labor cost of a Quarter of Wheat (weeks)",
	     ylim=c(1,12.5), xlim=c(1560,1823),
	     cex.axis=1.2, cex.lab=1.5,
	     lab=c(12,5,7)
	     );
	lines(lowess(Year, Labor), col="red", lwd=3)
	})
	
# cartouche
text(1740, 10.5, "Chart", cex=2, font=2)
text(1740, 8.5, 
	paste("Shewing at One View", 
        "The Work Required to Purchase", 
        "One Quarter of Wheat",
        "from 1565 to 1821", 
        sep="\n"), cex=1.5, font=3)

with(Wheat.monarchs, {
#	start <- ifelse(start==1820, 1818, start)
	y <- ifelse( !commonwealth & (!seq_along(start) %% 2), 12.4, 12.6)
	segments(start, y, end, y, col=gray(.4), lwd=8, lend=1)
	segments(start, y, end, y, col=ifelse(commonwealth, "white", NA), lwd=4, lend=1)
	text((start+end)/2, y-0.2, name, cex=0.7, xpd=TRUE)
	})
par(op)
dev.off()
