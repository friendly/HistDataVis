#' ---
#' title: "06_9: Reconstruction of Herschel's graph"
#' author: "Michael Friendly"
#' date: "31 Oct 2021"
#' ---

library(readr)
library(dplyr)
library(ggplot2)
library(ggrepel)

#setwd("C:/Users/friendly/Dropbox/Documents/TOGS/ch06-scat/R/")

#Herschel1 <- read_delim("herschel1.dat", 
#                        ";", escape_double = FALSE, trim_ws = TRUE)

# Herschel's data on gamma Virginis from p. 35 of Herschel Micrometrical measures;

Herschel1 <- read_delim('
epoch;degrees;minutes;distance;weight;authority;notes 
1718.19;160;52;NA;4;Pound;
1718.20;160;52;NA;4;Bradley;
1720.31;139;7;7.49;1;Cassini;very uncertain
1756.00;144;22;6.50;4;Mayer;
1780.06;NA;NA;5.70;4;H.;Catalog 1782
1781.89;130;44;NA;4;H.;Catalog 1782
1803.20;120;15;NA;5;H.;Mean of 8 measures
1819.40;NA;NA;3.56;4;Sigma;Descriptio Tubi Fraunhof p 17
1820.20;105;15;NA;4;Sigma;
1822.25;103;24;3.79;4;Sh.;Phil Trans 1824
1822.50;102;24;NA;4;Sigma;
1825.32;96;53;3.26;4;S.;Phil Trans
1825.35;97;58;2.38;4;Sigma;
1828.35;90;30;NA;1;h.;One night measure. no reliance
1829.16;NA;NA;1.79;2;h.;2 nights obs
1829.22;87;43;NA;2;h.;2 nights obs
1830.24;NA;NA;2.22;5;h.;6 nights obs
1830.38;82;5;NA;4;h.;
', 	delim=";", 
    escape_double = FALSE, 
    trim_ws = TRUE)

# calculate position angles, adjust weight
Herschel1 %<>%
    mutate(posangle = degrees + minutes/60) %>% 
    mutate(weight = ifelse(weight==1, 0.5, weight))
View(Herschel1)

#Herschel2 <- read_table2("herschel2.dat")
#  Table 1 (p190): 
#	Interpolated posangle,
#	Angular velocity, calculated as slopes,
#	Separation distance, calculated as 1/sqrt(velocity)

Herschel2 <- read_table2('
year degrees minutes velocity distance
1720  160  0  -0.32   17.2
1730  156 40  -0.354  16.81
1740  153  0  -0.376  16.31
1750  148 55  -0.416  15.50
1760  144 25  -0.478  14.46
1770  139 45  -0.533  13.70
1780  134 30  -0.547  13.52
1790  128 35  -0.597  12.94
1800  122 25  -0.632  12.58
1810  115 30  -0.800  11.18
1815  111 20  -0.929  10.37
1820  106 15  -1.092   9.57
1825   98 20  -1.987   7.09
1830   84 20  -4.165   4.90
')

Herschel2 <- herschel2 %>%
  mutate(posangle = degrees + minutes/60) 

# use unicode for Sigma
Herschel1$auth <- ifelse(Herschel1$authority == "Sigma", "\u03A3", Herschel1$authority)

set.seed(142)
labs <- geom_text_repel(data=Herschel1, na.rm=TRUE,
                        aes(x=epoch, y=posangle, label=auth))

title <- expression(paste("Herschel data on ", gamma, italic("Virginis") ))

p <-
  ggplot(data=Herschel1, aes(x=epoch, y=posangle)) +
  geom_point(color="black", na.rm = TRUE) +
  geom_point(pch=1, aes(size=weight), na.rm = TRUE, show.legend = FALSE) +
  labs(x="Year", y="Position angle (deg.)") +
  geom_line(data=Herschel2, aes(x=year, y=posangle), 
            color="red", size=1.25, na.rm = TRUE) +
  geom_smooth(data=Herschel1, aes(x=epoch, y=posangle, weight=weight), 
              method="loess", formula = y ~ x,
              na.rm = TRUE, se=FALSE, color="grey") 

p <-
	p +
  annotate("text", x=1800, y=160, label=title, size=6) +
  theme_bw() +
  theme(text = element_text(size=16))
  
p + labs

ggsave(filename = "herschel-rplot.png", h=5, w=1.25*5, dpi=300)
ggsave(filename = "herschel-rplot.svg", h=5, w=1.25*5)
ggsave(filename = "herschel-rplot.pdf", h=5, w=1.25*5)
