#' ---
#' title: "06_21: Chocolate consumption and Nobel prizes"
#' author: "Michael Friendly"
#' date: "04 Nov 2021"
#' ---

# import the Nobel data here
Nobel <- read.csv("Nobel.csv")

library(ggplot2)
library(ggrepel)

# extract the model and parameters for annotations
mod <- lm(Nobel ~ Chocolate, data=Nobel)
slope <- coef(mod)[2]
R <- cor(Nobel[,-1])
r <- R[1, 5]

lab <- paste0("r = ", round(r, 2), "\np < 0.0001\nslope = ", round(as.numeric(slope), 2))


set.seed(12345)
ggplot(data=Nobel, aes(x=Chocolate, y=Nobel, label=Country)) +
	geom_point(size=3) +
	geom_text_repel(size=5) +
	labs(x="Chocolate Consumption (kg/year/capita)",
			 y="Nobel Laureates per 10M Population") +
	annotate("text", x=2, y=28, 
					label=lab, size=7) +
	geom_smooth(method="lm", formula="y~x", se=FALSE, size=1.4) +
	theme_bw() +
	theme(axis.title = element_text(size = rel(1.5)),
				panel.grid = element_blank())

ggsave(filename = "06_21-nobel-chocolate.png", w=8.5, h=7)
ggsave(filename = "06_21-nobel-chocolate.svg", w=8.5, h=7)
