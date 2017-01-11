FPKMin<- read.csv(file = "FPKMover1.csv", header = TRUE)
str(FPKMin)
distdata<- FPKMin[, 2:9]
str(distdata)


tdata<- t(distdata)
head(tdata)
rownames(tdata)
colnames(tdata)
distmatrix<- dist(as.matrix(tdata))
str(distmatrix)
sampleDistMatrix<- as.matrix(distmatrix)
rownames(sampleDistMatrix)
colnames(sampleDistMatrix)
library("pheatmap")
library("RColorBrewer")
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix, clustering_distance_rows=distmatrix, clustering_distance_cols= distmatrix, col=colors)
