# 1 m vs. B analysis #

##### 1) Formatting data files #####

#load package ("tidyverse")
library(tidyverse)
library(hms)
library(ggpubr)

#Set working directory to a local folder containing updated files
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files")

#Import Data Release files in .csv format

adcp18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/ADCP.csv", header = TRUE)
bb18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/BenthicBiomass_v2.csv", header = TRUE)
bc18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/BenthicChem_v2.csv", header = TRUE)
wc18 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2018/WaterChem_v2.csv", header = TRUE)

adcp19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/ADCP.csv", header = TRUE)
bb19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/BenthicBiomass.csv", header = TRUE) 
bc19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/BenthicChem.csv", header = TRUE)
wc19 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2019/Water_Chem_2019_V2.csv", header = TRUE)

wc20 <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2020/WaterChem2020.csv", header = TRUE)
conf.int <- read.csv("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Analysis/1 m vs. Bottom/Data files/Files_2020/ConfidenceIntervals2020.csv", header = TRUE)

#Load wind data files in .txt format
## add setwd for NOAA buoy folder (use getwd() to check)
ws_erie18 <- read.table(file = "erep1h2018.txt", header = TRUE)
ws_erie18 <- ws_erie18 [-1,]
ws_erie19 <- read.table(file = "erep1h2019.txt", header = TRUE)
ws_erie19 <- ws_erie19 [-1,]
 
ws_huron18 <- read.table(file = "lpnm4h2018.txt", header = TRUE)
ws_huron18 <- ws_huron18 [-1,]
ws_huron19 <- read.table(file = "lpnm4h2019.txt", header = TRUE)
ws_huron19 <- ws_huron19 [-1,]

ws_mmc18 <- read.table(file = "45170h2018.txt", header = TRUE)
ws_mmc18 <- ws_mmc18 [-1,]

ws_mwa19 <- read.table(file = "45174h2019.txt", header = TRUE)
ws_mwa19 <- ws_mwa19 [-1,]

ws_msb18 <- read.table(file = "45183h2018.txt", header = TRUE)
ws_msb18 <- ws_msb18 [-1,]
ws_msb19 <- read.table(file = "45183h2019.txt", header = TRUE)
ws_msb19 <- ws_msb19 [-1,]

ws_oir18 <- read.table(file = "rprn6h2018.txt", header = TRUE)
ws_oir18 <- ws_oir18 [-1,]
ws_oir19 <- read.table(file = "rprn6h2019.txt", header = TRUE)
ws_oir19 <- ws_oir19 [-1,]

ws_ool18 <- read.table(file = "olcn6h2018.txt", header = TRUE)
ws_ool18 <- ws_ool18 [-1,]
ws_ool19 <- read.table(file = "olcn6h2019.txt", header = TRUE)
ws_ool19 <- ws_ool19 [-1,]

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

#Create subsets of each df, keeping only columns needed for analysis

adcp18_sub <- subset(adcp18, select = c("Transect", "Year", "Month", "Day",
                                        "Hour", "Minute", "DateTime", "Hs", 
                                        "Cell01Spd", "Cell02Spd"))
adcp19_sub <- subset(adcp19, select = c("Transect", "Year", "Month", "Day",
                                        "Hour", "Minute", "DateTime", "Hs", 
                                        "Cell01Spd", "Cell02Spd"))

bb18_sub <- subset(bb18, select = c("Year", "Month", "Date", "Transect", "Station", 
                                    "Quadrat", "SAVWeight"))
bb19_sub <- subset(bb19, select = c("Year", "Month", "Date", "Transect", "Station", 
                                    "Quadrat", "SAVWeight"))

bc18_sub <- subset(bc18, select = c("Year", "Month", "Date", "Transect", "Station", 
                                    "DreissTotalWeight", "DreissTissueWeight"))
bc19_sub <- subset(bc19, select = c("Year", "Month", "Date", "Transect", "Station", 
                                    "DreissTotalWeight", "DreissTissueWeight"))

wc18_sub <- subset(wc18, select = c("Year", "Transect", "Station", "Depth", "Date", 
                                    "Time", "TP", "OrthoP", "TN", "Ammonia", 
                                    "AmmoniaOrganicN", "NOx", "TSS", "Chloride", 
                                    "Fluoride", "Silica", "Sulfate", "DepthAveTemp",
                                    "DepthAveSpCond", "DepthAvepH", "DepthAveTurb",
                                    "DepthAveDO", "DepthAveChl", "DepthAvePhyco"))
wc19_sub <- subset(wc19, select = c("Year", "Transect", "Station", "Depth", "Date", 
                                    "Time", "TP_NWQL","TP_UMESC", "OrthoP", "SRP", 
                                    "TN", "Ammonia", "AmmoniaOrganicN", "NOx", 
                                    "TSS", "Chloride", "Fluoride", "Silica", "Sulfate",
                                    "DepthAveTemp","DepthAveSpCond", "DepthAvepH", 
                                    "DepthAveTurb","DepthAveDO", "DepthAveChl", 
                                    "DepthAvePhyco"))
wc20_sub <- subset(wc20, select = c("Year", "Transect", "Station", "Depth", 
                                    "SubstrateType", "Date", 
                                    "Time", "TP", "SRP", "TN",
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

#Ensure variables match in df's before combining years

wc18_sub <- add_column(wc18_sub, TP_NWQL = "", .after = "TP")
wc18_sub <- add_column(wc18_sub, TP_UMESC = "", .after = "TP_NWQL")
wc18_sub <- add_column(wc18_sub, SRP = "", .after = "OrthoP")
wc18_sub <- add_column(wc18_sub, SubstrateType = "NA", .after = "Depth")
wc19_sub <- add_column(wc19_sub, TP = "", .after = "Time")
wc19_sub <- add_column(wc19_sub, SubstrateType = "NA", .after = "Depth")
wc20_sub <- add_column(wc20_sub, TP_NWQL = "", .after = "TP")
wc20_sub <- add_column(wc20_sub, TP_UMESC = "", .after = "TP_NWQL")
wc20_sub <- add_column(wc20_sub, OrthoP = "", .after = "TP_UMESC")
wc20_sub <- add_column(wc20_sub, DepthAveTemp = "", .after = "Sulfate")
wc20_sub <- add_column(wc20_sub, DepthAveSpCond = "", .after = "DepthAveTemp")
wc20_sub <- add_column(wc20_sub, DepthAvepH = "", .after = "DepthAveSpCond")
wc20_sub <- add_column(wc20_sub, DepthAveTurb = "", .after = "DepthAvepH")
wc20_sub <- add_column(wc20_sub, DepthAveDO = "", .after = "DepthAveTurb")
wc20_sub <- add_column(wc20_sub, DepthAveChl = "", .after = "DepthAveDO")
wc20_sub <- add_column(wc20_sub, DepthAvePhyco = "", .after = "DepthAveChl")

#Merge 2018 and 2019 df's into a combined df

adcp_combined <- rbind(adcp18_sub, adcp19_sub)

bb_combined <- rbind(bb18_sub, bb19_sub)

bc_combined <- rbind(bc18_sub, bc19_sub)

wc_combined <- rbind(wc18_sub, wc19_sub, wc20_sub)

ws_combined <- rbind(ws_erie18_sub, ws_erie19_sub,
                              ws_huron18_sub, ws_huron19_sub,
                              ws_mmc18_sub, ws_msb18_sub, 
                              ws_msb19_sub, ws_mwa19_sub, ws_oir18_sub,
                              ws_oir19_sub, ws_ool18_sub, ws_ool19_sub, 
                              ws_osi18_sub, ws_osn19_sub)

#Reset observation names

rownames(ws_combined) = NULL

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

bb_combined$SAVWeight [bb_combined$SAVWeight == "BDL"]<-0
bc_combined$DreissTissueWeight [bc_combined$DreissTissueWeight == "BDL"]<-0
bc_combined$DreissTotalWeight [bc_combined$DreissTotalWeight == "BDL"]<-0
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
wc_combined$DepthAveTurb [wc_combined$DepthAveTurb == "BDL"]<-0
wc_combined$DepthAveChl [wc_combined$DepthAveChl == "BDL"]<-0
wc_combined$DepthAvePhyco [wc_combined$DepthAvePhyco == "BDL"]<-0

#Format df's

#adcp 

adcp_combined$Transect <- as.factor(adcp_combined$Transect)
adcp_combined$Year <- as.factor(adcp_combined$Year)
adcp_combined <- add_column(adcp_combined, Date = paste(adcp_combined$Year, 
                                                    adcp_combined$Month, 
                                                    adcp_combined$Day, sep = "-",
                                                    collapse = NULL), .before = "Month")
adcp_combined <- add_column(adcp_combined, Time = paste(adcp_combined$Hour, 
                                                        adcp_combined$Minute, sep = ":",
                                                        collapse = NULL), .before = "DateTime")
adcp_combined$Date <- as.Date(adcp_combined$Date)
adcp_combined <- subset(adcp_combined, select = -c(4:7))

adcp_combined$DateTime <- as.POSIXct(adcp_combined$DateTime, 
                                     format = "%Y-%m-%d %H:%M:%S",
                                     origin = "1970-01-01",
                                     tz = "Etc/GMT+5")
adcp_combined$Time <- substr(adcp_combined$DateTime, 12, 19)
#adcp_combined$Time <- as.numeric(adcp_combined$Time)
adcp_combined$Time <- as.numeric(hms(adcp_combined$Time))
str(adcp_combined)

#bb

bb_combined$Year <- as.factor(bb_combined$Year)
bb_combined$Month <- as.factor(bb_combined$Month)
bb_combined$Date <- as.Date(as.character(bb_combined$Date), format = "%Y-%m-%d")

bb_combined$Transect <- as.factor(bb_combined$Transect)
bb_combined$Station <- as.factor(bb_combined$Station)
bb_combined$Quadrat <- as.factor(bb_combined$Quadrat)
bb_combined$SAVWeight <- as.numeric(bb_combined$SAVWeight)

str(bb_combined)

#bc

bc_combined$Year <- as.factor(bc_combined$Year)
bc_combined$Month <- as.factor(bc_combined$Month)
bc_combined$Date <- as.Date(as.character(bc_combined$Date), format = "%Y-%m-%d")
bc_combined$Transect <- as.factor(bc_combined$Transect)
bc_combined$Station <- as.factor(bc_combined$Station)
bc_combined$DreissTotalWeight <- as.numeric(bc_combined$DreissTotalWeight)
bc_combined$DreissTissueWeight <- as.numeric(bc_combined$DreissTissueWeight)

str(bc_combined)

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
wc_combined$DepthAveTemp <- as.numeric(wc_combined$DepthAveTemp)
wc_combined$DepthAveSpCond <- as.numeric(wc_combined$DepthAveSpCond)
wc_combined$DepthAvepH <- as.numeric(wc_combined$DepthAvepH)
wc_combined$DepthAveTurb <- as.numeric(wc_combined$DepthAveTurb)
wc_combined$DepthAveDO <- as.numeric(wc_combined$DepthAveDO)
wc_combined$DepthAveChl <- as.numeric(wc_combined$DepthAveChl)
wc_combined$DepthAvePhyco <- as.numeric(wc_combined$DepthAvePhyco)

str(wc_combined)


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
ws_combined <- subset(ws_combined, select = -c(19:22))
ws_combined$WSPD <- as.numeric(ws_combined$WSPD)

str(ws_combined)


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
bb_combined <- add_column(bb_combined, ID_DTr 
                            = paste(bb_combined$Date, 
                            bb_combined$Transect, sep = "", 
                            collapes = NULL), .before = "Year")
bc_combined <- add_column(bc_combined, ID_DTr = paste
                                   (bc_combined$Date, 
                                     bc_combined$Transect, sep = "", 
                                     collapse = NULL), .before = "Year")
wc_combined <- add_column(wc_combined, ID_DTr = 
                                   paste(wc_combined$Date, 
                                         wc_combined$Transect, sep = "",
                                         collapse = NULL), .before = "Year")
#ID Date, Transect, Station
bb_combined <- add_column(bb_combined, ID_DTrS 
                                      = paste(bb_combined$Date, 
                                              bb_combined$Transect, bb_combined$Station, sep = "", 
                                              collapes = NULL), .before = "Year")
bc_combined <- add_column(bc_combined, ID_DTrS = paste
                                   (bc_combined$Date, 
                                     bc_combined$Transect, bc_combined$Station, sep = "", 
                                     collapse = NULL), .before = "Year")
wc_combined <- add_column(wc_combined, ID_DTrS = paste(wc_combined$Date, wc_combined$Transect, wc_combined$Station, sep = "", collapse = NULL), .before = "Year")

#create TP_all column in wc_combined and remove old columns

wc_combined$TP_all <- if_else(is.na(wc_combined$TP), 
                             if_else(is.na(wc_combined$TP_NWQL), 
                                     wc_combined$TP_UMESC, 
                                     wc_combined$TP_NWQL),
                                     wc_combined$TP)

wc_combined <- within(wc_combined, rm("TP_NWQL", "TP_UMESC", "TP"))

#subset 1m and B

wc_1m <- subset(wc_combined, Depth == "1m")
wc_B <- subset(wc_combined, Depth == "B")

#create combined df, using wc_B as template, in preparation for importing wc_1m

wc_1mB <- wc_B

#rename columns in wc_1mB to include "B"

wc_1mB <- wc_1mB %>% dplyr::rename(TP_B = TP_all)
wc_1mB <- wc_1mB %>% dplyr::rename(OrthoP_B= OrthoP)
wc_1mB <- wc_1mB %>% dplyr::rename(SRP_B = SRP)
wc_1mB <- wc_1mB %>% dplyr::rename(TN_B = TN)
wc_1mB <- wc_1mB %>% dplyr::rename(Ammonia_B = Ammonia)
wc_1mB <- wc_1mB %>% dplyr::rename(AmmoniaOrganicN_B = AmmoniaOrganicN)
wc_1mB <- wc_1mB %>% dplyr::rename(NOx_B = NOx)
wc_1mB <- wc_1mB %>% dplyr::rename(TSS_B = TSS)
wc_1mB <- wc_1mB %>% dplyr::rename(Chloride_B = Chloride)
wc_1mB <- wc_1mB %>% dplyr::rename(Fluoride_B = Fluoride)
wc_1mB <- wc_1mB %>% dplyr::rename(Silica_B = Silica)
wc_1mB <- wc_1mB %>% dplyr::rename(Sulfate_B = Sulfate)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAveTemp_B = DepthAveTemp)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAveSpCond_B = DepthAveSpCond)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAvepH_B = DepthAvepH)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAveTurb_B = DepthAveTurb)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAveDO_B = DepthAveDO)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAveChl_B = DepthAveChl)
wc_1mB <- wc_1mB %>% dplyr::rename(DepthAvePhyco_B = DepthAvePhyco)

#import wc_1m nutrient results using match formula
#df_target$new_column <- df_data_import$column[match(df_target$match_column, df_data_import$match_column)]

wc_1mB$TP_1m <- wc_1m$TP_all[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$OrthoP_1m <- wc_1m$OrthoP[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$SRP_1m <- wc_1m$SRP[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$TN_1m <- wc_1m$TN[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$Ammonia_1m <- wc_1m$Ammonia[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$AmmoniaOrganicN_1m <- wc_1m$AmmoniaOrganicN[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$NOx_1m <- wc_1m$NOx[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$TSS_1m <- wc_1m$TSS[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$Chloride_1m <- wc_1m$Chloride[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$Fluoride_1m <- wc_1m$Fluoride[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$Silica_1m <- wc_1m$Silica[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$Sulfate_1m <- wc_1m$Sulfate[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAveTemp_1m <- wc_1m$DepthAveTemp[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAveSpCond_1m <- wc_1m$DepthAveSpCond[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAvepH_1m <- wc_1m$DepthAvepH[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAveTurb_1m <- wc_1m$DepthAveTurb[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAveDO_1m <- wc_1m$DepthAveDO[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAveChl_1m <- wc_1m$DepthAveChl[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]
wc_1mB$DepthAvePhyco_1m <- wc_1m$DepthAvePhyco[match(wc_1mB$ID_DTrS, wc_1m$ID_DTrS)]

#Calculate difference in nutrient values between 1m and B samples

wc_1mB <- mutate(wc_1mB, TP_diff = TP_1m - TP_B)
wc_1mB <- mutate(wc_1mB, OrthoP_diff = OrthoP_1m - OrthoP_B)
wc_1mB <- mutate(wc_1mB, SRP_diff = SRP_1m - SRP_B)
wc_1mB <- mutate(wc_1mB, TN_diff = TN_1m - TN_B)
wc_1mB <- mutate(wc_1mB, Ammonia_diff = Ammonia_1m - Ammonia_B)
wc_1mB <- mutate(wc_1mB, AmmoniaOrganicN_diff = AmmoniaOrganicN_1m - AmmoniaOrganicN_B)
wc_1mB <- mutate(wc_1mB, NOx_diff = NOx_1m - NOx_B)
wc_1mB <- mutate(wc_1mB, TSS_diff = TSS_1m - TSS_B)
wc_1mB <- mutate(wc_1mB, Chloride_diff = Chloride_1m - Chloride_B)
wc_1mB <- mutate(wc_1mB, Fluoride_diff = Fluoride_1m - Fluoride_B)
wc_1mB <- mutate(wc_1mB, Silica_diff = Silica_1m - Silica_B)
wc_1mB <- mutate(wc_1mB, Sulfate_diff = Sulfate_1m - Sulfate_B)
wc_1mB <- mutate(wc_1mB, DepthAveTemp_diff = DepthAveTemp_1m - DepthAveTemp_B)
wc_1mB <- mutate(wc_1mB, DepthAveSpCond_diff = DepthAveSpCond_1m - DepthAveSpCond_B)
wc_1mB <- mutate(wc_1mB, DepthAvepH_diff = DepthAvepH_1m - DepthAvepH_B)
wc_1mB <- mutate(wc_1mB, DepthAveTurb_diff = DepthAveTurb_1m - DepthAveTurb_B)
wc_1mB <- mutate(wc_1mB, DepthAveDO_diff = DepthAveDO_1m - DepthAveDO_B)
wc_1mB <- mutate(wc_1mB, DepthAveChl_diff = DepthAveChl_1m - DepthAveChl_B)
wc_1mB <- mutate(wc_1mB, DepthAvePhyco_diff = DepthAvePhyco_1m - DepthAvePhyco_B)

#Reorder variables

wc_1mB <- wc_1mB[,c("ID_DTr", "ID_DTrS", "Year", "Transect", "Station", "Depth", 
                   "SubstrateType", "Date",                    
                  "Time", "DateTime", "TP_1m", "TP_B", "TP_diff", "OrthoP_1m", 
                    "OrthoP_B", "OrthoP_diff", "SRP_1m", "SRP_B", "SRP_diff", "TN_1m",
                    "TN_B", "TN_diff","Ammonia_1m", "Ammonia_B", "Ammonia_diff", 
                    "AmmoniaOrganicN_1m", "AmmoniaOrganicN_B", "AmmoniaOrganicN_diff",
                    "NOx_1m", "NOx_B", "NOx_diff", "TSS_1m", "TSS_B", "TSS_diff",
                    "Chloride_1m", "Chloride_B", "Chloride_diff",
                    "Fluoride_1m", "Fluoride_B", "Fluoride_diff",
                    "Silica_1m", "Silica_B", "Silica_diff", "Sulfate_1m", "Sulfate_B",
                    "Sulfate_diff", "DepthAveTemp_1m", "DepthAveTemp_B", "DepthAveTemp_diff",
                    "DepthAveSpCond_1m", "DepthAveSpCond_B", "DepthAveSpCond_diff",
                    "DepthAvepH_1m", "DepthAvepH_B", "DepthAvepH_diff", "DepthAveTurb_1m",
                    "DepthAveTurb_B", "DepthAveTurb_diff", "DepthAveDO_1m", "DepthAveDO_B",
                    "DepthAveDO_diff", "DepthAveChl_1m", "DepthAveChl_B", "DepthAveChl_diff",
                    "DepthAvePhyco_1m", "DepthAvePhyco_B", "DepthAvePhyco_diff")]

#Calculate max nutrient value between 1m and B samples

wc_1mB [, "TP_max"] <- apply(wc_1mB[, 11:12], 1, max)#TP
wc_1mB [, "OrthoP_max"] <- apply(wc_1mB[, 14:15], 1, max)#OrthoP
wc_1mB [, "SRP_max"] <- apply(wc_1mB[, 17:18], 1, max)#SRP
wc_1mB [, "TN_max"] <- apply(wc_1mB[, 20:21], 1, max)#TN
wc_1mB [, "Ammonia_max"] <- apply(wc_1mB[, 23:24], 1, max)#Ammonia
wc_1mB [, "AmmoniaOrganicN_max"] <- apply(wc_1mB[, 26:27], 1, max)#AmmoniaOrganicN
wc_1mB [, "NOx_max"] <- apply(wc_1mB[, 29:30], 1, max)#NOx
wc_1mB [, "TSS_max"] <- apply(wc_1mB[, 32:33], 1, max)#TSS
wc_1mB [, "Chloride_max"] <- apply(wc_1mB[, 35:36], 1, max)#Chloride
wc_1mB [, "Fluoride_max"] <- apply(wc_1mB[, 38:39], 1, max)#Fluoride
wc_1mB [, "Silica_max"] <- apply(wc_1mB[, 41:42], 1, max)#Silica
wc_1mB [, "Sulfate_max"] <- apply(wc_1mB[, 44:45], 1, max)#Sulfate
wc_1mB [, "DepthAveTemp_max"] <- apply(wc_1mB[, 47:48], 1, max)#DepthAveTemp
wc_1mB [, "DepthAveSpCond_max"] <- apply(wc_1mB[, 50:51], 1, max)#DepthAveSpCond
wc_1mB [, "DepthAvepH_max"] <- apply(wc_1mB[, 53:54], 1, max)#DepthAvepH
wc_1mB [, "DepthAveTurb_max"] <- apply(wc_1mB[, 56:57], 1, max)#DepthAveTurb
wc_1mB [, "DepthAveDO_max"] <- apply(wc_1mB[, 59:60], 1, max)#DepthAveDO
wc_1mB [, "DepthAveChl_max"] <- apply(wc_1mB[, 62:63], 1, max)#DepthAveChl
wc_1mB [, "DepthAvePhyco_max"] <- apply(wc_1mB[, 65:66], 1, max)#DepthAvePhyco

# Reorder variables

wc_1mB <- wc_1mB[,c("ID_DTr", "ID_DTrS", "Year", "Transect", "Station", "Depth", 
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
                    "Sulfate_1m", "Sulfate_B", "Sulfate_diff", "Sulfate_max",
                    "DepthAveTemp_1m", "DepthAveTemp_B", "DepthAveTemp_diff",
                    "DepthAveTemp_max", "DepthAveSpCond_1m", "DepthAveSpCond_B", 
                    "DepthAveSpCond_diff", "DepthAveSpCond_max","DepthAvepH_1m", 
                    "DepthAvepH_B", "DepthAvepH_diff", "DepthAvepH_max", "DepthAveTurb_1m",
                    "DepthAveTurb_B", "DepthAveTurb_diff", "DepthAveTurb_max",
                    "DepthAveDO_1m", "DepthAveDO_B", "DepthAveDO_diff", "DepthAveDO_max",
                    "DepthAveChl_1m", "DepthAveChl_B", "DepthAveChl_diff", "DepthAveChl_max",
                    "DepthAvePhyco_1m", "DepthAvePhyco_B", "DepthAvePhyco_diff",
                    "DepthAvePhyco_max")]


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


##### 3) Nutrient max vs. diff plots #####

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



##### 4) ADCP data formatting #####

# Install/load TTR package for runMean() and runMax()
library(TTR)

# Add columns for 24-hour avg & max, and 48-hour avg & max 
# by calculating rolling average & rolling max
adcp_combined_avgs = adcp_combined
adcp_combined_avgs = adcp_combined_avgs %>%
  dplyr::group_by(Year, Transect) %>%
  dplyr::mutate(Avg24hrSpdCell01 = runMean(Cell01Spd, 8), Avg48hrSpdCell01 = runMean(Cell01Spd, 16),
                   Max24hrSpdCell01 =  runMax(Cell01Spd, 8), Max48hrSpdCell01 = runMax(Cell01Spd, 16),
                  Avg24hrSpdCell02 = runMean(Cell02Spd, 8), Avg48hrSpdCell02 = runMean(Cell02Spd, 16),
                  Max24hrSpdCell02 =  runMax(Cell02Spd, 8), Max48hrSpdCell02 = runMax(Cell02Spd, 16),
                  ) 
adcp_combined_avgs = adcp_combined_avgs %>%
  dplyr::group_by(Year, Transect) %>%
  dplyr::mutate(Avg24hrSpdCell01Cell02 = rowMeans(cbind(Avg24hrSpdCell01, Avg24hrSpdCell02)),
                Avg48hrSpdCell01Cell02 = rowMeans(cbind(Avg48hrSpdCell01, Avg48hrSpdCell02)),
                )
adcp_combined_avgs = adcp_combined_avgs %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    Max24hrSpdCell01Cell02 = max(c(Max24hrSpdCell01, Max24hrSpdCell02)),
    Max48hrSpdCell01Cell02 = max(c(Max48hrSpdCell01, Max48hrSpdCell02))
    )


##### 5) Merging ADCP & WaterChem ####

# load package "fuzzyjoin" for merging
library("fuzzyjoin")

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
                     .before = "TP_1m")
adcp_combined_avgs <- add_column(adcp_combined_avgs, DateTimeNum = "", 
                                .before = "Hs")

# Convert DateTime to numeric and put into DateTimeNum
wc_1mB$DateTimeNum <- as.numeric(as.POSIXct(wc_1mB$DateTime))
adcp_combined_avgs$DateTimeNum <- as.numeric(as.POSIXct(adcp_combined_avgs$DateTime))

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
wc_eep = subset(wc_1mB, Transect == "EEP") # doesn't have matching ADCP data
wc_hal = subset(wc_1mB, Transect == "HAL") # doesn't have matching ADCP data
wc_mwa = subset(wc_1mB, Transect == "MWA") # doesn't have matching ADCP data

# Merge WC & ADCP data by transect
wc_adcp_hhb = difference_left_join(wc_hhb, adcp_hhb, by = "DateTimeNum",
                                max_dist = 5400)
wc_adcp_htb = difference_left_join(wc_htb, adcp_htb, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_mmc = difference_left_join(wc_mmc, adcp_mmc, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_oir = difference_left_join(wc_oir, adcp_oir, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_ool = difference_left_join(wc_ool, adcp_ool, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_osi = difference_left_join(wc_osi, adcp_osi, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_ede = difference_left_join(wc_ede, adcp_ede, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_edw = difference_left_join(wc_edw, adcp_edw, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_msb = difference_left_join(wc_msb, adcp_msb, by = "DateTimeNum",
                                   max_dist = 5400)
wc_adcp_osn = difference_left_join(wc_osn, adcp_osn, by = "DateTimeNum",
                                   max_dist = 5400)

# Merge all wc/adcp dataframes, all transects put together
wc_adcp_all = rbind(wc_adcp_hhb, wc_adcp_htb, wc_adcp_mmc, wc_adcp_oir,
                    wc_adcp_ool, wc_adcp_osi, wc_adcp_ede, wc_adcp_edw,
                    wc_adcp_msb, wc_adcp_osn)



##### 6) Graphing ADCP + Nutrients - formatting and prep #####

# trying to remove unnecessary/duplicated columns, not working
#wc_adcp_plots <- wc_adcp[, -c("ID_DTr", "ID_DTrS", "ID_DtTr.y", "Year.y", "Transect.y", 
 #                          "Depth", "SubstrateType", "Date.y", "DateTime.y")]

# rename some columns
wc_adcp_plots <- wc_adcp_all %>% dplyr::rename(Transect = Transect.x)  
wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(Year = Year.x)  
wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(Date = Date.x)  
wc_adcp_plots <- wc_adcp_plots %>% dplyr::rename(DateTime = DateTime.x)

## Order transects by location for legend
wc_adcp_plots$Transect = factor(wc_adcp_plots$Transect, 
                                levels = c("MMC", "MSB", "HHB", 
                                           "HTB", "EDW","EDE", 
                                           "OIR", "OOL", "OSI", "OSN"))

## Remove outlier because it doesn't match up with an ADCP measurement,
## but it is making the scale of the TN graphs larger without a point to support it.
wc_adcp_plots$TN_diff [wc_adcp_plots$TN_diff == 2.414] <- NA
wc_adcp_plots$Ammonia_diff [wc_adcp_plots$Ammonia_diff == -0.3015] <- NA
wc_adcp_plots$Chloride_diff [wc_adcp_plots$Chloride_diff > 47] <- NA
wc_adcp_plots$Sulfate_diff [wc_adcp_plots$Sulfate_diff > 2.5] <- NA


##### 7) Early plot example for ADCP Water Speed vs. Nutrient Diff ####

# TP (writing the code to go into the function)

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
  
  
##### 8) Function for ADCP water speed vs. Diff Nutrients plots ######



adcpplots = function(dat, xvar, yvar, CI50, CI90, U, L, xlab, ylab) {
  
  ggplot(data = dat, aes(x = dat[,xvar], y = dat[,yvar])) +
    geom_hline(yintercept = c(CI50[,U], CI50[,L]), color = "grey68",
               linetype = "solid", size = 0.5) +
    geom_hline(yintercept = c(CI90[,U], CI90[,L]), color = "grey68",
               linetype = "dashed", size = 0.5) +
    geom_hline(yintercept=0,color="black")+
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
    xlim(0,max(dat[,xvar])) + ylim(min(dat[,yvar]), max(dat[,yvar])) +
    theme_classic() + labs(x = xlab, y = ylab, size = 18) 
}

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
tp5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
tp8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TP_diff", TP.CI50, TP.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TP (mg/L) between 1 m \nand 0.1 m above bottom")
TPplots1 = ggarrange(tp1, tp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots2 = ggarrange(tp3, tp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots3 = ggarrange(tp5, tp6, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
TPplots4 = ggarrange(tp7, tp8, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
ggexport(TPplots1, filename = "TP-ADCP1.pdf")
ggexport(TPplots2, filename = "TP-ADCP2.pdf")
ggexport(TPplots3, filename = "TP-ADCP3.pdf")
ggexport(TPplots4, filename = "TP-ADCP4.pdf")


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
srp5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
srp8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "SRP_diff", SRP.CI50, SRP.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in SRP (mg/L) between 1 m \nand 0.1 m above bottom")
SRPplots1 = ggarrange(srp1, srp2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
SRPplots2 = ggarrange(srp3, srp4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
SRPplots3 = ggarrange(srp5, srp6, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
SRPplots4 = ggarrange(srp7, srp8, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
ggexport(SRPplots1, filename = "SRP-ADCP1.pdf")
ggexport(SRPplots2, filename = "SRP-ADCP2.pdf")
ggexport(SRPplots3, filename = "SRP-ADCP3.pdf")
ggexport(SRPplots4, filename = "SRP-ADCP4.pdf")


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
tn5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")
tn8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TN_diff", TN.CI50, TN.CI90,
          "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
          "Difference in TN (mg/L) between 1 m \nand 0.1 m above bottom")  
TNplots1 = ggarrange(tn1, tn2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TNplots2 = ggarrange(tn3, tn4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TNplots3 = ggarrange(tn5, tn6, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TNplots4 = ggarrange(tn7, tn8, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(TNplots1, filename = "TN-ADCP1.pdf")
ggexport(TNplots2, filename = "TN-ADCP2.pdf")
ggexport(TNplots3, filename = "TN-ADCP3.pdf")
ggexport(TNplots4, filename = "TN-ADCP4.pdf")


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
amm5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")
amm8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Ammonia_diff", Ammonia.CI50, Ammonia.CI90,
                "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                "Difference in Ammonia (mg/L) between 1 m \nand 0.1 m above bottom")  
Ammoniaplots1 = ggarrange(amm1, amm2, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
Ammoniaplots2 = ggarrange(amm3, amm4, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
Ammoniaplots3 = ggarrange(amm5, amm6, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
Ammoniaplots4 = ggarrange(amm7, amm8, common.legend = TRUE, legend = "right",
                     ncol = 1, nrow = 2)
ggexport(Ammoniaplots1, filename = "Ammonia-ADCP1.pdf")
ggexport(Ammoniaplots2, filename = "Ammonia-ADCP2.pdf")
ggexport(Ammoniaplots3, filename = "Ammonia-ADCP3.pdf")
ggexport(Ammoniaplots4, filename = "Ammonia-ADCP4.pdf")


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
aon5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")
aon8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "AmmoniaOrganicN_diff", AON.CI50, AON.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Ammonia + Organic N (mg/L)\n between 1 m and 0.1 m above bottom")  
AONplots1 = ggarrange(aon1, aon2, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
AONplots2 = ggarrange(aon3, aon4, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
AONplots3 = ggarrange(aon5, aon6, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
AONplots4 = ggarrange(aon7, aon8, common.legend = TRUE, legend = "right",
                          ncol = 1, nrow = 2)
ggexport(AONplots1, filename = "AmmoniaOrganicN-ADCP1.pdf")
ggexport(AONplots2, filename = "AmmoniaOrganicN-ADCP2.pdf")
ggexport(AONplots3, filename = "AmmoniaOrganicN-ADCP3.pdf")
ggexport(AONplots4, filename = "AmmoniaOrganicN-ADCP4.pdf")


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
NOx5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")
NOx8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "NOx_diff", NOx.CI50, NOx.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in NOx (mg/L) between 1 m \nand 0.1 m above bottom")  
NOxplots1 = ggarrange(NOx1, NOx2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots2 = ggarrange(NOx3, NOx4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots3 = ggarrange(NOx5, NOx6, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
NOxplots4 = ggarrange(NOx7, NOx8, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(NOxplots1, filename = "NOx-ADCP1.pdf")
ggexport(NOxplots2, filename = "NOx-ADCP2.pdf")
ggexport(NOxplots3, filename = "NOx-ADCP3.pdf")
ggexport(NOxplots4, filename = "NOx-ADCP4.pdf")


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
TSS5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")
TSS8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "TSS_diff", TSS.CI50, TSS.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in TSS (mg/L) between 1 m \nand 0.1 m above bottom")  
TSSplots1 = ggarrange(TSS1, TSS2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots2 = ggarrange(TSS3, TSS4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots3 = ggarrange(TSS5, TSS6, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
TSSplots4 = ggarrange(TSS7, TSS8, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(TSSplots1, filename = "TSS-ADCP1.pdf")
ggexport(TSSplots2, filename = "TSS-ADCP2.pdf")
ggexport(TSSplots3, filename = "TSS-ADCP3.pdf")
ggexport(TSSplots4, filename = "TSS-ADCP4.pdf")


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
chlo5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")
chlo8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Chloride_diff", Chloride.CI50, Chloride.CI90,
                 "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                 "Difference in Chloride (mg/L) between 1 m \nand 0.1 m above bottom")  
chloplots1 = ggarrange(chlo1, chlo2, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
chloplots2 = ggarrange(chlo3, chlo4, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
chloplots3 = ggarrange(chlo5, chlo6, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
chloplots4 = ggarrange(chlo7, chlo8, common.legend = TRUE, legend = "right",
                      ncol = 1, nrow = 2)
ggexport(chloplots1, filename = "Chloride-ADCP1.pdf")
ggexport(chloplots2, filename = "Chloride-ADCP2.pdf")
ggexport(chloplots3, filename = "Chloride-ADCP3.pdf")
ggexport(chloplots4, filename = "Chloride-ADCP4.pdf")


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
Fluo5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")
Fluo8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Fluoride_diff", Fluoride.CI50, Fluoride.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Fluoride (mg/L) between 1 m \nand 0.1 m above bottom")  
Fluoplots1 = ggarrange(Fluo1, Fluo2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots2 = ggarrange(Fluo3, Fluo4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots3 = ggarrange(Fluo5, Fluo6, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
Fluoplots4 = ggarrange(Fluo7, Fluo8, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(Fluoplots1, filename = "Fluoride-ADCP1.pdf")
ggexport(Fluoplots2, filename = "Fluoride-ADCP2.pdf")
ggexport(Fluoplots3, filename = "Fluoride-ADCP3.pdf")
ggexport(Fluoplots4, filename = "Fluoride-ADCP4.pdf")


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
sulf5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")
sulf8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Sulfate_diff", Sulfate.CI50, Sulfate.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Sulfate (mg/L) between 1 m \nand 0.1 m above bottom")  
sulfplots1 = ggarrange(sulf1, sulf2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots2 = ggarrange(sulf3, sulf4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots3 = ggarrange(sulf5, sulf6, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
sulfplots4 = ggarrange(sulf7, sulf8, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(sulfplots1, filename = "Sulfate-ADCP1.pdf")
ggexport(sulfplots2, filename = "Sulfate-ADCP2.pdf")
ggexport(sulfplots3, filename = "Sulfate-ADCP3.pdf")
ggexport(sulfplots4, filename = "Sulfate-ADCP4.pdf")


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
sili5 = adcpplots(wc_adcp_plots, "Avg24hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili6 = adcpplots(wc_adcp_plots, "Avg48hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Average 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili7 = adcpplots(wc_adcp_plots, "Max24hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 24 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")
sili8 = adcpplots(wc_adcp_plots, "Max48hrSpdCell01Cell02", "Silica_diff", Silica.CI50, Silica.CI90,
                  "Upper", "Lower", "Max 48 hour water speed (cm/s) in Cells 01 & 02",
                  "Difference in Silica (mg/L) between 1 m \nand 0.1 m above bottom")  
siliplots1 = ggarrange(sili1, sili2, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots2 = ggarrange(sili3, sili4, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots3 = ggarrange(sili5, sili6, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
siliplots4 = ggarrange(sili7, sili8, common.legend = TRUE, legend = "right",
                       ncol = 1, nrow = 2)
ggexport(siliplots1, filename = "Silica-ADCP1.pdf")
ggexport(siliplots2, filename = "Silica-ADCP2.pdf")
ggexport(siliplots3, filename = "Silica-ADCP3.pdf")
ggexport(siliplots4, filename = "Silica-ADCP4.pdf")




##### 9) ADCP Water Speed vs. Max & Diff Nutrients ####

  
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
ggexport(TP2ndplots2, filename = "2nd-TP-ADCP2.pdf")
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

##### 10) Removing Past Dataframes (can be done after ALL #####
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
   conf.int, wc_1m, wc_adcp_ede, wc_adcp_edw, wc_adcp_hhb, wc_adcp_htb, 
   wc_adcp_mmc, wc_adcp_msb, wc_adcp_oir, wc_adcp_ool, wc_adcp_osi, wc_adcp_osn, 
   wc_B, wc_combined, wc_ede, wc_edw, wc_eep, wc_hal, wc_hhb, wc_htb, wc_mmc, 
   wc_msb, wc_mwa, wc_oir, wc_ool, wc_osi, wc_osn, wc18, wc18_sub, wc19, 
   wc19_sub, wc20, wc20_sub, ws_erie18, ws_erie18_sub, ws_erie19, ws_erie19_sub, 
   ws_huron18, ws_huron18_sub, ws_huron19, ws_huron19_sub, ws_mmc18, 
   ws_mmc18_sub, ws_msb18, ws_msb18_sub, ws_msb19, ws_msb19_sub, ws_mwa19, 
   ws_mwa19_sub, ws_oir18, ws_oir18_sub, ws_oir19, ws_oir19_sub, ws_ool18, 
   ws_ool18_sub, ws_ool19, ws_ool19_sub, ws_osi18, ws_osi18_sub, ws_osn19, 
   ws_osn19_sub)


##### 11) breakpoint analysis ADCP data


breakpoint = wc_adcp_plots

breakpoint = breakpoint[order(breakpoint$Avg24hrSpdCell01),]


install.packages("strucchange")
library(strucchange)

plot.ts(breakpoint$TP_diff)
model1 = Fstats(breakpoint$TP_diff~1, from=0.01)
sctest(model1)
# Null: there is NO structural change in a series if >0.05
strucchange::breakpoints(wc_adcp_plots$TP_diff~1)


library(changepoint)
library(changepoint.np) #non-parametric
library(bcp) #bayesian

# NOT RUN {
## Nile data with one breakpoint: the annual flows drop in 1898
## because the first Ashwan dam was built
data("wc_adcp_plots")
plot(Nile)

## F statistics indicate one breakpoint
fs.nile <- Fstats(Nile ~ 1)
plot(fs.nile)
breakpoints(fs.nile)
lines(breakpoints(fs.nile))

## or
bp.nile <- breakpoints(Nile ~ 1)
summary(bp.nile)

## the BIC also chooses one breakpoint
plot(bp.nile)
breakpoints(bp.nile)

## fit null hypothesis model and model with 1 breakpoint
fm0 <- lm(Nile ~ 1)
fm1 <- lm(Nile ~ breakfactor(bp.nile, breaks = 1))
plot(Nile)
lines(ts(fitted(fm0), start = 1871), col = 3)
lines(ts(fitted(fm1), start = 1871), col = 4)
lines(bp.nile)

## confidence interval
ci.nile <- confint(bp.nile)
ci.nile
lines(ci.nile)


## UK Seatbelt data: a SARIMA(1,0,0)(1,0,0)_12 model
## (fitted by OLS) is used and reveals (at least) two
## breakpoints - one in 1973 associated with the oil crisis and
## one in 1983 due to the introduction of compulsory
## wearing of seatbelts in the UK.
data("UKDriverDeaths")
seatbelt <- log10(UKDriverDeaths)
seatbelt <- cbind(seatbelt, lag(seatbelt, k = -1), lag(seatbelt, k = -12))
colnames(seatbelt) <- c("y", "ylag1", "ylag12")
seatbelt <- window(seatbelt, start = c(1970, 1), end = c(1984,12))
plot(seatbelt[,"y"], ylab = expression(log[10](casualties)))

## testing
re.seat <- efp(y ~ ylag1 + ylag12, data = seatbelt, type = "RE")
plot(re.seat)

## dating
bp.seat <- breakpoints(y ~ ylag1 + ylag12, data = seatbelt, h = 0.1)
summary(bp.seat)
lines(bp.seat, breaks = 2)

## minimum BIC partition
plot(bp.seat)
breakpoints(bp.seat)
## the BIC would choose 0 breakpoints although the RE and supF test
## clearly reject the hypothesis of structural stability. Bai &
## Perron (2003) report that the BIC has problems in dynamic regressions.
## due to the shape of the RE process of the F statistics choose two
## breakpoints and fit corresponding models
bp.seat2 <- breakpoints(bp.seat, breaks = 2)
fm0 <- lm(y ~ ylag1 + ylag12, data = seatbelt)
fm1 <- lm(y ~ breakfactor(bp.seat2)/(ylag1 + ylag12) - 1, data = seatbelt)

## plot
plot(seatbelt[,"y"], ylab = expression(log[10](casualties)))
time.seat <- as.vector(time(seatbelt))
lines(time.seat, fitted(fm0), col = 3)
lines(time.seat, fitted(fm1), col = 4)
lines(bp.seat2)

## confidence intervals
ci.seat2 <- confint(bp.seat, breaks = 2)
ci.seat2
lines(ci.seat2)
# }