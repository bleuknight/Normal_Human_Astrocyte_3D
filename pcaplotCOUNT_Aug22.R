source("https://bioconductor.org/biocLite.R")
library("DESeq")
library(RColorBrewer)

##import file 
geneTable<- read.csv("allcountdata.csv", header = TRUE)

##format data
geneTable<- na.omit(geneTable)
colnames(geneTable)
nams = geneTable$tracking_id
rownames(geneTable) = make.names(nams, unique = TRUE)
colnames(geneTable)
geneTable = geneTable[ , 2:9]
geneTable<- as.matrix(sapply(geneTable, as.integer)) 
deseqDesign = data.frame(
  row.names = colnames( geneTable ),
  condition = c( "monolayer", "monolayer",  "monolayer", "monolayer", "matrix", "matrix", "matrix", "matrix" ),
  donor = c( "A", "B",  "A", "B", "A", "B",  "A", "B") ) 

cds= newCountDataSet (geneTable, deseqDesign)
head(cds)
cds$condition


###normalization
cds = estimateSizeFactors( cds)

##estimate dispersions

cdsBlind<- estimateDispersions(cds, method = "blind")
vsdFull = varianceStabilizingTransformation(cdsBlind)

###divide each column of count table by size factor of the column to bring count values to common scale for comparison

head(counts(cds, normalized=TRUE))

##generate PCA plot

PCANAL<- plotPCA(vsdFull, intgroup=c("condition", "donor"))
print(PCANAL)

## change axis settings

old.options <- lattice.options(save.object = TRUE)
old.options
update(trellis.last.object(), ylim = (c(-25, 20)), xlim = (c(-42, 45)))

