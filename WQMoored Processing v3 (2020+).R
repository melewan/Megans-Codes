###WQMoored Processing ###

### SET-UP/FORMATTING ###

# Load read excel package and plyr package
library(plyr)
library(dplyr)
library(tidyverse)
library(readxl)
library(readr)
library(tidyr)
library(ggplot2)
library(egg)
library(data.table)
library(hms)
library(ggpubr)

# Select working directory 
setwd(choose.dir(caption = "Select folder to process"))

# Select ID file 
id.file = choose.files(multi = F, 
                       caption = "Select id file")

## Load in transect file for R to read 

id = data.frame(read_excel(id.file))
names(id)[2] = "EXO2filename"

for(i in 1:nrow(id)) {
  
  EXO2filename = id$EXO2filename[i]
  file.name = paste(EXO2filename,".csv", sep = "")
  

  if (file.exists(file.name)==TRUE) {
    data = read.csv(file.name,stringsAsFactors= FALSE, fileEncoding = "UTF-8-BOM")

# Adjust formatting
    
    start.row = which(data[,1] == "Date (MM/DD/YYYY)")
    colnames(data) = data[start.row,]
    data  = data[-c(1:start.row),]
    data$'Date (MM/DD/YYYY)' = as.Date(data$'Date (MM/DD/YYYY)', "%m/%d/%Y")
    data[, -c(1:2,4)] = sapply(data[, -c(1:2,4)], as.numeric)

# Keep only necessary columns
    col.only = data[c("Date (MM/DD/YYYY)", "Time (HH:MM:SS)", "Site Name", "Chlorophyll RFU", "ODO mg/L", "SpCond µS/cm", 
                  "BGA PC RFU", "Turbidity FNU", "pH", "Temp °C")]

# Rename column names
    colnames(col.only) = c("Date", "Time", "site", "AveChl", "AveDO", "AveSpCond", "AvePhycocyanin", "AveTurb", "AvepH", "AveTemp")

# Remove out of water time
    in.water = subset(col.only, AveSpCond > 180)
    

# Concatenate into master data frame
if(!exists("all.moored")){
  all.moored=in.water
} else{
  all.moored = rbind.fill(all.moored, in.water)
}
  }
}

# Change format of Date column to match Time format
all.moored$Date = as.character(all.moored$Date)

# Change BDLs to 0 
all.moored$AveChl [all.moored$AveChl <= 0]<-0
all.moored$AvePhycocyanin [all.moored$AvePhycocyanin <= 0 ] <- 0

# Concatenate Date and Time columns 
all.moored = add_column(all.moored, DateTime = paste
                               (all.moored$Date,
                                 all.moored$Time,
                                 sep = " ", collapse = NULL), .before = "Date")

# POSIXct formatting
all.moored$DateTime <- as.POSIXct(all.moored$DateTime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")


# Subset into transect
EEP.moored = subset(all.moored, site == "EEP")
HAL.moored = subset(all.moored, site == "HAL")

# Adjust measurement resolution (# of decimal points)
all.moored$AveTemp = lapply(all.moored$AveTemp, round, 3)
all.moored$AveSpCond = lapply(all.moored$AveSpCond, round, 2)
all.moored$AvepH = lapply(all.moored$AvepH, round, 2)
all.moored$AveTurb = lapply(all.moored$AveTurb, round, 2)
all.moored$AveDO = lapply(all.moored$AveDO, round, 2)
all.moored$AveChl = lapply(all.moored$AveChl, round, 2)
all.moored$AvePhycocyanin = lapply(all.moored$AvePhycocyanin, round, 2)

# change BDLs to BDL
all.moored$AveTurb [all.moored$AveTurb <= 0.3]<-"BDL"
all.moored$AveChl [all.moored$AveChl <= 0.01]<-"BDL"
all.moored$AvePhycocyanin [all.moored$AvePhycocyanin <= 0.01]<-"BDL"

# Add columns
all.moored <- add_column(all.moored, Year = 2021, 
                            .before = "DateTime")
all.moored <- add_column(all.moored, Lake = "",
                         .before = "site")

# Rename columns
names(all.moored)[6] = "Transect"
names(all.moored)[7] = "Chl"
names(all.moored)[8] = "DO"
names(all.moored)[9] = "SpCond"
names(all.moored)[10] = "Phycocyanin"
names(all.moored)[11] = "Turb"
names(all.moored)[12] = "pH"
names(all.moored)[13] = "Temp"

# Order columns
all.moored = all.moored[ , c("Year", "Date", "Time", "Lake", "Transect", "Temp", "SpCond", "pH", "Turb", "DO", "Chl", "Phycocyanin")] 

for(i in 1:nrow(all.moored)) {
  if(all.moored$Transect[i] == "HAL"){all.moored$Lake[i] = "Huron"}
  else if(all.moored$Transect[i] == "EEP"){all.moored$Lake[i] = "Erie"}
}

# Save all.moored as a csv file
all.moored = sapply(all.moored, as.character)
write.csv(all.moored, file = choose.files(multi = F, 
                                              caption = "Save 'WaterQualityMooredYYYY.csv' file"),
                                                row.names = FALSE)


# Select working directory 
setwd(choose.dir(caption = "Select cast data folder"))


## Load Cast data 
WaterQualityProfiles2021 <- read.csv("WaterQualityProfiles2021.csv")

# Change date format to match moored data
WaterQualityProfiles2021$Date = as.Date(WaterQualityProfiles2021$Date, 
                                             format = "%m/%d/%Y")

# Change format of Date column to match Time format
WaterQualityProfiles2021$Time = as.character(WaterQualityProfiles2021$Time)

# Concatenate Date and Time columns 
WaterQualityProfiles2021 = add_column(WaterQualityProfiles2021, DateTime = paste
                        (WaterQualityProfiles2021$Date,
                          WaterQualityProfiles2021$Time,
                          sep = " ", collapse = NULL), .before = "Date")

# Change BDLs to 0 and make column numeric
WaterQualityProfiles2021$AveChl [WaterQualityProfiles2021$AveChl == "BDL"]<-0
WaterQualityProfiles2021$AveChl <- as.numeric(WaterQualityProfiles2021$AveChl)
WaterQualityProfiles2021$AveTurb [WaterQualityProfiles2021$AveTurb == "BDL"]<-0
WaterQualityProfiles2021$AveTurb <- as.numeric(WaterQualityProfiles2021$AveTurb)
WaterQualityProfiles2021$AvePhycocyanin [WaterQualityProfiles2021$AvePhycocyanin == "BDL"]<-0
WaterQualityProfiles2021$AvePhycocyanin <- as.numeric(WaterQualityProfiles2021$AvePhycocyanin)


# POSIXct formatting
WaterQualityProfiles2021$DateTime <- as.POSIXct(WaterQualityProfiles2021$DateTime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")


## Subset all EEP data
EEP = subset(WaterQualityProfiles2021, Transect == "EEP")

# Subset EEP data by month and station
EEP.May = subset(EEP, Month == "May" & Station == "6")
EEP.June = subset(EEP, Month == "June" & Station == "6")
#EEP.July = subset(EEP, Month == "July" & Station == "6")
EEP.August = subset(EEP, Month == "August" & Station == "6")

# Calculate EEP 0.7 m above bottom values
EEP.May.actual = (max(EEP.May$BinnedDepth)-0.7)
EEP.June.actual = (max(EEP.June$BinnedDepth)-0.7)
#EEP.July.actual = (max(EEP.July$BinnedDepth)-0.7)
EEP.August.actual = (max(EEP.August$BinnedDepth)-0.7)

# Subset EEP data for range of depth values 0.6 - 0.8 m above bottom
EEP.May.depth = subset(EEP.May, BinnedDepth >= EEP.May.actual - 0.1 & BinnedDepth <= EEP.May.actual + 0.1)
EEP.June.depth = subset(EEP.June, BinnedDepth >= EEP.June.actual - 0.1 & BinnedDepth <= EEP.June.actual + 0.1)
#EEP.July.depth = subset(EEP.July, BinnedDepth >= EEP.July.actual - 0.1 & BinnedDepth <= EEP.July.actual + 0.1)
EEP.August.depth = subset(EEP.August, BinnedDepth >= EEP.August.actual - 0.1 & BinnedDepth <= EEP.August.actual + 0.1)

# Subset EEP data for bottom data points for each month
EEP.May.bottom = EEP.May %>% dplyr::slice(nrow(EEP.May)-1,)
EEP.June.bottom = EEP.June %>% dplyr::slice(nrow(EEP.June)-1,)
#EEP.July.bottom = EEP.July %>% dplyr::slice(nrow(EEP.July)-1,)
EEP.August.bottom = EEP.August %>% dplyr::slice(nrow(EEP.August)-1,)

# Create data frame for EEP 0.7 m above bottom points
#EEP.depth = rbind(EEP.May.depth, EEP.June.depth, EEP.July.depth, EEP.August.depth)
EEP.depth = rbind(EEP.May.depth, EEP.June.depth, EEP.August.depth)

# Create data frame for EEP bottom points
#EEP.bottom = rbind(EEP.May.bottom, EEP.June.bottom, EEP.July.bottom, EEP.August.bottom)
EEP.bottom = rbind(EEP.May.bottom, EEP.June.bottom, EEP.August.bottom)




HAL = subset(WaterQualityProfiles2021, Transect == "HAL")


# Subset HAL data by month and station
HAL.May = subset(HAL, Month == "May" & Station == "6")
#HAL.June = subset(HAL, Month == "June" & Station == "6")
HAL.July = subset(HAL, Month == "July" & Station == "6")
#HAL.August = subset(HAL, Month == "August" & Station == "6")

# Calculate HAL 0.7 m above bottom values
HAL.May.actual = (max(HAL.May$BinnedDepth)-0.7)
#HAL.June.actual = (max(HAL.June$BinnedDepth)-0.7)
HAL.July.actual = (max(HAL.July$BinnedDepth)-0.7)
#HAL.August.actual = (max(HAL.August$BinnedDepth)-0.7)

# Subset HAL data for range of depth values 0.6 - 0.8 m above bottom
HAL.May.depth = subset(HAL.May, BinnedDepth >= HAL.May.actual - 0.1 & BinnedDepth <= HAL.May.actual + 0.1)
#HAL.June.depth = subset(HAL.June, BinnedDepth >= HAL.June.actual - 0.1 & BinnedDepth <= HAL.June.actual + 0.1)
HAL.July.depth = subset(HAL.July, BinnedDepth >= HAL.July.actual - 0.1 & BinnedDepth <= HAL.July.actual + 0.1)
#HAL.August.depth = subset(HAL.August, BinnedDepth >= HAL.August.actual - 0.1 & BinnedDepth <= HAL.August.actual + 0.1)

# Subset HAL data for bottom data points for each month
HAL.May.bottom = HAL.May %>% dplyr::slice(nrow(HAL.May)-1,)
#HAL.June.bottom = HAL.June %>% dplyr::slice(nrow(HAL.June)-1,)
HAL.July.bottom = HAL.July %>% dplyr::slice(nrow(HAL.July)-1,)
#HAL.August.bottom = HAL.August %>% dplyr::slice(nrow(HAL.August)-1,)

# Create data frame for HAL 0.7 m above bottom points
#HAL.depth = rbind(HAL.May.depth, HAL.June.depth, HAL.July.depth, HAL.August.depth)
HAL.depth = rbind(HAL.May.depth, HAL.July.depth)

# Create data frame for HAL bottom points
#HAL.bottom = rbind(HAL.May.bottom, HAL.June.bottom, HAL.July.bottom, HAL.August.bottom)
HAL.bottom = rbind(HAL.May.bottom, HAL.July.bottom)



### QAQC comparison plots for cast and moored data

# Set theme 
theme_set(theme_classic())

# Change working directory again to save plots (in WQMoored Processing > YYYY folder)
setwd(choose.dir(caption = "Select folder to process"))

## QAQC plot functions ##

# pH

pH_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AvepH)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="pH Profile Cast vs Moored plots", 
         y="pH", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}
  
EEP.pH = pH_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.pH = pH_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.pH, filename = "EEP.pH.jpg", width = 1200, height = 500)
ggexport(HAL.pH, filename = "HAL.pH.jpg", width = 1200, height = 500)


# chl

chl_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AveChl)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="Chl Profile Cast vs Moored plots", 
         y="Chl RFU", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}


EEP.chl = chl_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.chl = chl_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.chl, filename = "EEP.chl.jpg", width = 1200, height = 500)
ggexport(HAL.chl, filename = "HAL.chl.jpg", width = 1200, height = 500)


# DO

DO_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AveDO)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="DO Profile Cast vs Moored plots", 
         y="DO", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}


EEP.DO = DO_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.DO = DO_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.DO, filename = "EEP.DO.jpg", width = 1200, height = 500)
ggexport(HAL.DO, filename = "HAL.DO.jpg", width = 1200, height = 500)


# SpCond

SpCond_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AveSpCond)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="SpCond Profile Cast vs Moored plots", 
         y="SpCond", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}


EEP.spc = SpCond_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.spc = SpCond_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.spc, filename = "EEP.spc.jpg", width = 1200, height = 500)
ggexport(HAL.spc, filename = "HAL.spc.jpg", width = 1200, height = 500)


# Turb

Turb_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AveTurb)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="Turbidity Profile Cast vs Moored plots", 
         y="Turbidity", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}

EEP.turb = Turb_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.turb = Turb_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.turb, filename = "EEP.turb.jpg", width = 1200, height = 500)
ggexport(HAL.turb, filename = "HAL.turb.jpg", width = 1200, height = 500)



# Temp

Temp_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AveTemp)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="Temperature Profile Cast vs Moored plots", 
         y="Temperature", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}


EEP.temp = Temp_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.temp = Temp_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.temp, filename = "EEP.temp.jpg", width = 1200, height = 500)
ggexport(HAL.temp, filename = "HAL.temp.jpg", width = 1200, height = 500)


# BGA/Phycocyanin

EEP.moored$AvePhycocyanin <- as.numeric(EEP.moored$AvePhycocyanin)
HAL.moored$AvePhycocyanin <- as.numeric(HAL.moored$AvePhycocyanin)

BGA_QAQC = function(dat1, dat2, dat3, mytitle) {
  
  ggplot(NULL, aes(x = DateTime, y = AvePhycocyanin)) +
    geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
    geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
    geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
    scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
    guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
    labs(subtitle="Phycocyanin Profile Cast vs Moored plots", 
         y="Phycocyanin RFU", 
         x="Date", 
         title= mytitle)  +
    theme(text= element_text (size=14))
  
}


EEP.bga = BGA_QAQC(EEP.moored, EEP.depth, EEP.bottom, "EEP 6 m 2021")
HAL.bga = BGA_QAQC(HAL.moored, HAL.depth, HAL.bottom, "HAL 6 m 2021")

ggexport(EEP.bga, filename = "EEP.bga.jpg", width = 1200, height = 500)
ggexport(HAL.bga, filename = "HAL.bga.jpg", width = 1200, height = 500)
