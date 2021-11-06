#' ---
#' title: "04_P3a: Snow's cholera map with pump neighborhoods"
#' author: "Michael Friendly, Peter Li"
#' date: "30 Oct 2021"
#' ---

# This version uses the cholera package, largely to use its voronoiPolygons function

library(cholera)
library(HistData)
library(sp)

# compute vertices of Voronoi pump tiles
vertices <- voronoiPolygons(sites = cholera::pumps, rw.data = cholera::roads)

# locations of the 578 fatalities in Soho
cases <- cholera::fatalities.unstacked

# tabulate fatalities within each pump tile
census <- lapply(vertices, function(tile) {
  sp::point.in.polygon(cases$x, cases$y, tile$x, tile$y)
})

# Find areas of polygons
polygon_area <- function(XY) {
	X <- XY[,1]
	Y <- XY[,2]
	Xm <- c(X[-1], X[1])
	Ym <- c(Y[-1], Y[1])
	Xdiff <- Xm - X
	Area <- abs(sum((Y + Ym) * Xdiff/2))
	return(Area)
}

# Calculate residuals, from null model of deaths ~ area

areas <- sapply(vertices, polygon_area)
deaths <- sapply(census, sum)
expected <- sum(deaths) * areas/sum(areas)
residual <- (deaths - expected) / sqrt(expected)

results <- data.frame(areas, deaths, expected, residual)


row.names(results) <- HistData::Snow.pumps$label

# function to calculate transparent color based on signed residual of deaths
#    blue for negative, (OK)
#    white for middle, 
#    red for positive  (danger)
color.gradient <- function(x, colors=c(rgb(0,0,1,.2), 
                                       rep(rgb(1, 1, 1, 0), 3), 
                                       rgb(1,0,0,.2)), 
                              colsteps=200) {
  return( colorRampPalette(colors, alpha=TRUE) (colsteps) [ findInterval(x, seq(min(x),max(x), length.out=colsteps)) ] )
}


op <- par(mar=c(1,1,3,1)+.1)

HistData::SnowMap(scale=FALSE, 
                  main="Snow's Cholera Map with Pump Neighborhoods",
                  xlim=c(5,18), ylim=c(5,18))

cols <- color.gradient(results$residual)

# plot the Voronoi boundaries
for(i in seq_along(vertices)) {
	coord <- vertices[[i]]
	polygon(coord$x, coord$y, col=cols[i], lwd=2)
}
# re-plot pump labels on top
HistData::Spumps()
par(op)

