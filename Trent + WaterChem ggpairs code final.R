### QAQC of Trent + WaterChem points using ggpairs ###

# load ggplot package for ggpairs() function
library(ggplot2)
library(GGally)
library(readxl)
library(plyr)
library(dplyr)
library(tidyverse)
library(PerformanceAnalytics)

# set working directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/Multi Year QC/TrentOutliers/All Years Outlier QC")

# load datasets from each year 
trent <- read_excel("trentoutliers.xlsx", sheet = "trentoutliers")
wc18 = read_excel("WaterChem_2018_v2.xlsx", sheet = "DataRelease_v2")
wc19 = read_excel("Water_Chem_2019_V2.xlsx", sheet = "data for release_2")
wc20 = read_excel("WaterChem2020.xlsx", sheet = "WaterChem2020")

# combine wc dataframes row-wise
wc_combined = rbind(wc18, wc19, wc20)

# remove rows with depth of 1 m
wc_combinedB <- subset(wc_combined, Depth != "1m") 

# ID column 
trent = add_column(trent, ID = 0, .after = "Depth")
wc_combinedB = add_column(wc_combinedB, ID = 0, .after = "Station")

# before merge, must have one common column
for(i in 1:nrow(trent)) {
  
  year = trent$Year[i]
  month = trent$Month[i]
  transect = trent$Site[i]
  station = trent$Depth[i]
  IDname = paste(year, month, transect, station)
 
  trent$ID[i] = IDname
}

for(i in 1:nrow(wc_combinedB)) {
  
  year = wc_combinedB$Year[i]
  month = wc_combinedB$Month[i]
  transect = wc_combinedB$Transect[i]
  station = wc_combinedB$Station[i]
  IDname = paste(year, month, transect, station)
  
  wc_combinedB$ID[i] = IDname
}
  
# combine wc and trent dataframes column-wise
trentwc = merge(x=trent,y=wc_combinedB,by="ID",all.x=TRUE)

# change BDLs to 0
trentwc$TP [trentwc$TP == "BDL"]<-0
trentwc$TN [trentwc$TN == "BDL"]<-0

# turn character columns into numeric
trentwc[, -c(1:6,44:50,64)] = sapply(trentwc[, -c(1:6,44:50,64)], 
                                     as.numeric, na.rm = TRUE)

### use chart.Correlation() to make bivariate comparison plots ###

# trim dataframe to exclude non-numerics - ONLY columns we want to compare
# separate into plots by benthic type
trentwcclad = trentwc[c("Clad_C","Clad_N","Clad_P","Clad_CN",
                    "Clad_CP","Clad_NP","TP","TN")]
trentwcmus = trentwc[c("Mus_C","Mus_N","Mus_P","Mus_CN",
                       "Mus_CP","Mus_NP","TP","TN")]
trentwcsed = trentwc[c("Sed_C","Sed_N","Sed_P","Sed_CN",
                       "Sed_CP","Sed_NP","TP","TN")]

# Clad correlation
chart.Correlation(trentwcclad, use = "pairwise.complete.obs")
# hit export under plots, export as PDF, PDF size = 7x12, landscape orientation

# Mus correlation
chart.Correlation(trentwcmus, use = "pairwise.complete.obs")
# hit export under plots, export as PDF, PDF size = 7x12, landscape orientation

# Sed correlation
chart.Correlation(trentwcsed, use = "pairwise.complete.obs")
# hit export under plots, export as PDF, PDF size = 7x12, landscape orientation

