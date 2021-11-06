#' ---
#' title: "09_13: Plots of successive pairs of RANDU random numbers"
#' author: "Michael Friendly"
#' date: "05 Nov 2021"
#' ---

# Figure 9.13 - 2D 
seed <- as.double(1)
RANDU <- function() {
    seed <<- ((2^16 + 3) * seed) %% (2^31)
    seed/(2^31)
}

XY <- matrix(0, 800, 2)
for (i in 1:nrow(XY)) {
	XY[i,] <- c(RANDU(), RANDU())
}

png(file="randu-2d.png", height=6, width=6, unit="in", res=300)
#svg(file="randu-2d.svg", height=6, width=6)

op <- par(mar=c(5,5,2,1)+.1)
plot(XY, 
	xlab="Uniform random x[i]", ylab="Uniform random x[i+1]",
	main="RANDU random numbers", cex.main=1.5,
	pch=16, cex.lab=1.4)
par(op)
dev.off()

# 2D plot, recognizing the linear combination
seed <- as.double(1)
XYZ <- matrix(0, 800, 3)
colnames(XYZ) <- c("x", "y", "z")

for (i in 1:nrow(XYZ)) {
	XYZ[i,] <- c(RANDU(), RANDU(), RANDU())
}


plot(9*x - 6*y + z ~ x, data=XYZ)
