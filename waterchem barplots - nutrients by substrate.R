## WaterChem - differences between parameters across varying bottom substrates ##

# Load packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readxl)

# Set Working Directory
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora
        /Analysis/Data Summaries/WaterChemNutrientsBySubstrate")


##### 2020 #####

# Import WaterChem2020 file
waterchem20 <- read_excel("WaterChem2020.xlsx", 
                        sheet = "WaterChem2020")

# Rename TP_UMESC column to TP
waterchem20 = waterchem20 %>% dplyr::rename(TP = TP_UMESC)

# Change BDLs to 0
waterchem20$TP [waterchem20$TP == "BDL"]<-0
waterchem20$SRP [waterchem20$SRP == "BDL"]<-0
waterchem20$Ammonia [waterchem20$Ammonia == "BDL"]<-0
waterchem20$AmmoniaOrganicN [waterchem20$AmmoniaOrganicN == "BDL"]<-0
waterchem20$TSS [waterchem20$TSS == "BDL"]<-0

# Format column types
waterchem20$TP <- as.numeric(waterchem20$TP)
waterchem20$SRP <- as.numeric(waterchem20$SRP)
waterchem20$Ammonia <- as.numeric(waterchem20$Ammonia)
waterchem20$AmmoniaOrganicN <- as.numeric(waterchem20$AmmoniaOrganicN)
waterchem20$TSS <- as.numeric(waterchem20$TSS)
waterchem20$Depth.Type <- as.factor(waterchem20$Depth.Type)
waterchem20$Chl <- as.numeric(waterchem20$Chl, na.rm = TRUE)
waterchem20$Pheo <- as.numeric(waterchem20$Pheo, na.rm = TRUE)

# Filter for bottom substrate types B & CD (from column Depth.Type)
waterchemB20 = filter(waterchem20, Depth.Type != "1m")

# Dplyr reorg - find mean of each B type
waterchemBavg20 = waterchemB20 %>%
  dplyr::group_by(Transect, Station, Date, Depth.Type) %>%
  dplyr::summarise(
    # Mean
    TP.avg = mean(TP), SRP.avg = mean(SRP), TN.avg = mean(TN), Ammonia.avg = mean(Ammonia),
    AmmoniaOrganicN.avg = mean(AmmoniaOrganicN), NOx.avg = mean(NOx),TSS.avg = mean(TSS),
    Chloride.avg = mean(Chloride), Fluoride.avg = mean(Fluoride), Silica.avg = mean(Silica),
    Sulfate.avg = mean(Sulfate), Chl.avg = mean(Chl, na.rm = TRUE), 
    Pheo.avg = mean(Pheo, na.rm = TRUE),
    # Standard Error
    TP.SE = sd(TP)/sqrt(length(TP)), SRP.SE = sd(SRP)/sqrt(length(SRP)), 
    TN.SE = sd(TN)/sqrt(length(TN)), Ammonia.SE = sd(Ammonia)/sqrt(length(Ammonia)),
    AmmoniaOrganicN.SE = sd(AmmoniaOrganicN)/sqrt(length(AmmoniaOrganicN)),
    NOx.SE = sd(NOx)/sqrt(length(NOx)), TSS.SE = sd(TSS)/sqrt(length(TSS)),
    Chloride.SE = sd(Chloride)/sqrt(length(Chloride)), 
    Fluoride.SE = sd(Fluoride)/sqrt(length(Fluoride)), 
    Silica.SE = sd(Silica)/sqrt(length(Silica)), Sulfate.SE = sd(Sulfate)/sqrt(length(Sulfate)),
    Chl.SE = sd(Chl, na.rm = TRUE)/sqrt(length(Chl)), 
    Pheo.SE = sd(Pheo, na.rm = TRUE)/sqrt(length(Pheo))
  ) 



## PLOTS ##

# TP
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = TP.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ TP (mg/L) \nat 0.1 m above bottom", size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.005)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                   expression(paste(italic("Cladophora"), " + dreissenid bed"))))
  
# TN
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = TN.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=TN.avg - TN.SE, ymax = TN.avg + TN.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ TN (mg/L) \nat 0.1 m above bottom", size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.5)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " + dreissenid bed"))))

# Ammonia
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = Ammonia.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=Ammonia.avg - Ammonia.SE, ymax = Ammonia.avg + Ammonia.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ Ammonia (mg/L) \nat 0.1 m above bottom", 
       size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.025)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " + dreissenid bed"))))

# Ammonia + Organic N
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = AmmoniaOrganicN.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=AmmoniaOrganicN.avg - AmmoniaOrganicN.SE, 
                    ymax = AmmoniaOrganicN.avg + AmmoniaOrganicN.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ Ammonia + \nOrganic N (mg/L) 
       at 0.1 m above bottom", size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.31)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " + dreissenid bed"))))

# NOx
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = NOx.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=NOx.avg - NOx.SE, ymax = NOx.avg + NOx.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ NOx (mg/L) \nat 0.1 m above bottom", size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.22)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " + dreissenid bed"))))

# Chl
ggplot(data = waterchemBavg20, aes(x = Depth.Type, y = Chl.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","orange2")) + 
  geom_errorbar(aes(ymin=Chl.avg - Chl.SE, ymax = Chl.avg + Chl.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type", y="Average in-situ chlorophyll (mg/L) \nat 0.1 m above bottom", size = 18) + 
  scale_y_continuous(expand=c(0,0), limits=c(0,2.5)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " + dreissenid bed"))))


##### 2021 #####

# Import WaterChem2020 file
waterchem21 <- read_excel("WaterChem2021.xlsx", 
                          sheet = "WaterChem2021")

# Rename TP_UMESC column to TP
waterchem21 = waterchem21 %>% dplyr::rename(TP = TP_UMESC)

# Change BDLs to 0
waterchem21$TP [waterchem21$TP == "BDL"]<-0
waterchem21$SRP [waterchem21$SRP == "BDL"]<-0
waterchem21$Ammonia [waterchem21$Ammonia == "BDL"]<-0
waterchem21$AmmoniaOrganicN [waterchem21$AmmoniaOrganicN == "BDL"]<-0
waterchem21$TSS [waterchem21$TSS == "BDL"]<-0

# Format column types
waterchem21$TP <- as.numeric(waterchem21$TP)
waterchem21$SRP <- as.numeric(waterchem21$SRP)
waterchem21$Ammonia <- as.numeric(waterchem21$Ammonia)
waterchem21$AmmoniaOrganicN <- as.numeric(waterchem21$AmmoniaOrganicN)
waterchem21$TSS <- as.numeric(waterchem21$TSS)
waterchem21$Depth.Type <- as.factor(waterchem21$Depth.Type)
waterchem21$Chl <- as.numeric(waterchem21$Chl, na.rm = TRUE)
waterchem21$Pheo <- as.numeric(waterchem21$Pheo, na.rm = TRUE)

# Filter for bottom substrate types B & CD (from column Depth.Type)
waterchemB21 = filter(waterchem21, Depth.Type != "1m")

# Dplyr reorg - find mean of each B type
waterchemBavg21 = waterchemB21 %>%
  dplyr::group_by(Transect, Station, Month, Date, Depth.Type) %>%
  dplyr::summarise( count = n(),
    # Mean
    TP.avg = mean(TP), SRP.avg = mean(SRP),
    # Standard Error
    TP.SE = sd(TP)/sqrt(length(TP)), SRP.SE = sd(SRP)/sqrt(length(SRP))
  ) 

##### Plots for 1 location, all conditions #####

## Create new dataframes for each time and place of sampling

# MSB July
WC21MSBJuly = filter(waterchemBavg21, Transect == "MSB")

# MWA August
WC21MWAAug = filter(waterchemBavg21, Transect == "MWA")
WC21MWAAug = filter(WC21MWAAug, Month != "July")


## TP ##

## WC21MSBJuly
ggplot(data = WC21MSBJuly, aes(x = Depth.Type, y = TP.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3", "olivedrab4", "orange2")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type",
       y="Average in-situ TP (mg/L) \nat 0.1 m above bottom",
       title = "TP at Lake Michigan, Sleeping Bear - July 2021") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.005)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " bed")),
                              expression(paste(italic("Cladophora"), " + dreissenid bed")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## WC21MWAAugust
ggplot(data = WC21MWAAug, aes(x = Depth.Type, y = TP.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","olivedrab4", "orange2")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type",
       y="Average in-situ TP (mg/L) \nat 0.1 m above bottom",
       title = "TP at Lake Michigan, Waukegan - August 2021") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.010)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " bed")),
                              expression(paste(italic("Cladophora"), " + dreissenid bed")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.



## SRP ##


## WC21MSBJuly
ggplot(data = WC21MSBJuly, aes(x = Depth.Type, y = SRP.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3","olivedrab4","orange2")) + 
  geom_errorbar(aes(ymin=SRP.avg - SRP.SE, ymax = SRP.avg + SRP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type",
       y="Average in-situ SRP (mg/L) \nat 0.1 m above bottom",
       title = "SRP at Lake Michigan, Sleeping Bear - July 2021") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.004)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " bed")),
                              expression(paste(italic("Cladophora"), " + dreissenid bed")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## WC21MWAAugust
ggplot(data = WC21MWAAug, aes(x = Depth.Type, y = SRP.avg, fill = Depth.Type)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("orangered3", "olivedrab4", "orange2")) + 
  geom_errorbar(aes(ymin=SRP.avg - SRP.SE, ymax = SRP.avg + SRP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Substrate Type",
       y="Average in-situ SRP (mg/L) \nat 0.1 m above bottom",
       title = "SRP at Lake Michigan, Waukegan - August 2021") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.006)) +
  scale_x_discrete(labels = c(expression(paste("Bare substrate")), 
                              expression(paste(italic("Cladophora"), " bed")),
                              expression(paste(italic("Cladophora"), " + dreissenid bed")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.




##### Make plots with same condition from different transects #####

## Bare substrate ##
baresubstrate = filter(waterchemBavg21, Depth.Type == "B")

## TP
ggplot(data = baresubstrate, aes(x = Transect, y = TP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ TP (mg/L) \nat 0.1 m above bottom",
       title = "TP over bare substrate across locations") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.005)) +
  scale_x_discrete(labels = c(expression(paste("EEP")), 
                              expression(paste("MSB")),
                              expression(paste("MWA")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## SRP
ggplot(data = baresubstrate, aes(x = Transect, y = SRP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=SRP.avg - SRP.SE, ymax = SRP.avg + SRP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ SRP (mg/L) \nat 0.1 m above bottom",
       title = "SRP over bare substrate across locations") + 
  scale_y_continuous(expand=c(0,0), limits=c(0,0.005)) +
  scale_x_discrete(labels = c(expression(paste("EEP")), 
                              expression(paste("MSB")),
                              expression(paste("MWA")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## Cladophora bed ##
cladophorabed = filter(waterchemBavg21, Depth.Type == "C")


## TP
ggplot(data = cladophorabed, aes(x = Transect, y = TP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey","darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ TP (mg/L) \nat 0.1 m above bottom",
       title = c(expression(paste("TP over a ", italic("Cladophora"), " bed across locations")))) +
  scale_y_continuous(expand=c(0,0), limits=c(0,0.005)) +
  scale_x_discrete(labels = c(expression(paste("EDE")), 
                              expression(paste("HAL")),
                              expression(paste("MSB")),
                              expression(paste("MWA")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## SRP
ggplot(data = cladophorabed, aes(x = Transect, y = SRP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey","darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=SRP.avg - SRP.SE, ymax = SRP.avg + SRP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ SRP (mg/L) \nat 0.1 m above bottom",
       title = c(expression(paste("SRP over a ", italic("Cladophora"), " bed across locations")))) +
  scale_y_continuous(expand=c(0,0), limits=c(0,0.006)) +
  scale_x_discrete(labels = c(expression(paste("EDE")), 
                              expression(paste("HAL")),
                              expression(paste("MSB")),
                              expression(paste("MWA")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.




## Cladophora + Dreissenid bed ##

# Dplyr reorg - average all transects despite date/month
wcBavg_again = waterchemB21 %>%
  dplyr::group_by(Transect, Station, Depth.Type) %>%
  dplyr::summarise( count = n(),
                    # Mean
                    TP.avg = mean(TP), SRP.avg = mean(SRP),
                    # Standard Error
                    TP.SE = sd(TP)/sqrt(length(TP)), SRP.SE = sd(SRP)/sqrt(length(SRP))
  ) 

claddreiss = filter(wcBavg_again, Depth.Type == "CD")

## Order transects by location for legend
claddreiss$Transect = factor(claddreiss$Transect, 
                                levels = c("MWA", "MSB", "HHB", 
                                           "HAL", "EDE", "EEP", 
                                           "OIR", "OOL"))


## TP
ggplot(data = claddreiss, aes(x = Transect, y = TP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey","darkslategrey", "darkslategrey", "darkslategrey",
                               "darkslategrey","darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=TP.avg - TP.SE, ymax = TP.avg + TP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ TP (mg/L) \nat 0.1 m above bottom",
       title = c(expression(paste("TP over a ", italic("Cladophora"), " + dreissenid bed across locations")))) +
  scale_y_continuous(expand=c(0,0), limits=c(0,0.010)) +
  scale_x_discrete(labels = c(expression(paste("MWA")), 
                              expression(paste("MSB")),
                              expression(paste("HHB")),
                              expression(paste("HAL")), 
                              expression(paste("EDE")),
                              expression(paste("EEP")),
                              expression(paste("OIR")),
                              expression(paste("OOL")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.


## SRP
ggplot(data = claddreiss, aes(x = Transect, y = SRP.avg, fill = Transect)) + 
  geom_bar(col="black", stat="identity", position = position_dodge()) + 
  scale_fill_manual(values = c("darkslategrey","darkslategrey", "darkslategrey", "darkslategrey",
                               "darkslategrey","darkslategrey", "darkslategrey", "darkslategrey")) + 
  geom_errorbar(aes(ymin=SRP.avg - SRP.SE, ymax = SRP.avg + SRP.SE)) +
  theme(text = element_text(size=15), plot.title = element_text(size = 12)) + 
  theme(panel.background = element_rect(fill = "white", colour = "black")) + 
  theme(legend.position = c("none")) +
  labs(x="Transect",
       y="Average in-situ SRP (mg/L) \nat 0.1 m above bottom",
       title = c(expression(paste("SRP over a ", italic("Cladophora"), " + dreissenid bed across locations")))) +
  scale_y_continuous(expand=c(0,0), limits=c(0,0.004)) +
  scale_x_discrete(labels = c(expression(paste("MWA")), 
                              expression(paste("MSB")),
                              expression(paste("HHB")),
                              expression(paste("HAL")), 
                              expression(paste("EDE")),
                              expression(paste("EEP")),
                              expression(paste("OIR")),
                              expression(paste("OOL")))) +
  theme(axis.text.x = element_text(size=9)) +
  theme(axis.title = element_text(size = 13)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(size = 14))

# export as a PDF, landscape, and save dimensions as 5 in. x 6.5 in.
