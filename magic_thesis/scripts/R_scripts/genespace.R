Sys.setenv(DISPLAY = "")
options(bitmapType = "cairo")

# if (!requireNamespace("devtools", quietly = TRUE))
#   install.packages("devtools")
# library(devtools)
# devtools::install_github("jtlovell/GENESPACE")
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install(c("Biostrings", "rtracklayer"))
# if (!requireNamespace("reticulate", quietly = TRUE))
#   install.packages("reticulate")

library(GENESPACE)
#library(reticulate)
#Sys.setenv(RETICULATE_CONDA = "/global/home/users/mtandean/miniforge3/bin/conda")
#use_condaenv("genespace_env", required = TRUE)
 conda_bin <- "/global/home/users/mtandean/miniforge3/envs/genespace_env2/bin"
 #Sys.setenv(PATH = paste0(conda_bin, ":", Sys.getenv("PATH")))
 print(Sys.getenv("PATH"))
#print(Sys.getenv("PATH"))
# library(devtools)

###############################################
# -- change paths to those valid on your system
#genomeRepo <-"~/scratch/magic_thesis/intermediate_data/assembly/contig_assemblies/"
wd <- "~/scratch/magic_thesis/intermediate_data/annotation/genespace"
path2mcscanx <- "~/miniforge3/envs/genespace_env2/bin/"
###############################################
#system('export PATH="/global/home/users/mtandean/miniforge3/envs/genespace_env2/bin:$PATH"')




# -- initalize the run and QC the inputs
gpar <- init_genespace(
  wd = wd, 
  path2mcscanx = "~/bin/MCScanX",
  path2diamond = "~/miniforge3/envs/genespace_env2/bin/diamond",
  path2orthofinder = file.path(conda_bin, "orthofinder"),
  nCores=9)


# -- accomplish the run
setwd(wd)
out <- run_genespace(gpar)

debug(system2)

