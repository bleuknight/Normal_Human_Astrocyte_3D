#separate noncoding RNAs based on suffix
##import file from which host genes (HGXX) miRNA and snoRNAs were already omitted
inclSome<- read.csv("FPKM_omit.csv", header = TRUE)

##convert factor tracking_id to new column in data frame that is a character string
inclSome$codingSeq<- as.character(inclSome$tracking_id)

##search for noncoding suffixes for antisense and intronic RNA in character string
inclSome$noncode<- grepl("-AS|-IT", inclSome$codingSeq)

##separate coding and noncoding sequences into separate data frames
omitNoncode<- inclSome[inclSome$noncode == FALSE, ]
Noncode<- inclSome[inclSome$noncode == TRUE, ]

##write to merge with excel workbook of noncoding genes already omitted
write.csv(omitNoncode, file = "FPKMcoding.csv")
write.csv(Noncode, file = "noncoding.csv")


