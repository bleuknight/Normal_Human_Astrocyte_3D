res <- read.table("volcanothreshold.txt", header=TRUE)
head(res)

# Make a basic volcano plot
with(res, plot(log2FoldChange, -log10(padj), pch=20, main="Volcano plot", xlim=c(-5.5, 5.5), ylim=c(0, 20), cex.axis = 1.75, cex.lab = 1.5))

# Add colored points: red if padj<0.001, orange if p adj < 0.01, green if padj<0.1)

with(subset(res, padj<.1 & abs(log2FoldChange)>2), points(log2FoldChange, -log10(pvalue), pch=20, col="green"))
with(subset(res, padj<.01 & abs(log2FoldChange)>2 ), points(log2FoldChange, -log10(pvalue), pch=20, col="orange"))
with(subset(res, padj<.001 & abs(log2FoldChange)>2 ), points(log2FoldChange, -log10(pvalue), pch=20, col="red"))