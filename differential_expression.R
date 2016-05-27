source("http://bioconductor.org/biocLite.R")
biocLite("DESeq")
biocLite("BBmisc")
biocLite("GenomicAlignments")
biocLite("BBmisc")
library("BBmisc")
library("DESeq")



geneTable<- read.table("intoDeseq2.txt", header = TRUE)
nams = geneTable$SYMBOL
rownames(geneTable) = make.names(nams, unique = TRUE)
colnames(geneTable)
geneTable = geneTable[ , 2:5]
head(geneTable)
deseqDesign = data.frame(
  row.names = colnames( geneTable ),
  condition = c( "monolayer", "matrix", "monolayer",  "matrix" ),
  libType = c( "paired-end", "paired-end",  "paired-end", "paired-end") ) 
condition = deseqDesign$condition

condition

length(condition)

head(deseqDesign)

### setup DeSeq data set using gene table and condition created above

cds= newCountDataSet (geneTable, condition)

head(cds)

###normalization
cds = estimateSizeFactors( cds )
sizeFactors( cds )

###divide each column of count table by size factor of the column to bring count values to common scale for comparison

head(counts(cds, normalized=TRUE))

##estimate dispersions

cds=estimateDispersions(cds)

###view dispersions for quality control

str(fitInfo(cds))

plotDispEsts (cds)

##show dispersion values that are used in differential expression calls
head(fData(cds))

##estimate differentially expressed genes

res = nbinomTest(cds, "monolayer", "matrix")
head(res)

##chose statistic theta to filter counts by
library("genefilter")
theta = seq(from=0, to=0.5, by=0.1)
colnames(res)
pBH = filtered_p(filter=res$baseMean, test=res$pval, theta=theta, method="BH")
pBH

rejection_plot(pBH, at="sample",
               xlim=c(0, 0.5), ylim=c(0, 800),
               xlab="FDR cutoff (Benjamini & Hochberg adjusted p-value)", main="")
theta = seq(from=0, to=0.8, by=0.02)
rejBH = filtered_R(alpha=0.1, filter=res$baseMean, test=res$pval, theta=theta, method="BH")
plot(theta, rejBH, type="l",
     xlab=expression(theta), ylab="number of rejections")

##filter by theta, removing genes in lowest 40% quantile
rs = rowSums ( counts ( cds ))
theta = 0.4
use = (rs > quantile(rs, probs=theta))
table(use)
cdsFilt=cds[use, ]
head(cdsFilt)
cdsFilt= newCountDataSet (cdsFilt, condition)
head(fData(cdsFilt))

dif = nbinomTest(cdsFilt, "monolayer", "matrix")
head(dif)


write.table(dif, file="DESeqOutputFilt.txt", sep="\t")