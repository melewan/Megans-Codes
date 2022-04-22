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
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/
      Multi Year QC/QCCodeAndProcessing/BenthicChem All Years correlation (ggpairs)")

# load datasets from each year 
bc18 <- read_excel("BenthicChem2018_v3.xlsx", sheet = "BenthicChem")
bc19 = read_excel("BenthicChem2019_v3.xlsx", sheet = "MusselTissueWeights-CountsMerge")
bc20 = read_excel("BenthicChem2020_v2.xlsx", sheet = "NewTissueBulkWeight2020")
bc21 = read_excel("BenthicChem2021.xlsx", sheet = "DataRelease")

# combine wc dataframes row-wise
bc_combined = rbind(bc18, bc19, bc20, bc21)

# change BDLs to 0
bc_combined$DreissTotalWeight [bc_combined$DreissTotalWeight == "BDL"]<-0
bc_combined$DreissTissueWeight [bc_combined$DreissTissueWeight == "BDL"]<-0

# keep only necessary columns
bc = bc_combined[c("Year", "DreissTotalWeight", "DreissTissueWeight")]

# turn character columns into numeric
bc = sapply(bc, as.numeric, na.rm = TRUE)

### use chart.Correlation() to make bivariate comparison plots ###
chart.Correlation(bc, use = "pairwise.complete.obs")
# hit export under plots, export as PDF, PDF size = 7x12, landscape orientation



## Comparing each year to each other

# change BDLs to 0
bc18$DreissTotalWeight [bc18$DreissTotalWeight == "BDL"]<-0
bc18$DreissTissueWeight [bc18$DreissTissueWeight == "BDL"]<-0
bc19$DreissTotalWeight [bc19$DreissTotalWeight == "BDL"]<-0
bc19$DreissTissueWeight [bc19$DreissTissueWeight == "BDL"]<-0
bc20$DreissTotalWeight [bc20$DreissTotalWeight == "BDL"]<-0
bc20$DreissTissueWeight [bc20$DreissTissueWeight == "BDL"]<-0
bc21$DreissTotalWeight [bc21$DreissTotalWeight == "BDL"]<-0
bc21$DreissTissueWeight [bc21$DreissTissueWeight == "BDL"]<-0

# keep only necessary columns
bc18 = bc18[c("DreissTotalWeight", "DreissTissueWeight")]
bc19 = bc19[c("DreissTotalWeight", "DreissTissueWeight")]
bc20 = bc20[c("DreissTotalWeight", "DreissTissueWeight")]
bc21 = bc21[c("DreissTotalWeight", "DreissTissueWeight")]

# turn character columns into numeric
bc18 = sapply(bc18, as.numeric, na.rm = TRUE)
bc19 = sapply(bc19, as.numeric, na.rm = TRUE)
bc20 = sapply(bc20, as.numeric, na.rm = TRUE)
bc21 = sapply(bc21, as.numeric, na.rm = TRUE)

### use chart.Correlation() to make bivariate comparison plots ###


## hmmm figure out some other way to compare years exactly


chart.Correlation(bc, use = "pairwise.complete.obs")
# hit export under plots, export as PDF, PDF size = 7x12, landscape orientation
