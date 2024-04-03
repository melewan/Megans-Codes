# 1 m vs. B analysis #

##### NA - Old Import of Data #####
# adcp18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2018/DataRelease/ADCP2018_v2.csv", header = TRUE)
# #bb18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/BenthicBiomass_v2.csv", header = TRUE)
# #bc18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/BenthicChem_v2.csv", header = TRUE)
# wc18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2018/DataRelease/WaterChem2018_v2.csv", header = TRUE)
# 
# adcp19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/ADCP2019v2.csv", header = TRUE)
# #bb19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/BenthicBiomass.csv", header = TRUE) 
# #bc19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/BenthicChem.csv", header = TRUE)
# wc19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/Water_Chem_2019_V2.csv", header = TRUE)
# 
# wc20 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/WaterChem2020.csv", header = TRUE)
# conf.int <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/ConfidenceIntervals2020.csv", header = TRUE)
# 
# wc21 = read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/WaterChem2021.csv")
# adcp21 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/ADCP2021v2.csv", header = TRUE)
# 
# wc22 = read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/WaterChem2022.csv")
# adcp22 = read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/1 m vs. B/Data files/ADCP2022.csv", header = TRUE)


##### 1) Formatting data files #####

#load packages
library(plyr)
library(dplyr)
library(tidyverse)
library(hms)
library(ggpubr)
library(lubridate)
library(fuzzyjoin)

# Import Data Release files from server

# 2018
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2018/DataRelease")
wc18 <- read.csv("WaterChem2018_v2.csv", header = TRUE)
  wc18 <- select(wc18, -c("ValueQualifier", "ValueQualifierChem", "SpCondLab"))
adcp18 <- read.csv("ADCP2018_v2.csv", header = TRUE)

# 2019
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2019/DataRelease")
wc19 <- read.csv("WaterChem2019_v2.csv", header = TRUE)
  wc19 <- select(wc19, -c("ValueQualifier", "ValueQualifierChem", "Notes", "MaxDepth"))
adcp19 <- read.csv("ADCP2019_v2.csv", header = TRUE)

# 2020
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2020/DataRelease")
wc20 <- read.csv("WaterChem2020_v2.csv", header = TRUE)
  wc20 <- select(wc20, -c("ValueQualifierChem"))
  
# 2021
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2021/Data Release")
wc21 <- read.csv("WaterChem2021.csv", header = TRUE)
  wc21 <- select(wc21, -c("ValueQualifierChem", "Notes"))
adcp21 <- read.csv("ADCP2021.csv", header = TRUE)

# 2022
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2022/DataRelease")
wc22 <- read.csv("WaterChem2022.csv", header = TRUE)
  wc22 <- select(wc22, -c("ValueQualifierChem"))
adcp22 <- read.csv("ADCP.csv", header = TRUE)
  
# Confidence Interval file
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/Water Nutrient Accumulation/Data files")
conf.int <- read.csv("ConfidenceIntervals2021.csv", header = TRUE)

### TODO Once 2023 waterchem is ready, put proper pathway here ###
wc23 = read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2023mockup.csv")



# import files from desktop when server is slow
setwd("C:/Users/melewan/Desktop/Data files")

adcp18 <- read.csv("C:/Users/melewan/Desktop/Data files/ADCP2018_v2.csv", header = TRUE)
wc18 <- read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2018_v2.csv", header = TRUE)

adcp19 <- read.csv("C:/Users/melewan/Desktop/Data files/ADCP2019_v2.csv", header = TRUE)
wc19 <- read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2019_v2.csv", header = TRUE)

wc20 <- read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2020_v2.csv", header = TRUE)

wc21 = read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2021.csv")
adcp21 <- read.csv("C:/Users/melewan/Desktop/Data files/ADCP2021.csv", header = TRUE)

wc22 = read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2022.csv")
adcp22 = read.csv("C:/Users/melewan/Desktop/Data files/ADCP.csv", header = TRUE)

wc23 = read.csv("C:/Users/melewan/Desktop/Data files/WaterChem2023mockup.csv")

conf.int <- read.csv("C:/Users/melewan/Desktop/Data files/ConfidenceIntervals2021.csv", header = TRUE)

#Load wind data files in .txt format
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Communications/Papers/Water Nutrient Accumulation/Data files/NOAA Wind Data (not using)")

ws_erie18 <- read.table(file = "erep1h2018.txt", header = TRUE)
ws_erie18 <- ws_erie18 [-1,]
ws_erie19 <- read.table(file = "erep1h2019.txt", header = TRUE)
ws_erie19 <- ws_erie19 [-1,]
ws_erie20 <- read.table(file = "erep1h2020.txt", header = TRUE)
ws_erie20 <- ws_erie20 [-1,]
ws_erie21 <- read.table(file = "erep1h2021.txt", header = TRUE)
ws_erie21 <- ws_erie21 [-1,]
 
ws_huron18 <- read.table(file = "lpnm4h2018.txt", header = TRUE)
ws_huron18 <- ws_huron18 [-1,]
ws_huron19 <- read.table(file = "lpnm4h2019.txt", header = TRUE)
ws_huron19 <- ws_huron19 [-1,]
ws_huron20 <- read.table(file = "lpnm4h2020.txt", header = TRUE)
ws_huron20 <- ws_huron20 [-1,]
ws_huron21 <- read.table(file = "lpnm4h2021.txt", header = TRUE)
ws_huron21 <- ws_huron21 [-1,]

ws_mmc18 <- read.table(file = "45170h2018.txt", header = TRUE)
ws_mmc18 <- ws_mmc18 [-1,]

ws_mwa19 <- read.table(file = "45174h2019.txt", header = TRUE)
ws_mwa19 <- ws_mwa19 [-1,]
ws_mwa20 <- read.table(file = "45174h2020.txt", header = TRUE)
ws_mwa20 <- ws_mwa20 [-1,]
ws_mwa21 <- read.table(file = "45174h2021.txt", header = TRUE)
ws_mwa21 <- ws_mwa21 [-1,]

ws_msb18 <- read.table(file = "45183h2018.txt", header = TRUE)
ws_msb18 <- ws_msb18 [-1,]
ws_msb19 <- read.table(file = "45183h2019.txt", header = TRUE)
ws_msb19 <- ws_msb19 [-1,]
ws_msb20 <- read.table(file = "45183h2020.txt", header = TRUE)
ws_msb20 <- ws_msb20 [-1,]
ws_msb21 <- read.table(file = "45183h2021.txt", header = TRUE)
ws_msb21 <- ws_msb21 [-1,]

ws_oir18 <- read.table(file = "rprn6h2018.txt", header = TRUE)
ws_oir18 <- ws_oir18 [-1,]
ws_oir19 <- read.table(file = "rprn6h2019.txt", header = TRUE)
ws_oir19 <- ws_oir19 [-1,]
ws_oir21 <- read.table(file = "rprn6h2021.txt", header = TRUE)
ws_oir21 <- ws_oir21 [-1,]

ws_ool18 <- read.table(file = "olcn6h2018.txt", header = TRUE)
ws_ool18 <- ws_ool18 [-1,]
ws_ool19 <- read.table(file = "olcn6h2019.txt", header = TRUE)
ws_ool19 <- ws_ool19 [-1,]
ws_ool21 <- read.table(file = "olcn6h2021.txt", header = TRUE)
ws_ool21 <- ws_ool21 [-1,]

ws_osi18 <- read.table(file = "osgn6h2018.txt", header = TRUE)
ws_osi18 <- ws_osi18 [-1,]

ws_osn19 <- read.table(file = "osgn6h2019.txt", header = TRUE)
ws_osn19 <- ws_osn19 [-1,]

#Rename columns in ws df's to match Data Release Files 

names(ws_erie18)[1] = "Year"
names(ws_erie18)[2] = "Month"
names(ws_erie18)[3] = "Day"
names(ws_erie18)[4] = "Hour"
names(ws_erie18)[5] = "Minute"
names(ws_erie18)[6] = "WDIR"
names(ws_erie18)[7] = "WSPD"

names(ws_erie19)[1] = "Year"
names(ws_erie19)[2] = "Month"
names(ws_erie19)[3] = "Day"
names(ws_erie19)[4] = "Hour"
names(ws_erie19)[5] = "Minute"
names(ws_erie19)[6] = "WDIR"
names(ws_erie19)[7] = "WSPD"

names(ws_huron18)[1] = "Year"
names(ws_huron18)[2] = "Month"
names(ws_huron18)[3] = "Day"
names(ws_huron18)[4] = "Hour"
names(ws_huron18)[5] = "Minute"
names(ws_huron18)[6] = "WDIR"
names(ws_huron18)[7] = "WSPD"

names(ws_huron19)[1] = "Year"
names(ws_huron19)[2] = "Month"
names(ws_huron19)[3] = "Day"
names(ws_huron19)[4] = "Hour"
names(ws_huron19)[5] = "Minute"
names(ws_huron19)[6] = "WDIR"
names(ws_huron19)[7] = "WSPD"

names(ws_mmc18)[1] = "Year"
names(ws_mmc18)[2] = "Month"
names(ws_mmc18)[3] = "Day"
names(ws_mmc18)[4] = "Hour"
names(ws_mmc18)[5] = "Minute"
names(ws_mmc18)[6] = "WDIR"
names(ws_mmc18)[7] = "WSPD"

names(ws_msb18)[1] = "Year"
names(ws_msb18)[2] = "Month"
names(ws_msb18)[3] = "Day"
names(ws_msb18)[4] = "Hour"
names(ws_msb18)[5] = "Minute"
names(ws_msb18)[6] = "WDIR"
names(ws_msb18)[7] = "WSPD"

names(ws_msb19)[1] = "Year"
names(ws_msb19)[2] = "Month"
names(ws_msb19)[3] = "Day"
names(ws_msb19)[4] = "Hour"
names(ws_msb19)[5] = "Minute"
names(ws_msb19)[6] = "WDIR"
names(ws_msb19)[7] = "WSPD"

names(ws_mwa19)[1] = "Year"
names(ws_mwa19)[2] = "Month"
names(ws_mwa19)[3] = "Day"
names(ws_mwa19)[4] = "Hour"
names(ws_mwa19)[5] = "Minute"
names(ws_mwa19)[6] = "WDIR"
names(ws_mwa19)[7] = "WSPD"

names(ws_oir18)[1] = "Year"
names(ws_oir18)[2] = "Month"
names(ws_oir18)[3] = "Day"
names(ws_oir18)[4] = "Hour"
names(ws_oir18)[5] = "Minute"
names(ws_oir18)[6] = "WDIR"
names(ws_oir18)[7] = "WSPD"

names(ws_oir19)[1] = "Year"
names(ws_oir19)[2] = "Month"
names(ws_oir19)[3] = "Day"
names(ws_oir19)[4] = "Hour"
names(ws_oir19)[5] = "Minute"
names(ws_oir19)[6] = "WDIR"
names(ws_oir19)[7] = "WSPD"

names(ws_ool18)[1] = "Year"
names(ws_ool18)[2] = "Month"
names(ws_ool18)[3] = "Day"
names(ws_ool18)[4] = "Hour"
names(ws_ool18)[5] = "Minute"
names(ws_ool18)[6] = "WDIR"
names(ws_ool18)[7] = "WSPD"

names(ws_ool19)[1] = "Year"
names(ws_ool19)[2] = "Month"
names(ws_ool19)[3] = "Day"
names(ws_ool19)[4] = "Hour"
names(ws_ool19)[5] = "Minute"
names(ws_ool19)[6] = "WDIR"
names(ws_ool19)[7] = "WSPD"

names(ws_osi18)[1] = "Year"
names(ws_osi18)[2] = "Month"
names(ws_osi18)[3] = "Day"
names(ws_osi18)[4] = "Hour"
names(ws_osi18)[5] = "Minute"
names(ws_osi18)[6] = "WDIR"
names(ws_osi18)[7] = "WSPD"

names(ws_osn19)[1] = "Year"
names(ws_osn19)[2] = "Month"
names(ws_osn19)[3] = "Day"
names(ws_osn19)[4] = "Hour"
names(ws_osn19)[5] = "Minute"
names(ws_osn19)[6] = "WDIR"
names(ws_osn19)[7] = "WSPD"

# adding ws 2020-2021

names(ws_erie20)[1] = "Year"
names(ws_erie20)[2] = "Month"
names(ws_erie20)[3] = "Day"
names(ws_erie20)[4] = "Hour"
names(ws_erie20)[5] = "Minute"
names(ws_erie20)[6] = "WDIR"
names(ws_erie20)[7] = "WSPD"

names(ws_erie21)[1] = "Year"
names(ws_erie21)[2] = "Month"
names(ws_erie21)[3] = "Day"
names(ws_erie21)[4] = "Hour"
names(ws_erie21)[5] = "Minute"
names(ws_erie21)[6] = "WDIR"
names(ws_erie21)[7] = "WSPD"

names(ws_huron20)[1] = "Year"
names(ws_huron20)[2] = "Month"
names(ws_huron20)[3] = "Day"
names(ws_huron20)[4] = "Hour"
names(ws_huron20)[5] = "Minute"
names(ws_huron20)[6] = "WDIR"
names(ws_huron20)[7] = "WSPD"

names(ws_huron21)[1] = "Year"
names(ws_huron21)[2] = "Month"
names(ws_huron21)[3] = "Day"
names(ws_huron21)[4] = "Hour"
names(ws_huron21)[5] = "Minute"
names(ws_huron21)[6] = "WDIR"
names(ws_huron21)[7] = "WSPD"

names(ws_msb20)[1] = "Year"
names(ws_msb20)[2] = "Month"
names(ws_msb20)[3] = "Day"
names(ws_msb20)[4] = "Hour"
names(ws_msb20)[5] = "Minute"
names(ws_msb20)[6] = "WDIR"
names(ws_msb20)[7] = "WSPD"

names(ws_msb21)[1] = "Year"
names(ws_msb21)[2] = "Month"
names(ws_msb21)[3] = "Day"
names(ws_msb21)[4] = "Hour"
names(ws_msb21)[5] = "Minute"
names(ws_msb21)[6] = "WDIR"
names(ws_msb21)[7] = "WSPD"

names(ws_mwa20)[1] = "Year"
names(ws_mwa20)[2] = "Month"
names(ws_mwa20)[3] = "Day"
names(ws_mwa20)[4] = "Hour"
names(ws_mwa20)[5] = "Minute"
names(ws_mwa20)[6] = "WDIR"
names(ws_mwa20)[7] = "WSPD"

names(ws_mwa21)[1] = "Year"
names(ws_mwa21)[2] = "Month"
names(ws_mwa21)[3] = "Day"
names(ws_mwa21)[4] = "Hour"
names(ws_mwa21)[5] = "Minute"
names(ws_mwa21)[6] = "WDIR"
names(ws_mwa21)[7] = "WSPD"

names(ws_oir21)[1] = "Year"
names(ws_oir21)[2] = "Month"
names(ws_oir21)[3] = "Day"
names(ws_oir21)[4] = "Hour"
names(ws_oir21)[5] = "Minute"
names(ws_oir21)[6] = "WDIR"
names(ws_oir21)[7] = "WSPD"

names(ws_ool21)[1] = "Year"
names(ws_ool21)[2] = "Month"
names(ws_ool21)[3] = "Day"
names(ws_ool21)[4] = "Hour"
names(ws_ool21)[5] = "Minute"
names(ws_ool21)[6] = "WDIR"
names(ws_ool21)[7] = "WSPD"

# Add DateTime columns to ADCP files
adcp18 <- add_column(adcp18, DateTime = paste
                          (adcp18$Date, 
                            adcp18$Time, 
                            sep = " ", collapse = NULL), .before = "VelocityE")
adcp18$Date <- as.Date(as.character(adcp18$Date), format = "%Y-%m-%d") 
adcp18$DateTime <- as.POSIXct(adcp18$DateTime, 
                                   format = "%Y-%m-%d %H:%M",
                                   origin = "1970-01-01",
                                   tz = "Etc/GMT+5")

adcp19 <- add_column(adcp19, DateTime = paste
                     (adcp19$Date, 
                       adcp19$Time, 
                       sep = " ", collapse = NULL), .before = "VelocityE")
adcp19$Date <- as.Date(as.character(adcp19$Date), format = "%Y-%m-%d") 
adcp19$DateTime <- as.POSIXct(adcp19$DateTime, 
                              format = "%Y-%m-%d %H:%M",
                              origin = "1970-01-01",
                              tz = "Etc/GMT+5")

adcp21 <- add_column(adcp21, DateTime = paste
                     (adcp21$Date, 
                       adcp21$Time, 
                       sep = " ", collapse = NULL), .before = "VelocityE")
adcp21$Date <- as.Date(as.character(adcp21$Date), format = "%Y-%m-%d") 
adcp21$DateTime <- as.POSIXct(adcp21$DateTime, 
                              format = "%Y-%m-%d %H:%M",
                              origin = "1970-01-01",
                              tz = "Etc/GMT+5")

adcp22 <- add_column(adcp22, DateTime = paste
                     (adcp22$Date, 
                       adcp22$Time, 
                       sep = " ", collapse = NULL), .before = "VelocityE")
adcp22$Date <- as.Date(as.character(adcp22$Date), format = "%Y-%m-%d") 
adcp22$DateTime <- as.POSIXct(adcp22$DateTime, 
                              format = "%Y-%m-%d %H:%M",
                              origin = "1970-01-01",
                              tz = "Etc/GMT+5")


#Create subsets of each df, keeping only columns needed for analysis

adcp18_sub <- subset(adcp18, select = c("Transect", "Year", "Date", "Time",
                                        "DateTime", "Hs", "Cell01Spd", "Cell02Spd"))
adcp19_sub <- subset(adcp19, select = c("Transect", "Year", "Date", "Time",
                                        "DateTime", "Hs", "Cell01Spd", "Cell02Spd"))
adcp21_sub <- subset(adcp21, select = c("Transect", "Year", "Date", "Time",
                                        "DateTime", "Hs", "Cell01Spd", "Cell02Spd"))
adcp22_sub <- subset(adcp22, select = c("Transect", "Year", "Date", "Time",
                                        "DateTime", "Hs", "Cell01Spd", "Cell02Spd"))

#bb18_sub <- subset(bb18, select = c("Year", "Month", "Date", "Transect", "Station", 
 #                                   "Quadrat", "SAVWeight"))
#bb19_sub <- subset(bb19, select = c("Year", "Month", "Date", "Transect", "Station", 
 #                                   "Quadrat", "SAVWeight"))

#bc18_sub <- subset(bc18, select = c("Year", "Month", "Date", "Transect", "Station", 
 #                                   "DreissTotalWeight", "DreissTissueWeight"))
#bc19_sub <- subset(bc19, select = c("Year", "Month", "Date", "Transect", "Station", 
 #                                   "DreissTotalWeight", "DreissTissueWeight"))

wc18_sub <- subset(wc18, select = c("Year", "Transect", "Station", "Depth", "Date", 
                                    "Time", "TP_NWQL", "OrthoP", "TN", "Ammonia", 
                                    "AmmoniaOrganicN", "NOx", "TSS", "Chloride", 
                                    "Fluoride", "Silica", "Sulfate"))
wc19_sub <- subset(wc19, select = c("Year", "Transect", "Station", "Depth", "Date", 
                                    "Time", "TP_NWQL","TP_UMESC", "OrthoP", "SRP", 
                                    "TN", "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate"))
wc20_sub <- subset(wc20, select = c("Year", "Transect", "Station", "Depth", 
                                    "Date", "Time", "TP_UMESC", "SRP", "TN",
                                    "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate"
                                    ))
wc21_sub <- subset(wc21, select = c("Year", "Transect", "Station", "Depth", 
                                    "Date","Time", "TP_NWQL","TP_UMESC", "OrthoP", "SRP", "TN",
                                    "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate"
                                      ))
wc22_sub <- subset(wc22, select = c("Year", "Transect", "Station", "Depth", 
                                    "Date","Time", "TP_UMESC", "SRP", "TN",
                                    "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate"
))
wc23_sub <- subset(wc23, select = c("Year", "Transect", "Station", "Depth",
                                    "Date", "Time", "TP", "SRP", "TN",
                                    "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate"
))


ws_erie18_sub <- subset(ws_erie18, select = c("Year", "Month", "Day", "Hour",
                                                        "Minute", "WSPD"))
ws_erie19_sub <- subset(ws_erie19, select = c("Year", "Month", "Day", "Hour",
                                                        "Minute", "WSPD"))
ws_huron18_sub <- subset(ws_huron18, select = c("Year", "Month", "Day", "Hour",
                                                          "Minute", "WSPD"))
ws_huron19_sub <- subset(ws_huron19, select = c("Year", "Month", "Day", "Hour",
                                                          "Minute", "WSPD"))
ws_msb18_sub <- subset(ws_msb18, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_msb19_sub <- subset(ws_msb19, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_mmc18_sub <- subset(ws_mmc18, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_mwa19_sub <- subset(ws_mwa19, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_oir18_sub <- subset(ws_oir18, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_oir19_sub <- subset(ws_oir19, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_ool18_sub <- subset(ws_ool18, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_ool19_sub <- subset(ws_ool19, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_osi18_sub <- subset(ws_osi18, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
ws_osn19_sub <- subset(ws_osn19, select = c("Year", "Month", "Day", "Hour",
                                                      "Minute", "WSPD"))
# 2020-21
# 
ws_erie20_sub <- subset(ws_erie20, select = c("Year", "Month", "Day", "Hour",
                                              "Minute", "WSPD"))
ws_erie21_sub <- subset(ws_erie21, select = c("Year", "Month", "Day", "Hour",
                                              "Minute", "WSPD"))
ws_huron20_sub <- subset(ws_huron20, select = c("Year", "Month", "Day", "Hour",
                                                "Minute", "WSPD"))
ws_huron21_sub <- subset(ws_huron21, select = c("Year", "Month", "Day", "Hour",
                                                "Minute", "WSPD"))
ws_msb20_sub <- subset(ws_msb20, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))
ws_msb21_sub <- subset(ws_msb21, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))
ws_mwa20_sub <- subset(ws_mwa20, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))
ws_mwa21_sub <- subset(ws_mwa21, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))
ws_oir21_sub <- subset(ws_oir21, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))
ws_ool21_sub <- subset(ws_ool21, select = c("Year", "Month", "Day", "Hour",
                                            "Minute", "WSPD"))

#Add location columns to each wind speed df 

ws_erie18_sub <- add_column(ws_erie18_sub, Location = "Erie", 
                                 .before = "Year")
ws_erie19_sub <- add_column(ws_erie19_sub, Location = "Erie", 
                                 .before = "Year")
ws_huron18_sub <- add_column(ws_huron18_sub, Location = "Huron",
                                  .before = "Year")
ws_huron19_sub <- add_column(ws_huron19_sub, Location = "Huron",
                                  .before = "Year")
ws_mmc18_sub <- add_column(ws_mmc18_sub, Location = "MMC",
                                .before = "Year")
ws_msb18_sub <- add_column(ws_msb18_sub, Location = "MSB",
                                .before = "Year")
ws_msb19_sub <- add_column(ws_msb19_sub, Location = "MSB",
                                .before = "Year")
ws_mwa19_sub <- add_column(ws_mwa19_sub, Location = "MWA",
                                .before = "Year")
ws_oir18_sub <- add_column(ws_oir18_sub, Location = "OIR",
                                .before = "Year")
ws_oir19_sub <- add_column(ws_oir19_sub, Location = "OIR",
                                .before = "Year")
ws_ool18_sub <- add_column(ws_ool18_sub, Location = "OOL",
                                .before = "Year")
ws_ool19_sub <- add_column(ws_ool19_sub, Location = "OOL",
                                .before = "Year")
ws_osi18_sub <- add_column(ws_osi18_sub, Location = "OSI",
                                .before = "Year")
ws_osn19_sub <- add_column(ws_osn19_sub, Location = "OSN",
                                .before = "Year")
#2020-21
ws_erie20_sub <- add_column(ws_erie20_sub, Location = "Erie", 
                            .before = "Year")
ws_erie21_sub <- add_column(ws_erie21_sub, Location = "Erie", 
                            .before = "Year")
ws_huron20_sub <- add_column(ws_huron20_sub, Location = "Huron",
                             .before = "Year")
ws_huron21_sub <- add_column(ws_huron21_sub, Location = "Huron",
                             .before = "Year")
ws_msb20_sub <- add_column(ws_msb20_sub, Location = "MSB",
                           .before = "Year")
ws_msb21_sub <- add_column(ws_msb21_sub, Location = "MSB",
                           .before = "Year")
ws_mwa20_sub <- add_column(ws_mwa20_sub, Location = "MWA",
                           .before = "Year")
ws_mwa21_sub <- add_column(ws_mwa21_sub, Location = "MWA",
                           .before = "Year")
ws_oir21_sub <- add_column(ws_oir21_sub, Location = "OIR",
                           .before = "Year")
ws_ool21_sub <- add_column(ws_ool21_sub, Location = "OOL",
                           .before = "Year")


#Ensure variables match in df's before combining years

wc18_sub <- add_column(wc18_sub, TP = "", .after = "Time")
wc18_sub <- add_column(wc18_sub, TP_UMESC = "", .after = "TP_NWQL")
wc18_sub <- add_column(wc18_sub, SRP = "", .after = "OrthoP")

wc19_sub <- add_column(wc19_sub, TP = "", .after = "Time")

wc20_sub <- add_column(wc20_sub, TP = "", .after = "Time")
wc20_sub <- add_column(wc20_sub, TP_NWQL = "", .after = "TP")
wc20_sub <- add_column(wc20_sub, OrthoP = "", .after = "TP_UMESC")

wc21_sub <- add_column(wc21_sub, TP = "", .after = "Time")

wc22_sub <- add_column(wc22_sub, TP = "", .after = "Time")
wc22_sub <- add_column(wc22_sub, TP_NWQL = "", .after = "TP")
wc22_sub <- add_column(wc22_sub, OrthoP = "", .after = "TP_UMESC")

wc23_sub <- add_column(wc23_sub, TP_NWQL = "", .after = "TP")
wc23_sub <- add_column(wc23_sub, TP_UMESC = "", .after = "TP_NWQL")
wc23_sub <- add_column(wc23_sub, OrthoP = "", .after = "TP_UMESC")

#Merge df's into a combined df

adcp_combined <- rbind(adcp18_sub, adcp19_sub, adcp21_sub, adcp22_sub)

#bb_combined <- rbind(bb18_sub, bb19_sub)

#bc_combined <- rbind(bc18_sub, bc19_sub)


wc18_sub$Date = as.Date(wc18_sub$Date)
wc19_sub$Date = as.Date(wc19_sub$Date)
wc20_sub$Date = as.Date(wc20_sub$Date)
wc21_sub$Date = as.Date(wc21_sub$Date)
wc22_sub$Date = as.Date(wc22_sub$Date, format = "%m/%d/%Y")
wc23_sub$Date = as.Date(wc23_sub$Date, format = "%m/%d/%Y")

wc_combined <- rbind(wc18_sub, wc19_sub, wc20_sub, wc21_sub, wc22_sub, wc23_sub)


ws_combined <- rbind(ws_erie18_sub, ws_erie19_sub, ws_erie20_sub, ws_erie21_sub,
                              ws_huron18_sub, ws_huron19_sub, ws_huron20_sub, ws_huron21_sub,
                              ws_msb18_sub, ws_msb19_sub, ws_msb20_sub, ws_msb21_sub,
                              ws_mmc18_sub,  ws_mwa19_sub, ws_mwa20_sub, ws_mwa21_sub,
                              ws_oir18_sub, ws_oir19_sub, ws_oir21_sub,
                              ws_ool18_sub, ws_ool19_sub, ws_ool21_sub,
                              ws_osi18_sub, ws_osn19_sub)

#Reset observation names
rownames(ws_combined) = NULL


## add column for SubstrateType ##
wc_combined <- add_column(wc_combined, SubstrateType = "", 
                       .before = "Date")

## if then for adding substratetype column contents to wc combined
for(i in 1:nrow(wc_combined)) {
  if(wc_combined$Depth[i] == "B1" || wc_combined$Depth[i] == "B2" || wc_combined$Depth[i] == "B3") {
    wc_combined$SubstrateType[i] = "Bare substrate"
  } else if (wc_combined$Depth[i] == "C1" || wc_combined$Depth[i] == "C2" || wc_combined$Depth[i] == "C3") {
  wc_combined$SubstrateType[i] = "Cladophora bed"
  } else if (wc_combined$Depth[i] == "D1" || wc_combined$Depth[i] == "D2" || wc_combined$Depth[i] == "D3") {
  wc_combined$SubstrateType[i] = "Dreissenid bed"
  } else if (wc_combined$Depth[i] == "CD1" || wc_combined$Depth[i] == "CD2" || wc_combined$Depth[i] == "CD3") {
  wc_combined$SubstrateType[i] = "Cladophora + dreissenid bed"
  }
}

#Correct date for sites where 1m and B were sampled on different days

wc_combined["427","Date"] <- "2019-06-17" #OOL3 B - changed from 2019-06-18
wc_combined["429","Date"] <- "2019-06-17" #OOL6 B - changed from 2019-06-18
wc_combined["433","Date"] <- "2019-06-18" #OOL18 B - changed from 2019-06-17
wc_combined["493","Date"] <- "2019-07-23" #OIR3 B - changed from 2019-07-24
wc_combined["497","Date"] <- "2019-07-23" #OIR B - changed from 2019-07-24

#Add transect variable to ws_combined

ws_combined <- add_column(ws_combined, OSN = "", .after = "Location")
ws_combined <- add_column(ws_combined, OSI = "", .after = "Location")
ws_combined <- add_column(ws_combined, OOL = "", .after = "Location")
ws_combined <- add_column(ws_combined, OIR = "", .after = "Location")
ws_combined <- add_column(ws_combined, MMC = "", .after = "Location")
ws_combined <- add_column(ws_combined, MSB = "", .after = "Location")
ws_combined <- add_column(ws_combined, MWA = "", .after = "Location")
ws_combined <- add_column(ws_combined, HTB = "", .after = "Location")
ws_combined <- add_column(ws_combined, HHB = "", .after = "Location")
ws_combined <- add_column(ws_combined, HAL = "", .after = "Location")
ws_combined <- add_column(ws_combined, EEP = "", .after = "Location")
ws_combined <- add_column(ws_combined, EDW = "", .after = "Location")
ws_combined <- add_column(ws_combined, EDE = "", .after = "Location")

#Add binary code for Transect, assigning a wind speed buoy location for each transect.

ws_combined$EDE <- if_else(ws_combined$Location == "Erie", "1","0")
ws_combined$EDW <- if_else(ws_combined$Location == "Erie", "1","0")
ws_combined$EEP <- if_else(ws_combined$Location == "Erie", "1","0")
ws_combined$HAL <- if_else(ws_combined$Location == "Huron", "1","0")
ws_combined$HHB <- if_else(ws_combined$Location == "Huron", "1","0")
ws_combined$HTB <- if_else(ws_combined$Location == "Huron", "1","0")
ws_combined$MMC <- if_else(ws_combined$Location == "MMC", "1","0")
ws_combined$MSB <- if_else(ws_combined$Location == "MSB", "1","0")
ws_combined$MWA <- if_else(ws_combined$Location == "MWA", "1","0")
ws_combined$OIR <- if_else(ws_combined$Location == "OIR", "1","0")
ws_combined$OOL <- if_else(ws_combined$Location == "OOL", "1","0")
ws_combined$OSI <- if_else(ws_combined$Location == "OSI", "1","0")
ws_combined$OSN <- if_else(ws_combined$Location == "OSN", "1","0")

#Change "BDL" to "0" where applicable. 

#bb_combined$SAVWeight [bb_combined$SAVWeight == "BDL"]<-0
#bc_combined$DreissTissueWeight [bc_combined$DreissTissueWeight == "BDL"]<-0
#bc_combined$DreissTotalWeight [bc_combined$DreissTotalWeight == "BDL"]<-0
wc_combined$TP [wc_combined$TP == "BDL"]<-0
wc_combined$TP_NWQL [wc_combined$TP_NWQL == "BDL"]<-0
wc_combined$TP_UMESC [wc_combined$TP_UMESC == "BDL"]<-0
wc_combined$OrthoP[wc_combined$OrthoP == "BDL"]<-0
wc_combined$SRP[wc_combined$SRP == "BDL"]<-0
wc_combined$TN [wc_combined$TN == "BDL"]<-0
wc_combined$Ammonia [wc_combined$Ammonia == "BDL"]<-0
wc_combined$AmmoniaOrganicN [wc_combined$AmmoniaOrganicN == "BDL"]<-0
wc_combined$NOx [wc_combined$NOx == "BDL"]<-0
wc_combined$TSS [wc_combined$TSS == "BDL"]<-0
wc_combined$Chloride [wc_combined$Chloride == "BDL"]<-0
wc_combined$Fluoride [wc_combined$Fluoride == "BDL"]<-0
wc_combined$Silica [wc_combined$Silica == "BDL"]<-0
wc_combined$Sulfate [wc_combined$Sulfate == "BDL"]<-0

#Format df's

#adcp
adcp_combined$Transect <- as.factor(adcp_combined$Transect)
adcp_combined$Year <- as.factor(adcp_combined$Year)
adcp_combined$Date <- as.Date(adcp_combined$Date)


adcp_combined$DateTime = as.POSIXct(adcp_combined$DateTime, format = "%m/%d/%y %H:%M", origin = "01/01/1970", tz = "UTC")
#or
#adcp_combined$DateTime <- as.POSIXct(adcp_combined$DateTime, 
              #                       format = "%Y-%m-%d %H:%M:%S",
               #                      origin = "1970-01-01",
                #                     tz = "Etc/GMT+5")
#adcp_combined$Time <- substr(adcp_combined$DateTime, 12, 19)
#adcp_combined$Time <- as.numeric(hms(adcp_combined$Time))  
              
# formatting time column as time. nothing works (things hashed out above) except this data.table function, 
# which is "experimental" but we'll use it here.
adcp_combined$Time = data.table::as.ITime(adcp_combined$Time)

str(adcp_combined)
# says it's 'ITime" value type but we'll deal with that for now. 

#bb

#bb_combined$Year <- as.factor(bb_combined$Year)
#bb_combined$Month <- as.factor(bb_combined$Month)
#bb_combined$Date <- as.Date(as.character(bb_combined$Date), format = "%Y-%m-%d")

#bb_combined$Transect <- as.factor(bb_combined$Transect)
#bb_combined$Station <- as.factor(bb_combined$Station)
#bb_combined$Quadrat <- as.factor(bb_combined$Quadrat)
#bb_combined$SAVWeight <- as.numeric(bb_combined$SAVWeight)

#str(bb_combined)

#bc

#bc_combined$Year <- as.factor(bc_combined$Year)
#bc_combined$Month <- as.factor(bc_combined$Month)
#bc_combined$Date <- as.Date(as.character(bc_combined$Date), format = "%Y-%m-%d")
#bc_combined$Transect <- as.factor(bc_combined$Transect)
#bc_combined$Station <- as.factor(bc_combined$Station)
#bc_combined$DreissTotalWeight <- as.numeric(bc_combined$DreissTotalWeight)
#bc_combined$DreissTissueWeight <- as.numeric(bc_combined$DreissTissueWeight)

#str(bc_combined)

#wc                                                    

wc_combined$Year <- as.factor(wc_combined$Year)
wc_combined$Transect <- as.factor(wc_combined$Transect)
wc_combined$Station <- as.factor(wc_combined$Station)
wc_combined$Depth <- as.factor(wc_combined$Depth)
wc_combined$SubstrateType <- as.factor(wc_combined$SubstrateType)
wc_combined <- add_column(wc_combined, DateTime = paste
                                 (wc_combined$Date, 
                                  wc_combined$Time, 
                                  sep = " ", collapse = NULL), .before = "TP")
wc_combined$Date <- as.Date(as.character(wc_combined$Date), format = "%Y-%m-%d") 

wc_combined$DateTime <- as.POSIXct(wc_combined$DateTime, 
                                   format = "%Y-%m-%d %H:%M",
                                   origin = "1970-01-01",
                                   tz = "Etc/GMT+5")
wc_combined$TP <- as.numeric(wc_combined$TP)
wc_combined$TP_NWQL <- as.numeric(wc_combined$TP_NWQL)
wc_combined$TP_UMESC <- as.numeric(wc_combined$TP_UMESC)
wc_combined$OrthoP <- as.numeric(wc_combined$OrthoP)
wc_combined$SRP <- as.numeric(wc_combined$SRP)
wc_combined$TN <- as.numeric(wc_combined$TN)
wc_combined$Ammonia <- as.numeric(wc_combined$Ammonia)
wc_combined$AmmoniaOrganicN <- as.numeric(wc_combined$AmmoniaOrganicN)
wc_combined$NOx <- as.numeric(wc_combined$NOx)
wc_combined$TSS <- as.numeric(wc_combined$TSS)
wc_combined$Chloride <- as.numeric(wc_combined$Chloride)
wc_combined$Fluoride <- as.numeric(wc_combined$Fluoride)
wc_combined$Silica <- as.numeric(wc_combined$Silica)
wc_combined$Sulfate <- as.numeric(wc_combined$Sulfate)

#WindSpd

ws_combined$Location <- as.factor(ws_combined$Location)
ws_combined$EDE <- as.factor(ws_combined$EDE)
ws_combined$EDW <- as.factor(ws_combined$EDW)
ws_combined$HAL <- as.factor(ws_combined$HAL)
ws_combined$HHB <- as.factor(ws_combined$HHB)
ws_combined$HTB <- as.factor(ws_combined$HTB)
ws_combined$MWA <- as.factor(ws_combined$MWA)
ws_combined$MSB <- as.factor(ws_combined$MSB)
ws_combined$MMC <- as.factor(ws_combined$MMC)
ws_combined$OIR <- as.factor(ws_combined$OIR)
ws_combined$OOL <- as.factor(ws_combined$OOL)
ws_combined$OSN <- as.factor(ws_combined$OSN)
ws_combined$OSI <- as.factor(ws_combined$OSI)
ws_combined$EEP <- as.factor(ws_combined$EEP)
ws_combined$Year <- as.factor(ws_combined$Year)
ws_combined$Month <- as.integer(ws_combined$Month)
ws_combined$Day <- as.integer(ws_combined$Day)
ws_combined <- add_column(ws_combined, 
                                  Date = paste(ws_combined$Year, 
                                  ws_combined$Month, 
                                  ws_combined$Day, sep = "-",
                                  collapse = NULL), .before = "Month")
ws_combined <- add_column(ws_combined, 
                                  Time = paste(ws_combined$Hour, 
                                  ws_combined$Minute, sep = ":", 
                                  collapse = NULL), .before = "Month")
ws_combined <- add_column(ws_combined, DateTime = paste
                                  (ws_combined$Date, 
                                  ws_combined$Time, 
                                  sep = " ", collapse = NULL), .before = "Month")
ws_combined$Date <- as.Date(as.character(ws_combined$Date), format = "%Y-%m-%d")
ws_combined$DateTime <- as.POSIXct(ws_combined$DateTime, format = "%Y-%m-%d %H:%M", tz = "UTC")
ws_combined = subset(ws_combined, Month > 4 & Month < 11)
ws_combined <- subset(ws_combined, select = -c(20:22))
ws_combined$WSPD <- as.numeric(ws_combined$WSPD)


#Create ID's which can be used to combine data from different df's
#ID DateTime, Transect
adcp_combined <- add_column(adcp_combined, ID_DtTr = paste
                            (adcp_combined$DateTime, adcp_combined$Transect, 
                              sep = "", collapse = NULL), .before = "Transect")
wc_combined <- add_column(wc_combined, ID_DtTr = 
                            paste(wc_combined$DateTime, 
                                  wc_combined$Transect, sep = "",
                                  collapse = NULL), .before = "Year")


#ID Date, Transect
adcp_combined <- add_column(adcp_combined, ID_DTr 
                          = paste(adcp_combined$Date, 
                                  adcp_combined$Transect, sep = "", 
                                  collapes = NULL), .before = "Year")
#bb_combined <- add_column(bb_combined, ID_DTr 
                          #  = paste(bb_combined$Date, 
                          #  bb_combined$Transect, sep = "", 
                          #  collapes = NULL), .before = "Year")
#bc_combined <- add_column(bc_combined, ID_DTr = paste
                          #         (bc_combined$Date, 
                          #           bc_combined$Transect, sep = "", 
                          #           collapse = NULL), .before = "Year")
wc_combined <- add_column(wc_combined, ID_DTr = 
                                   paste(wc_combined$Date, 
                                         wc_combined$Transect, sep = "",
                                         collapse = NULL), .before = "Year")
#ID Date, Transect, Station
#bb_combined <- add_column(bb_combined, ID_DTrS 
                         #             = paste(bb_combined$Date, 
                          #                    bb_combined$Transect, bb_combined$Station, sep = "", 
                          #                    collapes = NULL), .before = "Year")
#bc_combined <- add_column(bc_combined, ID_DTrS = paste
                         #          (bc_combined$Date, 
                          #           bc_combined$Transect, bc_combined$Station, sep = "", 
                         #            collapse = NULL), .before = "Year")
wc_combined <- add_column(wc_combined, ID_DTrS = paste(wc_combined$Date, wc_combined$Transect, wc_combined$Station, sep = "", collapse = NULL), .before = "Year")


#create TP_all column in wc_combined and remove old columns

wc_combined$TP_all <- if_else(is.na(wc_combined$TP), 
                             if_else(is.na(wc_combined$TP_NWQL), 
                                     wc_combined$TP_UMESC, 
                                     wc_combined$TP_NWQL),
                                     wc_combined$TP)
# FOR THE INSTANCES WHEN WE HAD ONE SAMPLE FROM UMESC AND ONE FROM NWQL (2021), CODE CHOSE NWQL


wc_combined <- within(wc_combined, rm("TP_NWQL", "TP_UMESC", "TP"))


#subset 1m and B

wc_1m <- subset(wc_combined, Depth == "1m")
wc_B <- subset(wc_combined, Depth == "B")

#create combined df, using wc_B as template, in preparation for importing wc_1m

wc1mB <- wc_B

#rename columns in wc_1mB to include "B"

wc1mB <- wc1mB %>% dplyr::rename(TP_B = TP_all)
wc1mB <- wc1mB %>% dplyr::rename(OrthoP_B= OrthoP)
wc1mB <- wc1mB %>% dplyr::rename(SRP_B = SRP)
wc1mB <- wc1mB %>% dplyr::rename(TN_B = TN)
wc1mB <- wc1mB %>% dplyr::rename(Ammonia_B = Ammonia)
wc1mB <- wc1mB %>% dplyr::rename(AmmoniaOrganicN_B = AmmoniaOrganicN)
wc1mB <- wc1mB %>% dplyr::rename(NOx_B = NOx)
wc1mB <- wc1mB %>% dplyr::rename(TSS_B = TSS)
wc1mB <- wc1mB %>% dplyr::rename(Chloride_B = Chloride)
wc1mB <- wc1mB %>% dplyr::rename(Fluoride_B = Fluoride)
wc1mB <- wc1mB %>% dplyr::rename(Silica_B = Silica)
wc1mB <- wc1mB %>% dplyr::rename(Sulfate_B = Sulfate)


#import wc_1m nutrient results using match formula
#df_target$new_column <- df_data_import$column[match(df_target$match_column, df_data_import$match_column)]

wc1mB$TP_1m <- wc_1m$TP_all[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$OrthoP_1m <- wc_1m$OrthoP[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$SRP_1m <- wc_1m$SRP[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$TN_1m <- wc_1m$TN[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$Ammonia_1m <- wc_1m$Ammonia[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$AmmoniaOrganicN_1m <- wc_1m$AmmoniaOrganicN[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$NOx_1m <- wc_1m$NOx[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$TSS_1m <- wc_1m$TSS[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$Chloride_1m <- wc_1m$Chloride[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$Fluoride_1m <- wc_1m$Fluoride[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$Silica_1m <- wc_1m$Silica[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc1mB$Sulfate_1m <- wc_1m$Sulfate[match(wc1mB$ID_DTrS, wc_1m$ID_DTrS)]


#Calculate difference in nutrient values between 1m and B samples

wc1mB <- mutate(wc1mB, TP_diff = TP_1m - TP_B)
wc1mB <- mutate(wc1mB, OrthoP_diff = OrthoP_1m - OrthoP_B)
wc1mB <- mutate(wc1mB, SRP_diff = SRP_1m - SRP_B)
wc1mB <- mutate(wc1mB, TN_diff = TN_1m - TN_B)
wc1mB <- mutate(wc1mB, Ammonia_diff = Ammonia_1m - Ammonia_B)
wc1mB <- mutate(wc1mB, AmmoniaOrganicN_diff = AmmoniaOrganicN_1m - AmmoniaOrganicN_B)
wc1mB <- mutate(wc1mB, NOx_diff = NOx_1m - NOx_B)
wc1mB <- mutate(wc1mB, TSS_diff = TSS_1m - TSS_B)
wc1mB <- mutate(wc1mB, Chloride_diff = Chloride_1m - Chloride_B)
wc1mB <- mutate(wc1mB, Fluoride_diff = Fluoride_1m - Fluoride_B)
wc1mB <- mutate(wc1mB, Silica_diff = Silica_1m - Silica_B)
wc1mB <- mutate(wc1mB, Sulfate_diff = Sulfate_1m - Sulfate_B)


#Reorder variables

wc1mB <- wc1mB[,c("ID_DTr", "ID_DTrS", "Year", "Transect", "Station", "Depth", 
                   "SubstrateType", "Date",                    
                  "Time", "DateTime", "TP_1m", "TP_B", "TP_diff", "OrthoP_1m", 
                    "OrthoP_B", "OrthoP_diff", "SRP_1m", "SRP_B", "SRP_diff", "TN_1m",
                    "TN_B", "TN_diff","Ammonia_1m", "Ammonia_B", "Ammonia_diff", 
                    "AmmoniaOrganicN_1m", "AmmoniaOrganicN_B", "AmmoniaOrganicN_diff",
                    "NOx_1m", "NOx_B", "NOx_diff", "TSS_1m", "TSS_B", "TSS_diff",
                    "Chloride_1m", "Chloride_B", "Chloride_diff",
                    "Fluoride_1m", "Fluoride_B", "Fluoride_diff",
                    "Silica_1m", "Silica_B", "Silica_diff", "Sulfate_1m", "Sulfate_B",
                    "Sulfate_diff")]

#Calculate max nutrient value between 1m and B samples

wc1mB [, "TP_max"] <- apply(wc1mB[, 11:12], 1, max)#TP
wc1mB [, "OrthoP_max"] <- apply(wc1mB[, 14:15], 1, max)#OrthoP
wc1mB [, "SRP_max"] <- apply(wc1mB[, 17:18], 1, max)#SRP
wc1mB [, "TN_max"] <- apply(wc1mB[, 20:21], 1, max)#TN
wc1mB [, "Ammonia_max"] <- apply(wc1mB[, 23:24], 1, max)#Ammonia
wc1mB [, "AmmoniaOrganicN_max"] <- apply(wc1mB[, 26:27], 1, max)#AmmoniaOrganicN
wc1mB [, "NOx_max"] <- apply(wc1mB[, 29:30], 1, max)#NOx
wc1mB [, "TSS_max"] <- apply(wc1mB[, 32:33], 1, max)#TSS
wc1mB [, "Chloride_max"] <- apply(wc1mB[, 35:36], 1, max)#Chloride
wc1mB [, "Fluoride_max"] <- apply(wc1mB[, 38:39], 1, max)#Fluoride
wc1mB [, "Silica_max"] <- apply(wc1mB[, 41:42], 1, max)#Silica
wc1mB [, "Sulfate_max"] <- apply(wc1mB[, 44:45], 1, max)#Sulfate


# Reorder variables

wc1mB <- wc1mB[,c("ID_DTr", "ID_DTrS", "Year", "Transect", "Station", "Depth", 
                    "SubstrateType", "Date", "Time", "DateTime", 
                    "TP_1m", "TP_B", "TP_diff", "TP_max", 
                    "OrthoP_1m", "OrthoP_B", "OrthoP_diff", "OrthoP_max", 
                    "SRP_1m", "SRP_B", "SRP_diff", "SRP_max",
                    "TN_1m", "TN_B", "TN_diff", "TN_max", 
                    "Ammonia_1m", "Ammonia_B", "Ammonia_diff", "Ammonia_max", 
                    "AmmoniaOrganicN_1m", "AmmoniaOrganicN_B", 
                    "AmmoniaOrganicN_diff", "AmmoniaOrganicN_max", 
                    "NOx_1m", "NOx_B", "NOx_diff", "NOx_max", 
                    "TSS_1m", "TSS_B", "TSS_diff", "TSS_max",
                    "Chloride_1m", "Chloride_B", "Chloride_diff", "Chloride_max",
                    "Fluoride_1m", "Fluoride_B", "Fluoride_diff", "Fluoride_max",
                    "Silica_1m", "Silica_B", "Silica_diff", "Silica_max", 
                    "Sulfate_1m", "Sulfate_B", "Sulfate_diff", "Sulfate_max")]


##### 2) Confidence Intervals for Plots #####

## Adjust column types in confidence interval dataframe
conf.int$Parameter <- as.factor(conf.int$Parameter)
conf.int$Percentile <- as.numeric(conf.int$Percentile)

## Filter confidence interval dataframes for TP
TP.CI = conf.int %>% filter(conf.int$Parameter == "TP")
TP.CI50 = TP.CI %>% filter(TP.CI$Percentile == "50")
TP.CI90 = TP.CI %>% filter(TP.CI$Percentile == "90")
## Filter confidence interval dataframes for SRP
SRP.CI = conf.int %>% filter(conf.int$Parameter == "SRP")
SRP.CI50 = SRP.CI %>% filter(SRP.CI$Percentile == "50")
SRP.CI90 = SRP.CI %>% filter(SRP.CI$Percentile == "90")
## Filter confidence interval dataframes for TN
TN.CI = conf.int %>% filter(conf.int$Parameter == "TN")
TN.CI50 = TN.CI %>% filter(TN.CI$Percentile == "50")
TN.CI90 = TN.CI %>% filter(TN.CI$Percentile == "90")
## Filter confidence interval dataframes for Ammonia
Ammonia.CI = conf.int %>% filter(conf.int$Parameter == "Ammonia")
Ammonia.CI50 = Ammonia.CI %>% filter(Ammonia.CI$Percentile == "50")
Ammonia.CI90 = Ammonia.CI %>% filter(Ammonia.CI$Percentile == "90")
## Filter confidence interval dataframes for AON
AON.CI = conf.int %>% filter(conf.int$Parameter == "AmmoniaOrganicN")
AON.CI50 = AON.CI %>% filter(AON.CI$Percentile == "50")
AON.CI90 = AON.CI %>% filter(AON.CI$Percentile == "90")
## Filter confidence interval dataframes for NOx
NOx.CI = conf.int %>% filter(conf.int$Parameter == "NOx")
NOx.CI50 = NOx.CI %>% filter(NOx.CI$Percentile == "50")
NOx.CI90 = NOx.CI %>% filter(NOx.CI$Percentile == "90")
## Filter confidence interval dataframes for TSS
TSS.CI = conf.int %>% filter(conf.int$Parameter == "TSS")
TSS.CI50 = TSS.CI %>% filter(TSS.CI$Percentile == "50")
TSS.CI90 = TSS.CI %>% filter(TSS.CI$Percentile == "90")
## Filter confidence interval dataframes for Chloride
Chloride.CI = conf.int %>% filter(conf.int$Parameter == "Chloride")
Chloride.CI50 = Chloride.CI %>% filter(Chloride.CI$Percentile == "50")
Chloride.CI90 = Chloride.CI %>% filter(Chloride.CI$Percentile == "90")
## Filter confidence interval dataframes for Fluoride
Fluoride.CI = conf.int %>% filter(conf.int$Parameter == "Fluoride")
Fluoride.CI50 = Fluoride.CI %>% filter(Fluoride.CI$Percentile == "50")
Fluoride.CI90 = Fluoride.CI %>% filter(Fluoride.CI$Percentile == "90")
## Filter confidence interval dataframes for Silica
Silica.CI = conf.int %>% filter(conf.int$Parameter == "Silica")
Silica.CI50 = Silica.CI %>% filter(Silica.CI$Percentile == "50")
Silica.CI90 = Silica.CI %>% filter(Silica.CI$Percentile == "90")
## Filter confidence interval dataframes for Sulfate
Sulfate.CI = conf.int %>% filter(conf.int$Parameter == "Sulfate")
Sulfate.CI50 = Sulfate.CI %>% filter(Sulfate.CI$Percentile == "50")
Sulfate.CI90 = Sulfate.CI %>% filter(Sulfate.CI$Percentile == "90")


##### Formatting/Prep for Logistic Regression #####

# subset columns to only what is needed
wc_1mB = wc1mB[,-c(6, 11:12, 15:18, 19:20, 23:24, 27:28, 31:32, 35:36, 39:40, 
                   43:44, 47:48, 51:52, 55:56)]


# add columns for logit matrix
wc_1mB <- add_column(wc_1mB, logitTP = "", .before = "SRP_diff")
wc_1mB <- add_column(wc_1mB, logitSRP = "", .before = "TN_diff")
wc_1mB <- add_column(wc_1mB, logitTN = "", .before = "Ammonia_diff")
wc_1mB <- add_column(wc_1mB, logitAmm = "", .before = "AmmoniaOrganicN_diff")
wc_1mB <- add_column(wc_1mB, logitAON = "", .before = "NOx_diff")
wc_1mB <- add_column(wc_1mB, logitNOx = "", .before = "TSS_diff")
wc_1mB <- add_column(wc_1mB, logitTSS = "", .before = "Chloride_diff")
wc_1mB <- add_column(wc_1mB, logitChl = "", .before = "Fluoride_diff")
wc_1mB <- add_column(wc_1mB, logitFluo = "", .before = "Silica_diff")
wc_1mB <- add_column(wc_1mB, logitSili = "", .before = "Sulfate_diff")
wc_1mB <- add_column(wc_1mB, logitSulf = "")
wc_1mB[, -c(1:10)] = sapply(wc_1mB[, -c(1:10)], as.numeric)

# ifelse statements to classify diff values as 0 or 1 (inside CI = 0, outside CI = 1)
# this works omg thanks maddie
wc_1mB$logitTP = ifelse(wc_1mB$TP_diff > TP.CI90$Lower & wc_1mB$TP_diff < TP.CI90$Upper,0,1)
wc_1mB$logitSRP = ifelse(wc_1mB$SRP_diff > SRP.CI90$Lower & wc_1mB$SRP_diff < SRP.CI90$Upper,0,1)
wc_1mB$logitTN = ifelse(wc_1mB$TN_diff > TN.CI90$Lower & wc_1mB$TN_diff < TN.CI90$Upper,0,1)
wc_1mB$logitAmm = ifelse(wc_1mB$Ammonia_diff > Ammonia.CI90$Lower & wc_1mB$Ammonia_diff < Ammonia.CI90$Upper,0,1)
wc_1mB$logitAON = ifelse(wc_1mB$AmmoniaOrganicN_diff > AON.CI90$Lower 
                         & wc_1mB$AmmoniaOrganicN_diff < AON.CI90$Upper,0,1)
wc_1mB$logitNOx = ifelse(wc_1mB$NOx_diff > NOx.CI90$Lower & wc_1mB$NOx_diff < NOx.CI90$Upper,0,1)
# No TSS bc no 90th CI
wc_1mB$logitChl = ifelse(wc_1mB$Chloride_diff > Chloride.CI90$Lower & wc_1mB$Chloride_diff < Chloride.CI90$Upper,0,1)
wc_1mB$logitFluo = ifelse(wc_1mB$Fluoride_diff > Fluoride.CI90$Lower & wc_1mB$Fluoride_diff < Fluoride.CI90$Upper,0,1)
wc_1mB$logitSili = ifelse(wc_1mB$Silica_diff > Silica.CI90$Lower & wc_1mB$Silica_diff < Silica.CI90$Upper,0,1)
wc_1mB$logitSulf = ifelse(wc_1mB$Sulfate_diff > Sulfate.CI90$Lower & wc_1mB$Sulfate_diff <= Sulfate.CI90$Upper,0,1)


##### Formatting/Prep of Nut Diff file for plots and write to csv #####

## Add lake column using transect column

wc_1mB <- add_column(wc_1mB, Lake = "", .after = "Year")

for(i in 1:nrow(wc_1mB)) {
  if(wc_1mB$Transect[i] == "HHB" || wc_1mB$Transect[i] == "HAL" ||
     wc_1mB$Transect[i] == "HTB") {
    wc_1mB$Lake[i] = "Huron"}
  if(wc_1mB$Transect[i] == "MMC" || wc_1mB$Transect[i] == "MSB" ||
     wc_1mB$Transect[i] == "MWA") {
    wc_1mB$Lake[i] = "Michigan"}
  if(wc_1mB$Transect[i] == "OIR" || wc_1mB$Transect[i] == "OOL" ||
     wc_1mB$Transect[i] == "OSI" || wc_1mB$Transect[i] == "OSN") {
    wc_1mB$Lake[i] = "Ontario"}
  if(wc_1mB$Transect[i] == "EDE" || wc_1mB$Transect[i] == "EDW" ||
     wc_1mB$Transect[i] == "EEP") {
    wc_1mB$Lake[i] = "Erie"}
}

# save .csv used for nutrient max/diff graphs
wc_1mB = wc_1mB[with(wc_1mB, order(DateTime)), ]
write.csv(wc_1mB, "nutrients_maxvsdiff_ALLYEARS.csv", na="NA", row.names = FALSE)

##### NA - 3) Nutrient max vs. diff plots WITH TRANSECT INCLUDED IN LEGEND #####

## Order transects by location for legend
wc_1mB$Transect = factor(wc_1mB$Transect, levels = c("MMC", "MWA", "MSB", "HHB", 
                                                     "HTB", "HAL", "EEP", "EDW", 
                                                     "EDE", "OIR", "OOL", "OSI", "OSN"))
# TP
ggplot(wc_1mB, aes(x=TP_max, y=TP_diff)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3", 
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"TP_max"])) + ylim(min(wc_1mB[,"TP_diff"]),
                                        max(wc_1mB[,"TP_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max TP (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)


# TN
ggplot(wc_1mB, aes(x=TN_max, y=TN_diff)) +
  geom_hline(yintercept = c(TN.CI50$Upper,TN.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TN.CI90$Upper,TN.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"TN_max"])) + ylim(min(wc_1mB[,"TN_diff"]),
                                        max(wc_1mB[,"TN_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max TN (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)


# Ammonia
ggplot(wc_1mB, aes(x=Ammonia_max, y=Ammonia_diff)) +
  geom_hline(yintercept = c(Ammonia.CI50$Upper,Ammonia.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Ammonia.CI90$Upper,Ammonia.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"Ammonia_max"])) + ylim(min(wc_1mB[,"Ammonia_diff"]),
                                             max(wc_1mB[,"Ammonia_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Ammonia (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Ammonia (mg/L) between \n1 m and 0.1 m above bottom", size = 18)


# Ammonia + Organic N
ggplot(wc_1mB, aes(x=AmmoniaOrganicN_max, y=AmmoniaOrganicN_diff)) +
  geom_hline(yintercept = c(AON.CI50$Upper,AON.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(AON.CI90$Upper,AON.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"AmmoniaOrganicN_max"])) + ylim(min(wc_1mB[,"AmmoniaOrganicN_diff"]),
                                                     max(wc_1mB[,"AmmoniaOrganicN_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Ammonia + Organic N (mg/L)\n of 1 m and 0.1 m above bottom", 
       y ="Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom", size = 18)



# NOx
ggplot(wc_1mB, aes(x=NOx_max, y=NOx_diff)) +
  geom_hline(yintercept = c(NOx.CI50$Upper,NOx.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(NOx.CI90$Upper,NOx.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"NOx_max"])) + ylim(min(wc_1mB[,"NOx_diff"]),
                                         max(wc_1mB[,"NOx_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max NOx (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)



# TSS
ggplot(wc_1mB, aes(x=TSS_max, y=TSS_diff)) +
  geom_hline(yintercept = c(TSS.CI50$Upper,TSS.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TSS.CI90$Upper,TSS.CI90$Lower), color = "grey57", ## NA for 90th
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"TSS_max"])) + ylim(min(wc_1mB[,"TSS_diff"]),
                                         max(wc_1mB[,"TSS_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max TSS (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)


# Chloride
ggplot(wc_1mB, aes(x=Chloride_max, y=Chloride_diff)) +
  geom_hline(yintercept = c(Chloride.CI50$Upper,Chloride.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Chloride.CI90$Upper,Chloride.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"Chloride_max"])) + ylim(min(wc_1mB[,"Chloride_diff"]),
                                              max(wc_1mB[,"Chloride_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Chloride (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)



# Fluoride
ggplot(wc_1mB, aes(x=Fluoride_max, y=Fluoride_diff)) +
  geom_hline(yintercept = c(Fluoride.CI50$Upper,Fluoride.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Fluoride.CI90$Upper,Fluoride.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"Fluoride_max"])) + ylim(min(wc_1mB[,"Fluoride_diff"]),
                                              max(wc_1mB[,"Fluoride_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Fluoride (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)



# Silica
ggplot(wc_1mB, aes(x=Silica_max, y=Silica_diff)) +
  geom_hline(yintercept = c(Silica.CI50$Upper,Silica.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Silica.CI90$Upper,Silica.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"Silica_max"])) + ylim(min(wc_1mB[,"Silica_diff"]),
                                            max(wc_1mB[,"Silica_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Silica (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)


# Sulfate
ggplot(wc_1mB, aes(x=Sulfate_max, y=Sulfate_diff)) +
  geom_hline(yintercept = c(Sulfate.CI50$Upper,Sulfate.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Sulfate.CI90$Upper,Sulfate.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3", "deepskyblue4",
                               "darkgoldenrod1", "darkgoldenrod", "darkgoldenrod3",
                               "deeppink","deeppink3", "deeppink4",
                               "chartreuse", "chartreuse3", "chartreuse4", 
                               "darkgreen")))) +
  xlim(0,max(wc_1mB[,"Sulfate_max"])) + ylim(min(wc_1mB[,"Sulfate_diff"]),
                                             max(wc_1mB[,"Sulfate_diff"])) +
  geom_hline(yintercept=0,color="black")+
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  theme_classic()+
  labs(x ="Max Sulfate (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

##### 3) Nutrient max vs. diff plots WITH JUST LAKE IN LEGEND (HERE) #####


# Make new dataframe for nutrient plots so it doesn't get affected by adcp subsets
wc1mB_plots = wc_1mB

## Order lake column by location for legend
wc1mB_plots$Lake = factor(wc1mB_plots$Lake, levels = c("Michigan", "Huron", 
                                             "Erie", "Ontario"))
# TP
tp = ggplot(wc1mB_plots, aes(x=TP_max, y=TP_diff)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.0001, 
              height = 0.0001, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"TP_max"])) + ylim(min(wc1mB_plots[,"TP_diff"]),
                                        max(wc1mB_plots[,"TP_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max TP (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(tp, filename = "TP_.pdf")

# SRP
srp = ggplot(wc1mB_plots, aes(x=SRP_max, y=SRP_diff)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.0001, 
              height = 0.0001, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"TP_max"])) + ylim(min(wc1mB_plots[,"TP_diff"]),
                                        max(wc1mB_plots[,"TP_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max SRP (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(srp, filename = "SRP_2.pdf")

# TN

wc1mB_plots$TN_diff [wc1mB_plots$TN_diff == 2.414] <- NA  #use this line if to remove large tn outlier

tn = ggplot(wc1mB_plots, aes(x=TN_max, y=TN_diff)) +
  geom_hline(yintercept = c(TN.CI50$Upper,TN.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TN.CI90$Upper,TN.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.0004, 
              height = 0.0004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"TN_max"])) + ylim(min(wc1mB_plots[,"TN_diff"]),
                                        max(wc1mB_plots[,"TN_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max TN (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(tn, filename = "TN_2.pdf")

# Ammonia
amm = ggplot(wc1mB_plots, aes(x=Ammonia_max, y=Ammonia_diff)) +
  geom_hline(yintercept = c(Ammonia.CI50$Upper,Ammonia.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Ammonia.CI90$Upper,Ammonia.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.0003, 
              height = 0.0003, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"Ammonia_max"])) + ylim(min(wc1mB_plots[,"Ammonia_diff"]),
                                             max(wc1mB_plots[,"Ammonia_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max Ammonia (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Ammonia (mg/L) between \n1 m and 0.1 m above bottom", size = 18)

ggexport(amm, filename = "Amm_2.pdf")

# Ammonia + Organic N
aon = ggplot(wc1mB_plots, aes(x=AmmoniaOrganicN_max, y=AmmoniaOrganicN_diff)) +
  geom_hline(yintercept = c(AON.CI50$Upper,AON.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(AON.CI90$Upper,AON.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.0004, 
              height = 0.005, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"AmmoniaOrganicN_max"])) + ylim(min(wc1mB_plots[,"AmmoniaOrganicN_diff"]),
                                                     max(wc1mB_plots[,"AmmoniaOrganicN_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max Ammonia + Organic N (mg/L)\n of 1 m and 0.1 m above bottom", 
       y ="Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom", size = 18)

ggexport(aon, filename = "AON_2.pdf")

# NOx
nox = ggplot(wc1mB_plots, aes(x=NOx_max, y=NOx_diff)) +
  geom_hline(yintercept = c(NOx.CI50$Upper,NOx.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(NOx.CI90$Upper,NOx.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.004, 
              height = 0.004, size = 2) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"NOx_max"])) + ylim(min(wc1mB_plots[,"NOx_diff"]),
                                         max(wc1mB_plots[,"NOx_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max NOx (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(nox, filename = "NOx_2.pdf")

# TSS
tss = ggplot(wc1mB_plots, aes(x=TSS_max, y=TSS_diff)) +
  geom_hline(yintercept = c(TSS.CI50$Upper,TSS.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TSS.CI90$Upper,TSS.CI90$Lower), color = "grey57", ## NA for 90th
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.001, 
              height = 0.002, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"TSS_max"])) + ylim(min(wc1mB_plots[,"TSS_diff"]),
                                         max(wc1mB_plots[,"TSS_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max TSS (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(tss, filename = "TSS_2.pdf")

# Chloride
chlo = ggplot(wc1mB_plots, aes(x=Chloride_max, y=Chloride_diff)) +
  geom_hline(yintercept = c(Chloride.CI50$Upper,Chloride.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Chloride.CI90$Upper,Chloride.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.005, 
              height = 0.005, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"Chloride_max"])) + ylim(min(wc1mB_plots[,"Chloride_diff"]),
                                              max(wc1mB_plots[,"Chloride_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max Chloride (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(chlo, filename = "Chloride_2.pdf")


# Fluoride
fluo = ggplot(wc1mB_plots, aes(x=Fluoride_max, y=Fluoride_diff)) +
  geom_hline(yintercept = c(Fluoride.CI50$Upper,Fluoride.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Fluoride.CI90$Upper,Fluoride.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.005, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"Fluoride_max"])) + ylim(min(wc1mB_plots[,"Fluoride_diff"]),
                                              max(wc1mB_plots[,"Fluoride_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max Fluoride (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(fluo, filename = "Fluoride_2.pdf")

# Silica
sili = ggplot(wc1mB_plots, aes(x=Silica_max, y=Silica_diff)) +
  geom_hline(yintercept = c(Silica.CI50$Upper,Silica.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Silica.CI90$Upper,Silica.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"Silica_max"])) + ylim(min(wc1mB_plots[,"Silica_diff"]),
                                            max(wc1mB_plots[,"Silica_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic()+
  labs(x ="Max Silica (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(sili, filename = "Silica_2.pdf")

# Sulfate
sulf = ggplot(wc1mB_plots, aes(x=Sulfate_max, y=Sulfate_diff)) +
  geom_hline(yintercept = c(Sulfate.CI50$Upper,Sulfate.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(Sulfate.CI90$Upper,Sulfate.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +  
  geom_abline(intercept=0,slope=1,color="black")+
  geom_abline(intercept=0,slope=-1,color="black")+
  geom_jitter(aes(shape=Year, fill = Lake), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 22, 23, 25)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc1mB_plots[,"Sulfate_max"])) + ylim(min(wc1mB_plots[,"Sulfate_diff"]),
                                             max(wc1mB_plots[,"Sulfate_diff"])) +
  geom_hline(yintercept=0,color="black")+

  theme_classic()+
  labs(x ="Max Sulfate (mg/L) of 1 m and \n0.1 m above bottom", 
       y ="Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

ggexport(sulf, filename = "Sulfate_2.pdf")


##### 3.5) WC BY SUBSTRATE - NEW ADDITION USING wc_1mB #####









##### 4) 24 hr Average formatting - ADCP #####

# averaging for noon times

# create Output file for noon-time reference ID file
adcp_combined$Hour = hour(adcp_combined$Time)
output = subset(adcp_combined)
output = output %>% 
  dplyr::group_by(Year, Transect) %>%
  dplyr::filter(Hour >= 10 & Hour <= 14) %>%
  distinct(Date, .keep_all = T) %>%
  add_column(AverageHere = "Yes")
output$Date = as.Date(output$Date)
output$Day = as.numeric(output$Date)

# match output to adcp combined to add AverageHere column to select rows
output2 = output %>%
  select(ID_DtTr, AverageHere)
adcp_combined = left_join(adcp_combined, output2, by = "ID_DtTr")
adcp_combined <- adcp_combined %>% dplyr::rename(Transect = Transect.x)
adcp_combined <- adcp_combined %>% dplyr::rename(Year = Year.x)
adcp_combined = subset(adcp_combined, select = -c(12,13))

adcp_combined$Day = as.numeric(adcp_combined$Date)
adcp_combined$Transect = as.character(adcp_combined$Transect)
output <- add_column(output, Day2 = output$Day)
output <- add_column(output, Day3 = output$Day)
output$Year = as.character(output$Year)
adcp_combined <- add_column(adcp_combined, Day2 = adcp_combined$Day)
adcp_combined <- add_column(adcp_combined, Day3 = adcp_combined$Day)

#output <- add_column(output, Assoc.Day = "")
adcp_combined <- add_column(adcp_combined, Assoc.Day = "")


# 24 hour averages

# add Associated Day column to adcp_combined
  for(j in 1:nrow(adcp_combined)) {
  if(adcp_combined$Hour[j] < 12) {
    adcp_combined$Assoc.Day[j] = adcp_combined$Day[j]
       } else {adcp_combined$Assoc.Day[j] = adcp_combined$Day[j]+1}
  }
adcp_combined$Assoc.Day = as.factor(adcp_combined$Assoc.Day)


# ID column for 24 hour
adcp_combined <- add_column(adcp_combined, Group = 
                            paste(adcp_combined$Transect, 
                                  adcp_combined$Year,
                                  adcp_combined$Assoc.Day,
                                  collapse = NULL), .before = "Year")
adcp_combined$Group = as.factor(adcp_combined$Group)


# add blank columns for putting 24 averages in
adcp_combined_avgs = adcp_combined
adcp_combined_avgs <- add_column(adcp_combined_avgs, Avg24hrSpdCell01 = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Max24hrSpdCell01 = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Avg24hrSWH = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Max24hrSWH = "")
  
# 24 hour averaging 
    avg24ws = aggregate(cbind(adcp_combined$Cell01Spd) 
                ~ adcp_combined$Year + adcp_combined$Transect + adcp_combined$Assoc.Day + adcp_combined$Group, 
                      adcp_combined, FUN=mean)
   avg24hs = aggregate(cbind(adcp_combined$Hs) 
                       ~ adcp_combined$Year + adcp_combined$Transect + adcp_combined$Assoc.Day + adcp_combined$Group, 
                       adcp_combined, FUN=mean)
   max24ws = aggregate(cbind(adcp_combined$Cell01Spd) 
                       ~ adcp_combined$Year + adcp_combined$Transect + adcp_combined$Assoc.Day + adcp_combined$Group, 
                       adcp_combined, FUN=max)
   max24hs = aggregate(cbind(adcp_combined$Hs) 
                       ~ adcp_combined$Year + adcp_combined$Transect + adcp_combined$Assoc.Day + adcp_combined$Group, 
                       adcp_combined, FUN=max) 
   
# change column names 
   colnames(avg24ws) = c("Year", "Transect", "Assoc.Day", "Group", "Avg24hrSpdCell01")
   colnames(avg24hs) = c("Year", "Transect", "Assoc.Day", "Group", "Avg24hrSWH")
   colnames(max24ws) = c("Year", "Transect", "Assoc.Day", "Group", "Max24hrSpdCell01")
   colnames(max24hs) = c("Year", "Transect", "Assoc.Day", "Group", "Max24hrSWH")
 
# merge variables together
   avemax24 = left_join(avg24ws, max24ws, by = "Group")
   avemax24 = subset(avemax24, select = -c(6:8))
   avemax24 = left_join(avemax24, avg24hs, by = "Group")
   avemax24 = subset(avemax24, select = -c(7:9))
   avemax24 = left_join(avemax24, max24hs, by = "Group")
   avemax24 = subset(avemax24, select = -c(8:10))
   names(avemax24)[1] = "Year"
   names(avemax24)[2] = "Transect"
   names(avemax24)[3] = "Assoc.Day"

# merge adcp_combined_avgs's station data with ave/max variables   
   adcp_combined_avgs = left_join(adcp_combined, avemax24, by = c("Group"))
   adcp_combined_avgs = subset(adcp_combined_avgs, select = -c(13,15:16,18:20))
   names(adcp_combined_avgs)[2] = "Transect"
   names(adcp_combined_avgs)[5] = "Year"
   names(adcp_combined_avgs)[14] = "Assoc.Day"

# make ADCP combined avgs 1 per day   
   adcp_combined_avgs = adcp_combined_avgs %>% 
     dplyr::group_by(Year, Transect) %>%
     dplyr::filter(Hour >= 10 & Hour <= 14) %>%
     distinct(Date, .keep_all = T)
   
##### ------ bar timeline prep for shelby ------ #####

adcpcombinedavgs_bar = adcp_combined_avgs
adcpcombinedavgs_bar = adcpcombinedavgs_bar[with(adcpcombinedavgs_bar, order(Transect, DateTime)), ]
     
write.csv(adcpcombinedavgs_bar, "adcpcombinedavgs.csv", na="NA", row.names = FALSE)



##### 5) Merging (fuzzyjoin) WaterChem with ADCP / THEN 48 hour averaging ####

# use package "fuzzyjoin" for merging

# restrict wc_1mB to just 6 m for only the ADCP graphs

wc_1mB = subset(wc_1mB, Station == 6)
   
# Make sure that each df's DateTime column has the same formatting/same tz & origin

wc_1mB$DateTime <- as.POSIXct(wc_1mB$DateTime, 
                              format = "%Y-%m-%d %H:%M",
                              origin = "1970-01-01",
                              tz = "Etc/GMT+5")
adcp_combined_avgs$DateTime <- as.POSIXct(adcp_combined_avgs$DateTime, 
                                          format = "%Y-%m-%d %H:%M:%S",
                                          origin = "1970-01-01",
                                          tz = "Etc/GMT+5")

# Create new blank column for numeric DateTime (DateTimeNum)
wc_1mB <- add_column(wc_1mB, DateTimeNum = "", 
                     .before = "TP_diff")
adcp_combined_avgs <- add_column(adcp_combined_avgs, DateTimeNum = "", 
                                .before = "Hs")

# Convert DateTime to numeric and put into DateTimeNum

wc_1mB$DateTimeNum = as.numeric(seconds(ymd_hms(wc_1mB$DateTime)))
adcp_combined_avgs$DateTimeNum = as.numeric(seconds(ymd_hms(adcp_combined_avgs$DateTime)))
adcp_combined_avgs$Assoc.Day = as.numeric(adcp_combined_avgs$Assoc.Day)

# add blank 48 hour columns 
adcp_combined_avgs <- add_column(adcp_combined_avgs, Avg48hrSpdCell01 = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Max48hrSpdCell01 = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Avg48hrSWH = "")
adcp_combined_avgs <- add_column(adcp_combined_avgs, Max48hrSWH = "")

# Subset ADCP data by transect
adcp_hhb = subset(adcp_combined_avgs, Transect == "HHB") #
adcp_htb = subset(adcp_combined_avgs, Transect == "HTB") #
adcp_mmc = subset(adcp_combined_avgs, Transect == "MMC") #
adcp_oir = subset(adcp_combined_avgs, Transect == "OIR") #
adcp_ool = subset(adcp_combined_avgs, Transect == "OOL") #
adcp_osi = subset(adcp_combined_avgs, Transect == "OSI") #
adcp_ede = subset(adcp_combined_avgs, Transect == "EDE") #
adcp_edw = subset(adcp_combined_avgs, Transect == "EDW") #
adcp_msb = subset(adcp_combined_avgs, Transect == "MSB") #
adcp_osn = subset(adcp_combined_avgs, Transect == "OSN") #
adcp_hal = subset(adcp_combined_avgs, Transect == "HAL") #
adcp_eep = subset(adcp_combined_avgs, Transect == "EEP") #

# Subset WC data by transect
wc_hhb = subset(wc_1mB, Transect == "HHB") #
wc_htb = subset(wc_1mB, Transect == "HTB") #
wc_mmc = subset(wc_1mB, Transect == "MMC") #
wc_oir = subset(wc_1mB, Transect == "OIR") #
wc_ool = subset(wc_1mB, Transect == "OOL") #
wc_osi = subset(wc_1mB, Transect == "OSI") #
wc_ede = subset(wc_1mB, Transect == "EDE") #
wc_edw = subset(wc_1mB, Transect == "EDW") #
wc_msb = subset(wc_1mB, Transect == "MSB") #
wc_osn = subset(wc_1mB, Transect == "OSN") #
wc_eep = subset(wc_1mB, Transect == "EEP") # 
wc_hal = subset(wc_1mB, Transect == "HAL") #
wc_mwa = subset(wc_1mB, Transect == "MWA") # doesn't have matching ADCP data

# Merge WC & ADCP data by transect
wc_adcp_hhb = left_join(wc_hhb, adcp_hhb, by = "Date")
wc_adcp_htb = left_join(wc_htb, adcp_htb, by = "Date")
wc_adcp_mmc = left_join(wc_mmc, adcp_mmc, by = "Date")
wc_adcp_oir = left_join(wc_oir, adcp_oir, by = "Date")
wc_adcp_ool = left_join(wc_ool, adcp_ool, by = "Date")
wc_adcp_osi = left_join(wc_osi, adcp_osi, by = "Date")
wc_adcp_ede = left_join(wc_ede, adcp_ede, by = "Date")
wc_adcp_edw = left_join(wc_edw, adcp_edw, by = "Date")
wc_adcp_msb = left_join(wc_msb, adcp_msb, by = "Date")
wc_adcp_osn = left_join(wc_osn, adcp_osn, by = "Date")
wc_adcp_hal = left_join(wc_hal, adcp_hal, by = "Date")
wc_adcp_eep = left_join(wc_eep, adcp_eep, by = "Date")

# calculate 48 hour averages by matching to waterchem 

# HHB
for(i in 1:nrow(wc_adcp_hhb)) {
  wc_adcp_hhb$Avg48hrSpdCell01[i] <- (adcp_hhb$Avg24hrSpdCell01[match(wc_adcp_hhb$Assoc.Day[i], adcp_hhb$Assoc.Day)] +
                                      adcp_hhb$Avg24hrSpdCell01[match(wc_adcp_hhb$Assoc.Day[i] - 1, adcp_hhb$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_hhb)) {
  wc_adcp_hhb$Avg48hrSWH[i] <- (adcp_hhb$Avg24hrSWH[match(wc_adcp_hhb$Assoc.Day[i], adcp_hhb$Assoc.Day)] +
                                adcp_hhb$Avg24hrSWH[match(wc_adcp_hhb$Assoc.Day[i] - 1, adcp_hhb$Assoc.Day)]) / 2
}

# HTB
for(i in 1:nrow(wc_adcp_htb)) {
  wc_adcp_htb$Avg48hrSpdCell01[i] <- (adcp_htb$Avg24hrSpdCell01[match(wc_adcp_htb$Assoc.Day[i], adcp_htb$Assoc.Day)] +
                                        adcp_htb$Avg24hrSpdCell01[match(wc_adcp_htb$Assoc.Day[i] - 1, adcp_htb$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_htb)) {
  wc_adcp_htb$Avg48hrSWH[i] <- (adcp_htb$Avg24hrSWH[match(wc_adcp_htb$Assoc.Day[i], adcp_htb$Assoc.Day)] +
                                  adcp_htb$Avg24hrSWH[match(wc_adcp_htb$Assoc.Day[i] - 1, adcp_htb$Assoc.Day)]) / 2
}
# MMC
for(i in 1:nrow(wc_adcp_mmc)) {
  wc_adcp_mmc$Avg48hrSpdCell01[i] <- (adcp_mmc$Avg24hrSpdCell01[match(wc_adcp_mmc$Assoc.Day[i], adcp_mmc$Assoc.Day)] +
                                        adcp_mmc$Avg24hrSpdCell01[match(wc_adcp_mmc$Assoc.Day[i] - 1, adcp_mmc$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_mmc)) {
  wc_adcp_mmc$Avg48hrSWH[i] <- (adcp_mmc$Avg24hrSWH[match(wc_adcp_mmc$Assoc.Day[i], adcp_mmc$Assoc.Day)] +
                                  adcp_mmc$Avg24hrSWH[match(wc_adcp_mmc$Assoc.Day[i] - 1, adcp_mmc$Assoc.Day)]) / 2
}
# OIR
for(i in 1:nrow(wc_adcp_oir)) {
  wc_adcp_oir$Avg48hrSpdCell01[i] <- (adcp_oir$Avg24hrSpdCell01[match(wc_adcp_oir$Assoc.Day[i], adcp_oir$Assoc.Day)] +
                                        adcp_oir$Avg24hrSpdCell01[match(wc_adcp_oir$Assoc.Day[i] - 1, adcp_oir$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_oir)) {
  wc_adcp_oir$Avg48hrSWH[i] <- (adcp_oir$Avg24hrSWH[match(wc_adcp_oir$Assoc.Day[i], adcp_oir$Assoc.Day)] +
                                  adcp_oir$Avg24hrSWH[match(wc_adcp_oir$Assoc.Day[i] - 1, adcp_oir$Assoc.Day)]) / 2
}
# OOL
for(i in 1:nrow(wc_adcp_ool)) {
  wc_adcp_ool$Avg48hrSpdCell01[i] <- (adcp_ool$Avg24hrSpdCell01[match(wc_adcp_ool$Assoc.Day[i], adcp_ool$Assoc.Day)] +
                                        adcp_ool$Avg24hrSpdCell01[match(wc_adcp_ool$Assoc.Day[i] - 1, adcp_ool$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_ool)) {
  wc_adcp_ool$Avg48hrSWH[i] <- (adcp_ool$Avg24hrSWH[match(wc_adcp_ool$Assoc.Day[i], adcp_ool$Assoc.Day)] +
                                  adcp_ool$Avg24hrSWH[match(wc_adcp_ool$Assoc.Day[i] - 1, adcp_ool$Assoc.Day)]) / 2
}
# OSI
for(i in 1:nrow(wc_adcp_osi)) {
  wc_adcp_osi$Avg48hrSpdCell01[i] <- (adcp_osi$Avg24hrSpdCell01[match(wc_adcp_osi$Assoc.Day[i], adcp_osi$Assoc.Day)] +
                                        adcp_osi$Avg24hrSpdCell01[match(wc_adcp_osi$Assoc.Day[i] - 1, adcp_osi$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_osi)) {
  wc_adcp_osi$Avg48hrSWH[i] <- (adcp_osi$Avg24hrSWH[match(wc_adcp_osi$Assoc.Day[i], adcp_osi$Assoc.Day)] +
                                  adcp_osi$Avg24hrSWH[match(wc_adcp_osi$Assoc.Day[i] - 1, adcp_osi$Assoc.Day)]) / 2
}
# EDE
for(i in 1:nrow(wc_adcp_ede)) {
  wc_adcp_ede$Avg48hrSpdCell01[i] <- (adcp_ede$Avg24hrSpdCell01[match(wc_adcp_ede$Assoc.Day[i], adcp_ede$Assoc.Day)] +
                                        adcp_ede$Avg24hrSpdCell01[match(wc_adcp_ede$Assoc.Day[i] - 1, adcp_ede$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_ede)) {
  wc_adcp_ede$Avg48hrSWH[i] <- (adcp_ede$Avg24hrSWH[match(wc_adcp_ede$Assoc.Day[i], adcp_ede$Assoc.Day)] +
                                  adcp_ede$Avg24hrSWH[match(wc_adcp_ede$Assoc.Day[i] - 1, adcp_ede$Assoc.Day)]) / 2
}
# EDW
for(i in 1:nrow(wc_adcp_edw)) {
  wc_adcp_edw$Avg48hrSpdCell01[i] <- (adcp_edw$Avg24hrSpdCell01[match(wc_adcp_edw$Assoc.Day[i], adcp_edw$Assoc.Day)] +
                                        adcp_edw$Avg24hrSpdCell01[match(wc_adcp_edw$Assoc.Day[i] - 1, adcp_edw$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_edw)) {
  wc_adcp_edw$Avg48hrSWH[i] <- (adcp_edw$Avg24hrSWH[match(wc_adcp_edw$Assoc.Day[i], adcp_edw$Assoc.Day)] +
                                  adcp_edw$Avg24hrSWH[match(wc_adcp_edw$Assoc.Day[i] - 1, adcp_edw$Assoc.Day)]) / 2
}
# MSB
for(i in 1:nrow(wc_adcp_msb)) {
  wc_adcp_msb$Avg48hrSpdCell01[i] <- (adcp_msb$Avg24hrSpdCell01[match(wc_adcp_msb$Assoc.Day[i], adcp_msb$Assoc.Day)] +
                                        adcp_msb$Avg24hrSpdCell01[match(wc_adcp_msb$Assoc.Day[i] - 1, adcp_msb$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_msb)) {
  wc_adcp_msb$Avg48hrSWH[i] <- (adcp_msb$Avg24hrSWH[match(wc_adcp_msb$Assoc.Day[i], adcp_msb$Assoc.Day)] +
                                  adcp_msb$Avg24hrSWH[match(wc_adcp_msb$Assoc.Day[i] - 1, adcp_msb$Assoc.Day)]) / 2
}
# OSN
for(i in 1:nrow(wc_adcp_osn)) {
  wc_adcp_osn$Avg48hrSpdCell01[i] <- (adcp_osn$Avg24hrSpdCell01[match(wc_adcp_osn$Assoc.Day[i], adcp_osn$Assoc.Day)] +
                                        adcp_osn$Avg24hrSpdCell01[match(wc_adcp_osn$Assoc.Day[i] - 1, adcp_osn$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_osn)) {
  wc_adcp_osn$Avg48hrSWH[i] <- (adcp_osn$Avg24hrSWH[match(wc_adcp_osn$Assoc.Day[i], adcp_osn$Assoc.Day)] +
                                  adcp_osn$Avg24hrSWH[match(wc_adcp_osn$Assoc.Day[i] - 1, adcp_osn$Assoc.Day)]) / 2
}
# HAL
for(i in 1:nrow(wc_adcp_hal)) {
  wc_adcp_hal$Avg48hrSpdCell01[i] <- (adcp_hal$Avg24hrSpdCell01[match(wc_adcp_hal$Assoc.Day[i], adcp_hal$Assoc.Day)] +
                                        adcp_hal$Avg24hrSpdCell01[match(wc_adcp_hal$Assoc.Day[i] - 1, adcp_hal$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_hal)) {
  wc_adcp_hal$Avg48hrSWH[i] <- (adcp_hal$Avg24hrSWH[match(wc_adcp_hal$Assoc.Day[i], adcp_hal$Assoc.Day)] +
                                  adcp_hal$Avg24hrSWH[match(wc_adcp_hal$Assoc.Day[i] - 1, adcp_hal$Assoc.Day)]) / 2
}
# EEP
for(i in 1:nrow(wc_adcp_eep)) {
  wc_adcp_eep$Avg48hrSpdCell01[i] <- (adcp_eep$Avg24hrSpdCell01[match(wc_adcp_eep$Assoc.Day[i], adcp_eep$Assoc.Day)] +
                                        adcp_eep$Avg24hrSpdCell01[match(wc_adcp_eep$Assoc.Day[i] - 1, adcp_eep$Assoc.Day)]) / 2
}
for(i in 1:nrow(wc_adcp_eep)) {
  wc_adcp_eep$Avg48hrSWH[i] <- (adcp_eep$Avg24hrSWH[match(wc_adcp_eep$Assoc.Day[i], adcp_eep$Assoc.Day)] +
                                  adcp_eep$Avg24hrSWH[match(wc_adcp_eep$Assoc.Day[i] - 1, adcp_eep$Assoc.Day)]) / 2
}

# calculate 48 hour maxes by matching to waterchem

# HHB
for(i in 1:nrow(wc_adcp_hhb)) {
  wc_adcp_hhb$Max48hrSpdCell01[i] <- pmax(adcp_hhb$Max24hrSpdCell01[match(wc_adcp_hhb$Assoc.Day[i], adcp_hhb$Assoc.Day)],
                                        adcp_hhb$Max24hrSpdCell01[match(wc_adcp_hhb$Assoc.Day[i] - 1, adcp_hhb$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_hhb)) {
  wc_adcp_hhb$Max48hrSWH[i] <- pmax(adcp_hhb$Max24hrSWH[match(wc_adcp_hhb$Assoc.Day[i], adcp_hhb$Assoc.Day)],
                                          adcp_hhb$Max24hrSWH[match(wc_adcp_hhb$Assoc.Day[i] - 1, adcp_hhb$Assoc.Day)])
}
# HTB
for(i in 1:nrow(wc_adcp_htb)) {
  wc_adcp_htb$Max48hrSpdCell01[i] <- pmax(adcp_htb$Max24hrSpdCell01[match(wc_adcp_htb$Assoc.Day[i], adcp_htb$Assoc.Day)],
                                          adcp_htb$Max24hrSpdCell01[match(wc_adcp_htb$Assoc.Day[i] - 1, adcp_htb$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_htb)) {
  wc_adcp_htb$Max48hrSWH[i] <- pmax(adcp_htb$Max24hrSWH[match(wc_adcp_htb$Assoc.Day[i], adcp_htb$Assoc.Day)],
                                    adcp_htb$Max24hrSWH[match(wc_adcp_htb$Assoc.Day[i] - 1, adcp_htb$Assoc.Day)])
}
# MMC
for(i in 1:nrow(wc_adcp_mmc)) {
  wc_adcp_mmc$Max48hrSpdCell01[i] <- pmax(adcp_mmc$Max24hrSpdCell01[match(wc_adcp_mmc$Assoc.Day[i], adcp_mmc$Assoc.Day)],
                                          adcp_mmc$Max24hrSpdCell01[match(wc_adcp_mmc$Assoc.Day[i] - 1, adcp_mmc$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_mmc)) {
  wc_adcp_mmc$Max48hrSWH[i] <- pmax(adcp_mmc$Max24hrSWH[match(wc_adcp_mmc$Assoc.Day[i], adcp_mmc$Assoc.Day)],
                                    adcp_mmc$Max24hrSWH[match(wc_adcp_mmc$Assoc.Day[i] - 1, adcp_mmc$Assoc.Day)])
}
# OIR
for(i in 1:nrow(wc_adcp_oir)) {
  wc_adcp_oir$Max48hrSpdCell01[i] <- pmax(adcp_oir$Max24hrSpdCell01[match(wc_adcp_oir$Assoc.Day[i], adcp_oir$Assoc.Day)],
                                          adcp_oir$Max24hrSpdCell01[match(wc_adcp_oir$Assoc.Day[i] - 1, adcp_oir$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_oir)) {
  wc_adcp_oir$Max48hrSWH[i] <- pmax(adcp_oir$Max24hrSWH[match(wc_adcp_oir$Assoc.Day[i], adcp_oir$Assoc.Day)],
                                    adcp_oir$Max24hrSWH[match(wc_adcp_oir$Assoc.Day[i] - 1, adcp_oir$Assoc.Day)])
}
# OOL
for(i in 1:nrow(wc_adcp_ool)) {
  wc_adcp_ool$Max48hrSpdCell01[i] <- pmax(adcp_ool$Max24hrSpdCell01[match(wc_adcp_ool$Assoc.Day[i], adcp_ool$Assoc.Day)],
                                          adcp_ool$Max24hrSpdCell01[match(wc_adcp_ool$Assoc.Day[i] - 1, adcp_ool$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_ool)) {
  wc_adcp_ool$Max48hrSWH[i] <- pmax(adcp_ool$Max24hrSWH[match(wc_adcp_ool$Assoc.Day[i], adcp_ool$Assoc.Day)],
                                    adcp_ool$Max24hrSWH[match(wc_adcp_ool$Assoc.Day[i] - 1, adcp_ool$Assoc.Day)])
}
# OSI
for(i in 1:nrow(wc_adcp_osi)) {
  wc_adcp_osi$Max48hrSpdCell01[i] <- pmax(adcp_osi$Max24hrSpdCell01[match(wc_adcp_osi$Assoc.Day[i], adcp_osi$Assoc.Day)],
                                          adcp_osi$Max24hrSpdCell01[match(wc_adcp_osi$Assoc.Day[i] - 1, adcp_osi$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_osi)) {
  wc_adcp_osi$Max48hrSWH[i] <- pmax(adcp_osi$Max24hrSWH[match(wc_adcp_osi$Assoc.Day[i], adcp_osi$Assoc.Day)],
                                    adcp_osi$Max24hrSWH[match(wc_adcp_osi$Assoc.Day[i] - 1, adcp_osi$Assoc.Day)])
}
# EDE
for(i in 1:nrow(wc_adcp_ede)) {
  wc_adcp_ede$Max48hrSpdCell01[i] <- pmax(adcp_ede$Max24hrSpdCell01[match(wc_adcp_ede$Assoc.Day[i], adcp_ede$Assoc.Day)],
                                          adcp_ede$Max24hrSpdCell01[match(wc_adcp_ede$Assoc.Day[i] - 1, adcp_ede$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_ede)) {
  wc_adcp_ede$Max48hrSWH[i] <- pmax(adcp_ede$Max24hrSWH[match(wc_adcp_ede$Assoc.Day[i], adcp_ede$Assoc.Day)],
                                    adcp_ede$Max24hrSWH[match(wc_adcp_ede$Assoc.Day[i] - 1, adcp_ede$Assoc.Day)])
}
# EDW
for(i in 1:nrow(wc_adcp_edw)) {
  wc_adcp_edw$Max48hrSpdCell01[i] <- pmax(adcp_edw$Max24hrSpdCell01[match(wc_adcp_edw$Assoc.Day[i], adcp_edw$Assoc.Day)],
                                          adcp_edw$Max24hrSpdCell01[match(wc_adcp_edw$Assoc.Day[i] - 1, adcp_edw$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_edw)) {
  wc_adcp_edw$Max48hrSWH[i] <- pmax(adcp_edw$Max24hrSWH[match(wc_adcp_edw$Assoc.Day[i], adcp_edw$Assoc.Day)],
                                    adcp_edw$Max24hrSWH[match(wc_adcp_edw$Assoc.Day[i] - 1, adcp_edw$Assoc.Day)])
}
# MSB
for(i in 1:nrow(wc_adcp_msb)) {
  wc_adcp_msb$Max48hrSpdCell01[i] <- pmax(adcp_msb$Max24hrSpdCell01[match(wc_adcp_msb$Assoc.Day[i], adcp_msb$Assoc.Day)],
                                          adcp_msb$Max24hrSpdCell01[match(wc_adcp_msb$Assoc.Day[i] - 1, adcp_msb$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_msb)) {
  wc_adcp_msb$Max48hrSWH[i] <- pmax(adcp_msb$Max24hrSWH[match(wc_adcp_msb$Assoc.Day[i], adcp_msb$Assoc.Day)],
                                    adcp_msb$Max24hrSWH[match(wc_adcp_msb$Assoc.Day[i] - 1, adcp_msb$Assoc.Day)])
}
# OSN
for(i in 1:nrow(wc_adcp_osn)) {
  wc_adcp_osn$Max48hrSpdCell01[i] <- pmax(adcp_osn$Max24hrSpdCell01[match(wc_adcp_osn$Assoc.Day[i], adcp_osn$Assoc.Day)],
                                          adcp_osn$Max24hrSpdCell01[match(wc_adcp_osn$Assoc.Day[i] - 1, adcp_osn$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_osn)) {
  wc_adcp_osn$Max48hrSWH[i] <- pmax(adcp_osn$Max24hrSWH[match(wc_adcp_osn$Assoc.Day[i], adcp_osn$Assoc.Day)],
                                    adcp_osn$Max24hrSWH[match(wc_adcp_osn$Assoc.Day[i] - 1, adcp_osn$Assoc.Day)])
}
# HAL
for(i in 1:nrow(wc_adcp_hal)) {
  wc_adcp_hal$Max48hrSpdCell01[i] <- pmax(adcp_hal$Max24hrSpdCell01[match(wc_adcp_hal$Assoc.Day[i], adcp_hal$Assoc.Day)],
                                          adcp_hal$Max24hrSpdCell01[match(wc_adcp_hal$Assoc.Day[i] - 1, adcp_hal$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_hal)) {
  wc_adcp_hal$Max48hrSWH[i] <- pmax(adcp_hal$Max24hrSWH[match(wc_adcp_hal$Assoc.Day[i], adcp_hal$Assoc.Day)],
                                    adcp_hal$Max24hrSWH[match(wc_adcp_hal$Assoc.Day[i] - 1, adcp_hal$Assoc.Day)])
}
# EEP
for(i in 1:nrow(wc_adcp_eep)) {
  wc_adcp_eep$Max48hrSpdCell01[i] <- pmax(adcp_eep$Max24hrSpdCell01[match(wc_adcp_eep$Assoc.Day[i], adcp_eep$Assoc.Day)],
                                          adcp_eep$Max24hrSpdCell01[match(wc_adcp_eep$Assoc.Day[i] - 1, adcp_eep$Assoc.Day)])
}
for(i in 1:nrow(wc_adcp_eep)) {
  wc_adcp_eep$Max48hrSWH[i] <- pmax(adcp_eep$Max24hrSWH[match(wc_adcp_eep$Assoc.Day[i], adcp_eep$Assoc.Day)],
                                    adcp_eep$Max24hrSWH[match(wc_adcp_eep$Assoc.Day[i] - 1, adcp_eep$Assoc.Day)])
}

# Merge all wc/adcp dataframes, all transects put together
wc_adcp_all = rbind(wc_adcp_hhb, wc_adcp_htb, wc_adcp_mmc, wc_adcp_oir,
                    wc_adcp_ool, wc_adcp_osi, wc_adcp_ede, wc_adcp_edw,
                    wc_adcp_msb, wc_adcp_osn, wc_adcp_hal, wc_adcp_eep)

# make new columns numeric
wc_adcp_all$Avg48hrSpdCell01 = as.numeric(wc_adcp_all$Avg48hrSpdCell01)
wc_adcp_all$Max48hrSpdCell01 = as.numeric(wc_adcp_all$Max48hrSpdCell01)
wc_adcp_all$Avg48hrSWH = as.numeric(wc_adcp_all$Avg48hrSWH)
wc_adcp_all$Max48hrSWH = as.numeric(wc_adcp_all$Max48hrSWH)


# save merged calculations file for input into logistic regression
wc_adcp_all = wc_adcp_all[with(wc_adcp_all, order(Transect.x, DateTime.x)), ]
write.csv(wc_adcp_all, "wc_adcp_ALLYEARS.csv", na="NA", row.names = FALSE)


##### ------ LOGISTIC REGRESSION ------ #####

# load files
wcadcp <- read.csv("C:/Users/melewan/Desktop/Data files/wc_adcp_all.csv", header = TRUE)
inputx <- read.csv("C:/Users/melewan/Desktop/Data files/logit - nutrient x physical parameters.csv", header = TRUE)

# remove unnecessary columns
wcadcp <- subset(wcadcp, select = -c(1,2,6:8,10:12,14:15,17:18,20:21,23:24,26:27,29:33,35:36,
                                     38:39, 41:42, 44:57))

# remove outliers
wcadcp$Max48hrSWH [wcadcp$Max48hrSWH > 60] <- NA
wcadcp$Avg48hrSWH [wcadcp$Avg48hrSWH > 60] <- NA
wcadcp$Avg24hrSWH [wcadcp$Avg24hrSWH > 60] <- NA
wcadcp$Max24hrSWH [wcadcp$Max24hrSWH > 60] <- NA

wcadcp$Avg24hrSpdCell01 [wcadcp$Avg24hrSpdCell01 > 35] <- NA
wcadcp$Max24hrSpdCell01 [wcadcp$Max24hrSpdCell01 > 40] <- NA
wcadcp$Max48hrSpdCell01 [wcadcp$Max48hrSpdCell01 > 40] <- NA



# rename some columns
names(wcadcp)[3] = "Year"
names(wcadcp)[4] = "Transect"
names(wcadcp)[9] = "DateTime"

# make 1,0 columns numeric
#wcadcp[,c(13,16,19,22,25,28,34,37,40,43)] = sapply(wcadcp[,c(13,16,19,22,25,28,34,37,40,43)], as.numeric)

# create new df for xval output
columnames = c("Modelname", "Xval", "Pvalue", "AIC")
temp_df = data.frame(matrix(ncol = 4))
colnames(temp_df) <- columnames

# gather info for each parameter combination and loop through all
for(i in 1:nrow (inputx)) {
  #i = 1
  logit = inputx$Nutrient[i]
  physical = inputx$ColumnName[i]
  if (inputx$Parameter[i] == "Water Speed"){
    df_list = list(wcadcp = wcadcp)
  } else {
    df_list = list(wcadcp = wcadcp)
  }
  xlab = inputx$ColumnName[i]
  ylab = inputx$Nutrient[i]
  modelname = paste(logit, " x ", physical, sep = "")
  
  # function for run model, calculate x, plot logit
  modelall = function(logit, physical, df_list, xlab, ylab, modelname, data) {
    
    # run model
    model = glm(paste(as.character(colnames(df_list[[1]])[colnames(df_list[[1]]) %in% logit]),
                      "~", as.character(colnames(df_list[[1]])[colnames(df_list[[1]]) %in% physical])), 
                family=binomial(), data = df_list[[1]])
    options(scipen=999)
    summary = summary(model)
    form = paste0(as.character(logit), " ~ ", as.character(physical))
    
    replace1 = gsub("paste\\(.+", form, deparse(summary$call[[2]])[1], perl = TRUE)
    replace2 = gsub("\\s+logit].+", "", deparse(summary$call[[2]])[2], perl = TRUE)
    replace3 = gsub("\\s+physical].+", "", deparse(summary$call[[2]])[3], perl = TRUE)
    final_replace = sym(gsub("`", "", sym(replace1), perl = TRUE))
    summary$call[[2]] = final_replace
    
    summary$call[[4]] = sym(gsub('df_list.+', names(df_list)[1], deparse(summary$call[[4]]), perl = TRUE))
    # glm(formula = y ~ x, family = "binomial", data = data)
    
    print(summary$call[[2]])
    
    
    # 1) save model output as a .csv
    capture.output(summary, file = paste0(modelname, ".csv"))
    
    # 2) solve logit equation for x, using 10% probability and model coefficients
    xval = (log(0.1/(1-0.1)) - coef(model)[1])/coef(model)[2]
    
    pvalue = coef(summary(model))[2,4] # 2nd row (predictor), 4th value in summary (p value)
    aic = AIC(model)
    
    newrow <- c(modelname, xval, pvalue, aic)
    data[i, ] <- newrow
    
    # plot
    ggplot(data = df_list[[1]], aes(x = df_list[[1]][, c(physical)], y = abs(df_list[[1]][,c(logit)]))) + 
      geom_point(data = df_list[[1]], aes(x = df_list[[1]][, c(physical)], y = abs(df_list[[1]][,c(logit)]))) +
      stat_smooth(method = "glm", method.args = list(family=binomial), se = TRUE) + 
      scale_y_discrete()+
      scale_x_continuous() +
      xlab(xlab) +
      ylab(ylab) #+
    #geom_vline(xintercept = xval)
    ggsave(file =paste(modelname, ".pdf"))
    
    return(data)
  }
  
  temp_df <- modelall(logit, physical, df_list, xlab, ylab, modelname, temp_df)
}

# Write dataframe out to .csv
write_csv(temp_df, "modelxvalues.csv")


# done


##### 6) Graphing Physical Parameters + Nutrients - formatting and prep #####

## a) ADCP ##

# trying to remove unnecessary/duplicated columns, not working
#wc_adcp_plots <- wc_adcp[, -c("ID_DTr", "ID_DTrS", "ID_DtTr.y", "Year.y", "Transect.y", 
 #                          "Depth", "SubstrateType", "Date.y", "DateTime.y")]

# rename some columns
wc_adcp_plots <- wc_adcp_all %>% dplyr::rename(Transect = Transect.x)  
wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(Year = Year.x)  
# wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(Date = Date.x)  
wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(DateTime = DateTime.x)

## Order transects by location for legend
#wc_adcp_plots$Transect = factor(wc_adcp_plots$Transect, 
#                                levels = c("MMC", "MSB", "HHB", 
 #                                          "HTB", "EDW","EDE", 
  #                                         "OIR", "OOL", "OSI", "OSN"))
wc_adcp_plots <- add_column(wc_adcp_plots, Lake = "", .after = "Year")

for(i in 1:nrow(wc_adcp_plots)) {
  if(wc_adcp_plots$Transect[i] == "HHB" || wc_adcp_plots$Transect[i] == "HAL" ||
     wc_adcp_plots$Transect[i] == "HTB") {
    wc_adcp_plots$Lake[i] = "Huron"}
  if(wc_adcp_plots$Transect[i] == "MMC" || wc_adcp_plots$Transect[i] == "MSB" ||
     wc_adcp_plots$Transect[i] == "MWA") {
    wc_adcp_plots$Lake[i] = "Michigan"}
  if(wc_adcp_plots$Transect[i] == "OIR" || wc_adcp_plots$Transect[i] == "OOL" ||
     wc_adcp_plots$Transect[i] == "OSI" || wc_adcp_plots$Transect[i] == "OSN") {
    wc_adcp_plots$Lake[i] = "Ontario"}
  if(wc_adcp_plots$Transect[i] == "EDE" || wc_adcp_plots$Transect[i] == "EDW" ||
     wc_adcp_plots$Transect[i] == "EEP") {
    wc_adcp_plots$Lake[i] = "Erie"}
}
## Order lake column by location for legend
wc_adcp_plots$Lake = factor(wc_adcp_plots$Lake, levels = c("Michigan", "Huron", 
                                                           "Erie", "Ontario"))

## Remove outlier because it doesn't match up with an ADCP measurement,
## but it is making the scale of the TN graphs larger without a point to support it.
wc_adcp_plots$TN_diff [wc_adcp_plots$TN_diff == 2.414] <- NA
wc_adcp_plots$Ammonia_diff [wc_adcp_plots$Ammonia_diff == -0.3015] <- NA
wc_adcp_plots$Chloride_diff [wc_adcp_plots$Chloride_diff > 47] <- NA
wc_adcp_plots$Sulfate_diff [wc_adcp_plots$Sulfate_diff > 2.5] <- NA

# set some columns to numeric
wc_adcp_plots$Avg48hrSpdCell01 = as.numeric(wc_adcp_plots$Avg48hrSpdCell01)
wc_adcp_plots$Max48hrSpdCell01 = as.numeric(wc_adcp_plots$Max48hrSpdCell01)
wc_adcp_plots$Avg48hrSWH = as.numeric(wc_adcp_plots$Avg48hrSWH)
wc_adcp_plots$Max48hrSWH = as.numeric(wc_adcp_plots$Max48hrSWH)

# remove rows if  year is 2020 (wc has 2020 but adcp does not)
wc_adcp_plots = subset(wc_adcp_plots, Year != 2020)

# ## b) WINDSPEED ##
# 
# # rename some columns
# wc_ws_plots <- wc_ws_all
# wc_ws_plots <- wc_ws_plots %>% dplyr::rename(Year = Year.x)  
# wc_ws_plots <- wc_ws_plots %>% dplyr::rename(Date = Date.x)  
# wc_ws_plots <- wc_ws_plots %>% dplyr::rename(DateTime = DateTime.x)
# 
# ## Order transects by location for legend
# #wc_adcp_plots$Transect = factor(wc_adcp_plots$Transect, 
# #                                levels = c("MMC", "MSB", "HHB", 
# #                                          "HTB", "EDW","EDE", 
# #                                         "OIR", "OOL", "OSI", "OSN"))
# 
# ## Order lake column by location for legend
# wc_ws_plots$Lake = factor(wc_ws_plots$Lake, levels = c("Michigan", "Huron", 
#                                                            "Erie", "Ontario"))
# 
# ## Remove outlier because it doesn't match up with a physical measurement,
# ## but it is making the scale of the graphs larger without a point to support it.
# wc_ws_plots$TN_diff [wc_ws_plots$TN_diff == 2.414] <- NA
# wc_ws_plots$Ammonia_diff [wc_ws_plots$Ammonia_diff == -0.3015] <- NA
# wc_ws_plots$Chloride_diff [wc_ws_plots$Chloride_diff > 47] <- NA
# wc_ws_plots$Sulfate_diff [wc_ws_plots$Sulfate_diff > 2.5] <- NA
# wc_ws_plots$Avg48hrWSPD [wc_ws_plots$Avg48hrWSPD > 15] <- NA
# 


##### 7) Early plot example for ADCP Water Speed vs. Nutrient Diff ####

# TP (writing the code to go into the function)
## 1) coloring by transect

# Avg24hrSpdCell01
ggplot(wc_adcp_plots, aes(x=Avg24hrSpdCell01, y=TP_diff)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape = Year, fill = Transect), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21)) +
  scale_fill_manual(values = c("deepskyblue","deepskyblue3",         #MMC, MSB
                               "darkgoldenrod1", "darkgoldenrod",    #HHB, HTB
                                "deeppink","deeppink3",              #EDW, EDE
                                "chartreuse", "chartreuse3",         #OIR, OOL, OSI/N   
                               "chartreuse4", "darkgreen")) +                             
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue","deepskyblue3",
                               "darkgoldenrod1", "darkgoldenrod",
                               "deeppink","deeppink3",
                               "chartreuse", "chartreuse3", 
                               "chartreuse4","darkgreen")))) +
  xlim(0,max(wc_adcp_plots[,"Avg24hrSpdCell01"])) + ylim(min(wc_adcp_plots[,"TP_diff"]),
                                        max(wc_adcp_plots[,"TP_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic() +
  labs(x ="Average 24 hour water speed (cm/s) in Cell 01", 
       y ="Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)

## 2) COLORING BY LAKE - USE NOW

# TP (writing the code to go into the function)

# Avg24hrSpdCell01
ggplot(wc_adcp_plots, aes(x=Avg24hrSpdCell01, y=TP_diff)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 1) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed", size = 1) +
  geom_jitter(aes(shape = Year, fill = Lake), width = 0.004, 
              height = 0.004, size = 2) +
  scale_shape_manual(values = c(24, 21, 23)) +
  scale_fill_manual(values = c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")) +                             
  guides(fill=guide_legend(
    override.aes=list(colour=c("deepskyblue",
                               "darkgoldenrod1",
                               "deeppink",
                               "darkgreen")))) +
  xlim(0,max(wc_adcp_plots[,"Avg24hrSpdCell01"])) + ylim(min(wc_adcp_plots[,"TP_diff"]),
                                                         max(wc_adcp_plots[,"TP_diff"])) +
  geom_hline(yintercept=0,color="black")+
  theme_classic() +
  labs(x ="Average 24 hour water speed (cm/s) in Cell 01", 
       y ="Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18)
  
##### 8) Function for ADCP (both water speed and SWH) vs. Diff Nutrients plots ######


adcpplots = function(dat, xvar, yvar, CI50, CI90, U, L, xlab, ylab) {
  
  ggplot(data = dat, aes(x = dat[,xvar], y = dat[,yvar])) +
    geom_hline(yintercept = c(CI50[,U], CI50[,L]), color = "grey68",
               linetype = "solid", size = 0.5) +
    geom_hline(yintercept = c(CI90[,U], CI90[,L]), color = "grey68",
               linetype = "dashed", size = 0.5) +
    geom_hline(yintercept=0,color="black")+
    geom_jitter(aes(shape = Year, fill = Lake), width = 0.004, 
                height = 0.004, size = 2) +
    scale_shape_manual(values = c(24, 21, 23, 25)) +
    scale_fill_manual(values = c("deepskyblue",
                                 "darkgoldenrod1",
                                 "deeppink",
                                 "darkgreen")) +                             
    guides(fill=guide_legend(
      override.aes=list(colour=c("deepskyblue",
                                 "darkgoldenrod1",
                                 "deeppink",
                                 "darkgreen")))) +
    xlim(0,max(dat[,xvar])) + ylim(min(dat[,yvar]), max(dat[,yvar])) +
    theme_classic() + labs(x = xlab, y = ylab, size = 18) 
}

##### 8a) Post-function code for Water Speed vs. Diff nutrients plots #####

# TP #
tp1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
# tp5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
#           "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
# tp6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
#           "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
# tp7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
#           "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
# tp8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
#           "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
TPplots1 = ggarrange(tp1, tp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots2 = ggarrange(tp3, tp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
# TPplots3 = ggarrange(tp5, tp6, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
# TPplots4 = ggarrange(tp7, tp8, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
ggexport(TPplots1, filename = "TP-ADCP-Ave.pdf")
ggexport(TPplots2, filename = "TP-ADCP-Max.pdf")
# ggexport(TPplots3, filename = "TP-ADCP3.pdf")
# ggexport(TPplots4, filename = "TP-ADCP4.pdf")


# SRP #
srp1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
# srp5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
#           "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
# srp6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
#           "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
# srp7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
#           "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
# srp8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
#           "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
SRPplots1 = ggarrange(srp1, srp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
SRPplots2 = ggarrange(srp3, srp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
# SRPplots3 = ggarrange(srp5, srp6, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
# SRPplots4 = ggarrange(srp7, srp8, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
ggexport(SRPplots1, filename = "SRP-ADCP-Ave.pdf")
ggexport(SRPplots2, filename = "SRP-ADCP-Max.pdf")
# ggexport(SRPplots3, filename = "SRP-ADCP3.pdf")
# ggexport(SRPplots4, filename = "SRP-ADCP4.pdf")


# TN #
tn1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
# tn5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
#           "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
# tn6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
#           "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
# tn7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
#           "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
# tn8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
#           "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#           "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")  
TNplots1 = ggarrange(tn1, tn2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TNplots2 = ggarrange(tn3, tn4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
# TNplots3 = ggarrange(tn5, tn6, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
# TNplots4 = ggarrange(tn7, tn8, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
ggexport(TNplots1, filename = "TN-ADCP-Ave.pdf")
ggexport(TNplots2, filename = "TN-ADCP-Max.pdf")
# ggexport(TNplots3, filename = "TN-ADCP3.pdf")
# ggexport(TNplots4, filename = "TN-ADCP4.pdf")


# Ammonia #
amm1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
# amm5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
#                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
# amm6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
#                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
# amm7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
#                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
# amm8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
#                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")  
Ammoniaplots1 = ggarrange(amm1, amm2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
Ammoniaplots2 = ggarrange(amm3, amm4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
# Ammoniaplots3 = ggarrange(amm5, amm6, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
# Ammoniaplots4 = ggarrange(amm7, amm8, common.legend = TRUE, legend = "right",
#                      ncol = 1, nrow = 2)
ggexport(Ammoniaplots1, filename = "Ammonia-ADCP-Ave.pdf")
ggexport(Ammoniaplots2, filename = "Ammonia-ADCP-Max.pdf")
# ggexport(Ammoniaplots3, filename = "Ammonia-ADCP3.pdf")
# ggexport(Ammoniaplots4, filename = "Ammonia-ADCP4.pdf")


# Ammonia + Organic N #
aon1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
# aon5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
#                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
# aon6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
#                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
# aon7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
#                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
# aon8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
#                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")  
AONplots1 = ggarrange(aon1, aon2, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
AONplots2 = ggarrange(aon3, aon4, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
# AONplots3 = ggarrange(aon5, aon6, common.legend = TRUE, legend = "right",
#                           ncol = 1, nrow = 2)
# AONplots4 = ggarrange(aon7, aon8, common.legend = TRUE, legend = "right",
#                           ncol = 1, nrow = 2)
ggexport(AONplots1, filename = "AmmoniaOrganicN-ADCP-Ave.pdf")
ggexport(AONplots2, filename = "AmmoniaOrganicN-ADCP-Max.pdf")
# ggexport(AONplots3, filename = "AmmoniaOrganicN-ADCP3.pdf")
# ggexport(AONplots4, filename = "AmmoniaOrganicN-ADCP4.pdf")


# NOx #
NOx1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
# NOx5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
#                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
# NOx6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
#                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
# NOx7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
#                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
# NOx8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
#                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")  
NOxplots1 = ggarrange(NOx1, NOx2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots2 = ggarrange(NOx3, NOx4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
# NOxplots3 = ggarrange(NOx5, NOx6, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
# NOxplots4 = ggarrange(NOx7, NOx8, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
ggexport(NOxplots1, filename = "NOx-ADCP-Ave.pdf")
ggexport(NOxplots2, filename = "NOx-ADCP-Max.pdf")
# ggexport(NOxplots3, filename = "NOx-ADCP3.pdf")
# ggexport(NOxplots4, filename = "NOx-ADCP4.pdf")


# TSS #
TSS1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
# TSS5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
#                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
# TSS6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
#                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
# TSS7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
#                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
# TSS8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
#                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")  
TSSplots1 = ggarrange(TSS1, TSS2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots2 = ggarrange(TSS3, TSS4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
# TSSplots3 = ggarrange(TSS5, TSS6, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
# TSSplots4 = ggarrange(TSS7, TSS8, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
ggexport(TSSplots1, filename = "TSS-ADCP-Ave.pdf")
ggexport(TSSplots2, filename = "TSS-ADCP-Max.pdf")
# ggexport(TSSplots3, filename = "TSS-ADCP3.pdf")
# ggexport(TSSplots4, filename = "TSS-ADCP4.pdf")


# Chloride #
chlo1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
# chlo5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
#                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
# chlo6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
#                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
# chlo7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
#                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
# chlo8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
#                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")  
chloplots1 = ggarrange(chlo1, chlo2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
chloplots2 = ggarrange(chlo3, chlo4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
# chloplots3 = ggarrange(chlo5, chlo6, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
# chloplots4 = ggarrange(chlo7, chlo8, common.legend = TRUE, legend = "right",
#                       ncol = 1, nrow = 2)
ggexport(chloplots1, filename = "Chloride-ADCP-Ave.pdf")
ggexport(chloplots2, filename = "Chloride-ADCP-Max.pdf")
# ggexport(chloplots3, filename = "Chloride-ADCP3.pdf")
# ggexport(chloplots4, filename = "Chloride-ADCP4.pdf")


# Fluoride #
Fluo1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
# Fluo5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
#                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
# Fluo6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
#                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
# Fluo7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
#                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
# Fluo8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
#                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")  
Fluoplots1 = ggarrange(Fluo1, Fluo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots2 = ggarrange(Fluo3, Fluo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
# Fluoplots3 = ggarrange(Fluo5, Fluo6, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
# Fluoplots4 = ggarrange(Fluo7, Fluo8, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
ggexport(Fluoplots1, filename = "Fluoride-ADCP-Ave.pdf")
ggexport(Fluoplots2, filename = "Fluoride-ADCP-Max.pdf")
# ggexport(Fluoplots3, filename = "Fluoride-ADCP3.pdf")
# ggexport(Fluoplots4, filename = "Fluoride-ADCP4.pdf")


# Sulfate #
sulf1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
# sulf5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
#                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
# sulf6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
#                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
# sulf7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
#                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
# sulf8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
#                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")  
sulfplots1 = ggarrange(sulf1, sulf2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots2 = ggarrange(sulf3, sulf4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
# sulfplots3 = ggarrange(sulf5, sulf6, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
# sulfplots4 = ggarrange(sulf7, sulf8, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
ggexport(sulfplots1, filename = "Sulfate-ADCP-Ave.pdf")
ggexport(sulfplots2, filename = "Sulfate-ADCP-Max.pdf")
# ggexport(sulfplots3, filename = "Sulfate-ADCP3.pdf")
# ggexport(sulfplots4, filename = "Sulfate-ADCP4.pdf")


# Silica #
sili1 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili2 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili3 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili4 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
# sili5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
#                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
# sili6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
#                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
# sili7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
#                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
# sili8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
#                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
#                   "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")  
siliplots1 = ggarrange(sili1, sili2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots2 = ggarrange(sili3, sili4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
# siliplots3 = ggarrange(sili5, sili6, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
# siliplots4 = ggarrange(sili7, sili8, common.legend = TRUE, legend = "right",
#                        ncol = 1, nrow = 2)
ggexport(siliplots1, filename = "Silica-ADCP-Ave.pdf")
ggexport(siliplots2, filename = "Silica-ADCP-Max.pdf")
# ggexport(siliplots3, filename = "Silica-ADCP3.pdf")
# ggexport(siliplots4, filename = "Silica-ADCP4.pdf")


##### 8b) Post-function code for ADCP SIGNIFICANT WAVE HEIGHT vs. Diff nutrients plots #####

# TP #

tp1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
TPplots1 = ggarrange(tp1, tp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots2 = ggarrange(tp3, tp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)

ggexport(TPplots1, filename = "TP-SWH-Ave.pdf")
ggexport(TPplots2, filename = "TP-SWH-Max.pdf")


# SRP #
srp1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")

SRPplots1 = ggarrange(srp1, srp2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
SRPplots2 = ggarrange(srp3, srp4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(SRPplots1, filename = "SRP-SWH-Ave.pdf")
ggexport(SRPplots2, filename = "SRP-SWH-Max.pdf")


# TN #
tn1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
TNplots1 = ggarrange(tn1, tn2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TNplots2 = ggarrange(tn3, tn4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
ggexport(TNplots1, filename = "TN-SWH-Ave.pdf")
ggexport(TNplots2, filename = "TN-SWH2-Max.pdf")

# Ammonia #
amm1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
Ammoniaplots1 = ggarrange(amm1, amm2, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
Ammoniaplots2 = ggarrange(amm3, amm4, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
ggexport(Ammoniaplots1, filename = "Ammonia-SWH-Ave.pdf")
ggexport(Ammoniaplots2, filename = "Ammonia-SWH-Max.pdf")

# Ammonia + Organic N #
aon1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
AONplots1 = ggarrange(aon1, aon2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
AONplots2 = ggarrange(aon3, aon4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(AONplots1, filename = "AmmoniaOrganicN-SWH-Ave.pdf")
ggexport(AONplots2, filename = "AmmoniaOrganicN-SWH-Max.pdf")

# NOx #
NOx1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOxplots1 = ggarrange(NOx1, NOx2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots2 = ggarrange(NOx3, NOx4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(NOxplots1, filename = "NOx-SWH-Ave.pdf")
ggexport(NOxplots2, filename = "NOx-SWH-Max.pdf")


# TSS #
TSS1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSSplots1 = ggarrange(TSS1, TSS2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots2 = ggarrange(TSS3, TSS4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(TSSplots1, filename = "TSS-SWH-Ave.pdf")
ggexport(TSSplots2, filename = "TSS-SWH-Max.pdf")

# Chloride #
chlo1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chloplots1 = ggarrange(chlo1, chlo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
chloplots2 = ggarrange(chlo3, chlo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(chloplots1, filename = "Chloride-SWH-Ave.pdf")
ggexport(chloplots2, filename = "Chloride-SWH-Max.pdf")


# Fluoride #
Fluo1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluoplots1 = ggarrange(Fluo1, Fluo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots2 = ggarrange(Fluo3, Fluo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(Fluoplots1, filename = "Fluoride-SWH-Ave.pdf")
ggexport(Fluoplots2, filename = "Fluoride-SWH-Max.pdf")


# Sulfate #
sulf1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")

sulfplots1 = ggarrange(sulf1, sulf2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots2 = ggarrange(sulf3, sulf4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(sulfplots1, filename = "Sulfate-SWH-Ave.pdf")
ggexport(sulfplots2, filename = "Sulfate-SWH-Max.pdf")


# Silica #
sili1 = adcpplots(wc_adcp_plots, "Avg24hrSWH", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 24 hour Significant Wave Height (cm)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili2 = adcpplots(wc_adcp_plots, "Avg48hrSWH", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 48 hour Significant Wave Height (cm)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili3 = adcpplots(wc_adcp_plots, "Max24hrSWH", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 24 hour Significant Wave Height (cm)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili4 = adcpplots(wc_adcp_plots, "Max48hrSWH", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 48 hour Significant Wave Height (cm)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
siliplots1 = ggarrange(sili1, sili2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots2 = ggarrange(sili3, sili4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(siliplots1, filename = "Silica-SWH-Ave.pdf")
ggexport(siliplots2, filename = "Silica-SWH-Max.pdf")

##### 9) NA - Function for Wind Speed vs. Diff Nutrients plots ######

wsplots = function(dat, xvar, yvar, CI50, CI90, U, L, xlab, ylab) {
  
  ggplot(data = dat, aes(x = dat[,xvar], y = dat[,yvar])) +
    geom_hline(yintercept = c(CI50[,U], CI50[,L]), color = "grey68",
               linetype = "solid", size = 0.5) +
    geom_hline(yintercept = c(CI90[,U], CI90[,L]), color = "grey68",
               linetype = "dashed", size = 0.5) +
    geom_hline(yintercept=0,color="black")+
    geom_jitter(aes(shape = Year, fill = Lake), width = 0.004, 
                height = 0.004, size = 2) +
    scale_shape_manual(values = c(24, 21, 22, 23)) +
    scale_fill_manual(values = c("deepskyblue",
                                 "darkgoldenrod1",
                                 "deeppink",
                                 "darkgreen")) +                             
    guides(fill=guide_legend(
      override.aes=list(colour=c("deepskyblue",
                                 "darkgoldenrod1",
                                 "deeppink",
                                 "darkgreen")))) +
    xlim(0,max(dat[,xvar])) + ylim(min(dat[,yvar]), max(dat[,yvar])) +
    theme_classic() + labs(x = xlab, y = ylab, size = 18) 
}

##### 9a) NA - Post-function code for WIND SPEED vs. Diff nutrients plots #####

# TP #

tp1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp3 = wsplots(wc_ws_plots, "Max24hrWSPD", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp4 = wsplots(wc_ws_plots, "Max48hrWSPD", "TP_diff", TP.CI50, TP.CI90,
                "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
TPplots1 = ggarrange(tp1, tp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots2 = ggarrange(tp3, tp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)

ggexport(TPplots1, filename = "TP-WSPD-Ave.pdf")
ggexport(TPplots2, filename = "TP-WSPD-Max.pdf")


# SRP #
srp1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp3 = wsplots(wc_ws_plots, "Max24hrWSPD", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp4 = wsplots(wc_ws_plots, "Max48hrWSPD", "SRP_diff", SRP.CI50, SRP.CI90,
                 "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                 "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")

SRPplots1 = ggarrange(srp1, srp2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
SRPplots2 = ggarrange(srp3, srp4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(SRPplots1, filename = "SRP-WSPD-Ave.pdf")
ggexport(SRPplots2, filename = "SRP-WSPD-Max.pdf")


# TN #
tn1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn3 = wsplots(wc_ws_plots, "Max24hrWSPD", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn4 = wsplots(wc_ws_plots, "Max48hrWSPD", "TN_diff", TN.CI50, TN.CI90,
                "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
TNplots1 = ggarrange(tn1, tn2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TNplots2 = ggarrange(tn3, tn4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
ggexport(TNplots1, filename = "TN-WSPD-Ave.pdf")
ggexport(TNplots2, filename = "TN-WSPD2-Max.pdf")

# Ammonia #
amm1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm3 = wsplots(wc_ws_plots, "Max24hrWSPD", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm4 = wsplots(wc_ws_plots, "Max48hrWSPD", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                 "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                 "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
Ammoniaplots1 = ggarrange(amm1, amm2, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
Ammoniaplots2 = ggarrange(amm3, amm4, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
ggexport(Ammoniaplots1, filename = "Ammonia-WSPD-Ave.pdf")
ggexport(Ammoniaplots2, filename = "Ammonia-WSPD-Max.pdf")

# Ammonia + Organic N #
aon1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon3 = wsplots(wc_ws_plots, "Max24hrWSPD", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon4 = wsplots(wc_ws_plots, "Max48hrWSPD", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
AONplots1 = ggarrange(aon1, aon2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
AONplots2 = ggarrange(aon3, aon4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(AONplots1, filename = "AmmoniaOrganicN-WSPD-Ave.pdf")
ggexport(AONplots2, filename = "AmmoniaOrganicN-WSPD-Max.pdf")

# NOx #
NOx1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx3 = wsplots(wc_ws_plots, "Max24hrWSPD", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx4 = wsplots(wc_ws_plots, "Max48hrWSPD", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOxplots1 = ggarrange(NOx1, NOx2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots2 = ggarrange(NOx3, NOx4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(NOxplots1, filename = "NOx-WSPD-Ave.pdf")
ggexport(NOxplots2, filename = "NOx-WSPD-Max.pdf")


# TSS #
TSS1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS3 = wsplots(wc_ws_plots, "Max24hrWSPD", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS4 = wsplots(wc_ws_plots, "Max48hrWSPD", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSSplots1 = ggarrange(TSS1, TSS2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots2 = ggarrange(TSS3, TSS4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(TSSplots1, filename = "TSS-WSPD-Ave.pdf")
ggexport(TSSplots2, filename = "TSS-WSPD-Max.pdf")

# Chloride #
chlo1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo3 = wsplots(wc_ws_plots, "Max24hrWSPD", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo4 = wsplots(wc_ws_plots, "Max48hrWSPD", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                  "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                  "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chloplots1 = ggarrange(chlo1, chlo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
chloplots2 = ggarrange(chlo3, chlo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(chloplots1, filename = "Chloride-WSPD-Ave.pdf")
ggexport(chloplots2, filename = "Chloride-WSPD-Max.pdf")


# Fluoride #
Fluo1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo3 = wsplots(wc_ws_plots, "Max24hrWSPD", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo4 = wsplots(wc_ws_plots, "Max48hrWSPD", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluoplots1 = ggarrange(Fluo1, Fluo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots2 = ggarrange(Fluo3, Fluo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(Fluoplots1, filename = "Fluoride-WSPD-Ave.pdf")
ggexport(Fluoplots2, filename = "Fluoride-WSPD-Max.pdf")


# Sulfate #
sulf1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf3 = wsplots(wc_ws_plots, "Max24hrWSPD", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf4 = wsplots(wc_ws_plots, "Max48hrWSPD", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")

sulfplots1 = ggarrange(sulf1, sulf2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots2 = ggarrange(sulf3, sulf4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(sulfplots1, filename = "Sulfate-WSPD-Ave.pdf")
ggexport(sulfplots2, filename = "Sulfate-WSPD-Max.pdf")


# Silica #
sili1 = wsplots(wc_ws_plots, "Avg24hrWSPD", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 24 hour Wind Speed (m/s)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili2 = wsplots(wc_ws_plots, "Avg48hrWSPD", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 48 hour Wind Speed (m/s)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili3 = wsplots(wc_ws_plots, "Max24hrWSPD", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 24 hour Wind Speed (m/s)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili4 = wsplots(wc_ws_plots, "Max48hrWSPD", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 48 hour Wind Speed (m/s)",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
siliplots1 = ggarrange(sili1, sili2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots2 = ggarrange(sili3, sili4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(siliplots1, filename = "Silica-WSPD-Ave.pdf")
ggexport(siliplots2, filename = "Silica-WSPD-Max.pdf")


##### 10) NA - ADCP Water Speed vs. Max & Diff Nutrients NOT DONE ####

  
## Plot code PRE FUNCTION ##
jitter = position_jitter(width = 0.004, height = 0.004)  

ggplot(wc_adcp_plots, aes(x = Avg24hrSpdCell01)) +
  geom_hline(yintercept = c(TP.CI50$Upper,TP.CI50$Lower), color = "grey57",
             linetype = "solid", size = 0.5) +
  geom_hline(yintercept = c(TP.CI90$Upper,TP.CI90$Lower), color = "grey57",
             linetype = "dashed") +
  geom_hline(yintercept=0,color="black") +
  geom_point(aes(y=TP_diff, colour = "TP_diff"), colour = "black", fill = "grey", pch = 21, size = 2.5, 
             position = jitter) +
  geom_point(aes(y=TP_max, colour = "TP_max"), colour = "black", fill = "black", pch = 21, size = 2, position = jitter,
             alpha = 0.4) +
  scale_shape_identity() +
  xlim(0,max(wc_adcp_plots[,"Avg24hrSpdCell01"])) + ylim(min(wc_adcp_plots[,"TP_max"]),
                                                     max(wc_adcp_plots[,"TP_max"])) +
  theme_classic() +
  #legend(x = "right", legend =c("TP_diff", "TP_max"), col = c("darkmagenta", "olivedrab3"), 
        #  pch = 21, cex = 1) +
  scale_color_manual(name = "Legend", values = c(TP_diff = "goldenrod1", 
                                                 TP_max = "mediumblue")) +
  #  guides(fill=guide_legend(
  labs(x ="Average 24 hour water speed (cm/s) in Cell 01", 
       y ="Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom", size = 18) +
  scale_y_continuous(sec.axis = sec_axis(~ . * 1.5, name = "Max TP (mg/L) of either 1 m or \n0.1 m above bottom"))

  ## figure out legend



## function ##

adcp_maxdiff_plots = function(dat, xvar, yvardiff, yvarmax, CI50, CI90, U, L, xlab, ylab, ylab2) {

  ggplot(data = dat, aes(x = dat[,xvar], y = dat[,yvardiff])) +
    geom_hline(yintercept = c(CI50[,U], CI50[,L]), color = "grey57",
               linetype = "solid", size = 0.5) +
    geom_hline(yintercept = c(CI90[,U], CI90[,L]), color = "grey57",
               linetype = "dashed", size = 0.5) +
    geom_hline(yintercept=0,color="black") +
    geom_point(colour = "black", fill = "goldenrod1", pch = 21, size = 2.5, 
               position = jitter) +
    geom_point(aes(y = dat[,yvarmax]), colour = "black", fill = "mediumblue", pch = 21, size = 2, 
               position = jitter) +
    scale_shape_identity() +
    xlim(0,max(dat[,xvar])) + ylim(min(dat[,yvarmax]), max(dat[,yvarmax])) +
    theme_classic() +
    scale_color_manual(values = colors) +
    #  guides(fill=guide_legend(
    labs(x = xlab, y = ylab, size = 18) +
    scale_y_continuous(sec.axis = sec_axis(~ . * 1.3, name = ylab2))
}

# Set dimensions for jitter (now a value in the global environment) for all plots
jitter = position_jitter(width = 0.004, height = 0.004)


## TP ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$TP_diff[i])) {
    if (wc_adcp_plots$TP_diff[i] < 0) {
      wc_adcp_plots$TP_max[i] = wc_adcp_plots$TP_max[i] * (-1)
    } 
  }
}

# Run plot functions for TP #
# Variations of ADCP water speed x variable #
TP2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TP_diff", "TP_max", TP.CI50, TP.CI90, 
                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                   "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom",
                   "Max TP (mg/L) of either 1 m or \n0.1 m above bottom")
TP2ndplots1 = ggarrange(TP2nd_1, TP2nd_2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
TP2ndplots2 = ggarrange(TP2nd_3, TP2nd_4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
TP2ndplots3 = ggarrange(TP2nd_5, TP2nd_6, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
TP2ndplots4 = ggarrange(TP2nd_7, TP2nd_8, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(TP2ndplots1, filename = "2nd-TP-ADCP1.pdf")
ggexport(TP2ndplots2, filename = "2nd-TP-ADCP-Max.pdf")
ggexport(TP2ndplots3, filename = "2nd-TP-ADCP3.pdf")
ggexport(TP2ndplots4, filename = "2nd-TP-ADCP4.pdf")



## SRP ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$SRP_diff[i])) {
    if (wc_adcp_plots$SRP_diff[i] < 0) {
      wc_adcp_plots$SRP_max[i] = wc_adcp_plots$SRP_max[i] * (-1)
    } 
  }
}

# Run plot functions for TP #
# Variations of ADCP water speed x variable #
SRP2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "SRP_diff", "SRP_max", SRP.CI50, SRP.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max SRP (mg/L) of either 1 m or \n0.1 m above bottom")
SRP2ndplots1 = ggarrange(SRP2nd_1, SRP2nd_2, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
SRP2ndplots2 = ggarrange(SRP2nd_3, SRP2nd_4, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
SRP2ndplots3 = ggarrange(SRP2nd_5, SRP2nd_6, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
SRP2ndplots4 = ggarrange(SRP2nd_7, SRP2nd_8, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
ggexport(SRP2ndplots1, filename = "2nd-SRP-ADCP1.pdf")
ggexport(SRP2ndplots2, filename = "2nd-SRP-ADCP2.pdf")
ggexport(SRP2ndplots3, filename = "2nd-SRP-ADCP3.pdf")
ggexport(SRP2ndplots4, filename = "2nd-SRP-ADCP4.pdf")



## TN ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$TN_diff[i])) {
    if (wc_adcp_plots$TN_diff[i] < 0) {
      wc_adcp_plots$TN_max[i] = wc_adcp_plots$TN_max[i] * (-1)
    } 
  }
}

# Run plot functions for TN #
# Variations of ADCP water speed x variable #
TN2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TN_diff", "TN_max", TN.CI50, TN.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max TN (mg/L) of either 1 m or \n0.1 m above bottom")
TN2ndplots1 = ggarrange(TN2nd_1, TN2nd_2, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
TN2ndplots2 = ggarrange(TN2nd_3, TN2nd_4, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
TN2ndplots3 = ggarrange(TN2nd_5, TN2nd_6, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
TN2ndplots4 = ggarrange(TN2nd_7, TN2nd_8, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
ggexport(TN2ndplots1, filename = "2nd-TN-ADCP1.pdf")
ggexport(TN2ndplots2, filename = "2nd-TN-ADCP2.pdf")
ggexport(TN2ndplots3, filename = "2nd-TN-ADCP3.pdf")
ggexport(TN2ndplots4, filename = "2nd-TN-ADCP4.pdf")



## Ammonia ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$Ammonia_diff[i])) {
    if (wc_adcp_plots$Ammonia_diff[i] < 0) {
      wc_adcp_plots$Ammonia_max[i] = wc_adcp_plots$Ammonia_max[i] * (-1)
    } 
  }
}

# Run plot functions for Ammonia #
# Variations of ADCP water speed x variable #
Ammonia2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Ammonia_diff", "Ammonia_max", Ammonia.CI50, Ammonia.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max Ammonia (mg/L) of either 1 m or \n0.1 m above bottom")
Ammonia2ndplots1 = ggarrange(Ammonia2nd_1, Ammonia2nd_2, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
Ammonia2ndplots2 = ggarrange(Ammonia2nd_3, Ammonia2nd_4, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
Ammonia2ndplots3 = ggarrange(Ammonia2nd_5, Ammonia2nd_6, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
Ammonia2ndplots4 = ggarrange(Ammonia2nd_7, Ammonia2nd_8, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
ggexport(Ammonia2ndplots1, filename = "2nd-Ammonia-ADCP1.pdf")
ggexport(Ammonia2ndplots2, filename = "2nd-Ammonia-ADCP2.pdf")
ggexport(Ammonia2ndplots3, filename = "2nd-Ammonia-ADCP3.pdf")
ggexport(Ammonia2ndplots4, filename = "2nd-Ammonia-ADCP4.pdf")



## AmmoniaOrganicN ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$AmmoniaOrganicN_diff[i])) {
    if (wc_adcp_plots$AmmoniaOrganicN_diff[i] < 0) {
      wc_adcp_plots$AmmoniaOrganicN_max[i] = wc_adcp_plots$AmmoniaOrganicN_max[i] * (-1)
    } 
  }
}

# Run plot functions for AmmoniaOrganicN #
# Variations of ADCP water speed x variable #
AmmoniaOrganicN2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", 
                                          "AmmoniaOrganicN_max", AON.CI50, AON.CI90, 
                                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in AmmoniaOrganicN (mg/L)\n between 1 m and 0.1 m above bottom",
                                  "Max AmmoniaOrganicN (mg/L)\n of either 1 m or 0.1 m above bottom")
AmmoniaOrganicN2ndplots1 = ggarrange(AmmoniaOrganicN2nd_1, AmmoniaOrganicN2nd_2, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
AmmoniaOrganicN2ndplots2 = ggarrange(AmmoniaOrganicN2nd_3, AmmoniaOrganicN2nd_4, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
AmmoniaOrganicN2ndplots3 = ggarrange(AmmoniaOrganicN2nd_5, AmmoniaOrganicN2nd_6, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
AmmoniaOrganicN2ndplots4 = ggarrange(AmmoniaOrganicN2nd_7, AmmoniaOrganicN2nd_8, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
ggexport(AmmoniaOrganicN2ndplots1, filename = "2nd-AmmoniaOrganicN-ADCP1.pdf")
ggexport(AmmoniaOrganicN2ndplots2, filename = "2nd-AmmoniaOrganicN-ADCP2.pdf")
ggexport(AmmoniaOrganicN2ndplots3, filename = "2nd-AmmoniaOrganicN-ADCP3.pdf")
ggexport(AmmoniaOrganicN2ndplots4, filename = "2nd-AmmoniaOrganicN-ADCP4.pdf")



## NOx ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$NOx_diff[i])) {
    if (wc_adcp_plots$NOx_diff[i] < 0) {
      wc_adcp_plots$NOx_max[i] = wc_adcp_plots$NOx_max[i] * (-1)
    } 
  }
}

# Run plot functions for NOx #
# Variations of ADCP water speed x variable #
NOx2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "NOx_diff", "NOx_max", NOx.CI50, NOx.CI90, 
                             "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                             "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom",
                             "Max NOx (mg/L) of either 1 m or \n0.1 m above bottom")
NOx2ndplots1 = ggarrange(NOx2nd_1, NOx2nd_2, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
NOx2ndplots2 = ggarrange(NOx2nd_3, NOx2nd_4, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
NOx2ndplots3 = ggarrange(NOx2nd_5, NOx2nd_6, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
NOx2ndplots4 = ggarrange(NOx2nd_7, NOx2nd_8, common.legend = TRUE, legend = "right",
                        ncol = 1, nrow = 2)
ggexport(NOx2ndplots1, filename = "2nd-NOx-ADCP1.pdf")
ggexport(NOx2ndplots2, filename = "2nd-NOx-ADCP2.pdf")
ggexport(NOx2ndplots3, filename = "2nd-NOx-ADCP3.pdf")
ggexport(NOx2ndplots4, filename = "2nd-NOx-ADCP4.pdf")




## TSS ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$TSS_diff[i])) {
    if (wc_adcp_plots$TSS_diff[i] < 0) {
      wc_adcp_plots$TSS_max[i] = wc_adcp_plots$TSS_max[i] * (-1)
    } 
  }
}

# Run plot functions for TSS #
# Variations of ADCP water speed x variable #
TSS2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TSS_diff", "TSS_max", TSS.CI50, TSS.CI90, 
                              "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max TSS (mg/L) of either 1 m or \n0.1 m above bottom")
TSS2ndplots1 = ggarrange(TSS2nd_1, TSS2nd_2, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
TSS2ndplots2 = ggarrange(TSS2nd_3, TSS2nd_4, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
TSS2ndplots3 = ggarrange(TSS2nd_5, TSS2nd_6, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
TSS2ndplots4 = ggarrange(TSS2nd_7, TSS2nd_8, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
ggexport(TSS2ndplots1, filename = "2nd-TSS-ADCP1.pdf")
ggexport(TSS2ndplots2, filename = "2nd-TSS-ADCP2.pdf")
ggexport(TSS2ndplots3, filename = "2nd-TSS-ADCP3.pdf")
ggexport(TSS2ndplots4, filename = "2nd-TSS-ADCP4.pdf")



## Chloride ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$Chloride_diff[i])) {
    if (wc_adcp_plots$Chloride_diff[i] < 0) {
      wc_adcp_plots$Chloride_max[i] = wc_adcp_plots$Chloride_max[i] * (-1)
    } 
  }
}

# Run plot functions for Chloride #
# Variations of ADCP water speed x variable #
Chloride2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Chloride_diff", "Chloride_max", Chloride.CI50, Chloride.CI90, 
                              "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                              "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom",
                              "Max Chloride (mg/L) of either 1 m or \n0.1 m above bottom")
Chloride2ndplots1 = ggarrange(Chloride2nd_1, Chloride2nd_2, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
Chloride2ndplots2 = ggarrange(Chloride2nd_3, Chloride2nd_4, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
Chloride2ndplots3 = ggarrange(Chloride2nd_5, Chloride2nd_6, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
Chloride2ndplots4 = ggarrange(Chloride2nd_7, Chloride2nd_8, common.legend = TRUE, legend = "right",
                         ncol = 1, nrow = 2)
ggexport(Chloride2ndplots1, filename = "2nd-Chloride-ADCP1.pdf")
ggexport(Chloride2ndplots2, filename = "2nd-Chloride-ADCP2.pdf")
ggexport(Chloride2ndplots3, filename = "2nd-Chloride-ADCP3.pdf")
ggexport(Chloride2ndplots4, filename = "2nd-Chloride-ADCP4.pdf")



## Fluoride ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$Fluoride_diff[i])) {
    if (wc_adcp_plots$Fluoride_diff[i] < 0) {
      wc_adcp_plots$Fluoride_max[i] = wc_adcp_plots$Fluoride_max[i] * (-1)
    } 
  }
}

# Run plot functions for Fluoride #
# Variations of ADCP water speed x variable #
Fluoride2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Fluoride_diff", "Fluoride_max", Fluoride.CI50, Fluoride.CI90, 
                                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Fluoride (mg/L) of either 1 m or \n0.1 m above bottom")
Fluoride2ndplots1 = ggarrange(Fluoride2nd_1, Fluoride2nd_2, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Fluoride2ndplots2 = ggarrange(Fluoride2nd_3, Fluoride2nd_4, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Fluoride2ndplots3 = ggarrange(Fluoride2nd_5, Fluoride2nd_6, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Fluoride2ndplots4 = ggarrange(Fluoride2nd_7, Fluoride2nd_8, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
ggexport(Fluoride2ndplots1, filename = "2nd-Fluoride-ADCP1.pdf")
ggexport(Fluoride2ndplots2, filename = "2nd-Fluoride-ADCP2.pdf")
ggexport(Fluoride2ndplots3, filename = "2nd-Fluoride-ADCP3.pdf")
ggexport(Fluoride2ndplots4, filename = "2nd-Fluoride-ADCP4.pdf")



## Sulfate ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$Sulfate_diff[i])) {
    if (wc_adcp_plots$Sulfate_diff[i] < 0) {
      wc_adcp_plots$Sulfate_max[i] = wc_adcp_plots$Sulfate_max[i] * (-1)
    } 
  }
}

# Run plot functions for Sulfate #
# Variations of ADCP water speed x variable #
Sulfate2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Sulfate_diff", "Sulfate_max", Sulfate.CI50, Sulfate.CI90, 
                                   "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                                   "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom",
                                   "Max Sulfate (mg/L) of either 1 m or \n0.1 m above bottom")
Sulfate2ndplots1 = ggarrange(Sulfate2nd_1, Sulfate2nd_2, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Sulfate2ndplots2 = ggarrange(Sulfate2nd_3, Sulfate2nd_4, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Sulfate2ndplots3 = ggarrange(Sulfate2nd_5, Sulfate2nd_6, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
Sulfate2ndplots4 = ggarrange(Sulfate2nd_7, Sulfate2nd_8, common.legend = TRUE, legend = "right",
                              ncol = 1, nrow = 2)
ggexport(Sulfate2ndplots1, filename = "2nd-Sulfate-ADCP1.pdf")
ggexport(Sulfate2ndplots2, filename = "2nd-Sulfate-ADCP2.pdf")
ggexport(Sulfate2ndplots3, filename = "2nd-Sulfate-ADCP3.pdf")
ggexport(Sulfate2ndplots4, filename = "2nd-Sulfate-ADCP4.pdf")



## Silica ##

# Negative values if-statement #
for (i in 1:nrow(wc_adcp_plots)) {
  if (!is.na(wc_adcp_plots$Silica_diff[i])) {
    if (wc_adcp_plots$Silica_diff[i] < 0) {
      wc_adcp_plots$Silica_max[i] = wc_adcp_plots$Silica_max[i] * (-1)
    } 
  }
}

# Run plot functions for Silica #
# Variations of ADCP water speed x variable #
Silica2nd_1 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cell 01",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_2 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cell 01",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_3 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cell 01",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_4 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cell 01",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_5 = adcp_maxdiff_plots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_6 = adcp_maxdiff_plots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_7 = adcp_maxdiff_plots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2nd_8 = adcp_maxdiff_plots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Silica_diff", "Silica_max", Silica.CI50, Silica.CI90, 
                                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom",
                                  "Max Silica (mg/L) of either 1 m or \n0.1 m above bottom")
Silica2ndplots1 = ggarrange(Silica2nd_1, Silica2nd_2, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
Silica2ndplots2 = ggarrange(Silica2nd_3, Silica2nd_4, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
Silica2ndplots3 = ggarrange(Silica2nd_5, Silica2nd_6, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
Silica2ndplots4 = ggarrange(Silica2nd_7, Silica2nd_8, common.legend = TRUE, legend = "right",
                             ncol = 1, nrow = 2)
ggexport(Silica2ndplots1, filename = "2nd-Silica-ADCP1.pdf")
ggexport(Silica2ndplots2, filename = "2nd-Silica-ADCP2.pdf")
ggexport(Silica2ndplots3, filename = "2nd-Silica-ADCP3.pdf")
ggexport(Silica2ndplots4, filename = "2nd-Silica-ADCP4.pdf")


##### 11) Removing Past Dataframes (can be done after ALL #####
    #     formatting sections are complete: 1,2,4,5,6)  #

# KEEP THESE! dataframes that are used (or will be used) for plotting #
    # wc_1mB
    # adcp_combined_avgs
    # wc_adcp_all
    # wc_adcp_plots
    # bc_combined
    # bb_combined
    # ws_combined
    # ALL CONFIDENCE INTERVAL DATAFRAMES (denoted as "Nutrient".CI, .CI50, .CI90)
    
# Remove all other dataframes #
rm(adcp_combined, adcp_ede, adcp_edw, adcp_hhb, adcp_htb, adcp_mmc, adcp_msb, 
   adcp_oir, adcp_ool, adcp_osi, adcp_osn, adcp18, adcp18_sub, adcp19, 
   adcp19_sub, bb18, bb18_sub, bb19, bb19_sub, bc18, bc18_sub, bc19, bc19_sub, 
   wc_1m, wc_adcp_ede, wc_adcp_edw, wc_adcp_hhb, wc_adcp_htb, 
   wc_adcp_mmc, wc_adcp_msb, wc_adcp_oir, wc_adcp_ool, wc_adcp_osi, wc_adcp_osn, 
   wc_B, wc_combined, wc_ede, wc_edw, wc_eep, wc_hal, wc_hhb, wc_htb, wc_mmc, 
   wc_msb, wc_mwa, wc_oir, wc_ool, wc_osi, wc_osn, wc18, wc18_sub, wc19, 
   wc19_sub, wc20, wc20_sub, ws_erie18, ws_erie18_sub, ws_erie19, ws_erie19_sub, 
   ws_huron18, ws_huron18_sub, ws_huron19, ws_huron19_sub, ws_mmc18, 
   ws_mmc18_sub, ws_msb18, ws_msb18_sub, ws_msb19, ws_msb19_sub, ws_mwa19, 
   ws_mwa19_sub, ws_oir18, ws_oir18_sub, ws_oir19, ws_oir19_sub, ws_ool18, 
   ws_ool18_sub, ws_ool19, ws_ool19_sub, ws_osi18, ws_osi18_sub, ws_osn19, 
   ws_osn19_sub)
