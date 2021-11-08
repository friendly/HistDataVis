#' ---
#' title: "04_P3b: Snow's Cholera Map with Pump Polygons"
#' author: "Michael Friendly"
#' date: "08 Nov 2021"
#' ---

library(HistData)
folder <- "C:/Dropbox/Documents/TOGS/ch04-vital"

# Figure Plate 3b was: 4.11 (right panel)

png(file=file.path(folder, "fig/SnowMap-density.png"),
		width=7, height=7, units="in", res=300)

#svg(file=file.path(folder, "fig/SnowMap-density.svg"), width=7, height=7)

op <- par(mar=c(1,1,3,1)+.1)
SnowMap(density=TRUE, scale=FALSE, main="Snow's Cholera Map, Death Intensity",
				xlim=c(5,18), ylim=c(5,18)
				)
par(op)

dev.off()

