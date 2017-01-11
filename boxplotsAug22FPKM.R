library("digest")
library("ggplot2")

##import data

d2<- read.csv("FPKMover1.csv")

str(d2)

d<- d2
d$MonolayerA_ln1<- (d$MonolayerA_ln1 +0.01)
d$MonolayerA_ln2<- (d$MonolayerA_ln2 +0.01)
d$MonolayerB_ln1<- (d$MonolayerB_ln1 +0.01)
d$MonolayerB_ln2<- (d$MonolayerB_ln2 +0.01)
d$MatrixA_ln1<- (d$MatrixA_ln1 +0.01)
d$MatrixA_ln2<- (d$MatrixA_ln2 +0.01)
d$MatrixB_ln1<- (d$MatrixB_ln1 +0.01)
d$MatrixB_ln2<- (d$MatrixB_ln2 +0.01)



## format data
d.new <- d
d.new[, 2:9] <- log(d[2:9], 10)
d.new
str(d.new)
colnames(d.new)

require (reshape)
require (ggplot2)
long = melt(d.new, id.vars= "tracking_id")
long2 = melt(d2, id.vars= "tracking_id")
longNT = melt(d, id.vars= "tracking_id")

colnames(long)
long$variable

p <- ggplot(long, aes(variable, value, fill = variable))
p

##generate boxplots and assign color
p + geom_boxplot()  + stat_boxplot(geom ='errorbar') + scale_fill_manual(values=c("#660099", "#9966cc", "#cc99ff", "#ccccff", "#1b5e20", "#669966", "#99cc99",  "#CCFFCC" )) + theme_bw() + ylab("") + xlab("")  + theme(axis.text.x = element_text(angle = 90, hjust = 1, size=16)) + theme(axis.text.y = element_text(size = 16)) + theme(legend.text=element_text(size=16)) + ylim(-2.5, 7.5) 

