#' ---
#' title: "07_1: Milestones timeline"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---

#' The time-distribution of events considered milestones in the history of data visualization

# NB: Data here originally came from the Milestones Project database
#setwd("c:/sasuser/milestones")
#mileyears <- read.csv("mileyears3.csv", skip=1, col.names=c("key","year","where","add","junk"))
#mileyears <- mileyears[,2:3]


library(here)

# all milestone events up to 1999

subset<- c(1530, 1533, 1545, 1550, 1556, 1562, 1569, 1570, 1572, 1581,
1605, 1603, 1603, 1614, 1617, 1624, 1623, 1626, 1632, 1637, 1644,
1646, 1654, 1654, 1657, 1663, 1662, 1666, 1669, 1671, 1686, 1686,
1687, 1693, 1693, 1701, 1710, 1711, 1712, 1724, 1727, 1745, 1741,
1748, 1752, 1752, 1752, 1753, 1765, 1760, 1763, 1765, 1765, 1781,
1776, 1778, 1779, 1782, 1782, 1782, 1785, 1786, 1787, 1794, 1795,
1796, 1798, 1798, 1800, 1800, 1801, 1801, 1809, 1811, 1817, 1819,
1825, 1821, 1822, 1825, 1827, 1828, 1832, 1830, 1832, 1833, 1833,
1833, 1833, 1836, 1836, 1837, 1838, 1839, 1839, 1843, 1843, 1843,
1844, 1846, 1846, 1851, 1852, 1853, 1855, 1857, 1857, 1857, 1861,
1861, 1863, 1868, 1869, 1869, 1869, 1872, 1872, 1872, 1872, 1873,
1874, 1874, 1874, 1874, 1875, 1875, 1877, 1877, 1877, 1878, 1878,
1879, 1879, 1889, 1880, 1882, 1882, 1883, 1884, 1884, 1884, 1884,
1884, 1885, 1885, 1885, 1888, 1889, 1892, 1895, 1896, 1899, 1901,
1904, 1905, 1910, 1910, 1911, 1912, 1913, 1913, 1913, 1913, 1914,
1914, 1915, 1920, 1916, 1917, 1925, 1919, 1920, 1923, 1923, 1924,
1925, 1926, 1929, 1928, 1928, 1929, 1930, 1931, 1933, 1942, 1937,
1939, 1944, 1944, 1957, 1957, 1958, 1962, 1965, 1966, 1965, 1967,
1968, 1969, 1969, 1969, 1971, 1971, 1971, 1972, 1973, 1973, 1974,
1974, 1974, 1974, 1975, 1975, 1975, 1975, 1975, 1976, 1977, 1977,
1978, 1978, 1979, 1981, 1981, 1981, 1982, 1982, 1983, 1983, 1985,
1985, 1987, 1988, 1988, 1989, 1989, 1990, 1990, 1990, 1990, 1990,
1991, 1991, 1993, 1992, 1994, 1996, 1999)


den <- density(subset, from=1500, to=1990, bw="sj")

#  standard plot -- all together
w=9.8
h=5.6
png(filename="figs/07_1-mileyears3.png", res=300, width=w, height=h, units="in", pointsize=13)
#svg(filename="figs/07_1-mileyears3.svg", width=w, height=h, pointsize=13)

oldpar <- par(lheight=0.8, mar=c(4,4,3,1)+.1, yaxt="n", cex.main=1.3)
plot(density(subset, from=1500, to=1990, bw="sj"), lwd=2.5,
	main="Milestones: Time course of development",
	xlab="Year",
	ylab="Frequency",
	xlim = c(1500, 2002),
	cex.lab=1.5)
rect(1840, 0, 1910, 0.005, col=grey(.90, alpha=0.6), border=NA)

ref <-c(1600, 1700, 1800, 1850, 1900, 1950, 1975)
abline(v= ref, lty=2, lwd=1, col="blue")

	labx<-c(1550, 1650, 1750, 1825, 1875, 1925, 1962, 1997)
	laby<- 0.003 + 0.0003 * c(0, 1, 2, 3, 6, 3, 5, 2)
	labsize <- c(rep(1.2, 4), 1.5, rep(1.15, 3))
	txt1 <-c("Early maps\n& diagrams",
		 "Measurement\n& theory", 
		 "New graphic\nforms", 
		 "Begin\nmodern\nperiod", 
		 "Golden Age", 
		 "Modern dark\nages", 
		 "Re-birth", 
		 "Hi-D\nVis")
#oldpar <- par(lheight=0.8)
#text(labx, laby, labels=txt1, cex=1.2, xpd=TRUE)
text(labx, laby, labels=txt1, 
	cex=labsize, xpd=TRUE)

rug(subset, quiet=TRUE)
par(oldpar)

dev.off()
