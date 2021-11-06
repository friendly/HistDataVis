#' ---
#' title: "06_6: Scatterplot version of Playfair's plot"
#' author: "Michael Friendly"
#' date: "31 Oct 2021"
#' ---

data(Wheat, package="HistData")

# Fig 6.6

folder <- file.path(dropbox_folder(), "Documents", "TOGS")
path <- "ch06-scat/fig"

cd(file.path(folder,path))

h=6
w=9
dev.new(height=h, width=w)

png(file="06_6-wheat3.png", height=h, width=w, units="in", res=300)
#pdf(file="06_6-wheat3.pdf", height=h, width=w)
#svg(file="06_6-wheat3.svg", height=h, width=w)


op <- par(mar=c(4,4.2,1,1)+.1)   # tight bounding box
plot(Wheat ~ Wages, data=Wheat, type='p', pch=16, cex=1.8,
	xlab="Weekly wage (Shillings)",
	ylab="Price of wheat (Shillings/Quarter)",
	cex.lab=1.5
	)
lines(Wheat ~ Wages, data=Wheat, col="gray")
#pts <- seq(1, 50, 5) # c(1, 11, 21, 31, 53)

yrs <- c(1600, 1700, 1760, 1780, 1800, 1810)
pts <- which(Wheat$Year %in% yrs)
with(Wheat, text(Wages[pts], Wheat[pts], Year[pts], pos=1))

abline(lm(Wheat ~ Wages, data=Wheat), col="red", lwd=2)
par(op)
dev.off()

# try plotting the other way

plot(Wages ~ Wheat, data=Wheat, type='p', pch=16, cex=1.5,
	xlab="Weekly wage (Shillings)",
	ylab="Price of wheat (Shillings/Quarter)",
	cex.lab=1.5
	)
lines(Wages ~ Wheat, data=Wheat, col="gray")


