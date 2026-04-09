rm(list=ls())
library(geodata)
library(sf)
library(ggplot2)
library(maps)
prefix <- "CLIMATIC_ANALYSIS_"

setwd("~/scratch/magic_thesis")
wd <- getwd()

ecotype_info_path <- paste0(wd, '/meta_info/1TG_regmap_accessions.csv')
parent_info_path <- paste0(wd, '/meta_info/MAGIC_parents.csv')
region_key_path <- paste0(wd, '/meta_info/unsd_regions.csv')
climatic_figures_path <- paste0(wd, '/figures/climate_analysis')

#load data
worldclim_data <- worldclim_global('bio', 10, paste0(wd,'/climate_data'))
ecotype_data <- read.csv(ecotype_info_path)
world_coords <- map_data("world")
parents_data <- read.csv(parent_info_path)
region_key <- read.csv(region_key_path, sep = ";")


#rename columns
colnames(ecotype_data)[colnames(ecotype_data) == "longitude"]  = "lon"
colnames(ecotype_data)[colnames(ecotype_data) == "latitude"]  = "lat"

#extract coordinates for each ecotype in non-corrected, also drop NAs and (0,0) coords
ecotype_data <- ecotype_data[ecotype_data$lat!=0 & ecotype_data$lat!=0,]
ecotype_data <- na.omit(ecotype_data)
coordinates <- ecotype_data[, c("lon", "lat")]

values <- extract(worldclim_data, coordinates)[, -1]
climate_by_ecotype <- cbind(coordinates, values)

is_parent <- ecotype_data$ecotype_id %in% parents_data$ecotype_id

#plot ecotype locations on map 
#cut off southern hemisphere, have white background
ecotype_map <- ggplot() + coord_sf(ylim = c(0, 100), xlim = c(-150, 150)) + 
  geom_map(data = world_coords, map = world_coords,
           aes(map_id = region),
           color = "black", fill="lightgray", linewidth = 0.2) + 
  theme(panel.background = element_rect(fill = "white")) +
  geom_point(data = coordinates[!is_parent,], aes(x = lon, 
                                                  y = lat, color = "Other"))  +
  geom_point(data = coordinates[is_parent,],
             aes(x = lon, y = lat, color = "MAGIC Parent")) +
  scale_color_manual(name="", values=c("MAGIC Parent" = "tomato", 
                                       "Other" = "black"), 
                     labels = c("MAGIC Parent", "Other")) + 
  xlab("Longitude (\u00B0)") + ylab("Latitude (\u00B0)")

ggsave(paste0(prefix, "ecotype_coordinates_map.pdf"), 
       device="pdf",path=climatic_figures_path)

#center and scale climate data
scaled_numeric_climate <- scale(values, center = TRUE, scale = TRUE)

#run and plot pca
pca_climate <- prcomp(scaled_numeric_climate)
pca_climate_points <- as.data.frame(pca_climate$x[,1:2])
climate_pc_percent <- round(summary(pca_climate)$importance[2, c(1, 2)] * 100, 1)

pc12_climate_plot <- ggplot() + geom_point(data = pca_climate_points[!is_parent,], 
                                           aes(x = PC1, y = PC2, color = "Other"), cex=3) + 
  geom_point(data = pca_climate_points[is_parent,],
             aes(x = PC1, y = PC2, color = "MAGIC Parent"), cex=3) +
  labs(x = paste0("PC1 (", climate_pc_percent[1], "%)"),
       y = paste0("PC2 (", climate_pc_percent[2], "%)")) +
  scale_color_manual(name="",  values=c("MAGIC Parent" = "tomato", 
                                        "Other" = "black"), labels = c("MAGIC Parent", "Other")) + 
  theme_classic()

ggsave(paste0(prefix, "pc12_climate_plot.pdf"), 
       device = "pdf", path = climatic_figures_path)

#plot loadings for each var to PC1 and PC2
climate_loadings <- as.data.frame(pca_climate$rotation[,1:2])
pc12_loadings_plot <- ggplot() + 
  geom_segment(data = climate_loadings, aes(x = 0, y = 0, xend = PC1, yend = PC2), 
               color = "black",arrow = arrow(), lineend="round", linewidth=0.5) +
  labs(x = paste0("PC1 (", climate_pc_percent[1], "%)"),
       y = paste0("PC2 (", climate_pc_percent[2], "%)")) + 
  #geom_text(data = climate_loadings,
  #aes(x=PC1,y=PC2,label=rownames(climate_loadings))) +
  theme_bw()

ggsave(paste0(prefix, "pca_loadings_climate_plot.pdf"), 
       device="pdf", path = climatic_figures_path)

#hierarchical clustering:
pc_distance_matrix <- dist(pca_climate$x[,1:2], method="euclidean")
pca_hc <- hclust(pc_distance_matrix, method = "ward.D")
pdf(paste0(climatic_figures_path,'/',prefix,"pca_hc_dendrogram.pdf"))
plot(pca_hc, labels = FALSE, xlab = "", sub = "")
rect.hclust(pca_hc, k = 4)
dev.off()

hc_labels <- cutree(pca_hc, k = 8)

#plot pca scores with clustering labels:
pca_climate_points$clust <- hc_labels
pc12_climate_plot2_hc <- ggplot() + geom_point(data = pca_climate_points,
                                               aes(x = PC1, y = PC2, color = factor(hc_labels)),cex=3) +
  labs(x = paste0("PC1 (", climate_pc_percent[1], "%)"),
       y = paste0("PC2 (", climate_pc_percent[2], "%)")) +
  geom_point(data = pca_climate_points[is_parent,], 
             aes(x=PC1,y=PC2,shape="MAGIC Parent"), fill = "transparent", 
             color = "black", stroke = 1, cex=3) +
  guides(colour = guide_legend("Cluster"))  +
  scale_shape_manual(name="",values=c("MAGIC Parent" = 21)) +
  theme_classic(base_size = 18)

ggsave(paste0(prefix, "pc12_climate_plot_hc.pdf"), 
       device="pdf", path = climatic_figures_path)

clustering_map <- ggplot() + coord_sf(ylim = c(0, 100), xlim = c(-150, 150)) + 
  geom_map(data = world_coords, map = world_coords,
           aes(map_id = region),
           color = "black", fill="lightgray", linewidth = 0.2) + 
  theme(panel.background = element_rect(fill = "white")) +
  geom_point(data = ecotype_data, aes(x = lon, y = lat, color = factor(hc_labels)))  +
  geom_point(data = ecotype_data[is_parent,], aes(x=lon,y=lat, shape="MAGIC Parent"),
             fill = "transparent", color = "black", stroke = 1) +
  guides(colour = guide_legend("Cluster")) +
  scale_shape_manual(name="",values=c("MAGIC Parent" = 21)) + 
  xlab("Longitude (\u00B0)") + ylab("Latitude (\u00B0)") 

ggsave(paste0(prefix, "clustering_map.pdf"), 
       device="pdf", path = climatic_figures_path)

