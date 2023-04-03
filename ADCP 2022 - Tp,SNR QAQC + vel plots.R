### ADCP processing ###

# Load required packages
library(readxl)
library(tidyverse)
library(ggpubr)

# Set working directory 
# **adjust for year
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2022/ADCP")

# load in file
# ** adjust file name for year
ADCP = read_excel("ADCP 2022.xlsx",
                             sheet = "ADCP")

# numeric formatting
ADCP[, -c(1:5)] = sapply(ADCP[, -c(1:5)], as.numeric)

# Input code "NA" for parameters affected by Tp (wave peak period) error code 256
for(i in 1:nrow(ADCP)) {
  if(ADCP$Tp[i] == 256) {
    ADCP$Hs[i] = "NA"
    ADCP$Aband0[i] = "NA"
    ADCP$Aband1[i] = "NA"
    ADCP$Aband2[i] = "NA"
    ADCP$Aband3[i] = "NA"
    ADCP$Aband4[i] = "NA"
    ADCP$Aband5[i] = "NA"
    ADCP$Aband6[i] = "NA"
    ADCP$Aband7[i] = "NA"
    ADCP$Aband8[i] = "NA"
    ADCP$Aband9[i] = "NA"
    }
}

# Replace velocity values with NA if SNR <= 7 counts

for(i in 1:nrow(ADCP)) {
  #Overall
  if(ADCP$SNR1[i] <= 7) {
    ADCP$VelocityE[i] = "NA"
  }
  if(ADCP$SNR2[i] <= 7) {
    ADCP$VelocityN[i] = "NA"
  }
  if(ADCP$SNR3[i] <= 7) {
    ADCP$VelocityU[i] = "NA"
  }
  #Overall Speed adjustment
  if(ADCP$SNR1[i] <= 7 || ADCP$SNR2[i] <= 7 || ADCP$SNR3[i] <= 7) {
    ADCP$Speed[i] = "NA"
    ADCP$Direction[i] = "NA"
  }
  #Cell01
  if(ADCP$Cell01SNR1[i] <= 7) {
    ADCP$Cell01Ve[i] = "NA"
  }
  if(ADCP$Cell01SNR2[i] <= 7) {
    ADCP$Cell01Vn[i] = "NA"
  }
  if(ADCP$Cell01SNR3[i] <= 7) {
    ADCP$Cell01Vu[i] = "NA"
  }
  if(ADCP$Cell01SNR1[i] <= 7 || ADCP$Cell01SNR2[i] <= 7 || ADCP$Cell01SNR3[i] <= 7) {
    ADCP$Cell01Spd[i] = "NA"
    ADCP$Cell01Dir[i] = "NA"
  }
  #Cell02
  if(ADCP$Cell02SNR1[i] <= 7) {
    ADCP$Cell02Ve[i] = "NA"
  }
  if(ADCP$Cell02SNR2[i] <= 7) {
    ADCP$Cell02Vn[i] = "NA"
  }
  if(ADCP$Cell02SNR3[i] <= 7) {
    ADCP$Cell02Vu[i] = "NA"
  }
  if(ADCP$Cell02SNR1[i] <= 7 || ADCP$Cell02SNR2[i] <= 7 || ADCP$Cell02SNR3[i] <= 7) {
    ADCP$Cell02Spd[i] = "NA"
    ADCP$Cell02Dir[i] = "NA"
  }
  #Cell03
  if(ADCP$Cell03SNR1[i] <= 7) {
    ADCP$Cell03Ve[i] = "NA"
  }
  if(ADCP$Cell03SNR2[i] <= 7) {
    ADCP$Cell03Vn[i] = "NA"
  }
  if(ADCP$Cell03SNR3[i] <= 7) {
    ADCP$Cell03Vu[i] = "NA"
  }
  if(ADCP$Cell03SNR1[i] <= 7 || ADCP$Cell03SNR2[i] <= 7 || ADCP$Cell03SNR3[i] <= 7) {
    ADCP$Cell03Spd[i] = "NA"
    ADCP$Cell03Dir[i] = "NA"
  }
  #Cell04
  if(ADCP$Cell04SNR1[i] <= 7) {
    ADCP$Cell04Ve[i] = "NA"
  }
  if(ADCP$Cell04SNR2[i] <= 7) {
    ADCP$Cell04Vn[i] = "NA"
  }
  if(ADCP$Cell04SNR3[i] <= 7) {
    ADCP$Cell04Vu[i] = "NA"
  }
  if(ADCP$Cell04SNR1[i] <= 7 || ADCP$Cell04SNR2[i] <= 7 || ADCP$Cell04SNR3[i] <= 7) {
    ADCP$Cell04Spd[i] = "NA"
    ADCP$Cell04Dir[i] = "NA"
  }
  #Cell05
  if(ADCP$Cell05SNR1[i] <= 7) {
    ADCP$Cell05Ve[i] = "NA"
  }
  if(ADCP$Cell05SNR2[i] <= 7) {
    ADCP$Cell05Vn[i] = "NA"
  }
  if(ADCP$Cell05SNR3[i] <= 7) {
    ADCP$Cell05Vu[i] = "NA"
  }
  if(ADCP$Cell05SNR1[i] <= 7 || ADCP$Cell05SNR2[i] <= 7 || ADCP$Cell05SNR3[i] <= 7) {
    ADCP$Cell05Spd[i] = "NA"
    ADCP$Cell05Dir[i] = "NA"
  }
  #Cell06
  if(ADCP$Cell06SNR1[i] <= 7) {
    ADCP$Cell06Ve[i] = "NA"
  }
  if(ADCP$Cell06SNR2[i] <= 7) {
    ADCP$Cell06Vn[i] = "NA"
  }
  if(ADCP$Cell06SNR3[i] <= 7) {
    ADCP$Cell06Vu[i] = "NA"
  }
  if(ADCP$Cell06SNR1[i] <= 7 || ADCP$Cell06SNR2[i] <= 7 || ADCP$Cell06SNR3[i] <= 7) {
    ADCP$Cell06Spd[i] = "NA"
    ADCP$Cell06Dir[i] = "NA"
  }
  #Cell07
  if(ADCP$Cell07SNR1[i] <= 7) {
    ADCP$Cell07Ve[i] = "NA"
  }
  if(ADCP$Cell07SNR2[i] <= 7) {
    ADCP$Cell07Vn[i] = "NA"
  }
  if(ADCP$Cell07SNR3[i] <= 7) {
    ADCP$Cell07Vu[i] = "NA"
  }
  if(ADCP$Cell07SNR1[i] <= 7 || ADCP$Cell07SNR2[i] <= 7 || ADCP$Cell07SNR3[i] <= 7) {
    ADCP$Cell07Spd[i] = "NA"
    ADCP$Cell07Dir[i] = "NA"
  }
  #Cell08
  if(ADCP$Cell08SNR1[i] <= 7) {
    ADCP$Cell08Ve[i] = "NA"
  }
  if(ADCP$Cell08SNR2[i] <= 7) {
    ADCP$Cell08Vn[i] = "NA"
  }
  if(ADCP$Cell08SNR3[i] <= 7) {
    ADCP$Cell08Vu[i] = "NA"
  }
  if(ADCP$Cell08SNR1[i] <= 7 || ADCP$Cell08SNR2[i] <= 7 || ADCP$Cell08SNR3[i] <= 7) {
    ADCP$Cell08Spd[i] = "NA"
    ADCP$Cell08Dir[i] = "NA"
  }
  #Cell09
  if(ADCP$Cell09SNR1[i] <= 7) {
    ADCP$Cell09Ve[i] = "NA"
  }
  if(ADCP$Cell09SNR2[i] <= 7) {
    ADCP$Cell09Vn[i] = "NA"
  }
  if(ADCP$Cell09SNR3[i] <= 7) {
    ADCP$Cell09Vu[i] = "NA"
  }
  if(ADCP$Cell09SNR1[i] <= 7 || ADCP$Cell09SNR2[i] <= 7 || ADCP$Cell09SNR3[i] <= 7) {
    ADCP$Cell09Spd[i] = "NA"
    ADCP$Cell09Dir[i] = "NA"
  }
  #Cell10
  if(ADCP$Cell10SNR1[i] <= 7) {
    ADCP$Cell10Ve[i] = "NA"
  }
  if(ADCP$Cell10SNR2[i] <= 7) {
    ADCP$Cell10Vn[i] = "NA"
  }
  if(ADCP$Cell10SNR3[i] <= 7) {
    ADCP$Cell10Vu[i] = "NA"
  }
  if(ADCP$Cell10SNR1[i] <= 7 || ADCP$Cell10SNR2[i] <= 7 || ADCP$Cell10SNR3[i] <= 7) {
    ADCP$Cell10Spd[i] = "NA"
    ADCP$Cell10Dir[i] = "NA"
  }
}

# export file
write.csv(ADCP, "ADCP2022v2.csv", row.names=FALSE)


## Plotting VELOCITY for QAQC ##

## formatting


# formatting DateTime column 
ADCP$DateTime = as.POSIXct(ADCP$DateTime, format = "%Y-%m-%d %H:%M:%S", origin = "1970-01-01", tz = "UTC")

# make columns numeric to be able to plot.
ADCP[, -c(1:5)] = sapply(ADCP[, -c(1:5)], as.numeric)

# subset years dfs by transect
EEP = subset(ADCP, Transect == "EEP")
HAL = subset(ADCP, Transect == "HAL")


## function to plot all velocities

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

# HAL 

IntegratedVelocities = adcpqaqc(HAL, HAL$VelocityE, HAL$VelocityN, HAL$VelocityU, "HAL 2022 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "HALIntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(HAL, HAL$Cell01Ve, HAL$Cell01Vn, HAL$Cell01Vu, "HAL 2022 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "HALCell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(HAL, HAL$Cell02Ve, HAL$Cell02Vn, HAL$Cell02Vu, "HAL 2022 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "HALCell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(HAL, HAL$Cell03Ve, HAL$Cell03Vn, HAL$Cell03Vu, "HAL 2022 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "HALCell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(HAL, HAL$Cell04Ve, HAL$Cell04Vn, HAL$Cell04Vu, "HAL 2022 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "HALCell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(HAL, HAL$Cell05Ve, HAL$Cell05Vn, HAL$Cell05Vu, "HAL 2022 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "HALCell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(HAL, HAL$Cell06Ve, HAL$Cell06Vn, HAL$Cell06Vu, "HAL 2022 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "HALCell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(HAL, HAL$Cell07Ve, HAL$Cell07Vn, HAL$Cell07Vu, "HAL 2022 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "HALCell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(HAL, HAL$Cell08Ve, HAL$Cell08Vn, HAL$Cell08Vu, "HAL 2022 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "HALCell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HAL, HAL$Cell09Ve, HAL$Cell09Vn, HAL$Cell09Vu, "HAL 2022 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HALCell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(HAL, HAL$Cell09Ve, HAL$Cell09Vn, HAL$Cell09Vu, "HAL 2022 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "HALCell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(HAL, HAL$Cell10Ve, HAL$Cell10Vn, HAL$Cell10Vu, "HAL 2022 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "HALCell10Velocities.jpeg", width = 1200, height = 500)


# EEP

IntegratedVelocities = adcpqaqc(EEP, EEP$VelocityE, EEP$VelocityN, EEP$VelocityU, "EEP 2022 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "EEPIntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(EEP, EEP$Cell01Ve, EEP$Cell01Vn, EEP$Cell01Vu, "EEP 2022 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "EEPCell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(EEP, EEP$Cell02Ve, EEP$Cell02Vn, EEP$Cell02Vu, "EEP 2022 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "EEPCell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(EEP, EEP$Cell03Ve, EEP$Cell03Vn, EEP$Cell03Vu, "EEP 2022 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "EEPCell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(EEP, EEP$Cell04Ve, EEP$Cell04Vn, EEP$Cell04Vu, "EEP 2022 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "EEPCell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(EEP, EEP$Cell05Ve, EEP$Cell05Vn, EEP$Cell05Vu, "EEP 2022 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "EEPCell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(EEP, EEP$Cell06Ve, EEP$Cell06Vn, EEP$Cell06Vu, "EEP 2022 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "EEPCell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(EEP, EEP$Cell07Ve, EEP$Cell07Vn, EEP$Cell07Vu, "EEP 2022 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "EEPCell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(EEP, EEP$Cell08Ve, EEP$Cell08Vn, EEP$Cell08Vu, "EEP 2022 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "EEPCell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EEP, EEP$Cell09Ve, EEP$Cell09Vn, EEP$Cell09Vu, "EEP 2022 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EEPCell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(EEP, EEP$Cell09Ve, EEP$Cell09Vn, EEP$Cell09Vu, "EEP 2022 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "EEPCell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(EEP, EEP$Cell10Ve, EEP$Cell10Vn, EEP$Cell10Vu, "EEP 2022 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "EEPCell10Velocities.jpeg", width = 1200, height = 500)

}

adcpqaqc2()
