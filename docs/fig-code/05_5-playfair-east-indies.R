#' ---
#' title: "05_5: Re-creating Playfair's graph of balance of trade with East Indies"
#' author: "Michael Friendly"
#' date: "29 Oct 2021"
#' ---

# originally from Unwin, GDA witth R, Fig 10.6

library(ggplot2)
library(patchwork)
library(here)

setwd("C:/Dropbox/Documents/TOGS/ch05-playfair/fig")
path <- "ch05-playfair/fig"

data(EastIndiesTrade,package="GDAdata")
c1 <- ggplot(EastIndiesTrade, aes(x=Year, y=Exports)) + 
             ylim(0,2000) + 
             geom_line(colour="black", size=2) + 
             geom_line(aes(x=Year, y=Imports), colour="red", size=2) +  
             geom_ribbon(aes(ymin=Exports, ymax=Imports), fill="pink",alpha=0.5) + 
             ylab("Exports and Imports (millions of pounds)") +
             annotate("text", x = 1710, y = 0, label = "Exports", size=5) +
             annotate("text", x = 1770, y = 1620, label = "Imports", color="red", size=5) +
             annotate("text", x = 1732, y = 1950, label = "Balance of Trade to the East Indies", color="black", size=6) +             
             theme_bw()
c2 <- ggplot(EastIndiesTrade, aes(x=Year,
             y=Imports-Exports)) + geom_line(colour="blue", size=2) +
             ylab("Balance = Imports - Exports (millions of pounds)") +
             geom_ribbon(aes(ymin=Imports-Exports, ymax=0), fill="pink",alpha=0.5) + 
             annotate("text", x = 1711, y = 30, label = "Our Deficit", color="black", size=6) +             
             theme_bw()
             

c3 = c1 + c2
ggsave("east-indies-ggplot2.png", width=10, height=4)  # uses dpi=300
ggsave("east-indies-ggplot2.svg", width=10, height=4)


