if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
#BiocManager::install("gdsfmt")
#BiocManager::install("SNPRelate")
if (!requireNamespace("devtools", quietly=TRUE))
  install.packages("devtools")
install.packages("remotes")
library("devtools")
#install_github("zhengxwen/gdsfmt")
#install_github("zhengxwen/SNPRelate")

library("gdsfmt")
library("SNPRelate")

prefix <- "GENETIC_ANALYSIS_"

setwd("~/scratch/magic_thesis")
wd <- getwd()

bed.fn <- file.path(wd, "/intermediate_data/genetic_pca/1001g_regmap_mac10_pca.bed")
fam.fn <- file.path(wd, "/intermediate_data/genetic_pca/1001g_regmap_mac10_pca.fam")
bim.fn <- file.path(wd, "/intermediate_data/genetic_pca/1001g_regmap_mac10_pca.bim")

snpgdsBED2GDS(bed.fn, fam.fn, bim.fn, "1001g.gds")

snpgdsSummary("1001g.gds")

genofile <- snpgdsOpen("1001g.gds")

set.seed(1000)

# Try different LD thresholds for sensitivity analysis
snpset02 <- snpgdsLDpruning(genofile, ld.threshold=0.2)
snpset02.id <- unlist(unname(snpset02))


snpset_01 <- snpgdsLDpruning(genofile, ld.threshold=0.1)
snpset_01.id <- unlist(unname(snpset_01))

snpset_08 <- snpgdsLDpruning(genofile, ld.threshold=0.8)
snpset_08.id <- unlist(unname(snpset_08))

pca_02 <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=2)
pc.percent <- pca_02$varprop*100
head(round(pc.percent, 2))

tab <- data.frame(sample.id = pca_02$sample.id,
                  EV1 = pca_02$eigenvect[,1],    # the first eigenvector
                  EV2 = pca_02$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)
head(tab)

plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

# Get sample id
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))

# Get population information
#   or pop_code <- scan("pop.txt", what=character())
#   if it is stored in a text file "pop.txt"
pop_code <- read.gdsn(index.gdsn(genofile, "sample.annot/pop.group"))

# assume the order of sample IDs is as the same as population codes
head(cbind(sample.id, pop_code))