### ADCP processing ###


##### Formatting #####

# Load required packages
library(readxl)
library(tidyverse)
library(ggpubr)

# Set working directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/Multi Year QC/QCCodeAndProcessing/ADCP")

# load in file
ADCP2018 = read_excel("ADCP2018.xlsx",
                      sheet = "Sheet1")
ADCP2019 = read_excel("ADCP2019.xlsx",
                      sheet = "Sheet1" )

ADCP2018$Tp [ADCP2018$Tp == "NA"] <- 256
ADCP2019$Tp [ADCP2019$Tp == "NA"] <- 256


# create new DateTime column (2018)
ADCP2018 <- add_column(ADCP2018, 
                          Date = paste(ADCP2018$Year, 
                                       ADCP2018$Month, 
                                       ADCP2018$Day, sep = "-",
                                       collapse = NULL), .before = "Hour")
ADCP2018 <- add_column(ADCP2018, 
                          Time = paste(ADCP2018$Hour, 
                                       ADCP2018$Minute,
                                       ADCP2018$Second, sep = ":", 
                                       collapse = NULL), .before = "VelocityE")
ADCP2018$Date <- as.Date(as.character(ADCP2018$Date), format = "%Y-%m-%d")
ADCP2018 <- add_column(ADCP2018, DateTime = paste
                          (ADCP2018$Date, 
                            ADCP2018$Time, 
                            sep = " ", collapse = NULL), .before = "VelocityE")
ADCP2018$DateTime <- as.POSIXct(ADCP2018$DateTime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

# create new DateTime column (2019)
ADCP2019 <- add_column(ADCP2019, 
                       Date = paste(ADCP2019$Year, 
                                    ADCP2019$Month, 
                                    ADCP2019$Day, sep = "-",
                                    collapse = NULL), .before = "Hour")
ADCP2019 <- add_column(ADCP2019, 
                       Time = paste(ADCP2019$Hour, 
                                    ADCP2019$Minute,
                                    ADCP2019$Second, sep = ":", 
                                    collapse = NULL), .before = "VelocityE")
ADCP2019$Date <- as.Date(as.character(ADCP2019$Date), format = "%Y-%m-%d")
ADCP2019 <- add_column(ADCP2019, DateTime = paste
                       (ADCP2019$Date, 
                         ADCP2019$Time, 
                         sep = " ", collapse = NULL), .before = "VelocityE")
ADCP2019$DateTime <- as.POSIXct(ADCP2019$DateTime, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

# numeric formatting
ADCP2018[, -c(1, 5, 9:10)] = sapply(ADCP2018[, -c(1, 5, 9:10)], as.numeric)
ADCP2019[, -c(1, 5, 9:10)] = sapply(ADCP2019[, -c(1, 5, 9:10)], as.numeric)


##### ERR when Tp = 256 #####

# Input code "ERR" for parameters affected by Tp (wave peak period) error code 256
for(i in 1:nrow(ADCP2018)) {
  if(ADCP2018$Tp[i] == 256) {
    ADCP2018$Hs[i] = "ERR"
    ADCP2018$Aband0[i] = "ERR"
    ADCP2018$Aband1[i] = "ERR"
    ADCP2018$Aband2[i] = "ERR"
    ADCP2018$Aband3[i] = "ERR"
    ADCP2018$Aband4[i] = "ERR"
    ADCP2018$Aband5[i] = "ERR"
    ADCP2018$Aband6[i] = "ERR"
    ADCP2018$Aband7[i] = "ERR"
    ADCP2018$Aband8[i] = "ERR"
    ADCP2018$Aband9[i] = "ERR"
    }
}

for(i in 1:nrow(ADCP2019)) {
  if(ADCP2019$Tp[i] == 256) {
    ADCP2019$Hs[i] = "ERR"
    ADCP2019$Aband0[i] = "ERR"
    ADCP2019$Aband1[i] = "ERR"
    ADCP2019$Aband2[i] = "ERR"
    ADCP2019$Aband3[i] = "ERR"
    ADCP2019$Aband4[i] = "ERR"
    ADCP2019$Aband5[i] = "ERR"
    ADCP2019$Aband6[i] = "ERR"
    ADCP2019$Aband7[i] = "ERR"
    ADCP2019$Aband8[i] = "ERR"
    ADCP2019$Aband9[i] = "ERR"
  }
}

##### UNR when SNR <= 7 #####

# Replace velocity values with UNR if SNR <= 7 counts

for(i in 1:nrow(ADCP2018)) {
  #Cell01
  if(ADCP2018$Cell01SNR1[i] <= 7) {
    ADCP2018$Cell01Ve[i] = "UNR"
  }
  if(ADCP2018$Cell01SNR2[i] <= 7) {
    ADCP2018$Cell01Vn[i] = "UNR"
  }
  if(ADCP2018$Cell01SNR3[i] <= 7) {
    ADCP2018$Cell01Vu[i] = "UNR"
  }
  #Cell02
  if(ADCP2018$Cell02SNR1[i] <= 7) {
    ADCP2018$Cell02Ve[i] = "UNR"
  }
  if(ADCP2018$Cell02SNR2[i] <= 7) {
    ADCP2018$Cell02Vn[i] = "UNR"
  }
  if(ADCP2018$Cell02SNR3[i] <= 7) {
    ADCP2018$Cell02Vu[i] = "UNR"
  }
  #Cell03
  if(ADCP2018$Cell03SNR1[i] <= 7) {
    ADCP2018$Cell03Ve[i] = "UNR"
  }
  if(ADCP2018$Cell03SNR2[i] <= 7) {
    ADCP2018$Cell03Vn[i] = "UNR"
  }
  if(ADCP2018$Cell03SNR3[i] <= 7) {
    ADCP2018$Cell03Vu[i] = "UNR"
  }
  #Cell04
  if(ADCP2018$Cell04SNR1[i] <= 7) {
    ADCP2018$Cell04Ve[i] = "UNR"
  }
  if(ADCP2018$Cell04SNR2[i] <= 7) {
    ADCP2018$Cell04Vn[i] = "UNR"
  }
  if(ADCP2018$Cell04SNR3[i] <= 7) {
    ADCP2018$Cell04Vu[i] = "UNR"
  }
  #Cell05
  if(ADCP2018$Cell05SNR1[i] <= 7) {
    ADCP2018$Cell05Ve[i] = "UNR"
  }
  if(ADCP2018$Cell05SNR2[i] <= 7) {
    ADCP2018$Cell05Vn[i] = "UNR"
  }
  if(ADCP2018$Cell05SNR3[i] <= 7) {
    ADCP2018$Cell05Vu[i] = "UNR"
  }
  #Cell06
  if(ADCP2018$Cell06SNR1[i] <= 7) {
    ADCP2018$Cell06Ve[i] = "UNR"
  }
  if(ADCP2018$Cell06SNR2[i] <= 7) {
    ADCP2018$Cell06Vn[i] = "UNR"
  }
  if(ADCP2018$Cell06SNR3[i] <= 7) {
    ADCP2018$Cell06Vu[i] = "UNR"
  }
  #Cell07
  if(ADCP2018$Cell07SNR1[i] <= 7) {
    ADCP2018$Cell07Ve[i] = "UNR"
  }
  if(ADCP2018$Cell07SNR2[i] <= 7) {
    ADCP2018$Cell07Vn[i] = "UNR"
  }
  if(ADCP2018$Cell07SNR3[i] <= 7) {
    ADCP2018$Cell07Vu[i] = "UNR"
  }
  #Cell08
  if(ADCP2018$Cell08SNR1[i] <= 7) {
    ADCP2018$Cell08Ve[i] = "UNR"
  }
  if(ADCP2018$Cell08SNR2[i] <= 7) {
    ADCP2018$Cell08Vn[i] = "UNR"
  }
  if(ADCP2018$Cell08SNR3[i] <= 7) {
    ADCP2018$Cell08Vu[i] = "UNR"
  }
  #Cell09
  if(ADCP2018$Cell09SNR1[i] <= 7) {
    ADCP2018$Cell09Ve[i] = "UNR"
  }
  if(ADCP2018$Cell09SNR2[i] <= 7) {
    ADCP2018$Cell09Vn[i] = "UNR"
  }
  if(ADCP2018$Cell09SNR3[i] <= 7) {
    ADCP2018$Cell09Vu[i] = "UNR"
  }
  #Cell10
  if(ADCP2018$Cell10SNR1[i] <= 7) {
    ADCP2018$Cell10Ve[i] = "UNR"
  }
  if(ADCP2018$Cell10SNR2[i] <= 7) {
    ADCP2018$Cell10Vn[i] = "UNR"
  }
  if(ADCP2018$Cell10SNR3[i] <= 7) {
    ADCP2018$Cell10Vu[i] = "UNR"
  }
  }

# export file
write.csv(ADCP2018, "ADCP2018v2.csv", row.names=FALSE)


for(i in 1:nrow(ADCP2019)) {
  #Cell01
  if(ADCP2019$Cell01SNR1[i] <= 7) {
    ADCP2019$Cell01Ve[i] = "UNR"
  }
  if(ADCP2019$Cell01SNR2[i] <= 7) {
    ADCP2019$Cell01Vn[i] = "UNR"
  }
  if(ADCP2019$Cell01SNR3[i] <= 7) {
    ADCP2019$Cell01Vu[i] = "UNR"
  }
  #Cell02
  if(ADCP2019$Cell02SNR1[i] <= 7) {
    ADCP2019$Cell02Ve[i] = "UNR"
  }
  if(ADCP2019$Cell02SNR2[i] <= 7) {
    ADCP2019$Cell02Vn[i] = "UNR"
  }
  if(ADCP2019$Cell02SNR3[i] <= 7) {
    ADCP2019$Cell02Vu[i] = "UNR"
  }
  #Cell03
  if(ADCP2019$Cell03SNR1[i] <= 7) {
    ADCP2019$Cell03Ve[i] = "UNR"
  }
  if(ADCP2019$Cell03SNR2[i] <= 7) {
    ADCP2019$Cell03Vn[i] = "UNR"
  }
  if(ADCP2019$Cell03SNR3[i] <= 7) {
    ADCP2019$Cell03Vu[i] = "UNR"
  }
  #Cell04
  if(ADCP2019$Cell04SNR1[i] <= 7) {
    ADCP2019$Cell04Ve[i] = "UNR"
  }
  if(ADCP2019$Cell04SNR2[i] <= 7) {
    ADCP2019$Cell04Vn[i] = "UNR"
  }
  if(ADCP2019$Cell04SNR3[i] <= 7) {
    ADCP2019$Cell04Vu[i] = "UNR"
  }
  #Cell05
  if(ADCP2019$Cell05SNR1[i] <= 7) {
    ADCP2019$Cell05Ve[i] = "UNR"
  }
  if(ADCP2019$Cell05SNR2[i] <= 7) {
    ADCP2019$Cell05Vn[i] = "UNR"
  }
  if(ADCP2019$Cell05SNR3[i] <= 7) {
    ADCP2019$Cell05Vu[i] = "UNR"
  }
  #Cell06
  if(ADCP2019$Cell06SNR1[i] <= 7) {
    ADCP2019$Cell06Ve[i] = "UNR"
  }
  if(ADCP2019$Cell06SNR2[i] <= 7) {
    ADCP2019$Cell06Vn[i] = "UNR"
  }
  if(ADCP2019$Cell06SNR3[i] <= 7) {
    ADCP2019$Cell06Vu[i] = "UNR"
  }
  #Cell07
  if(ADCP2019$Cell07SNR1[i] <= 7) {
    ADCP2019$Cell07Ve[i] = "UNR"
  }
  if(ADCP2019$Cell07SNR2[i] <= 7) {
    ADCP2019$Cell07Vn[i] = "UNR"
  }
  if(ADCP2019$Cell07SNR3[i] <= 7) {
    ADCP2019$Cell07Vu[i] = "UNR"
  }
  #Cell08
  if(ADCP2019$Cell08SNR1[i] <= 7) {
    ADCP2019$Cell08Ve[i] = "UNR"
  }
  if(ADCP2019$Cell08SNR2[i] <= 7) {
    ADCP2019$Cell08Vn[i] = "UNR"
  }
  if(ADCP2019$Cell08SNR3[i] <= 7) {
    ADCP2019$Cell08Vu[i] = "UNR"
  }
  #Cell09
  if(ADCP2019$Cell09SNR1[i] <= 7) {
    ADCP2019$Cell09Ve[i] = "UNR"
  }
  if(ADCP2019$Cell09SNR2[i] <= 7) {
    ADCP2019$Cell09Vn[i] = "UNR"
  }
  if(ADCP2019$Cell09SNR3[i] <= 7) {
    ADCP2019$Cell09Vu[i] = "UNR"
  }
  #Cell10
  if(ADCP2019$Cell10SNR1[i] <= 7) {
    ADCP2019$Cell10Ve[i] = "UNR"
  }
  if(ADCP2019$Cell10SNR2[i] <= 7) {
    ADCP2019$Cell10Vn[i] = "UNR"
  }
  if(ADCP2019$Cell10SNR3[i] <= 7) {
    ADCP2019$Cell10Vu[i] = "UNR"
  }
}

# export file
write.csv(ADCP2019, "ADCP2019v2.csv", row.names=FALSE)

##### Formatting Plot Code for QAQC #####

## PLOTTING for QAQC ##

## formatting

# make columns numeric to be able to plot. UNR/ERR are changed to NA for plotting purposes. 
ADCP2018[, -c(1, 5, 9:10)] = sapply(ADCP2018[, -c(1, 5, 9:10)], as.numeric)
ADCP2019[, -c(1, 5, 9:10)] = sapply(ADCP2019[, -c(1, 5, 9:10)], as.numeric)

# subset years dfs by transect
HHB2018 = subset(ADCP2018, Transect == "HHB")
HTB2018 = subset(ADCP2018, Transect == "HTB")
MMC2018 = subset(ADCP2018, Transect == "MMC")
OIR2018 = subset(ADCP2018, Transect == "OIR")
OOL2018 = subset(ADCP2018, Transect == "OOL")
OSI2018 = subset(ADCP2018, Transect == "OSI")

EDE2019 = subset(ADCP2019, Transect == "EDE")
EDW2019 = subset(ADCP2019, Transect == "EDW")
MSB2019 = subset(ADCP2019, Transect == "MSB")
OSN2019 = subset(ADCP2019, Transect == "OSN")
OOL2019 = subset(ADCP2019, Transect == "OOL")

##### Plot Function #####

## plot function to include all velocities

adcpqaqc2 = function(){  

adcpqaqc = function(data, y1, y2, y3, name) {
    ggplot(data, aes(x = DateTime)) +
    geom_hline(yintercept=0,color="black") +
    geom_point(aes(y = y1, colour = "VelocityE")) +
    geom_point(aes(y = y2, colour = "VelocityN")) +
    geom_point(aes(y = y3, colour = "VelocityU")) +
        geom_line(aes(y = y1, colour = "VelocityE")) +
        geom_line(aes(y = y2, colour = "VelocityN")) +
        geom_line(aes(y = y3, colour = "VelocityU")) +
        labs(title = name,
             x = "DateTime",
            y = "Velocity (cm/s)", size = 26) +
        scale_color_manual("", 
                              breaks = c("VelocityE", "VelocityN", "VelocityU"),
                              values = c("lightseagreen", "tomato", "black")) 
}

##### 2018 Plots #####


# HHB 2018

IntegratedVelocities = adcpqaqc(HHB2018, HHB2018$VelocityE, HHB2018$VelocityN, HHB2018$VelocityU, "HHB2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "HHB2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(HHB2018, HHB2018$Cell01Ve, HHB2018$Cell01Vn, HHB2018$Cell01Vu, "HHB2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "HHB2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(HHB2018, HHB2018$Cell02Ve, HHB2018$Cell02Vn, HHB2018$Cell02Vu, "HHB2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "HHB2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(HHB2018, HHB2018$Cell03Ve, HHB2018$Cell03Vn, HHB2018$Cell03Vu, "HHB2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "HHB2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(HHB2018, HHB2018$Cell04Ve, HHB2018$Cell04Vn, HHB2018$Cell04Vu, "HHB2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "HHB2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(HHB2018, HHB2018$Cell05Ve, HHB2018$Cell05Vn, HHB2018$Cell05Vu, "HHB2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "HHB2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(HHB2018, HHB2018$Cell06Ve, HHB2018$Cell06Vn, HHB2018$Cell06Vu, "HHB2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "HHB2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(HHB2018, HHB2018$Cell07Ve, HHB2018$Cell07Vn, HHB2018$Cell07Vu, "HHB2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "HHB2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(HHB2018, HHB2018$Cell08Ve, HHB2018$Cell08Vn, HHB2018$Cell08Vu, "HHB2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "HHB2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HHB2018, HHB2018$Cell09Ve, HHB2018$Cell09Vn, HHB2018$Cell09Vu, "HHB2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HHB2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HHB2018, HHB2018$Cell09Ve, HHB2018$Cell09Vn, HHB2018$Cell09Vu, "HHB2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HHB2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(HHB2018, HHB2018$Cell10Ve, HHB2018$Cell10Vn, HHB2018$Cell10Vu, "HHB2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "HHB2018Cell10Velocities.jpeg", width = 1200, height = 500)



# HTB 2018

IntegratedVelocities = adcpqaqc(HTB2018, HTB2018$VelocityE, HTB2018$VelocityN, HTB2018$VelocityU, "HTB2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "HTB2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(HTB2018, HTB2018$Cell01Ve, HTB2018$Cell01Vn, HTB2018$Cell01Vu, "HTB2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "HTB2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(HTB2018, HTB2018$Cell02Ve, HTB2018$Cell02Vn, HTB2018$Cell02Vu, "HTB2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "HTB2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(HTB2018, HTB2018$Cell03Ve, HTB2018$Cell03Vn, HTB2018$Cell03Vu, "HTB2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "HTB2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(HTB2018, HTB2018$Cell04Ve, HTB2018$Cell04Vn, HTB2018$Cell04Vu, "HTB2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "HTB2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(HTB2018, HTB2018$Cell05Ve, HTB2018$Cell05Vn, HTB2018$Cell05Vu, "HTB2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "HTB2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(HTB2018, HTB2018$Cell06Ve, HTB2018$Cell06Vn, HTB2018$Cell06Vu, "HTB2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "HTB2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(HTB2018, HTB2018$Cell07Ve, HTB2018$Cell07Vn, HTB2018$Cell07Vu, "HTB2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "HTB2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(HTB2018, HTB2018$Cell08Ve, HTB2018$Cell08Vn, HTB2018$Cell08Vu, "HTB2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "HTB2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HTB2018, HTB2018$Cell09Ve, HTB2018$Cell09Vn, HTB2018$Cell09Vu, "HTB2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HTB2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HTB2018, HTB2018$Cell09Ve, HTB2018$Cell09Vn, HTB2018$Cell09Vu, "HTB2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HTB2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(HTB2018, HTB2018$Cell10Ve, HTB2018$Cell10Vn, HTB2018$Cell10Vu, "HTB2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "HTB2018Cell10Velocities.jpeg", width = 1200, height = 500)


# MMC 2018

IntegratedVelocities = adcpqaqc(MMC2018, MMC2018$VelocityE, MMC2018$VelocityN, MMC2018$VelocityU, "MMC2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "MMC2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(MMC2018, MMC2018$Cell01Ve, MMC2018$Cell01Vn, MMC2018$Cell01Vu, "MMC2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "MMC2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(MMC2018, MMC2018$Cell02Ve, MMC2018$Cell02Vn, MMC2018$Cell02Vu, "MMC2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "MMC2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(MMC2018, MMC2018$Cell03Ve, MMC2018$Cell03Vn, MMC2018$Cell03Vu, "MMC2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "MMC2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(MMC2018, MMC2018$Cell04Ve, MMC2018$Cell04Vn, MMC2018$Cell04Vu, "MMC2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "MMC2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(MMC2018, MMC2018$Cell05Ve, MMC2018$Cell05Vn, MMC2018$Cell05Vu, "MMC2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "MMC2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(MMC2018, MMC2018$Cell06Ve, MMC2018$Cell06Vn, MMC2018$Cell06Vu, "MMC2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "MMC2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(MMC2018, MMC2018$Cell07Ve, MMC2018$Cell07Vn, MMC2018$Cell07Vu, "MMC2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "MMC2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(MMC2018, MMC2018$Cell08Ve, MMC2018$Cell08Vn, MMC2018$Cell08Vu, "MMC2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "MMC2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(MMC2018, MMC2018$Cell09Ve, MMC2018$Cell09Vn, MMC2018$Cell09Vu, "MMC2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "MMC2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(MMC2018, MMC2018$Cell09Ve, MMC2018$Cell09Vn, MMC2018$Cell09Vu, "MMC2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "MMC2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(MMC2018, MMC2018$Cell10Ve, MMC2018$Cell10Vn, MMC2018$Cell10Vu, "MMC2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "MMC2018Cell10Velocities.jpeg", width = 1200, height = 500)



# OIR 2018

IntegratedVelocities = adcpqaqc(OIR2018, OIR2018$VelocityE, OIR2018$VelocityN, OIR2018$VelocityU, "OIR2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "OIR2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(OIR2018, OIR2018$Cell01Ve, OIR2018$Cell01Vn, OIR2018$Cell01Vu, "OIR2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "OIR2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(OIR2018, OIR2018$Cell02Ve, OIR2018$Cell02Vn, OIR2018$Cell02Vu, "OIR2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "OIR2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(OIR2018, OIR2018$Cell03Ve, OIR2018$Cell03Vn, OIR2018$Cell03Vu, "OIR2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "OIR2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(OIR2018, OIR2018$Cell04Ve, OIR2018$Cell04Vn, OIR2018$Cell04Vu, "OIR2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "OIR2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(OIR2018, OIR2018$Cell05Ve, OIR2018$Cell05Vn, OIR2018$Cell05Vu, "OIR2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "OIR2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(OIR2018, OIR2018$Cell06Ve, OIR2018$Cell06Vn, OIR2018$Cell06Vu, "OIR2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "OIR2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(OIR2018, OIR2018$Cell07Ve, OIR2018$Cell07Vn, OIR2018$Cell07Vu, "OIR2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "OIR2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(OIR2018, OIR2018$Cell08Ve, OIR2018$Cell08Vn, OIR2018$Cell08Vu, "OIR2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "OIR2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OIR2018, OIR2018$Cell09Ve, OIR2018$Cell09Vn, OIR2018$Cell09Vu, "OIR2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OIR2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OIR2018, OIR2018$Cell09Ve, OIR2018$Cell09Vn, OIR2018$Cell09Vu, "OIR2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OIR2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(OIR2018, OIR2018$Cell10Ve, OIR2018$Cell10Vn, OIR2018$Cell10Vu, "OIR2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "OIR2018Cell10Velocities.jpeg", width = 1200, height = 500)



# OOL 2018

IntegratedVelocities = adcpqaqc(OOL2018, OOL2018$VelocityE, OOL2018$VelocityN, OOL2018$VelocityU, "OOL2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "OOL2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(OOL2018, OOL2018$Cell01Ve, OOL2018$Cell01Vn, OOL2018$Cell01Vu, "OOL2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "OOL2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(OOL2018, OOL2018$Cell02Ve, OOL2018$Cell02Vn, OOL2018$Cell02Vu, "OOL2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "OOL2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(OOL2018, OOL2018$Cell03Ve, OOL2018$Cell03Vn, OOL2018$Cell03Vu, "OOL2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "OOL2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(OOL2018, OOL2018$Cell04Ve, OOL2018$Cell04Vn, OOL2018$Cell04Vu, "OOL2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "OOL2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(OOL2018, OOL2018$Cell05Ve, OOL2018$Cell05Vn, OOL2018$Cell05Vu, "OOL2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "OOL2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(OOL2018, OOL2018$Cell06Ve, OOL2018$Cell06Vn, OOL2018$Cell06Vu, "OOL2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "OOL2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(OOL2018, OOL2018$Cell07Ve, OOL2018$Cell07Vn, OOL2018$Cell07Vu, "OOL2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "OOL2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(OOL2018, OOL2018$Cell08Ve, OOL2018$Cell08Vn, OOL2018$Cell08Vu, "OOL2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "OOL2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OOL2018, OOL2018$Cell09Ve, OOL2018$Cell09Vn, OOL2018$Cell09Vu, "OOL2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OOL2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OOL2018, OOL2018$Cell09Ve, OOL2018$Cell09Vn, OOL2018$Cell09Vu, "OOL2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OOL2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(OOL2018, OOL2018$Cell10Ve, OOL2018$Cell10Vn, OOL2018$Cell10Vu, "OOL2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "OOL2018Cell10Velocities.jpeg", width = 1200, height = 500)



# OSI 2018

IntegratedVelocities = adcpqaqc(OSI2018, OSI2018$VelocityE, OSI2018$VelocityN, OSI2018$VelocityU, "OSI2018 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "OSI2018IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(OSI2018, OSI2018$Cell01Ve, OSI2018$Cell01Vn, OSI2018$Cell01Vu, "OSI2018 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "OSI2018Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(OSI2018, OSI2018$Cell02Ve, OSI2018$Cell02Vn, OSI2018$Cell02Vu, "OSI2018 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "OSI2018Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(OSI2018, OSI2018$Cell03Ve, OSI2018$Cell03Vn, OSI2018$Cell03Vu, "OSI2018 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "OSI2018Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(OSI2018, OSI2018$Cell04Ve, OSI2018$Cell04Vn, OSI2018$Cell04Vu, "OSI2018 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "OSI2018Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(OSI2018, OSI2018$Cell05Ve, OSI2018$Cell05Vn, OSI2018$Cell05Vu, "OSI2018 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "OSI2018Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(OSI2018, OSI2018$Cell06Ve, OSI2018$Cell06Vn, OSI2018$Cell06Vu, "OSI2018 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "OSI2018Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(OSI2018, OSI2018$Cell07Ve, OSI2018$Cell07Vn, OSI2018$Cell07Vu, "OSI2018 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "OSI2018Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(OSI2018, OSI2018$Cell08Ve, OSI2018$Cell08Vn, OSI2018$Cell08Vu, "OSI2018 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "OSI2018Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OSI2018, OSI2018$Cell09Ve, OSI2018$Cell09Vn, OSI2018$Cell09Vu, "OSI2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OSI2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OSI2018, OSI2018$Cell09Ve, OSI2018$Cell09Vn, OSI2018$Cell09Vu, "OSI2018 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OSI2018Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(OSI2018, OSI2018$Cell10Ve, OSI2018$Cell10Vn, OSI2018$Cell10Vu, "OSI2018 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "OSI2018Cell10Velocities.jpeg", width = 1200, height = 500)


##### 2019 Plots #####



# EDE 2019

IntegratedVelocities = adcpqaqc(EDE2019, EDE2019$VelocityE, EDE2019$VelocityN, EDE2019$VelocityU, "EDE2019 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "EDE2019IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(EDE2019, EDE2019$Cell01Ve, EDE2019$Cell01Vn, EDE2019$Cell01Vu, "EDE2019 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "EDE2019Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(EDE2019, EDE2019$Cell02Ve, EDE2019$Cell02Vn, EDE2019$Cell02Vu, "EDE2019 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "EDE2019Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(EDE2019, EDE2019$Cell03Ve, EDE2019$Cell03Vn, EDE2019$Cell03Vu, "EDE2019 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "EDE2019Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(EDE2019, EDE2019$Cell04Ve, EDE2019$Cell04Vn, EDE2019$Cell04Vu, "EDE2019 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "EDE2019Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(EDE2019, EDE2019$Cell05Ve, EDE2019$Cell05Vn, EDE2019$Cell05Vu, "EDE2019 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "EDE2019Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(EDE2019, EDE2019$Cell06Ve, EDE2019$Cell06Vn, EDE2019$Cell06Vu, "EDE2019 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "EDE2019Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(EDE2019, EDE2019$Cell07Ve, EDE2019$Cell07Vn, EDE2019$Cell07Vu, "EDE2019 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "EDE2019Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(EDE2019, EDE2019$Cell08Ve, EDE2019$Cell08Vn, EDE2019$Cell08Vu, "EDE2019 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "EDE2019Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EDE2019, EDE2019$Cell09Ve, EDE2019$Cell09Vn, EDE2019$Cell09Vu, "EDE2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EDE2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EDE2019, EDE2019$Cell09Ve, EDE2019$Cell09Vn, EDE2019$Cell09Vu, "EDE2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EDE2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(EDE2019, EDE2019$Cell10Ve, EDE2019$Cell10Vn, EDE2019$Cell10Vu, "EDE2019 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "EDE2019Cell10Velocities.jpeg", width = 1200, height = 500)


# EDW 2019

IntegratedVelocities = adcpqaqc(EDW2019, EDW2019$VelocityE, EDW2019$VelocityN, EDW2019$VelocityU, "EDW2019 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "EDW2019IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(EDW2019, EDW2019$Cell01Ve, EDW2019$Cell01Vn, EDW2019$Cell01Vu, "EDW2019 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "EDW2019Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(EDW2019, EDW2019$Cell02Ve, EDW2019$Cell02Vn, EDW2019$Cell02Vu, "EDW2019 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "EDW2019Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(EDW2019, EDW2019$Cell03Ve, EDW2019$Cell03Vn, EDW2019$Cell03Vu, "EDW2019 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "EDW2019Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(EDW2019, EDW2019$Cell04Ve, EDW2019$Cell04Vn, EDW2019$Cell04Vu, "EDW2019 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "EDW2019Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(EDW2019, EDW2019$Cell05Ve, EDW2019$Cell05Vn, EDW2019$Cell05Vu, "EDW2019 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "EDW2019Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(EDW2019, EDW2019$Cell06Ve, EDW2019$Cell06Vn, EDW2019$Cell06Vu, "EDW2019 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "EDW2019Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(EDW2019, EDW2019$Cell07Ve, EDW2019$Cell07Vn, EDW2019$Cell07Vu, "EDW2019 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "EDW2019Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(EDW2019, EDW2019$Cell08Ve, EDW2019$Cell08Vn, EDW2019$Cell08Vu, "EDW2019 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "EDW2019Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EDW2019, EDW2019$Cell09Ve, EDW2019$Cell09Vn, EDW2019$Cell09Vu, "EDW2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EDW2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EDW2019, EDW2019$Cell09Ve, EDW2019$Cell09Vn, EDW2019$Cell09Vu, "EDW2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EDW2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(EDW2019, EDW2019$Cell10Ve, EDW2019$Cell10Vn, EDW2019$Cell10Vu, "EDW2019 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "EDW2019Cell10Velocities.jpeg", width = 1200, height = 500)


# MSB 2019

IntegratedVelocities = adcpqaqc(MSB2019, MSB2019$VelocityE, MSB2019$VelocityN, MSB2019$VelocityU, "MSB2019 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "MSB2019IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(MSB2019, MSB2019$Cell01Ve, MSB2019$Cell01Vn, MSB2019$Cell01Vu, "MSB2019 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "MSB2019Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(MSB2019, MSB2019$Cell02Ve, MSB2019$Cell02Vn, MSB2019$Cell02Vu, "MSB2019 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "MSB2019Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(MSB2019, MSB2019$Cell03Ve, MSB2019$Cell03Vn, MSB2019$Cell03Vu, "MSB2019 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "MSB2019Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(MSB2019, MSB2019$Cell04Ve, MSB2019$Cell04Vn, MSB2019$Cell04Vu, "MSB2019 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "MSB2019Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(MSB2019, MSB2019$Cell05Ve, MSB2019$Cell05Vn, MSB2019$Cell05Vu, "MSB2019 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "MSB2019Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(MSB2019, MSB2019$Cell06Ve, MSB2019$Cell06Vn, MSB2019$Cell06Vu, "MSB2019 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "MSB2019Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(MSB2019, MSB2019$Cell07Ve, MSB2019$Cell07Vn, MSB2019$Cell07Vu, "MSB2019 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "MSB2019Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(MSB2019, MSB2019$Cell08Ve, MSB2019$Cell08Vn, MSB2019$Cell08Vu, "MSB2019 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "MSB2019Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(MSB2019, MSB2019$Cell09Ve, MSB2019$Cell09Vn, MSB2019$Cell09Vu, "MSB2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "MSB2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(MSB2019, MSB2019$Cell09Ve, MSB2019$Cell09Vn, MSB2019$Cell09Vu, "MSB2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "MSB2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(MSB2019, MSB2019$Cell10Ve, MSB2019$Cell10Vn, MSB2019$Cell10Vu, "MSB2019 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "MSB2019Cell10Velocities.jpeg", width = 1200, height = 500)


# OSN 2019

IntegratedVelocities = adcpqaqc(OSN2019, OSN2019$VelocityE, OSN2019$VelocityN, OSN2019$VelocityU, "OSN2019 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "OSN2019IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(OSN2019, OSN2019$Cell01Ve, OSN2019$Cell01Vn, OSN2019$Cell01Vu, "OSN2019 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "OSN2019Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(OSN2019, OSN2019$Cell02Ve, OSN2019$Cell02Vn, OSN2019$Cell02Vu, "OSN2019 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "OSN2019Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(OSN2019, OSN2019$Cell03Ve, OSN2019$Cell03Vn, OSN2019$Cell03Vu, "OSN2019 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "OSN2019Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(OSN2019, OSN2019$Cell04Ve, OSN2019$Cell04Vn, OSN2019$Cell04Vu, "OSN2019 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "OSN2019Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(OSN2019, OSN2019$Cell05Ve, OSN2019$Cell05Vn, OSN2019$Cell05Vu, "OSN2019 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "OSN2019Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(OSN2019, OSN2019$Cell06Ve, OSN2019$Cell06Vn, OSN2019$Cell06Vu, "OSN2019 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "OSN2019Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(OSN2019, OSN2019$Cell07Ve, OSN2019$Cell07Vn, OSN2019$Cell07Vu, "OSN2019 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "OSN2019Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(OSN2019, OSN2019$Cell08Ve, OSN2019$Cell08Vn, OSN2019$Cell08Vu, "OSN2019 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "OSN2019Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OSN2019, OSN2019$Cell09Ve, OSN2019$Cell09Vn, OSN2019$Cell09Vu, "OSN2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OSN2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OSN2019, OSN2019$Cell09Ve, OSN2019$Cell09Vn, OSN2019$Cell09Vu, "OSN2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OSN2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(OSN2019, OSN2019$Cell10Ve, OSN2019$Cell10Vn, OSN2019$Cell10Vu, "OSN2019 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "OSN2019Cell10Velocities.jpeg", width = 1200, height = 500)


# OOL 2019

IntegratedVelocities = adcpqaqc(OOL2019, OOL2019$VelocityE, OOL2019$VelocityN, OOL2019$VelocityU, "OOL2019 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "OOL2019IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(OOL2019, OOL2019$Cell01Ve, OOL2019$Cell01Vn, OOL2019$Cell01Vu, "OOL2019 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "OOL2019Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(OOL2019, OOL2019$Cell02Ve, OOL2019$Cell02Vn, OOL2019$Cell02Vu, "OOL2019 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "OOL2019Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(OOL2019, OOL2019$Cell03Ve, OOL2019$Cell03Vn, OOL2019$Cell03Vu, "OOL2019 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "OOL2019Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(OOL2019, OOL2019$Cell04Ve, OOL2019$Cell04Vn, OOL2019$Cell04Vu, "OOL2019 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "OOL2019Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(OOL2019, OOL2019$Cell05Ve, OOL2019$Cell05Vn, OOL2019$Cell05Vu, "OOL2019 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "OOL2019Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(OOL2019, OOL2019$Cell06Ve, OOL2019$Cell06Vn, OOL2019$Cell06Vu, "OOL2019 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "OOL2019Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(OOL2019, OOL2019$Cell07Ve, OOL2019$Cell07Vn, OOL2019$Cell07Vu, "OOL2019 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "OOL2019Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(OOL2019, OOL2019$Cell08Ve, OOL2019$Cell08Vn, OOL2019$Cell08Vu, "OOL2019 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "OOL2019Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OOL2019, OOL2019$Cell09Ve, OOL2019$Cell09Vn, OOL2019$Cell09Vu, "OOL2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OOL2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(OOL2019, OOL2019$Cell09Ve, OOL2019$Cell09Vn, OOL2019$Cell09Vu, "OOL2019 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "OOL2019Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(OOL2019, OOL2019$Cell10Ve, OOL2019$Cell10Vn, OOL2019$Cell10Vu, "OOL2019 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "OOL2019Cell10Velocities.jpeg", width = 1200, height = 500)

}

adcpqaqc2()

