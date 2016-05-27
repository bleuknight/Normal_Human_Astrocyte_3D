##import file from which host genes miRNA and snoRNAs were already omitted
allCoding<- read.csv("FPKMcoding.csv", header = TRUE)

##extract rownames of allCoding as vector
sort<- unlist(rownames(allCoding))

##separate FPKM that are ALL less than one into new data frame
lowFPKM<- subset(allCoding, MonolayerA_ln1<1 & MonolayerA_ln2<1 &MonolayerB_ln1<1 & 
        MonolayerB_ln2<1 & MatrixA_ln1<1 & MatrixB_ln1<1 & MatrixA_ln2<1 & MatrixB_ln2<1, )

##export file of all FPKM below 1
write.csv(lowFPKM, file ="FPKMbelow1.csv")

##extract rownames of lowFPKM as vector)
sort2<- unlist(rownames(lowFPKM))

##merge sort1 and sort2 into a single vector
merge<- c(sort, sort2)

##read vector merge as a data frame sorted by value
findIndex<- as.data.frame(sort(merge, decreasing = FALSE))

##determine duplicated values between lowFPKM and allCoding
##note that this is done backwards and forwards to reveal both locations of any value that is duplicated
findIndex$dup<- duplicated(findIndex)| duplicated(findIndex[nrow(findIndex):1, ])[nrow(findIndex):1]

##subset data based on column dup being false
keep<- subset(findIndex, findIndex$dup == FALSE)
rows<- as.character(keep$sort)
above1<- allCoding[rows, ]
str(above1)

##export file
write.csv(above1, file ="FPKMover1.csv")
