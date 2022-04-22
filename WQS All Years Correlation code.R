### QAQC of WQP 1m & B points ###

# load ggplot package for ggpairs() function
library(PerformanceAnalytics)
library(readxl)

# set working directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/
      Multi Year QC/QCCodeAndProcessing/Codes for Outlier Analysis + Correlations
      /WaterQualitySummary QAQC")

# load datasets from each year 
wqs18 = read_excel("WaterChem_v2.xlsx", sheet = "DataRelease_v2")
wqs19 = read_excel("Water_Chem_2019_V2.xlsx", sheet = "data for release_2")
wqs20 = read_excel("WaterQualitySummary2020.xlsx", sheet = "Data Release")
wqs21 = read_excel("WaterQualitySummary2021OutlierQAQC.xlsx", sheet = "WaterQualitySummary2021")

# subset dataframes by necessary columns
wqs18sub = subset(wqs18, select = c("DepthAveTemp", "DepthAveSpCond","DepthAvepH", 
                                    "DepthAveTurb", "DepthAveDO", "DepthAveChl", "DepthAvePhyco"))
wqs19sub = subset(wqs19, select = c("DepthAveTemp", "DepthAveSpCond","DepthAvepH", 
                                    "DepthAveTurb", "DepthAveDO", "DepthAveChl", "DepthAvePhyco"))
wqs20sub = subset(wqs20, select = c("DepthAveTemp", "DepthAveSpCond","DepthAvepH",
                                    "DepthAveTurb", "DepthAveDO", "DepthAveChl", "DepthAvePhyco"))
wqs21sub = subset(wqs21, select = c("DepthAveTemp", "DepthAveSpCond","DepthAvepH",
                                    "DepthAveTurb", "DepthAveDO", "DepthAveChl", "DepthAvePhyco"))

# combine dataframes row-wise
wqs_combined = rbind(wqs18sub, wqs19sub, wqs20sub, wqs21sub)

# change BDLs to 0
wqs_combined$DepthAveTurb [wqs_combined$DepthAveTurb == "BDL"]<-0
wqs_combined$DepthAveChl [wqs_combined$DepthAveChl == "BDL"]<-0
wqs_combined$DepthAvePhyco [wqs_combined$DepthAvePhyco == "BDL"]<-0

# turn character columns into numeric
wqs_combined[, c(1:7)] = sapply(wqs_combined[, c(1:7)], as.numeric)

# remove turbidity outlier
wqs_combined$DepthAveTurb[wqs_combined$DepthAveTurb == 5358.5490625] = NA

# use chart.Correlation() to make bivariate comparison plots
chart.Correlation(wqs_combined, use = "pairwise.complete.obs")
