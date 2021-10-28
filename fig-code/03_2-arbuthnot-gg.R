#' ---
#' title: "03_2: Sex ratio. Arbuthnot's data on the ratio of male to female births"
#' author: "Michael Friendly"
#' date: "28 Oct 2021"
#' ---

library(ggplot2)
old <- theme_set( theme_gray() +
          theme(text = element_text(size = 18)))
theme_set(old)

cd("C:/Dropbox/Documents/TOGS/ch03-data/fig")

data(Arbuthnot, package="HistData")

ggplot(Arbuthnot, aes(x=Year, y=Ratio)) +
    ylim(1, 1.20) + 
    ylab("Sex Ratio (Male / Female)") +
    geom_point(pch=16, size=2) +
    geom_line(color="gray") +
    geom_smooth(method="loess", color="blue", fill="blue", size=1.25, alpha=0.1) +
#    geom_smooth(method="lm", color="darkgreen", se=FALSE) + 
    geom_hline(yintercept=mean(Arbuthnot$Ratio), lty="dashed", size=1.25) +
    geom_hline(yintercept=1, color="red", size=2) +
    annotate("text", x=1645, y=1.01, label="Males = Females", color="red", size=5) +
#    annotate("text", x=1680, y=1.19, 
#             label="Arbuthnot's data on the\nMale / Female Sex Ratio", size=5.5) +
    theme_bw() + theme(text = element_text(size = 16))

# set fig size??
ggsave(file="03_2-arbuthnot-gg.png", width=7, height=4.4, dpi=300)
 
ggsave(file="03_2-arbuthnot-gg.svg", width=7, height=4.4)
