library("pheatmap")

##import data
df3<- read.csv(file = "df3.csv")

top10 <- read.csv(file = "115mostexpressed.csv", header = TRUE)
head(df3)
head (top10)

##format data
rownames(df3)<-  c("MonolayerA_ln1", "MonolayerA_ln2", "MonolayerB_ln1",
                   "MonolayerB_ln2", "MatrixA_ln1",    "MatrixA_ln2",   
                   "MatrixB_ln1",    "MatrixB_ln2")
rownames(df3)
rownames(top10)<- top10$tracking_id
top10<- top10[ , 2:9]
str(top10)
rownames(top10)


## assign color values

ann_colors = list( Lane = c(One = "slateblue", Two = "slategray1"), Donor = c(A = "blue", B = "cornflowerblue"),
                   Condition = c(Matrix = "#669966", Monolayer = "#660099"))

## Generate heatmap

pheatmap(top10, cluster_rows=TRUE, show_rownames=TRUE, fontsize_row=5,
         fontsize = 16, cluster_cols=TRUE, annotation_col=df3, annotation_colors = ann_colors,
         color = colorRampPalette(c("navy", "limegreen", "gold"))(50))


