#' ---
#' title: "06_1: Modern scatterplot"
#' author: "Michael Friendly"
#' date: "30 Oct 2021"
#' ---



workers <- read.csv(text = '
Name,Income,Experience,Skill,Gender
Abby,20,0,2,Female
Betty,35,5,5,Female
Charles,40,5,8,Male
Doreen,30,10,6,Female
Ethan,50,10,10,Male
Francie,50,15,7,Female
Georges,60,20,12,Male
Harry,50,25,10,Male
Isaac,70,30,15,Male
Juan,60,35,13,Male
', header = TRUE)
 


#folder <- "C:/Users/friendly/Dropbox/Documents/TOGS/ch06-scat/R"
#cd(folder)


png(filename = "workers.png", height=5, width=6, units="in", res=300)
#svg(filename = "workers.svg", height=5, width=6)

op <- par(mar=c(5,5,1,1))
plot(Income ~ Experience, data=workers, 
	pch=20, cex=2.5, cex.lab=2,
	xlab="Experience (years)",
	ylab="Salary (1000 $)")

text(workers$Experience[10], workers$Income[10], labels=workers$Name[10],
		pos=2, cex=1.5)

par(op)
dev.off()



