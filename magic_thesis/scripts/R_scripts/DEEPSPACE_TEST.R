if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
library(devtools)
devtools::install_github("jtlovell/DEEPSPACE")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("Biostrings", "rtracklayer", "GenomicRanges", "Rsamtools"))
if (!requireNamespace("reticulate", quietly = TRUE))
  install.packages("reticulate")

#usethis::create_github_token()
#gitcreds::gitcreds_set() 

library(reticulate)
Sys.setenv(RETICULATE_CONDA = "/global/home/users/mtandean/miniforge3/bin/conda")
use_condaenv("deepspace_env", required = TRUE)

library(devtools)
workHere <- "/global/home/users/mtandean/scratch/magic_thesis/tests/deepspace/new_run2" 
#dir.create(workHere)

fastaNames<- c("m84268_250919_003033_s1.hifi_reads.22571_XW.asm.bp.p_ctg.fa",
                "m84268_250919_003033_s1.hifi_reads.22582_XW.asm.bp.p_ctg.fa")

gIDs <- c("22571", "22582")
intermediate_data <- "/global/home/users/mtandean/scratch/magic_thesis/intermediate_data/assembly/contig_assemblies"
fastaFiles <- file.path(intermediate_data, fastaNames)
names(fastaFiles) <- gIDs
print(fastaFiles)

library(DEEPSPACE)
setwd(workHere)


test <- clean_windows(
  faFiles = fastaFiles,
  genomeIDs = gIDs,
  wd = workHere,
  minChrLen = 10e4, 
  
  nCores = 1,
  MCScanX_hCall = "/global/home/users/mtandean/miniforge3/envs/deepspace_env/bin/MCScanX_h",
  minimap2call = "/global/home/users/mtandean/miniforge3/envs/deepspace_env/bin/minimap2")

debug(system2)
undebug(system2)

#/global/home/users/mtandean/scratch/magic_thesis/tests/deepspace/run_mcscanx.sh"

cmd <- "/global/home/users/mtandean/miniforge3/envs/deepspace_env/bin/minimap2"
args <- c("-B4", "-f0.0001", "-o", "test.paf", "22571.fa", "22582.fa")

