### ADCP processing ###

# Load required packages
library(readxl)
library(tidyverse)
library(ggpubr)

# Set working directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2021/ADCP/HAL")

# load in file
ADCP2021 = read_excel("ADCP 2021.xlsx",
                             sheet = "HAL_DEF004")

# numeric formatting
ADCP2021[, -c(1, 8)] = sapply(ADCP2021[, -c(1, 8)], as.numeric)

# Input code "ERR" for parameters affected by Tp (wave peak period) error code 256
for(i in 1:nrow(ADCP2021)) {
  if(ADCP2021$Tp[i] == 256) {
    ADCP2021$Hs[i] = "ERR"
    ADCP2021$Aband0[i] = "ERR"
    ADCP2021$Aband1[i] = "ERR"
    ADCP2021$Aband2[i] = "ERR"
    ADCP2021$Aband3[i] = "ERR"
    ADCP2021$Aband4[i] = "ERR"
    ADCP2021$Aband5[i] = "ERR"
    ADCP2021$Aband6[i] = "ERR"
    ADCP2021$Aband7[i] = "ERR"
    ADCP2021$Aband8[i] = "ERR"
    ADCP2021$Aband9[i] = "ERR"
    }
}

# Replace values with UNR if SNR < 7 counts
#UNRfunction = function(snr, vel) {
#  for(i in 1:nrow(ADCP2021)) {
 #               if(snr[i] <= 7) {
 #                 vel[i] = "UNR"
 #                  }
 #               }
#}
#UNRfunction(ADCP2021$Cell10SNR1, ADCP2021$Cell10Ve)

## function not working, do manually


# Replace velocity values with UNR if SNR <= 7 counts

for(i in 1:nrow(ADCP2021)) {
  #Cell01
  if(ADCP2021$Cell01SNR1[i] <= 7) {
    ADCP2021$Cell01Ve[i] = "UNR"
  }
  if(ADCP2021$Cell01SNR2[i] <= 7) {
    ADCP2021$Cell01Vn[i] = "UNR"
  }
  if(ADCP2021$Cell01SNR3[i] <= 7) {
    ADCP2021$Cell01Vu[i] = "UNR"
  }
  #Cell02
  if(ADCP2021$Cell02SNR1[i] <= 7) {
    ADCP2021$Cell02Ve[i] = "UNR"
  }
  if(ADCP2021$Cell02SNR2[i] <= 7) {
    ADCP2021$Cell02Vn[i] = "UNR"
  }
  if(ADCP2021$Cell02SNR3[i] <= 7) {
    ADCP2021$Cell02Vu[i] = "UNR"
  }
  #Cell03
  if(ADCP2021$Cell03SNR1[i] <= 7) {
    ADCP2021$Cell03Ve[i] = "UNR"
  }
  if(ADCP2021$Cell03SNR2[i] <= 7) {
    ADCP2021$Cell03Vn[i] = "UNR"
  }
  if(ADCP2021$Cell03SNR3[i] <= 7) {
    ADCP2021$Cell03Vu[i] = "UNR"
  }
  #Cell04
  if(ADCP2021$Cell04SNR1[i] <= 7) {
    ADCP2021$Cell04Ve[i] = "UNR"
  }
  if(ADCP2021$Cell04SNR2[i] <= 7) {
    ADCP2021$Cell04Vn[i] = "UNR"
  }
  if(ADCP2021$Cell04SNR3[i] <= 7) {
    ADCP2021$Cell04Vu[i] = "UNR"
  }
  #Cell05
  if(ADCP2021$Cell05SNR1[i] <= 7) {
    ADCP2021$Cell05Ve[i] = "UNR"
  }
  if(ADCP2021$Cell05SNR2[i] <= 7) {
    ADCP2021$Cell05Vn[i] = "UNR"
  }
  if(ADCP2021$Cell05SNR3[i] <= 7) {
    ADCP2021$Cell05Vu[i] = "UNR"
  }
  #Cell06
  if(ADCP2021$Cell06SNR1[i] <= 7) {
    ADCP2021$Cell06Ve[i] = "UNR"
  }
  if(ADCP2021$Cell06SNR2[i] <= 7) {
    ADCP2021$Cell06Vn[i] = "UNR"
  }
  if(ADCP2021$Cell06SNR3[i] <= 7) {
    ADCP2021$Cell06Vu[i] = "UNR"
  }
  #Cell07
  if(ADCP2021$Cell07SNR1[i] <= 7) {
    ADCP2021$Cell07Ve[i] = "UNR"
  }
  if(ADCP2021$Cell07SNR2[i] <= 7) {
    ADCP2021$Cell07Vn[i] = "UNR"
  }
  if(ADCP2021$Cell07SNR3[i] <= 7) {
    ADCP2021$Cell07Vu[i] = "UNR"
  }
  #Cell08
  if(ADCP2021$Cell08SNR1[i] <= 7) {
    ADCP2021$Cell08Ve[i] = "UNR"
  }
  if(ADCP2021$Cell08SNR2[i] <= 7) {
    ADCP2021$Cell08Vn[i] = "UNR"
  }
  if(ADCP2021$Cell08SNR3[i] <= 7) {
    ADCP2021$Cell08Vu[i] = "UNR"
  }
  #Cell09
  if(ADCP2021$Cell09SNR1[i] <= 7) {
    ADCP2021$Cell09Ve[i] = "UNR"
  }
  if(ADCP2021$Cell09SNR2[i] <= 7) {
    ADCP2021$Cell09Vn[i] = "UNR"
  }
  if(ADCP2021$Cell09SNR3[i] <= 7) {
    ADCP2021$Cell09Vu[i] = "UNR"
  }
  #Cell10
  if(ADCP2021$Cell10SNR1[i] <= 7) {
    ADCP2021$Cell10Ve[i] = "UNR"
  }
  if(ADCP2021$Cell10SNR2[i] <= 7) {
    ADCP2021$Cell10Vn[i] = "UNR"
  }
  if(ADCP2021$Cell10SNR3[i] <= 7) {
    ADCP2021$Cell10Vu[i] = "UNR"
  }
  }

# export file
write.csv(ADCP2021, "ADCP2021v2.csv", row.names=FALSE)


## PLOTTING for QAQC ##

## formatting

ADCP2021$DateTime = as.POSIXct(ADCP2021$DateTime, format = "%Y-%m-%d %H:%M:%S", origin = "1970-01-01", tz = "UTC")

ADCP2021 = add_column(ADCP2021, Date = paste(ADCP2021$Year, 
                                             ADCP2021$Month, 
                                             ADCP2021$Day, sep = "-",
                                                        collapse = NULL), .before = "Month")
ADCP2021 <- add_column(ADCP2021, Time = paste(ADCP2021$Hour, 
                                              ADCP2021$Minute, sep = ":",
                                                        collapse = NULL), .before = "DateTime")
ADCP2021$Date <- as.Date(ADCP2021$Date)
#ADCP2021 <- subset(ADCP2021, select = -c(4:7))

ADCP2021$DateTime <- as.POSIXct(ADCP2021$DateTime, 
                                     format = "%Y-%m-%d %H:%M:%S",
                                     origin = "1970-01-01",
                                     tz = "Etc/GMT+5")


# make columns numeric to be able to plot. UNR/ERR are changed to NA for plotting purposes. 
ADCP2021[, -c(1, 3, 9:10)] = sapply(ADCP2021[, -c(1, 3, 9:10)], as.numeric)


## Original plot code that goes into function

ggplot(ADCP2021, aes(x = DateTime)) +
  geom_line(aes(y = VelocityE, colour = "VelocityE")) +
  geom_line(aes(y = VelocityN, colour = "VelocityN")) +
  geom_line(aes(y = VelocityU, colour = "VelocityU")) +
  labs(title = "HAL 2021",
       x = "DateTime",
       y = "Velocity (cm/s)") +
  scale_color_manual("", 
                     breaks = c("VelocityE", "VelocityN", "VelocityU"),
                     values = c("lightseagreen", "tomato", "black"))


## function to include all velocities

adcpqaqc2 = function(){  

adcpqaqc = function(y1, y2, y3, name) {
    ggplot(ADCP2021, aes(x = DateTime)) +
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

IntegratedVelocities = adcpqaqc(ADCP2021$VelocityE, ADCP2021$VelocityN, ADCP2021$VelocityU, "HAL 2021 Integrated Velocities")
ggexport(IntegratedVelocities, filename = "IntegratedVelocities.jpeg", width = 1200, height = 500)

Cell01Velocities = adcpqaqc(ADCP2021$Cell01Ve, ADCP2021$Cell01Vn, ADCP2021$Cell01Vu, "HAL 2021 Cell01 Velocities")
ggexport(Cell01Velocities, filename = "Cell01Velocities.jpeg", width = 1200, height = 500)

Cell02Velocities = adcpqaqc(ADCP2021$Cell02Ve, ADCP2021$Cell02Vn, ADCP2021$Cell02Vu, "HAL 2021 Cell02 Velocities")
ggexport(Cell02Velocities, filename = "Cell02Velocities.jpeg", width = 1200, height = 500)

Cell03Velocities = adcpqaqc(ADCP2021$Cell03Ve, ADCP2021$Cell03Vn, ADCP2021$Cell03Vu, "HAL 2021 Cell03 Velocities")
ggexport(Cell03Velocities, filename = "Cell03Velocities.jpeg", width = 1200, height = 500)

Cell04Velocities = adcpqaqc(ADCP2021$Cell04Ve, ADCP2021$Cell04Vn, ADCP2021$Cell04Vu, "HAL 2021 Cell04 Velocities")
ggexport(Cell04Velocities, filename = "Cell04Velocities.jpeg", width = 1200, height = 500)

Cell05Velocities = adcpqaqc(ADCP2021$Cell05Ve, ADCP2021$Cell05Vn, ADCP2021$Cell05Vu, "HAL 2021 Cell05 Velocities")
ggexport(Cell05Velocities, filename = "Cell05Velocities.jpeg", width = 1200, height = 500)

Cell06Velocities = adcpqaqc(ADCP2021$Cell06Ve, ADCP2021$Cell06Vn, ADCP2021$Cell06Vu, "HAL 2021 Cell06 Velocities")
ggexport(Cell06Velocities, filename = "Cell06Velocities.jpeg", width = 1200, height = 500)

Cell07Velocities = adcpqaqc(ADCP2021$Cell07Ve, ADCP2021$Cell07Vn, ADCP2021$Cell07Vu, "HAL 2021 Cell07 Velocities")
ggexport(Cell07Velocities, filename = "Cell07Velocities.jpeg", width = 1200, height = 500)

Cell08Velocities = adcpqaqc(ADCP2021$Cell08Ve, ADCP2021$Cell08Vn, ADCP2021$Cell08Vu, "HAL 2021 Cell08 Velocities")
ggexport(Cell08Velocities, filename = "Cell08Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(ADCP2021$Cell09Ve, ADCP2021$Cell09Vn, ADCP2021$Cell09Vu, "HAL 2021 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "Cell09Velocities.jpeg", width = 1200, height = 500)

Cell09Velocities = adcpqaqc(ADCP2021$Cell09Ve, ADCP2021$Cell09Vn, ADCP2021$Cell09Vu, "HAL 2021 Cell09 Velocities")
ggexport(Cell09Velocities, filename = "Cell09Velocities.jpeg", width = 1200, height = 500)

Cell10Velocities = adcpqaqc(ADCP2021$Cell10Ve, ADCP2021$Cell10Vn, ADCP2021$Cell10Vu, "HAL 2021 Cell10 Velocities")
ggexport(Cell10Velocities, filename = "Cell10Velocities.jpeg", width = 1200, height = 500)

}

adcpqaqc2()
