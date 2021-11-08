#' ---
#' title: "00_1: Timeline of milestones events, by continent"
#' author: "Michael Friendly"
#' date: "06 Nov 2021"
#' ---

library(here)

# Milestones events, classified as Europe vs. N. America.  These come from the Milestones Project database

	# North America
	sub1 <-
	c(1666, 1798, 1872, 1872, 1872, 1873, 1874, 1877, 1884, 1905,
	1910, 1910, 1913, 1913, 1913, 1914, 1914, 1915, 1916, 1917, 1925,
	1919, 1920, 1923, 1925, 1926, 1929, 1928, 1928, 1931, 1937, 1939,
	1944, 1944, 1957, 1957, 1962, 1965, 1966, 1965, 1969, 1969, 1971,
	1971, 1971, 1972, 1973, 1973, 1974, 1974, 1974, 1974, 1975, 1975,
	1975, 1975, 1976, 1977, 1977, 1978, 1978, 1979, 1981, 1981, 1981,
	1982, 1982, 1983, 1985, 1985, 1987, 1988, 1989, 1990, 1990, 1990,
	1990, 1991, 1991, 1993, 1992, 1994, 1999)

	# Europe
	sub2 <-
	c(1530, 1533, 1545, 1550, 1556, 1562, 1569, 1570, 1572, 1581,
	1605, 1603, 1603, 1614, 1617, 1624, 1623, 1626, 1632, 1637, 1644,
	1646, 1654, 1654, 1657, 1663, 1662, 1669, 1671, 1686, 1686, 1687,
	1693, 1693, 1701, 1710, 1711, 1712, 1724, 1727, 1745, 1741, 1748,
	1752, 1752, 1752, 1753, 1765, 1760, 1763, 1765, 1765, 1781, 1776,
	1778, 1779, 1782, 1782, 1782, 1785, 1786, 1787, 1794, 1795, 1796,
	1798, 1800, 1800, 1801, 1801, 1809, 1811, 1817, 1819, 1825, 1821,
	1822, 1825, 1827, 1828, 1832, 1830, 1832, 1833, 1833, 1833, 1833,
	1836, 1836, 1837, 1838, 1839, 1839, 1843, 1843, 1843, 1844, 1846,
	1846, 1851, 1852, 1853, 1855, 1857, 1857, 1857, 1861, 1861, 1863,
	1868, 1869, 1869, 1869, 1872, 1874, 1874, 1874, 1875, 1875, 1877,
	1877, 1878, 1878, 1879, 1879, 1889, 1880, 1882, 1882, 1883, 1884,
	1884, 1884, 1884, 1885, 1885, 1885, 1888, 1889, 1892, 1895, 1896,
	1899, 1901, 1904, 1911, 1912, 1913, 1920, 1923, 1924, 1929, 1930,
	1933, 1967, 1969, 1975, 1983, 1988, 1989, 1990, 1996)

# Density estimates

	d1 <- density(sub1, from=1500, to=1990, bw="sj", adjust=2.5)  # adjust=2.5  to more nearly equate
	d2 <- density(sub2, from=1500, to=1990, bw="sj", adjust=0.75)  # adjust=0.75
	f1 <- d1$y # * length(sub1)
	f2 <- d2$y # * length(sub2)
	
	ref <-c(1600, 1700, 1800, 1850, 1900, 1950, 1975)
	abline(v= ref, lty=2, lwd=1, col="blue")
	labx<-c(1550, 1650, 1750, 1825, 1875, 1925, 1962, 1987)

	txt1 <-c("Early maps\n& diagrams",
		 "Measurement\n& theory", 
		 "New graphic\nforms", 
		 "Modern\nage", 
		 "Golden\nAge", 
#		 "Modern dark\nage", 
		 "Dark\nage", 
		 "Re-birth", 
		 "Hi-Dim\nVis")


png(filename=here("figs", "00_1-mileyears4.png"), res=300, width=9, height=6, units="in", pointsize=16)
#svg(filename=here("figs", "00_1-mileyears4.svg"), width=9, height=6, pointsize=16)
	 
oldpar <- par(lheight=0.8, mar=c(4,4.2,3,1)+.1, yaxt="n")
	xlim <- range(c(d1$x, d2$x), na.rm=TRUE)
	ylim <- range(0, f1, f2)
	lab1 <- sprintf("Europe\n(n=%d)", length(sub1))
	lab2 <- sprintf("North\nAmerica\n(n=%d)", length(sub2))
	
	plot(d1, xlim=xlim, ylim=ylim, col="red", lwd=3,
		main="Where and when graphical milestones occurred",
		xlab="Year", ylab="Frequency",
		cex.lab=1.5)
	lines(d2, xlim=xlim, ylim=ylim, col="blue", lwd=3)
	# reference lines: divide epochs
	abline(v= ref, lty="longdash", col="brown")
	# epoch labels, tweaked
	laby <- 0.008 + 0.0008 * c(0, 1, 2, 3, 5, 3, 5, 3)
	laby <- 0.008 + 0.0008 * c(5, 3, 5, 3, 5, 3, 5, 3)
	text(labx, laby, labels=txt1, cex=1.1, xpd=TRUE)
	# curve labels
	text(1550, 0.001, lab1, col="blue", pos=3, cex=1.3)
	text(1950, 0.0045, lab2, col="red", cex=1.3)
	
	rug(sub1, quiet=TRUE, col="red", line=-.9)
	rug(sub2, quiet=TRUE, col="blue")

par <- oldpar
dev.off()
