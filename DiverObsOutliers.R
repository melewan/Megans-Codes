### Outlier Checking ###
h
## DiverObs 2021 Outlier QAQC ##

# Load packages
library(tidyverse)
library(readxl)

# Set Working Directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2021")

# Import diverobs2021 file
diverobs2021 <- read_excel("DiverObs2021.xlsx",
                               sheet = "DiverObsDataRelease")

# remove unnecessary columns
diverobs2021 <- subset(diverobs2021, select = -c(15,24,26,33,35,42,44))

# Change non-numeric values to a numeric value
diverobs2021$Substrate_Fines [diverobs2021$Substrate_Fines == "trace"]<-1
diverobs2021$Substrate_Sand [diverobs2021$Substrate_Sand == "trace"]<-1
diverobs2021$Substrate_Gravel [diverobs2021$Substrate_Gravel == "trace"]<-1
diverobs2021$Substrate_Cobble [diverobs2021$Substrate_Cobble == "trace"]<-1
diverobs2021$Substrate_Boulder [diverobs2021$Substrate_Boulder == "trace"]<-1
diverobs2021$Substrate_Bedrock [diverobs2021$Substrate_Bedrock == "trace"]<-1
diverobs2021$Substrate_BrokenShells [diverobs2021$Substrate_BrokenShells == "trace"]<-1
diverobs2021$SAVCover [diverobs2021$SAVCover == "trace"]<-1
diverobs2021$DreissCover [diverobs2021$DreissCover == "trace"]<-1
diverobs2021$GobyCount [diverobs2021$GobyCount == "X"]<-NA
diverobs2021$Q1_DreissCover [diverobs2021$Q1_DreissCover == "trace"]<-1
diverobs2021$Q1_EmptyShells [diverobs2021$Q1_EmptyShells == "trace"]<-1
diverobs2021$Q1_SAVCover [diverobs2021$Q1_SAVCover == "trace"]<-1
diverobs2021$Q1_EmptyShells [diverobs2021$Q1_EmptyShells == "trace"]<-1
diverobs2021$Q1_SAVheightMin [diverobs2021$Q1_SAVheightMin == "X"]<-NA
diverobs2021$Q1_SAVheightMax [diverobs2021$Q1_SAVheightMax == "X"]<-NA
diverobs2021$Q1_1SubstrateCover [diverobs2021$Q1_1SubstrateCover == "trace"]<-1
diverobs2021$Q1_2SubstrateCover [diverobs2021$Q1_2SubstrateCover == "trace"]<-1
diverobs2021$Q1_2SubstrateCover [diverobs2021$Q1_2SubstrateCover == "X"]<-NA
diverobs2021$Q2_DreissCover [diverobs2021$Q2_DreissCover == "trace"]<-1
diverobs2021$Q2_EmptyShells [diverobs2021$Q2_EmptyShells == "trace"]<-1
diverobs2021$Q2_SAVCover [diverobs2021$Q2_SAVCover == "trace"]<-1
diverobs2021$Q2_EmptyShells [diverobs2021$Q2_EmptyShells == "trace"]<-1
diverobs2021$Q2_SAVheightMin [diverobs2021$Q2_SAVheightMin == "X"]<-NA
diverobs2021$Q2_SAVheightMax [diverobs2021$Q2_SAVheightMax == "X"]<-NA
diverobs2021$Q2_1SubstrateCover [diverobs2021$Q2_1SubstrateCover == "trace"]<-1
diverobs2021$Q2_2SubstrateCover [diverobs2021$Q2_2SubstrateCover == "trace"]<-1
diverobs2021$Q2_2SubstrateCover [diverobs2021$Q2_2SubstrateCover == "X"]<-NA
diverobs2021$Q3_DreissCover [diverobs2021$Q3_DreissCover == "trace"]<-1
diverobs2021$Q3_EmptyShells [diverobs2021$Q3_EmptyShells == "trace"]<-1
diverobs2021$Q3_SAVCover [diverobs2021$Q3_SAVCover == "trace"]<-1
diverobs2021$Q3_EmptyShells [diverobs2021$Q3_EmptyShells == "trace"]<-1
diverobs2021$Q3_SAVheightMin [diverobs2021$Q3_SAVheightMin == "X"]<-NA
diverobs2021$Q3_SAVheightMax [diverobs2021$Q3_SAVheightMax == "X"]<-NA
diverobs2021$Q3_1SubstrateCover [diverobs2021$Q3_1SubstrateCover == "trace"]<-1
diverobs2021$Q3_2SubstrateCover [diverobs2021$Q3_2SubstrateCover == "trace"]<-1
diverobs2021$Q3_2SubstrateCover [diverobs2021$Q3_2SubstrateCover == "X"]<-NA

## Add matrix to the end of mean1mB dataframe depicting where outliers are
# Add new columns for outlier matrix
diverobs2021outliers = diverobs2021
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Fines.Outliers = 0,
                                  .after = "ValueQualifier")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Sand.Outliers = 0,
                                  .after = "Substrate_Fines.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Gravel.Outliers = 0, 
                                  .after = "Substrate_Sand.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Cobble.Outliers = 0, 
                                  .after = "Substrate_Gravel.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Boulder.Outliers = 0, 
                                  .after = "Substrate_Cobble.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_Bedrock.Outliers = 0, 
                                  .after = "Substrate_Boulder.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, 
                                  Substrate_BrokenShells.Outliers = 0, 
                                  .after = "Substrate_Bedrock.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, SAVCover.Outliers = 0, 
                                      .after = "Substrate_BrokenShells.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, DreissCover.Outliers = 0, 
                                      .after = "SAVCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, GobyCount.Outliers = 0, 
                                      .after = "DreissCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, GobySizeMin.Outliers = 0, 
                                      .after = "GobyCount.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, GobySizeMax.Outliers = 0, 
                                      .after = "GobySizeMin.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_DreissCover.Outliers = 0, 
                                      .after = "GobySizeMax.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_EmptyShells.Outliers = 0, 
                                      .after = "Q1_DreissCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_SAVCover.Outliers = 0, 
                                      .after = "Q1_EmptyShells.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_SAVheightMin.Outliers = 0, 
                                  .after = "Q1_SAVCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_SAVheightMax.Outliers = 0, 
                                  .after = "Q1_SAVheightMin.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_1SubstrateCover.Outliers = 0, 
                                  .after = "Q1_SAVheightMax.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q1_2SubstrateCover.Outliers = 0, 
                                  .after = "Q1_1SubstrateCover.Outliers")

diverobs2021outliers = add_column(diverobs2021outliers, Q2_DreissCover.Outliers = 0, 
                                  .after = "Q1_2SubstrateCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_EmptyShells.Outliers = 0, 
                                  .after = "Q2_DreissCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_SAVCover.Outliers = 0, 
                                  .after = "Q2_EmptyShells.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_SAVheightMin.Outliers = 0, 
                                  .after = "Q2_SAVCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_SAVheightMax.Outliers = 0, 
                                  .after = "Q2_SAVheightMin.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_1SubstrateCover.Outliers = 0, 
                                  .after = "Q2_SAVheightMax.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q2_2SubstrateCover.Outliers = 0, 
                                  .after = "Q2_1SubstrateCover.Outliers")


diverobs2021outliers = add_column(diverobs2021outliers, Q3_DreissCover.Outliers = 0, 
                                  .after = "Q2_2SubstrateCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_EmptyShells.Outliers = 0, 
                                  .after = "Q3_DreissCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_SAVCover.Outliers = 0, 
                                  .after = "Q3_EmptyShells.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_SAVheightMin.Outliers = 0, 
                                  .after = "Q3_SAVCover.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_SAVheightMax.Outliers = 0, 
                                  .after = "Q3_SAVheightMin.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_1SubstrateCover.Outliers = 0, 
                                  .after = "Q3_SAVheightMax.Outliers")
diverobs2021outliers = add_column(diverobs2021outliers, Q3_2SubstrateCover.Outliers = 0, 
                                  .after = "Q3_1SubstrateCover.Outliers")


# Change columns to numeric

diverobs2021outliers[, c(6:38)] = sapply(diverobs2021outliers[, c(6:38)],
                                         as.numeric)

## Find minor and major thresholds ##

## Minor
MinorOutliers = function(diverobs2021outliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(diverobs2021outliers, na.rm = TRUE)[2]
  upperq = quantile(diverobs2021outliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  minorresult = which(diverobs2021outliers > threshold.upper & diverobs2021outliers < extreme.threshold.upper
                      | diverobs2021outliers < threshold.lower & diverobs2021outliers > extreme.threshold.lower)
}
# Run function on all 7 parameters
MinorOutliersPositions = lapply(diverobs2021outliers[,6:38], MinorOutliers) 


## Major
MajorOutliers <- function(diverobs2021outliers) {
  # calculate upper and lower quartiles
  lowerq = quantile(diverobs2021outliers, na.rm = TRUE)[2]
  upperq = quantile(diverobs2021outliers, na.rm = TRUE)[4]
  iqr = upperq - lowerq
  # minor thresholds
  threshold.lower = lowerq - (iqr * 1.5)
  threshold.upper = (iqr * 1.5) + upperq
  # major thresholds
  extreme.threshold.lower = lowerq - (iqr * 3)
  extreme.threshold.upper = (iqr * 3) + upperq
  # result in list
  result <- which(diverobs2021outliers > extreme.threshold.upper | 
                    diverobs2021outliers < extreme.threshold.lower)
}
# Run function on all 7 parameters
MajorOutliersPositions = lapply(diverobs2021outliers[,6:38], MajorOutliers)

# create a matrix labeling outliers

diverobs2021outliers$Substrate_Fines.Outliers[MinorOutliersPositions$
                                                Substrate_Fines] = 1
diverobs2021outliers$Substrate_Fines.Outliers[MajorOutliersPositions$
                                                Substrate_Fines] = 2

diverobs2021outliers$Substrate_Sand.Outliers[MinorOutliersPositions$
                                               Substrate_Sand] = 1
diverobs2021outliers$Substrate_Sand.Outliers[MajorOutliersPositions$
                                               Substrate_Sand] = 2

diverobs2021outliers$Substrate_Gravel.Outliers[MinorOutliersPositions$
                                                 Substrate_Gravel] = 1
diverobs2021outliers$Substrate_Gravel.Outliers[MajorOutliersPositions$
                                                 Substrate_Gravel] = 2

diverobs2021outliers$Substrate_Cobble.Outliers[MinorOutliersPositions$
                                                 Substrate_Cobble] = 1
diverobs2021outliers$Substrate_Cobble.Outliers[MajorOutliersPositions$
                                                 Substrate_Cobble] = 2

diverobs2021outliers$Substrate_Boulder.Outliers[MinorOutliersPositions$
                                                  Substrate_Boulder] = 1
diverobs2021outliers$Substrate_Boulder.Outliers[MajorOutliersPositions$
                                                  Substrate_Boulder] = 2

diverobs2021outliers$Substrate_Bedrock.Outliers[MinorOutliersPositions$
                                                  Substrate_Bedrock] = 1
diverobs2021outliers$Substrate_Bedrock.Outliers[MajorOutliersPositions$
                                                  Substrate_Bedrock] = 2

diverobs2021outliers$Substrate_BrokenShells.Outliers[MinorOutliersPositions$
                                                       Substrate_BrokenShells] = 1
diverobs2021outliers$Substrate_BrokenShells.Outliers[MajorOutliersPositions$
                                                       Substrate_BrokenShells] = 2

diverobs2021outliers$SAVCover.Outliers[MinorOutliersPositions$SAVCover] = 1
diverobs2021outliers$SAVCover.Outliers[MajorOutliersPositions$SAVCover] = 2

diverobs2021outliers$DreissCover.Outliers[MinorOutliersPositions$DreissCover] = 1
diverobs2021outliers$DreissCover.Outliers[MajorOutliersPositions$DreissCover] = 2

diverobs2021outliers$GobyCount.Outliers[MinorOutliersPositions$GobyCount] = 1
diverobs2021outliers$GobyCount.Outliers[MajorOutliersPositions$GobyCount] = 2

diverobs2021outliers$GobySizeMin.Outliers[MinorOutliersPositions$GobySizeMin] = 1
diverobs2021outliers$GobySizeMin.Outliers[MajorOutliersPositions$GobySizeMin] = 2

diverobs2021outliers$GobySizeMax.Outliers[MinorOutliersPositions$GobySizeMax] = 1
diverobs2021outliers$GobySizeMax.Outliers[MajorOutliersPositions$GobySizeMax] = 2

diverobs2021outliers$Q1_DreissCover.Outliers[MinorOutliersPositions$
                                               Q1_DreissCover] = 1
diverobs2021outliers$Q1_DreissCover.Outliers[MajorOutliersPositions$
                                               Q1_DreissCover] = 2

diverobs2021outliers$Q1_EmptyShells.Outliers[MinorOutliersPositions$
                                               Q1_EmptyShells] = 1
diverobs2021outliers$Q1_EmptyShells.Outliers[MajorOutliersPositions$
                                               Q1_EmptyShells] = 2

diverobs2021outliers$Q1_SAVCover.Outliers[MinorOutliersPositions$
                                            Q1_SAVCover] = 1
diverobs2021outliers$Q1_SAVCover.Outliers[MajorOutliersPositions$
                                            Q1_SAVCover] = 2

diverobs2021outliers$Q1_SAVheightMin.Outliers[MinorOutliersPositions$
                                                Q1_SAVheightMin] = 1
diverobs2021outliers$Q1_SAVheightMin.Outliers[MajorOutliersPositions$
                                                Q1_SAVheightMin] = 2

diverobs2021outliers$Q1_SAVheightMax.Outliers[MinorOutliersPositions$
                                                Q1_SAVheightMax] = 1
diverobs2021outliers$Q1_SAVheightMax.Outliers[MajorOutliersPositions$
                                                Q1_SAVheightMax] = 2

diverobs2021outliers$Q1_1SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q1_1SubstrateCover] = 1
diverobs2021outliers$Q1_1SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q1_1SubstrateCover] = 2

diverobs2021outliers$Q1_2SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q1_2SubstrateCover] = 1
diverobs2021outliers$Q1_2SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q1_2SubstrateCover] = 2


diverobs2021outliers$Q2_DreissCover.Outliers[MinorOutliersPositions$
                                               Q2_DreissCover] = 1
diverobs2021outliers$Q2_DreissCover.Outliers[MajorOutliersPositions$
                                               Q2_DreissCover] = 2

diverobs2021outliers$Q2_EmptyShells.Outliers[MinorOutliersPositions$
                                               Q2_EmptyShells] = 1
diverobs2021outliers$Q2_EmptyShells.Outliers[MajorOutliersPositions$
                                               Q2_EmptyShells] = 2

diverobs2021outliers$Q2_SAVCover.Outliers[MinorOutliersPositions$
                                            Q2_SAVCover] = 1
diverobs2021outliers$Q2_SAVCover.Outliers[MajorOutliersPositions$
                                            Q2_SAVCover] = 2

diverobs2021outliers$Q2_SAVheightMin.Outliers[MinorOutliersPositions$
                                                Q2_SAVheightMin] = 1
diverobs2021outliers$Q2_SAVheightMin.Outliers[MajorOutliersPositions$
                                                Q2_SAVheightMin] = 2

diverobs2021outliers$Q2_SAVheightMax.Outliers[MinorOutliersPositions$
                                                Q2_SAVheightMax] = 1
diverobs2021outliers$Q2_SAVheightMax.Outliers[MajorOutliersPositions$
                                                Q2_SAVheightMax] = 2

diverobs2021outliers$Q2_1SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q2_1SubstrateCover] = 1
diverobs2021outliers$Q2_1SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q2_1SubstrateCover] = 2

diverobs2021outliers$Q2_2SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q2_2SubstrateCover] = 1
diverobs2021outliers$Q2_2SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q2_2SubstrateCover] = 2


diverobs2021outliers$Q3_DreissCover.Outliers[MinorOutliersPositions$
                                               Q3_DreissCover] = 1
diverobs2021outliers$Q3_DreissCover.Outliers[MajorOutliersPositions$
                                               Q3_DreissCover] = 2

diverobs2021outliers$Q3_EmptyShells.Outliers[MinorOutliersPositions$
                                               Q3_EmptyShells] = 1
diverobs2021outliers$Q3_EmptyShells.Outliers[MajorOutliersPositions$
                                               Q3_EmptyShells] = 2

diverobs2021outliers$Q3_SAVCover.Outliers[MinorOutliersPositions$
                                            Q3_SAVCover] = 1
diverobs2021outliers$Q3_SAVCover.Outliers[MajorOutliersPositions$
                                            Q3_SAVCover] = 2

diverobs2021outliers$Q3_SAVheightMin.Outliers[MinorOutliersPositions$
                                                Q3_SAVheightMin] = 1
diverobs2021outliers$Q3_SAVheightMin.Outliers[MajorOutliersPositions$
                                                Q3_SAVheightMin] = 2

diverobs2021outliers$Q3_SAVheightMax.Outliers[MinorOutliersPositions$
                                                Q3_SAVheightMax] = 1
diverobs2021outliers$Q3_SAVheightMax.Outliers[MajorOutliersPositions$
                                                Q3_SAVheightMax] = 2

diverobs2021outliers$Q3_1SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q3_1SubstrateCover] = 1
diverobs2021outliers$Q3_1SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q3_1SubstrateCover] = 2

diverobs2021outliers$Q3_2SubstrateCover.Outliers[MinorOutliersPositions$
                                                   Q3_2SubstrateCover] = 1
diverobs2021outliers$Q3_2SubstrateCover.Outliers[MajorOutliersPositions$
                                                   Q3_2SubstrateCover] = 2

# Save diverobs2021outliers as a csv file
write.csv(diverobs2021outliers, "DiverObs2021Outliers.csv", na="NA", row.names = FALSE)
