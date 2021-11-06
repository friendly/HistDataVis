#' ---
#' title: "09_14: RANDU in 3D"
#' author: "Michael Friendly"
#' date: "05 Nov 2021"
#' ---


# 400 triples of successive random numbers were taken from the VAX FORTRAN function RANDU running under VMS 1.5.
data(randu, package="datasets")

library(rgl)

# convert an RGL eps to png
# see https://stackoverflow.com/questions/60080167/rgl-how-to-produce-higher-resolution-snapshots
eps2png <- function(file) {
	cmdargs <- 
	  "gs -dSAFER -dBATCH -dNOPAUSE -dEPSCrop -sDEVICE=png16m -r600 "
	cmd <- paste0(cmdargs, " -sOutputFile=", file, ".png ", file, ".eps")
	cat("Running:", cmd, "\n")
	result <- system2(cmd)
	print(result)
}



# Figure 9.14 - 3D plots
par3d(windowRect = c(0,0,400,400) + 200)

with(randu, plot3d(x, y, z, size=6, axes=FALSE, 
                   xlab = "", ylab = "", zlab = ""))
box3d(col="gray")

# left panel: in standard orientation                   
rgl.postscript("09_14-randu0.eps", "eps")
#rgl.postscript("09_14-randu0.svg", "svg")
rgl.postscript("09_14-randu0.pdf", "pdf")

eps2png("09_14-randu0")

# right panel: rotate to show the planes on which points fall                  
rgl.viewpoint(theta = -3.8, phi = 3.8, fov = 0, zoom = 0.7)
#rgl.snapshot("randu.png")

rgl.postscript("09_14-randu1.eps", "eps")
#rgl.postscript("09_14-randu1.svg", "svg")
rgl.postscript("09_14-randu1.pdf", "pdf")

eps2png("09_14-randu1")
