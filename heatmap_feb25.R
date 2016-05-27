

##install packages as necessary

library(gplots)
library(RColorBrewer)

##import file
data<- read.csv("allcountdata.csv", comment.char="#")

data<- data[ , 2:9]

str(data)
##omit NA
na.dist <- function(x,...) {
  t.dist <- dist(x,...)
  t.dist <- as.matrix(t.dist)
  t.limit <- 1.1*max(t.dist,na.rm=T)
  t.dist[is.na(t.dist)] <- t.limit
  t.dist <- as.dist(t.dist)
  return(t.dist)
}

mat_data<- data.matrix(data)
head(mat_data, n=10)
str(mat_data)

##create a color palette from red to green

my_palette<- colorRampPalette(c("white", "grey", "black")) (n = 299)

##define color breaks manually for a skewed color transition

col_breaks = c(seq(-1,0,length=100),  # for red
               seq(0,0.8,length=100),              # for yellow
               seq(0.8,1,length=100))              # for green



mat_data<- data.matrix(mat_data[])

heatmap.2(mat_data, 
          distfun = na.dist,
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          margins =c(12,9),     # widens margins around plot
          col=my_palette,       # use on color palette defined earlier 
          breaks=col_breaks,    # enable color transition at specified limits
          dendrogram="column",     # only draw a column dendrogram
          Rowv="NA"            # turn off row clustering
        )
help(heatmap.2)

