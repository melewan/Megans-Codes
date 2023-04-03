### Outlier Checking ###

### QAQC of WaterChem2020 ###

# Load packages
library(tidyverse)
library(readxl)

# Set Working Directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2021/WaterChem")

# Import WaterChem2020 file
waterchem <- read_excel("WaterChem2021.xlsx", na="NA")

# Change BDLs to 0
waterchem$TP [waterchem$TP == "BDL"]<-0
waterchem$SRP [waterchem$SRP == "BDL"]<-0
waterchem$Ammonia [waterchem$Ammonia == "BDL"]<-0
waterchem$AmmoniaOrganicN [waterchem$AmmoniaOrganicN == "BDL"]<-0
waterchem$TSS [waterchem$TSS == "BDL"]<-0

## Add matrix to the end of mean1mB dataframe depicting where outliers are
# Add new columns for outlier matrix
waterchemoutliers = waterchem
waterchemoutliers = add_column(waterchemoutliers, TP.Outliers = 0, .after = "ValueQualifierChem")
waterchemoutliers = add_column(waterchemoutliers, SRP.Outliers = 0, .after = "TP.Outliers")
waterchemoutliers = add_column(waterchemoutliers, TN.Outliers = 0, .after = "SRP.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Ammonia.Outliers = 0, .after = "TN.Outliers")
waterchemoutliers = add_column(waterchemoutliers, AON.Outliers = 0, .after = "Ammonia.Outliers")
waterchemoutliers = add_column(waterchemoutliers, NOx.Outliers = 0, .after = "AON.Outliers")
waterchemoutliers = add_column(waterchemoutliers, TSS.Outliers = 0, .after = "NOx.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Chloride.Outliers = 0, .after = "TSS.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Fluoride.Outliers = 0, .after = "Chloride.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Silica.Outliers = 0, .after = "Fluoride.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Sulfate.Outliers = 0, .after = "Silica.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Chl.Outliers = 0, .after = "Sulfate.Outliers")
waterchemoutliers = add_column(waterchemoutliers, Pheo.Outliers = 0, .after = "Chl.Outliers")

# Change columns to numeric
waterchemoutliers$TP <- as.numeric(waterchemoutliers$TP)
waterchemoutliers$SRP <- as.numeric(waterchemoutliers$SRP)
waterchemoutliers$Ammonia <- as.numeric(waterchemoutliers$Ammonia)
waterchemoutliers$AmmoniaOrganicN <- as.numeric(waterchemoutliers$AmmoniaOrganicN)
waterchemoutliers$TSS <- as.numeric(waterchemoutliers$TSS)
waterchemoutliers$Chl <- as.numeric(waterchemoutliers$Chl, na.rm = TRUE)
waterchemoutliers$Pheo <- as.numeric(waterchemoutliers$Pheo, na.rm = TRUE)

## Find minor and major thresholds ##

## Minor
MinorOutliers = function(waterchemoutliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(waterchemoutliers, na.rm = TRUE)[2]
  upperq = quantile(waterchemoutliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  minorresult = which(waterchemoutliers > threshold.upper & waterchemoutliers < extreme.threshold.upper
                      | waterchemoutliers < threshold.lower & waterchemoutliers > extreme.threshold.lower)
}
# Run function on all 7 parameters
MinorOutliersPositions = lapply(waterchemoutliers[,9:21], MinorOutliers) 


## Major
MajorOutliers <- function(waterchemoutliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(waterchemoutliers, na.rm = TRUE)[2]
  upperq = quantile(waterchemoutliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  result <- which(waterchemoutliers > extreme.threshold.upper | 
                    waterchemoutliers < extreme.threshold.lower)
}
# Run function on all 7 parameters
MajorOutliersPositions = lapply(waterchemoutliers[,9:21], MajorOutliers)

# create a matrix labeling outliers

waterchemoutliers$TP.Outliers[MinorOutliersPositions$TP] = 1
waterchemoutliers$TP.Outliers[MajorOutliersPositions$TP] = 2

waterchemoutliers$SRP.Outliers[MinorOutliersPositions$SRP] = 1
waterchemoutliers$SRP.Outliers[MajorOutliersPositions$SRP] = 2

waterchemoutliers$TN.Outliers[MinorOutliersPositions$TN] = 1
waterchemoutliers$TN.Outliers[MajorOutliersPositions$TN] = 2

waterchemoutliers$Ammonia.Outliers[MinorOutliersPositions$Ammonia] = 1
waterchemoutliers$Ammonia.Outliers[MajorOutliersPositions$Ammonia] = 2

waterchemoutliers$AON.Outliers[MinorOutliersPositions$AmmoniaOrganicN] = 1
waterchemoutliers$AON.Outliers[MajorOutliersPositions$AmmoniaOrganicN] = 2

waterchemoutliers$NOx.Outliers[MinorOutliersPositions$NOx] = 1
waterchemoutliers$NOx.Outliers[MajorOutliersPositions$NOx] = 2

waterchemoutliers$TSS.Outliers[MinorOutliersPositions$TSS] = 1
waterchemoutliers$TSS.Outliers[MajorOutliersPositions$TSS] = 2

waterchemoutliers$Chloride.Outliers[MinorOutliersPositions$Chloride] = 1
waterchemoutliers$Chloride.Outliers[MajorOutliersPositions$Chloride] = 2

waterchemoutliers$Fluoride.Outliers[MinorOutliersPositions$Fluoride] = 1
waterchemoutliers$Fluoride.Outliers[MajorOutliersPositions$Fluoride] = 2

waterchemoutliers$Silica.Outliers[MinorOutliersPositions$Silica] = 1
waterchemoutliers$Silica.Outliers[MajorOutliersPositions$Silica] = 2

waterchemoutliers$Sulfate.Outliers[MinorOutliersPositions$Sulfate] = 1
waterchemoutliers$Sulfate.Outliers[MajorOutliersPositions$Sulfate] = 2

waterchemoutliers$Chl.Outliers[MinorOutliersPositions$Chl] = 1
waterchemoutliers$Chl.Outliers[MajorOutliersPositions$Chl] = 2

waterchemoutliers$Pheo.Outliers[MinorOutliersPositions$Pheo] = 1
waterchemoutliers$Pheo.Outliers[MajorOutliersPositions$Pheo] = 2

# Save waterchem20outliers as a csv file
write_xlsx(waterchemoutliers, "WaterChem2021Outliers.xlsx")
