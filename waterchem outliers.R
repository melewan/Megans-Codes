### Outlier Checking ###

### QAQC of WaterChem2020 ###

# Load packages
library(tidyverse)

# Set Working Directory
setwd("C:/Users/melewan/Desktop/R WaterChem")

# Import WaterChem2020 file
waterchem20 <- read.csv("C:/Users/melewan/Desktop/R WaterChem/WaterChem2020.csv", 
                        header = TRUE)

# Change BDLs to 0
waterchem20$TP [waterchem20$TP == "BDL"]<-0
waterchem20$SRP [waterchem20$SRP == "BDL"]<-0
waterchem20$Ammonia [waterchem20$Ammonia == "BDL"]<-0
waterchem20$AmmoniaOrganicN [waterchem20$AmmoniaOrganicN == "BDL"]<-0
waterchem20$TSS [waterchem20$TSS == "BDL"]<-0

## Add matrix to the end of mean1mB dataframe depicting where outliers are
# Add new columns for outlier matrix
waterchem20outliers = waterchem20
waterchem20outliers = add_column(waterchem20outliers, TP.Outliers = 0, .after = "ValueQualifierChem")
waterchem20outliers = add_column(waterchem20outliers, SRP.Outliers = 0, .after = "TP.Outliers")
waterchem20outliers = add_column(waterchem20outliers, TN.Outliers = 0, .after = "SRP.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Ammonia.Outliers = 0, .after = "TN.Outliers")
waterchem20outliers = add_column(waterchem20outliers, AON.Outliers = 0, .after = "Ammonia.Outliers")
waterchem20outliers = add_column(waterchem20outliers, NOx.Outliers = 0, .after = "AON.Outliers")
waterchem20outliers = add_column(waterchem20outliers, TSS.Outliers = 0, .after = "NOx.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Chloride.Outliers = 0, .after = "TSS.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Fluoride.Outliers = 0, .after = "Chloride.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Silica.Outliers = 0, .after = "Fluoride.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Sulfate.Outliers = 0, .after = "Silica.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Chl.Outliers = 0, .after = "Sulfate.Outliers")
waterchem20outliers = add_column(waterchem20outliers, Pheo.Outliers = 0, .after = "Chl.Outliers")

# Change columns to numeric
waterchem20outliers$TP <- as.numeric(waterchem20outliers$TP)
waterchem20outliers$SRP <- as.numeric(waterchem20outliers$SRP)
waterchem20outliers$Ammonia <- as.numeric(waterchem20outliers$Ammonia)
waterchem20outliers$AmmoniaOrganicN <- as.numeric(waterchem20outliers$AmmoniaOrganicN)
waterchem20outliers$TSS <- as.numeric(waterchem20outliers$TSS)
waterchem20outliers$Chl <- as.numeric(waterchem20outliers$Chl, na.rm = TRUE)
waterchem20outliers$Pheo <- as.numeric(waterchem20outliers$Pheo, na.rm = TRUE)

## Find minor and major thresholds ##

## Minor
MinorOutliers = function(waterchem20outliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(waterchem20outliers, na.rm = TRUE)[2]
  upperq = quantile(waterchem20outliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  minorresult = which(waterchem20outliers > threshold.upper & waterchem20outliers < extreme.threshold.upper
                      | waterchem20outliers < threshold.lower & waterchem20outliers > extreme.threshold.lower)
}
# Run function on all 7 parameters
MinorOutliersPositions = lapply(waterchem20outliers[,9:21], MinorOutliers) 


## Major
MajorOutliers <- function(waterchem20outliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(waterchem20outliers, na.rm = TRUE)[2]
  upperq = quantile(waterchem20outliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  result <- which(waterchem20outliers > extreme.threshold.upper | 
                    waterchem20outliers < extreme.threshold.lower)
}
# Run function on all 7 parameters
MajorOutliersPositions = lapply(waterchem20outliers[,9:21], MajorOutliers)

# create a matrix labeling outliers

waterchem20outliers$TP.Outliers[MinorOutliersPositions$TP] = 1
waterchem20outliers$TP.Outliers[MajorOutliersPositions$TP] = 2

waterchem20outliers$SRP.Outliers[MinorOutliersPositions$SRP] = 1
waterchem20outliers$SRP.Outliers[MajorOutliersPositions$SRP] = 2

waterchem20outliers$TN.Outliers[MinorOutliersPositions$TN] = 1
waterchem20outliers$TN.Outliers[MajorOutliersPositions$TN] = 2

waterchem20outliers$Ammonia.Outliers[MinorOutliersPositions$Ammonia] = 1
waterchem20outliers$Ammonia.Outliers[MajorOutliersPositions$Ammonia] = 2

waterchem20outliers$AON.Outliers[MinorOutliersPositions$AmmoniaOrganicN] = 1
waterchem20outliers$AON.Outliers[MajorOutliersPositions$AmmoniaOrganicN] = 2

waterchem20outliers$NOx.Outliers[MinorOutliersPositions$NOx] = 1
waterchem20outliers$NOx.Outliers[MajorOutliersPositions$NOx] = 2

waterchem20outliers$TSS.Outliers[MinorOutliersPositions$TSS] = 1
waterchem20outliers$TSS.Outliers[MajorOutliersPositions$TSS] = 2

waterchem20outliers$Chloride.Outliers[MinorOutliersPositions$Chloride] = 1
waterchem20outliers$Chloride.Outliers[MajorOutliersPositions$Chloride] = 2

waterchem20outliers$Fluoride.Outliers[MinorOutliersPositions$Fluoride] = 1
waterchem20outliers$Fluoride.Outliers[MajorOutliersPositions$Fluoride] = 2

waterchem20outliers$Silica.Outliers[MinorOutliersPositions$Silica] = 1
waterchem20outliers$Silica.Outliers[MajorOutliersPositions$Silica] = 2

waterchem20outliers$Sulfate.Outliers[MinorOutliersPositions$Sulfate] = 1
waterchem20outliers$Sulfate.Outliers[MajorOutliersPositions$Sulfate] = 2

waterchem20outliers$Chl.Outliers[MinorOutliersPositions$Chl] = 1
waterchem20outliers$Chl.Outliers[MajorOutliersPositions$Chl] = 2

waterchem20outliers$Pheo.Outliers[MinorOutliersPositions$Pheo] = 1
waterchem20outliers$Pheo.Outliers[MajorOutliersPositions$Pheo] = 2

# Save waterchem20outliers as a csv file
write.csv(waterchem20outliers, "WaterChem20Outliers.csv", na="NA", row.names = FALSE)
