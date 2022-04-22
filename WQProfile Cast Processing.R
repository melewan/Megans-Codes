### WQPROFILE PROCESSING ###

### SET-UP/FORMATTING ###

# Load installed packages
library(tidyverse)
library(magrittr)
library(readxl)
library(tidyr)
library(plyr)
library(dplyr)
library(ggplot2)
library(egg)
library(data.table)
library(hms)
library(matrixStats)

# Cladophora or HABs? 
clad.or.habs = menu(c("Cladophora", "HABs"), title = "Which project are you running
                    Water Quality Profile analysis on?")

if(clad.or.habs == 1) {
  

# Cladophora function
cladophoraWQP = function() {

# Select working directory 
setwd(choose.dir(caption = "Select folder to process"))
  
# Select ID file 
id.file = choose.files(multi = F, 
                       caption = "Select GLClad file")

# Select Year of data processing
datayear = menu(c("2018-19", "2020 +"), title = "Which year of data are you running
                    Water Quality Profile analysis on?")

if(datayear == 2) {

# 2020+ GLCladophora ID file
id = data.frame(read_excel(id.file, sheet = "Station Data", skip = 1))
names(id)[1] = "date"
names(id)[15] = "EXO2filename"
names(id)[3] = "transect"
names(id)[5] = "station"

} else {

# 2018-2019 GLCladophora ID file
# Reformat field data info
field.id = read_excel(id.file, sheet = "Field Data")
field.id = field.id[c("date","site/station name","1m Lchem Number")]
colnames(field.id) = c("date","site and station","Lchem")

# Format lab data info
lab.id = read_excel(id.file, sheet = "Lab Data")
colnames(lab.id) = lab.id[2,]
lab.id = lab.id[-c(1:2),c("Lchem number","Lake", "Site","Station","Sample Depth (m)")]
colnames(lab.id) = c("Lchem", "Lake", "site","station", "sample depth")

# Merge lab data with field data
id = merge(field.id, lab.id, by = "Lchem")
names(id)[5] = "transect"

# Select year close bracket
}

# Define function
ctdprocess = function() {


### FILE LOAD & SET-UP ###
  
# Process binned CTD files - load in the cast file for each row (sample) in id file: GLClad
for(i in 1:nrow(id)) {

# Load file (CLADOPHORA)
  # If-statement that loads cast files differently depending on the year  & GLClad format 
  if(datayear == 2) {
    # 2020+ format
    #i =
    EXO2filename = id$EXO2filename[i]
    file.name = paste(EXO2filename,".csv", sep = "")
    file.name2 = paste(EXO2filename)
    transect = id$transect[i]
    station = id$station[i]
   
  } else {
    # 2018-19 format
    #i = 
    lchem = id$Lchem[i]
    transect = id$transect[i]
    station = id$station[i]
    siteandstation = id$`site and station`[i]
    day = format(id$date[i], "%Y%m%d")
    file.name = paste(siteandstation," WQProfile ",day,".csv", sep = "")
    file.name2 = paste(siteandstation," WQProfile ",day,sep = "")
    }
  
if (file.exists(file.name)==TRUE) {
data = read.csv(file.name,stringsAsFactors= FALSE, fileEncoding = "UTF-8-BOM")

# Adjust formatting
start.row = which(data[,1] == "Date (MM/DD/YYYY)")
colnames(data) = data[start.row,]
data  = data[-c(1:start.row),]
data$'Date (MM/DD/YYYY)' = as.Date(data$'Date (MM/DD/YYYY)', "%m/%d/%Y")
data$`Depth m` = round(as.numeric(data$`Depth m`),1)
data[, -c(1:2,4)] = sapply(data[, -c(1:2,4)], as.numeric)

#change time format to be decimal hours (for aggregating) then change back at end
data[,2] = sapply(strsplit(data[,2],":"),
                  function(x) {
                    x = as.numeric(x)
                    x[1]+x[2]/60
                  }
)

# Keep only necessary columns
col.only = data[c("Date (MM/DD/YYYY)", "Time (HH:MM:SS)", "Depth m", "Chlorophyll RFU", "ODO mg/L", "SpCond µS/cm", 
                  "BGA PC RFU", "Turbidity FNU", "pH", "Temp °C")]

# Rename column names
colnames(col.only) = c("date", "time", "depth", "chl", "do", "spcond", "bga", "turb", "ph", "temp")

# Remove out of water time
in.water = subset(col.only, spcond > 180 & `depth` >= 0)

# Trim data to downcast and remove equilibration time
min.index = min(which(in.water[1:(nrow(in.water)/2),]$`depth` == min(in.water[1:(nrow(col.only)/2),]$`depth`)))
max.index = max(which(in.water$`depth` == max(col.only$`depth`)))
data.downcast = in.water[min.index:max.index,]  
downcast.upcast.no.surface.cal = in.water[min.index:nrow(in.water),] # make sure a dataframe with upcast added also has min.index

# Aggregate df data.downcast data by binned depth
data.ag.downcast = data.downcast
data.ag.downcast[,c(2:9)] = sapply(data.ag.downcast[,c(2:9)], as.numeric)
data.ag.downcast = ddply(data.downcast, .(`date`,`depth`), numcolwise(mean, na.rm = T))

# Remove data points with less than 3 observations or negative depths in the downcast
data.count = ddply(data.downcast, .(`date`,`depth`), summarize,
                   count = length(`date`))
cast.data = merge(data.ag.downcast, data.count)
cast.data = subset(cast.data, count >= 3)
cast.data = cast.data[order(cast.data$depth),]


### Codes needed to set up dataframes for pathway (bins of 2 & df of gaps) ###

# Create dataframe bins2.data that has bins of 2 included by keeping data points 
  # with 2 or more observations 
bins2.data = merge(data.ag.downcast, data.count)
bins2.data = subset(bins2.data, count >= 2)
bins2.data = bins2.data[order(bins2.data$depth),]

# Create df gap.info = the expected bin depths and the observed bins of 2 that may fill each gap.
gap.info = data.frame(start.depth=numeric(),end.depth=numeric(),expected.bins=numeric(),
            observed.bins2.count=numeric())

## Find and label data gaps in downcast only. 
# Expected and observed must equal each other for bins of 2 to be applied to df cast.data

# Gaps >= 0.5 m
note.downcast.gaps = ""
downcast.gap.count = 0
for(i in 1:(nrow(cast.data) - 1)) {
  if(cast.data$`depth`[i+1] - cast.data$`depth`[i] >= 0.5) {
    downcast.gap.count=downcast.gap.count+1
    gap.info[downcast.gap.count,]=c(cast.data$`depth`[i],cast.data$`depth`[i+1],
        (cast.data$`depth`[i+1]-cast.data$`depth`[i])*10,match(cast.data$`depth`[i+1], 
            bins2.data$depth)-match(cast.data$`depth`[i], bins2.data$depth))
    note.downcast.gaps = paste(note.downcast.gaps, "data gap between ", cast.data$`depth`[i], 
                 " and ", cast.data$`depth`[i+1], "; ", sep = "")
  }
}
# Gaps >= 1.5 m
note.downcast.1.5m.gaps = ""
downcast.1.5m.gap.count = 0
for(i in 1:(nrow(cast.data) - 1)) {
  if(cast.data$`depth`[i+1] - cast.data$`depth`[i] >= 1.5){
    downcast.1.5m.gap.count=downcast.1.5m.gap.count+1
    gap.info[downcast.1.5m.gap.count,]=c(cast.data$`depth`[i],cast.data$`depth`[i+1],
        (cast.data$`depth`[i+1]-cast.data$`depth`[i])*10,match(cast.data$`depth`[i+1], 
            bins2.data$depth)-match(cast.data$`depth`[i], bins2.data$depth))
    note.downcast.1.5m.gaps = paste(note.downcast.1.5m.gaps, "data gap between ", cast.data$`depth`[i], 
                               " and ", cast.data$`depth`[i+1], "; ", sep = "")
  }
}

# downcast-only graph function 

downcast.qaqc.graphs = function(){
  
  pdf(file = paste("graph",file.name2,".pdf"))

  temp.graph = ggplot(cast.data, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Temperature (°C)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  ph.graph = ggplot(cast.data, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + scale_y_reverse() + 
    scale_x_continuous(position = "top")
  chl.graph = ggplot(cast.data, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  odo.graph = ggplot(cast.data, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("ODO (mg/L)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  spcond.graph = ggplot(cast.data, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Specific Conductivity (µS/cm)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  bga.graph = ggplot(cast.data, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("BGA PC (RFU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  turb.graph = ggplot(cast.data, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") +
    geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Turbidity (FNU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, turb.graph, 
                         ncol = 2, nrow = 4)
  dev.off()
  
}

### find temp difference between upcast & downcast ###

# Subtract downcast from df data to get upcast only
data.upcast = in.water[ !(rownames(in.water) %in% rownames(data.downcast)), ]

# Aggregate df data.upcast data by binned depth, only populates if upcast available
data.ag.upcast = ddply(data.upcast, .(`date`,`depth`), numcolwise(mean, na.rm = T))

# Merge upcast and downcast with same bin depths only
temp.comp = merge(data.ag.downcast, data.ag.upcast, by.x='depth', by.y='depth')

# Find temp diff between upcast and downcast, new column called 'diff' shows temp difference
temp.comp$diff = abs(temp.comp$temp.x - temp.comp$temp.y)

# Creating values/notes of temp diff - true or false (if upcast is NA, will populate note)
if (dim(data.upcast)[1] != 0) {
if(max(temp.comp$diff) >=0.1) {temp.diff = temp.diff=TRUE
note.temp.diff = paste("temp diff >=0.1")
 } else {temp.diff = temp.diff=FALSE 
  note.temp.diff = paste("temp diff <0.1")}
} else {temp.diff = temp.diff=FALSE
  note.temp.diff.na = paste("upcast not available")}

## Bins of 2 for downcast only
# Fill in gaps with bins of 2 when applicable (when the gap can be completely filled by bins of 2)
if (temp.diff == TRUE && downcast.gap.count >=1) {  
for(i in 1:nrow(gap.info)){
  if(gap.info$expected.bins[i]==gap.info$observed.bins2.count[i]){
    cast2.data=rbind(cast.data,bins2.data[match(gap.info$start.depth[i]+0.1, 
                   bins2.data$depth):match(gap.info$end.depth[i]-0.1, bins2.data$depth),])
    note.bins2.downcast=paste("filled gaps between",  gap.info$start.depth[i], 
                              " and ", gap.info$end.depth[i], "using depths with count = 2; ", sep = "")
    cast2.data = cast2.data[order(cast2.data$depth),]
    }
  } 
}

# Graph functions for downcast + bins of 2
downcast.bins2.qaqc.graphs = function() {  
  pdf(file = paste("graph",file.name2,".pdf"))
  
  temp.graph = ggplot(cast2.data, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Temperature (°C)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  ph.graph = ggplot(cast2.data, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  chl.graph = ggplot(cast2.data, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  odo.graph = ggplot(cast2.data, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("ODO (mg/L)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  spcond.graph = ggplot(cast2.data, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cas2t.data)  + theme_minimal() + xlab("Specific Conductivity (µS/cm)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  bga.graph = ggplot(cast2.data, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("BGA PC (RFU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  turb.graph = ggplot(cast2.data, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
    geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Turbidity (FNU)") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  downcast.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, turb.graph, 
                         ncol = 2, nrow = 4)
  dev.off() 
  
  
}

### if using the upcast, create: 1) upcast + downcast dataframe, and 2) upcast + downcast + bins of 2 dataframe ###

# Create new dataframe with upcast + downcast data by aggregating df in.water
data.ag.up.and.down.cast = ddply(in.water, .(`date`,`depth`), numcolwise(mean, na.rm = T))

# Remove data points with less than 3 observations or negative depths in both downcast and upcast
up.and.down.data.count = ddply(in.water, .(`date`,`depth`), summarize,count = length(`date`))
up.and.down.data = merge(data.ag.up.and.down.cast, up.and.down.data.count)
up.and.down.data = subset(up.and.down.data, count >= 3)
up.and.down.data = up.and.down.data[order(up.and.down.data$depth),]

# Create dataframe up.and.down.bins2.data that has bins of 2 included by keeping data points with 2 or more observations 
up.and.down.bins2.data = merge(data.ag.up.and.down.cast, up.and.down.data.count)
up.and.down.bins2.data = subset(up.and.down.bins2.data, count >= 2)
up.and.down.bins2.data = up.and.down.bins2.data[order(up.and.down.bins2.data$depth),]

## Find and label data gaps in upcast + downcast data. 
# Expected and observed must equal each other for bins of 2 to be applied to df up.and.down.data

# Create df up.and.down.gap.info = the expected bin depths and the observed bins of 2 that may fill each gap. 
up.and.down.gap.info = data.frame(start.depth=numeric(),end.depth=numeric(),
                                  expected.bins=numeric(),observed.bins2.count=numeric())

# Gaps >= 0.5 m
note.up.and.down.gaps = ""
gap.count.up.down = 0
for(i in 1:(nrow(up.and.down.data) - 1)) {
  if(up.and.down.data$`depth`[i+1] - up.and.down.data$`depth`[i] >= 0.5) {
    gap.count.up.down=gap.count.up.down+1
    up.and.down.gap.info[gap.count.up.down,]=c(up.and.down.data$`depth`[i],up.and.down.data$`depth`[i+1],
       (up.and.down.data$`depth`[i+1]-up.and.down.data$`depth`[i])*10,match(up.and.down.data$`depth`[i+1], 
           up.and.down.bins2.data$depth)-match(up.and.down.data$`depth`[i], up.and.down.bins2.data$depth))
    note.up.and.down.gaps = paste(note.up.and.down.gaps, "data gap between ", up.and.down.data$`depth`[i], 
                  " and ", up.and.down.data$`depth`[i+1], "; ", sep = "")
    
  }
}
# Gaps >= 1.5 m
note.up.down.1.5m.gaps = ""
up.down.1.5m.gap.count = 0
for(i in 1:(nrow(up.and.down.data) - 1)) {
  if(up.and.down.data$`depth`[i+1] - up.and.down.data$`depth`[i] >= 1.5){
    up.down.1.5m.gap.count=up.down.1.5m.gap.count+1
    gap.info[up.down.1.5m.gap.count,]=c(up.and.down.data$`depth`[i],up.and.down.data$`depth`[i+1],
                          (up.and.down.data$`depth`[i+1]-up.and.down.data$`depth`[i])*10,match(up.and.down.data$`depth`[i+1], 
                           up.and.down.bins2.data$depth)-match(up.and.down.data$`depth`[i], up.and.down.bins2.data$depth))
    note.up.down.1.5m.gaps = paste(note.up.down.1.5m.gaps, "data gap between ", up.and.down.data$`depth`[i], 
                                         " and ", up.and.down.data$`depth`[i+1], "; ", sep = "")
    
  }
}
# Graph functions for upcast used
up.and.down.cast.qaqc.graphs = function() {
  
  pdf(file = paste("graph",file.name2,".pdf"))
  
  temp.graph = ggplot(up.and.down.data, aes(temp, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Temperature (°C)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  ph.graph = ggplot(up.and.down.data, aes(ph, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + 
    scale_y_reverse() + scale_x_continuous(position = "top")
  chl.graph = ggplot(up.and.down.data, aes(chl, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  odo.graph = ggplot(up.and.down.data, aes(do, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("ODO (mg/L)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  spcond.graph = ggplot(up.and.down.data, aes(spcond, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + 
    xlab("Specific Conductivity (µS/cm)") + ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  bga.graph = ggplot(up.and.down.data, aes(bga, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("BGA PC (RFU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  turb.graph = ggplot(up.and.down.data, aes(turb, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Turbidity (FNU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  up.and.down.cast.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, 
                                          turb.graph, ncol = 2, nrow = 4)
  dev.off()
  
}


### Bins of 2 for upcast and downcast ###
# Fill in gaps with bins of 2 when applicable (when the gap can be completely filled by bins of 2)
if(temp.diff == FALSE && gap.count.up.down >=1){
  for(i in 1:nrow(up.and.down.gap.info)){
    if(up.and.down.gap.info$expected.bins[i]==up.and.down.gap.info$observed.bins2.count[i]) {
      up.and.down2.data=rbind(up.and.down.data,up.and.down.bins2.data[match(up.and.down.gap.info$start.depth[i]+0.1, 
        up.and.down.bins2.data$depth):match(up.and.down.gap.info$end.depth[i]-0.1, up.and.down.bins2.data$depth),])
      note.bins2.up.and.down=paste(note.bins2.up.and.down,"filled gaps between",  up.and.down.gap.info$start.depth[i], 
                  " and ", up.and.down.gap.info$end.depth[i], "using depths with count = 2; ", sep = "")
      
      up.and.down2.data = up.and.down2.data[order(up.and.down2.data$depth),]
      } 
  } 
}

# Graph functions for upcast used + bins of 2
up.and.down.cast.bins2.qaqc.graphs = function() {
  
  pdf(file = paste("graph",file.name2,".pdf"))
  
  temp.graph = ggplot(up.and.down2.data, aes(temp, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Temperature (°C)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  ph.graph = ggplot(up.and.down2.data, aes(ph, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("pH") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  chl.graph = ggplot(up.and.down2.data, aes(chl, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  odo.graph = ggplot(up.and.down2.data, aes(do, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("ODO (mg/L)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  spcond.graph = ggplot(up.and.down2.data, aes(spcond, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + 
    xlab("Specific Conductivity (µS/cm)") + ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  bga.graph = ggplot(up.and.down2.data, aes(bga, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("BGA PC (RFU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  turb.graph = ggplot(up.and.down2.data, aes(turb, depth), position = position_identity()) + geom_path(data = downcast.upcast.no.surface.cal, colour = "grey75") + 
    geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Turbidity (FNU)") + 
    ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
  up.and.down.cast.bins2.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, 
                                          turb.graph, ncol = 2, nrow = 4)
  dev.off()
  
}   

# Pathway 

if (downcast.gap.count <=3 && downcast.1.5m.gap.count < 1){  
  downcast.qaqc.graphs();
  print("no significant gaps, used downcast only")
  cast.data.processed = cbind(transect = transect,station = station, cast.data, ValueQualifier = "")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else if ((temp.diff == TRUE && exists("note.bins2.downcast")) || 
           (exists("note.temp.diff.na") && exists("note.bins2.downcast"))){ 
  downcast.bins2.qaqc.graphs();
  print("significant gaps, temperature difference >0.1 (or upcast n/a), used downcast only & bins of 2")
  cast.data.processed = cbind(transect = transect,station = station, cast2.data, ValueQualifier = "")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else if (temp.diff == TRUE || exists("note.temp.diff.na")) {
  downcast.qaqc.graphs(); 
  print("significant gaps, used downcast only, upcast & bins of 2 not applicable")
  cast.data.processed = cbind(transect = transect,station = station, cast.data, ValueQualifier = "")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else if ((temp.diff == FALSE) && gap.count.up.down <=3 && up.down.1.5m.gap.count < 1){
  up.and.down.cast.qaqc.graphs();
  print("significant gaps, no temperature difference, used upcast to fill in gaps")
  cast.data.processed = cbind(transect = transect,station = station, up.and.down.data, 
                              ValueQualifier = "UC")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else if((temp.diff == FALSE) && exists("note.up.and.down.gaps") && exists("up.and.down2.data")) {
  up.and.down.cast.bins2.qaqc.graphs();
  print("significant gaps, no temperature difference, used upcast & bins of 2")
  cast.data.processed = cbind(transect = transect,station = station, up.and.down2.data, 
                              ValueQualifier = "UC")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else if (temp.diff == FALSE) {
  up.and.down.cast.qaqc.graphs();
  print("significant gaps, no temperature difference, used upcast to fill in gaps, bins 
        of 2 not applicable")
  cast.data.processed = cbind(transect = transect,station = station, up.and.down.data, 
                              ValueQualifier = "UC")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
} else {
  downcast.qaqc.graphs();
  print("significant gaps, used downcast only, upcast & bins of 2 not applicable")
  cast.data.processed = cbind(transect = transect,station = station, cast.data, ValueQualifier = "")
  cast.data.info = merge(id, cast.data.processed, by = c("transect","station","date"))
}
  
print(paste("Processed:",file.name))

## Formatting cast.data.info
cast.data.info = cast.data.info[c("transect", "station", "date", "Lake", "depth", "time", "chl", "do", 
                                  "spcond", "bga", "turb", "ph", "temp", "count" , "ValueQualifier")]
colnames(cast.data.info) = c("Transect", "Station", "Date", "Lake", "BinnedDepth","Time", "AveChl", "AveDO", 
                             "AveSpCond", "AvePhycocyanin", "AveTurb", "AvepH", "AveTemp", "Count", 
                             "ValueQualifier")
cast.data.info[, "Year"] = format(cast.data.info[,"Date"], "%Y")
cast.data.info[, "Month"] = format(cast.data.info[,"Date"], "%B")
cast.data.info = cast.data.info[,c(16,17,3,4,1,2,6,5,13,9,12,11,8,7,10,14,15)]

# Reformat Time
cast.data.info = cast.data.info %>%
  mutate(
    Time = Time / 24)

# Add Value Qualifiers
for(i in 1:nrow(cast.data.info))
  if(!is.null(cast.data.info$Count[i]) & cast.data.info$Count[i] == 2) {
    cast.data.info$'ValueQualifier'[i] = 'BCT'
  }

# Combine file with other cast data
if(!exists("all.casts")){
  all.casts=cast.data.info
} else{
  all.casts = rbind.fill(all.casts, cast.data.info)
}

# Add bottom marker for averaging later
all.casts$DepthForAve[(nrow(all.casts)-1):(nrow(all.casts))] = "B"

# Close bracket for "if file exists" if-statement (begins on line 69)
} else {print(paste(file.name2, "cast does not exist"))
}

# Close bracket for file-load for-loop
}

# After adding data to ctd.all file, remove all dfs/values/functions in the environment so we can run another file
# This keeps the id info from GLClad which we need for every loop (& the ctd.all file)
rm(data, col.only, in.water, data.downcast, data.ag.downcast, data.count, cast.data, 
   cast.data.processed, bins2.data, gap.info, data.upcast, data.ag.upcast, temp.comp, 
    data.ag.up.and.down.cast, up.and.down.data.count, up.and.down.data, up.and.down.bins2.data, 
      up.and.down.gap.info, downcast.gap.count, file.name, file.name2, gap.count.up.down, 
        max.index, min.index, note.downcast.gaps, note.temp.diff, note.up.and.down.gaps, start.row, 
          temp.diff, downcast.bins2.qaqc.graphs, downcast.qaqc.graphs, 
            up.and.down.cast.bins2.qaqc.graphs, up.and.down.cast.qaqc.graphs,cast.data.info, 
              downcast.1.5m.gap.count, up.down.1.5m.gap.count, note.downcast.1.5m.gaps, 
                note.up.down.1.5m.gaps, EXO2filename, transect, station)
  if(exists("bins2")) {rm(bins2)}
  if(exists("note.bins2.downcast")) {rm(note.bins2.downcast)}
  if(exists("note.bins2.up.and.down")) {rm(note.bins2.up.and.down)}
  if(exists("cast2.data")) {rm(cast2.data)}
  if(exists("up.and.down2.data")) {rm(up.and.down2.data)}
  if(exists("day")) {rm(day)}
  if(exists("lchem")) {rm(lchem)}
  if(exists("note.temp.diff.na")) {rm(note.temp.diff.na)}
  if(exists("siteandstation")) {rm(siteandstation)}

# Add 1m marker for averaging & using these data points after processing
for(i in 1:nrow(all.casts)){
  if(all.casts$BinnedDepth[i] >= 0.8 & all.casts$BinnedDepth[i] <=1.2){
    all.casts$DepthForAve[i] = "1 m"
  }
}

# Order all.casts file by Date, Transect, then Station
all.casts = all.casts[order(all.casts$Date, all.casts$Transect, all.casts$Station),]

# Adjust measurement resolution (# of decimal points)
all.casts$AveTemp = lapply(all.casts$AveTemp, round, 3)
all.casts$AveSpCond = lapply(all.casts$AveSpCond, round, 2)
all.casts$AvepH = lapply(all.casts$AvepH, round, 2)
all.casts$AveTurb = lapply(all.casts$AveTurb, round, 2)
all.casts$AveDO = lapply(all.casts$AveDO, round, 2)
all.casts$AveChl = lapply(all.casts$AveChl, round, 2)
all.casts$AvePhycocyanin = lapply(all.casts$AvePhycocyanin, round, 2)

# Replace certain values with BDL
all.casts.done = all.casts
all.casts.done$AveTurb [all.casts.done$AveTurb <= 0.3]<-"BDL"
all.casts.done$AveChl [all.casts.done$AveChl <= 0.01]<-"BDL"
all.casts.done$AvePhycocyanin [all.casts.done$AvePhycocyanin <= 0.01]<-"BDL"

all.casts.done[, c(9:15)] = sapply(all.casts.done[, c(9:15)], as.character)

# Save WQProfiles file to server
write.csv(all.casts.done, file = choose.files(multi = F, 
                            caption = "Save 'WaterQualityProfilesYYYY.csv' file"),
                            row.names = FALSE)

#### WaterQualitySummary ####

## 1 m & B Averaging ##

# Create dataframe with 1 m & B points only
oneb = subset(all.casts, DepthForAve != "NA")

# Change site info columns to factor to be able to group by them
oneb$DepthForAve = as.factor(oneb$DepthForAve)
oneb$Year = as.factor(oneb$Year)
oneb$Month = as.factor(oneb$Month)
oneb$Date = as.factor(oneb$Date)
oneb$Lake = as.factor(oneb$Lake)
oneb$Transect = as.factor(oneb$Transect)
oneb$Station = as.factor(oneb$Station)

# Replace values below detection limit with 1/2 detection limit
oneb$AveTurb [oneb$AveTurb <= 0.3]<- 0.15
oneb$AveChl [oneb$AveChl <= 0.01]<- 0.005
oneb$AvePhycocyanin [oneb$AvePhycocyanin <= 0.01]<- 0.005

# Change value columns to numeric
oneb[, c(9:15)] = sapply(oneb[, c(9:15)], as.character)
oneb[, c(9:15)] = sapply(oneb[, c(9:15)], as.numeric)

# Pipe: take the mean of all parameters, grouping by site information and DepthForAve (1 m & B)
mean1mB = oneb %>%
  dplyr::group_by(Year, Month, Date, Lake, Transect, Station, DepthForAve) %>%
  dplyr::summarise(MaxDepth = max(BinnedDepth), DepthAveTemp = mean(AveTemp), 
                   DepthAveSpCond = mean(AveSpCond), DepthAvepH = mean(AvepH), 
                   DepthAveTurb = mean(AveTurb), DepthAveDO = mean(AveDO), 
                   DepthAveChl = mean(AveChl), DepthAvePhyco = mean(AvePhycocyanin) 
                   )
names(mean1mB)[7] = "DepthForAve"

# Order 1 m & B file by Date, Transect, then Station
mean1mB = mean1mB[order(mean1mB$Date, mean1mB$Transect, mean1mB$Station),]


### QAQC of WaterQualitySummary (mean1mB) ###

## Add matrix to the end of mean1mB dataframe depicting where outliers are
# Add new columns for outlier matrix
mean1mB = add_column(mean1mB, Temp.Outliers = 0, .after = "DepthAvePhyco")
mean1mB = add_column(mean1mB, SpCond.Outliers = 0, .after = "Temp.Outliers")
mean1mB = add_column(mean1mB, pH.Outliers = 0, .after = "SpCond.Outliers")
mean1mB = add_column(mean1mB, Turb.Outliers = 0, .after = "pH.Outliers")
mean1mB = add_column(mean1mB, DO.Outliers = 0, .after = "Turb.Outliers")
mean1mB = add_column(mean1mB, Chl.Outliers = 0, .after = "DO.Outliers")
mean1mB = add_column(mean1mB, Phyco.Outliers = 0, .after = "Chl.Outliers")

## Find minor and major thresholds ##

## Minor
MinorOutliers = function(mean1mB) {
# calculate upper and lower quartiles
lowerq = quantile(mean1mB)[2]
upperq = quantile(mean1mB)[4]
iqr = upperq - lowerq
# minor thresholds
threshold.lower = lowerq - (iqr * 1.5)
threshold.upper = (iqr * 1.5) + upperq
# major thresholds
extreme.threshold.lower = lowerq - (iqr * 3)
extreme.threshold.upper = (iqr * 3) + upperq
# result in list
minorresult = which(mean1mB > threshold.upper & mean1mB < extreme.threshold.upper
                    | mean1mB < threshold.lower & mean1mB > extreme.threshold.lower)
}
# Run function on all 7 parameters
MinorOutliersPositions = lapply(mean1mB[,9:15], MinorOutliers) 


## Major
MajorOutliers <- function(mean1mB) {
# calculate upper and lower quartiles
lowerq = quantile(mean1mB)[2]
upperq = quantile(mean1mB)[4]
iqr = upperq - lowerq
# minor thresholds
threshold.lower = lowerq - (iqr * 1.5)
threshold.upper = (iqr * 1.5) + upperq
# major thresholds
extreme.threshold.lower = lowerq - (iqr * 3)
extreme.threshold.upper = (iqr * 3) + upperq
# result in list
result <- which(mean1mB > extreme.threshold.upper | mean1mB < extreme.threshold.lower)
}
# Run function on all 7 parameters
MajorOutliersPositions = lapply(mean1mB[,9:15], MajorOutliers)

# create a matrix labeling outliers

mean1mB$Temp.Outliers[MinorOutliersPositions$DepthAveTemp] = 1
mean1mB$Temp.Outliers[MajorOutliersPositions$DepthAveTemp] = 2

mean1mB$SpCond.Outliers[MinorOutliersPositions$DepthAveSpCond] = 1
mean1mB$SpCond.Outliers[MajorOutliersPositions$DepthAveSpCond] = 2

mean1mB$pH.Outliers[MinorOutliersPositions$DepthAvepH] = 1
mean1mB$pH.Outliers[MajorOutliersPositions$DepthAvepH] = 2

mean1mB$Turb.Outliers[MinorOutliersPositions$DepthAveTurb] = 1
mean1mB$Turb.Outliers[MajorOutliersPositions$DepthAveTurb] = 2

mean1mB$DO.Outliers[MinorOutliersPositions$DepthAveDO] = 1
mean1mB$DO.Outliers[MajorOutliersPositions$DepthAveDO] = 2

mean1mB$Chl.Outliers[MinorOutliersPositions$DepthAveChl] = 1
mean1mB$Chl.Outliers[MajorOutliersPositions$DepthAveChl] = 2

mean1mB$Phyco.Outliers[MinorOutliersPositions$DepthAvePhyco] = 1
mean1mB$Phyco.Outliers[MajorOutliersPositions$DepthAvePhyco] = 2

# Adjust measurement resolution (# of decimal points)
mean1mB$DepthAveTemp = lapply(mean1mB$DepthAveTemp, round, 3)
mean1mB$DepthAveSpCond = lapply(mean1mB$DepthAveSpCond, round, 2)
mean1mB$DepthAvepH = lapply(mean1mB$DepthAvepH, round, 2)
mean1mB$DepthAveTurb = lapply(mean1mB$DepthAveTurb, round, 2)
mean1mB$DepthAveDO = lapply(mean1mB$DepthAveDO, round, 2)
mean1mB$DepthAveChl = lapply(mean1mB$DepthAveChl, round, 2)
mean1mB$DepthAvePhyco = lapply(mean1mB$DepthAvePhyco, round, 2)

## Change values from 1/2 detection limit back to BDL
mean1mB$DepthAveTurb [mean1mB$DepthAveTurb <= 0.3]<- "BDL"
mean1mB$DepthAveChl [mean1mB$DepthAveChl <= 0.01]<- "BDL"
mean1mB$DepthAvePhyco [mean1mB$DepthAvePhyco <= 0.01]<- "BDL"

# Make columns character format for export
mean1mB[, c(9:15)] = sapply(mean1mB[, c(9:15)], as.character)

# Save 1 m & B file to server
write.csv(mean1mB, file = choose.files(multi = F, 
                                       caption = "Save 'WaterQualitySummaryYYYY.csv' file"), 
          row.names = FALSE)

# Save output of function into environment
return(all.casts)


# Close bracket for whole ctdprocess() function
}

# Run function
all.casts=ctdprocess()

# Close bracket for Cladophora function
}

### RUN CLADOPHORA FUNCTION ###
cladophoraWQP()

# Close bracket for if/else statement of project
} else {






####### HABs CODE SET UP #######

# HABs function
HABsWQP = function() {
  
  # Select working directory 
  setwd(choose.dir(caption = "Select BIN and Excel folder to process"))
  
  # Import GLChem as ID file
  id.file = choose.files(multi = F, 
  caption = "Select GLChem file that matches year of BIN and Excel folder")
  
  # Format ID file
  id = read_excel(id.file, sheet = "lab data")
  colnames(id) = id[3,]
  id = id[!(id$`Depth Category` =="INT"),]
  id = id[-c(1:4),c("Lchem number","date","location","site/station name","Sample Depth (m)")]
  colnames(id) = c("Lchem","date","lake", "site and station", "b depth")
  id$date = as.Date(as.numeric(id$date), origin = "1899-12-30")
  
  # Define function
  ctdprocess = function() {
    
    
    ### FILE LOAD & SET-UP ###
    
    # Process binned CTD files
    for(i in 1:nrow(id)) {
      
      # Load file (HABs)
      #i = 
      lchem = id$Lchem[i]
      siteandstation = id$`site and station`[i]
      day = format(id$date[i], "%Y%m%d")
      file.name = paste(siteandstation," WQProfile ",day,".csv", sep = "")
      file.name2 = paste(siteandstation," WQProfile ",day,sep = "")
      if (file.exists(file.name)==TRUE) {
        data = read.csv(file.name,stringsAsFactors= FALSE, fileEncoding = "UTF-8-BOM")
        
        # Adjust formatting
        start.row = which(data[,1] == "Date (MM/DD/YYYY)")
        colnames(data) = data[start.row,]
        data  = data[-c(1:start.row),]
        data$'Date (MM/DD/YYYY)' = as.Date(data$'Date (MM/DD/YYYY)', "%m/%d/%y")
        data$`Depth m` = round(as.numeric(data$`Depth m`),1)
        data[, -c(1:2,4)] = sapply(data[, -c(1:2,4)], as.numeric)
        
        #change time format to be decimal hours (for aggregating) then change back at end
        data[,2] = sapply(strsplit(data[,2],":"),
                          function(x) {
                            x = as.numeric(x)
                            x[1]+x[2]/60
                          }
        )
        
        # Rename column names that we use functions on
        col.only = data
        names(col.only)[1] = "date"
        names(col.only)[8] = "depth"
        names(col.only)[5] = "chl"
        names(col.only)[12] = "do"
        names(col.only)[15] = "spcond"
        names(col.only)[16] = "bga"
        names(col.only)[19] = "turb"
        names(col.only)[21] = "ph"
        names(col.only)[23] = "temp"
        
        # Remove out of water time
        in.water = subset(col.only, spcond > 180 & `depth` >= 0)
        
        # Trim data to downcast
        min.index = min(which(in.water[1:(nrow(in.water)/2),]$`depth` == min(in.water[1:(nrow(col.only)/2),]$`depth`)))
        max.index = max(which(in.water$`depth` == max(col.only$`depth`)))
        data.downcast = in.water[min.index:max.index,]
        
        # Aggregate df data.downcast data by binned depth
        data.ag.downcast = ddply(data.downcast, .(`date`,`depth`), numcolwise(mean, na.rm = T))
        
        # Remove data points with less than 3 observations or negative depths in the downcast
        data.count = ddply(data.downcast, .(`date`,`depth`), summarize,
                           count = length(`date`))
        cast.data = merge(data.ag.downcast, data.count)
        cast.data = subset(cast.data, count >= 3)
        cast.data = cast.data[order(cast.data$depth),]
        
        
        ### Codes needed to set up dataframes for pathway (bins of 2 & df of gaps) ###
        
        # Create dataframe bins2.data that has bins of 2 included by keeping data points with 2 or more observations 
        bins2.data = merge(data.ag.downcast, data.count)
        bins2.data = subset(bins2.data, count >= 2)
        bins2.data = bins2.data[order(bins2.data$depth),]
        
        # Create df gap.info = the expected bin depths and the observed bins of 2 that may fill each gap.
        gap.info = data.frame(start.depth=numeric(),end.depth=numeric(),expected.bins=numeric(),
                              observed.bins2.count=numeric())
        
        ## Find and label data gaps in downcast only. 
        # Expected and observed must equal each other for bins of 2 to be applied to df cast.data
        
        # Gaps >= 0.5 m
        note.downcast.gaps = ""
        downcast.gap.count = 0
        for(i in 1:(nrow(cast.data) - 1)) {
          if(cast.data$`depth`[i+1] - cast.data$`depth`[i] >= 0.5) {
            downcast.gap.count=downcast.gap.count+1
            gap.info[downcast.gap.count,]=c(cast.data$`depth`[i],cast.data$`depth`[i+1],
                (cast.data$`depth`[i+1]-cast.data$`depth`[i])*10,match(cast.data$`depth`[i+1], 
                   bins2.data$depth)-match(cast.data$`depth`[i], bins2.data$depth))
            note.downcast.gaps = paste(note.downcast.gaps, "data gap between ", cast.data$`depth`[i], 
                                       " and ", cast.data$`depth`[i+1], "; ", sep = "")
            
          }
        }
        # Gaps >= 1.5 m
        note.downcast.1.5m.gaps = ""
        downcast.1.5m.gap.count = 0
        for(i in 1:(nrow(cast.data) - 1)) {
          if(cast.data$`depth`[i+1] - cast.data$`depth`[i] >= 1.5){
            downcast.1.5m.gap.count=downcast.1.5m.gap.count+1
            gap.info[downcast.1.5m.gap.count,]=c(cast.data$`depth`[i],cast.data$`depth`[i+1],
                (cast.data$`depth`[i+1]-cast.data$`depth`[i])*10,match(cast.data$`depth`[i+1], 
                    bins2.data$depth)-match(cast.data$`depth`[i], bins2.data$depth))
            note.downcast.1.5m.gaps = paste(note.downcast.1.5m.gaps, "data gap between ", cast.data$`depth`[i], 
                                                 " and ", cast.data$`depth`[i+1], "; ", sep = "")
            
          }
        }
        
        # downcast-only graph function
        
        downcast.qaqc.graphs = function(){
          
          pdf(file = paste("graph",file.name2,".pdf"))
          
          temp.graph = ggplot(NULL, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Temperature (°C)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          ph.graph = ggplot(NULL, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + scale_y_reverse() + 
            scale_x_continuous(position = "top")
          chl.graph = ggplot(NULL, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          odo.graph = ggplot(NULL, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("ODO (mg/L)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          spcond.graph = ggplot(NULL, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Specific Conductivity (µS/cm)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          bga.graph = ggplot(NULL, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("BGA PC (RFU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          turb.graph = ggplot(NULL, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") +
            geom_point(data = cast.data) + geom_path(data = cast.data)  + theme_minimal() + xlab("Turbidity (FNU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, turb.graph, 
                                 ncol = 2, nrow = 4)
          dev.off()
          
        }
        
        ### find temp difference between upcast & downcast ###
        
        # Subtract downcast from df data to get upcast only
        data.upcast = in.water[ !(rownames(in.water) %in% rownames(data.downcast)), ]
        
        # Aggregate df data.upcast data by binned depth, only populates if upcast available
        data.ag.upcast = ddply(data.upcast, .(`date`,`depth`), numcolwise(mean, na.rm = T))
        
        # Merge upcast and downcast with same bin depths only
        temp.comp = merge(data.ag.downcast, data.ag.upcast, by.x='depth', by.y='depth')
        
        # Find temp diff between upcast and downcast, new column called 'diff' shows temp difference
        temp.comp$diff = abs(temp.comp$temp.x - temp.comp$temp.y)
        
        # Creating values/notes of temp diff - true or false (if upcast is NA, will populate note)
        if (dim(data.upcast)[1] != 0) {
          if(max(temp.comp$diff) >=0.1) {temp.diff = temp.diff=TRUE
          note.temp.diff = paste("temp diff >=0.1")
          } else {temp.diff = temp.diff=FALSE 
          note.temp.diff = paste("temp diff <0.1")}
        } else {temp.diff = temp.diff=FALSE
        note.temp.diff.na = paste("upcast not available")}
        
        ##Bins of 2 for downcast only
        # Fill in gaps with bins of 2 when applicable (when the gap can be completely filled by bins of 2)
        if (temp.diff == TRUE && downcast.gap.count >=1) {  
          for(i in 1:nrow(gap.info)){
            if(gap.info$expected.bins[i]==gap.info$observed.bins2.count[i]){
              cast2.data=rbind(cast.data,bins2.data[match(gap.info$start.depth[i]+0.1, 
                                                          bins2.data$depth):match(gap.info$end.depth[i]-0.1, bins2.data$depth),])
              note.bins2.downcast=paste("filled gaps between",  gap.info$start.depth[i], 
                                        " and ", gap.info$end.depth[i], "using depths with count = 2; ", sep = "")
              cast2.data = cast2.data[order(cast2.data$depth),]
            }
          } 
        }
        
        # Graph functions for downcast + bins of 2
        downcast.bins2.qaqc.graphs = function() {  
          pdf(file = paste("graph",file.name2,".pdf"))
          
          temp.graph = ggplot(NULL, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Temperature (°C)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          ph.graph = ggplot(NULL, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          chl.graph = ggplot(NULL, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          odo.graph = ggplot(NULL, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("ODO (mg/L)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          spcond.graph = ggplot(NULL, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cas2t.data)  + theme_minimal() + xlab("Specific Conductivity (µS/cm)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          bga.graph = ggplot(NULL, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("BGA PC (RFU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          turb.graph = ggplot(NULL, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = cast2.data) + geom_path(data = cast2.data)  + theme_minimal() + xlab("Turbidity (FNU)") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          downcast.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, turb.graph, 
                                          ncol = 2, nrow = 4)
          dev.off() 
          
          
        }
        
        ### if using the upcast, create: 1) upcast + downcast dataframe, and 2) upcast + downcast + bins of 2 dataframe ###
        
        # Create new dataframe with upcast + downcast data by aggregating df in.water
        data.ag.up.and.down.cast = ddply(in.water, .(`date`,`depth`), numcolwise(mean, na.rm = T))
        
        # Remove data points with less than 3 observations or negative depths in both downcast and upcast
        up.and.down.data.count = ddply(in.water, .(`date`,`depth`), summarize,count = length(`date`))
        up.and.down.data = merge(data.ag.up.and.down.cast, up.and.down.data.count)
        up.and.down.data = subset(up.and.down.data, count >= 3)
        up.and.down.data = up.and.down.data[order(up.and.down.data$depth),]
        
        # Create dataframe up.and.down.bins2.data that has bins of 2 included by keeping data points with 2 or more observations 
        up.and.down.bins2.data = merge(data.ag.up.and.down.cast, up.and.down.data.count)
        up.and.down.bins2.data = subset(up.and.down.bins2.data, count >= 2)
        up.and.down.bins2.data = up.and.down.bins2.data[order(up.and.down.bins2.data$depth),]
        
        # Find and label data gaps in upcast + downcast data
        # Expected and observed must equal each other for bins of 2 to be applied to df up.and.down.data
        
        # Create df up.and.down.gap.info = the expected bin depths and the observed bins of 2 that may fill each gap. 
        up.and.down.gap.info = data.frame(start.depth=numeric(),end.depth=numeric(),
                                          expected.bins=numeric(),observed.bins2.count=numeric())
        
        # Gaps >= 0.5 m
        note.up.and.down.gaps = ""
        gap.count.up.down = 0
        for(i in 1:(nrow(up.and.down.data) - 1)) {
          if(up.and.down.data$`depth`[i+1] - up.and.down.data$`depth`[i] >= 0.5) {
            gap.count.up.down=gap.count.up.down+1
            up.and.down.gap.info[gap.count.up.down,]=c(up.and.down.data$`depth`[i],up.and.down.data$`depth`[i+1],
                                                       (up.and.down.data$`depth`[i+1]-up.and.down.data$`depth`[i])*10,match(up.and.down.data$`depth`[i+1], 
                                                                                                                            up.and.down.bins2.data$depth)-match(up.and.down.data$`depth`[i], up.and.down.bins2.data$depth))
            note.up.and.down.gaps = paste(note.up.and.down.gaps, "data gap between ", up.and.down.data$`depth`[i], 
                                          " and ", up.and.down.data$`depth`[i+1], "; ", sep = "")
            
          }
        }
        # Gaps >= 1.5 m
        note.up.down.1.5m.gaps = ""
        up.down.1.5m.gap.count = 0
        for(i in 1:(nrow(up.and.down.data) - 1)) {
          if(up.and.down.data$`depth`[i+1] - up.and.down.data$`depth`[i] >= 1.5){
            up.down.1.5m.gap.count=up.down.1.5m.gap.count+1
            gap.info[up.down.1.5m.gap.count,]=c(up.and.down.data$`depth`[i],up.and.down.data$`depth`[i+1],
                                                (up.and.down.data$`depth`[i+1]-up.and.down.data$`depth`[i])*10,match(up.and.down.data$`depth`[i+1], 
                                                                                                                     up.and.down.bins2.data$depth)-match(up.and.down.data$`depth`[i], up.and.down.bins2.data$depth))
            note.up.down.1.5m.gaps = paste(note.up.down.1.5m.gaps, "data gap between ", up.and.down.data$`depth`[i], 
                                            " and ", up.and.down.data$`depth`[i+1], "; ", sep = "")
            
          }
        }
        
        # Graph functions for upcast used
        up.and.down.cast.qaqc.graphs = function() {
          
          pdf(file = paste("graph",file.name2,".pdf"))
          
          temp.graph = ggplot(NULL, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Temperature (°C)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          ph.graph = ggplot(NULL, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("pH") + ylab("Depth (m)") + 
            scale_y_reverse() + scale_x_continuous(position = "top")
          chl.graph = ggplot(NULL, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          odo.graph = ggplot(NULL, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("ODO (mg/L)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          spcond.graph = ggplot(NULL, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + 
            xlab("Specific Conductivity (µS/cm)") + ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          bga.graph = ggplot(NULL, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("BGA PC (RFU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          turb.graph = ggplot(NULL, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down.data) + geom_path(data = up.and.down.data)  + theme_minimal() + xlab("Turbidity (FNU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          up.and.down.cast.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, 
                                                  turb.graph, ncol = 2, nrow = 4)
          dev.off()
          
        }
        
        
        ### Bins of 2 for upcast and downcast ###
        # Fill in gaps with bins of 2 when applicable (when the gap can be completely filled by bins of 2) 
        if(temp.diff == FALSE && gap.count.up.down >=1){
          for(i in 1:nrow(up.and.down.gap.info)){
            if(up.and.down.gap.info$expected.bins[i]==up.and.down.gap.info$observed.bins2.count[i]) {
              up.and.down2.data=rbind(up.and.down.data,up.and.down.bins2.data[match(up.and.down.gap.info$start.depth[i]+0.1, 
                                                                                    up.and.down.bins2.data$depth):match(up.and.down.gap.info$end.depth[i]-0.1, up.and.down.bins2.data$depth),])
              note.bins2.up.and.down=paste(note.bins2.up.and.down,"filled gaps between",  up.and.down.gap.info$start.depth[i], 
                                           " and ", up.and.down.gap.info$end.depth[i], "using depths with count = 2; ", sep = "")
              
              up.and.down2.data = up.and.down2.data[order(up.and.down2.data$depth),]
            } 
          } 
        }
        
        up.and.down.cast.bins2.qaqc.graphs = function() {
          
          pdf(file = paste("graph",file.name2,".pdf"))
          
          temp.graph = ggplot(NULL, aes(temp, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Temperature (°C)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          ph.graph = ggplot(NULL, aes(ph, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("pH") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          chl.graph = ggplot(NULL, aes(chl, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Chlorophyll (RFU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          odo.graph = ggplot(NULL, aes(do, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("ODO (mg/L)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          spcond.graph = ggplot(NULL, aes(spcond, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + 
            xlab("Specific Conductivity (µS/cm)") + ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          bga.graph = ggplot(NULL, aes(bga, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("BGA PC (RFU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          turb.graph = ggplot(NULL, aes(turb, depth), position = position_identity()) + geom_path(data = data.downcast, colour = "grey75") + 
            geom_point(data = up.and.down2.data) + geom_path(data = up.and.down2.data)  + theme_minimal() + xlab("Turbidity (FNU)") + 
            ylab("Depth (m)") + scale_y_reverse() + scale_x_continuous(position = "top")
          up.and.down.cast.bins2.graphs.all = ggarrange(temp.graph, spcond.graph, chl.graph, bga.graph, ph.graph, odo.graph, 
                                                        turb.graph, ncol = 2, nrow = 4)
          dev.off()
          
        }   
        
        # Pathway 
        
        if (downcast.gap.count <=3 && downcast.1.5m.gap.count < 1){  
          downcast.qaqc.graphs();
          print("no significant gaps, used downcast only")
          cast.data.processed = cbind(Lchem = lchem, cast.data, ValueQualifier = "")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else if ((temp.diff == TRUE && exists("note.bins2.downcast")) || 
                   (exists("note.temp.diff.na") && exists("note.bins2.downcast"))){ 
          downcast.bins2.qaqc.graphs();
          print("significant gaps, temperature difference >0.1 (or upcast n/a), used 
                downcast only & bins of 2")
          cast.data.processed = cbind(Lchem = lchem, cast2.data, ValueQualifier = "")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else if (temp.diff == TRUE || exists("note.temp.diff.na")) {
          downcast.qaqc.graphs(); 
          print("significant gaps, used downcast only, upcast & bins of 2 not applicable")
          cast.data.processed = cbind(Lchem = lchem, cast.data, ValueQualifier = "")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else if ((temp.diff == FALSE) && gap.count.up.down <=3 && 
                   up.down.1.5m.gap.count < 1){
          up.and.down.cast.qaqc.graphs();
          print("significant gaps, no temperature difference, used upcast to fill in gaps")
          cast.data.processed = cbind(Lchem = lchem, up.and.down.data, ValueQualifier = "UC")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else if((temp.diff == FALSE) && exists("note.up.and.down.gaps") && 
                  exists("up.and.down2.data")) {
          up.and.down.cast.bins2.qaqc.graphs();
          print("significant gaps, no temperature difference, used upcast & bins of 2")
          cast.data.processed = cbind(Lchem = lchem, up.and.down2.data, ValueQualifier = "UC")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else if (temp.diff == FALSE) {
          up.and.down.cast.qaqc.graphs();
          print("significant gaps, no temperature difference, used upcast 
                to fill in gaps, bins of 2 not applicable")
          cast.data.processed = cbind(Lchem = lchem, up.and.down.data, ValueQualifier = "UC")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        } else {
          downcast.qaqc.graphs();
          print("significant gaps, used downcast only, upcast & bins of 2 not applicable")
          cast.data.processed = cbind(Lchem = lchem, cast.data, ValueQualifier = "")
          cast.data.info = merge(id, cast.data.processed, by = "Lchem")
        }
        
        print(paste("Processed:",file.name))
        
        ## Formatting cast.data.info
        names(cast.data.info)[2] = "Date (MM/DD/YYYY)"
        names(cast.data.info)[7] = "Depth m"
        names(cast.data.info)[10] = "Chlorophyll RFU"
        names(cast.data.info)[16] = "ODO mg/L"
        names(cast.data.info)[19] = "SpCond µS/cm"
        names(cast.data.info)[20] = "BGA PC RFU"
        names(cast.data.info)[23] = "Turbidity FNU"
        names(cast.data.info)[25] = "pH"
        names(cast.data.info)[27] = "Temp °C"
        names(cast.data.info)[3] = "Lake"
        names(cast.data.info)[4] = "Site"
        names(cast.data.info)[5] = "B Depth m"
        drops = c("date.y", "bindepth")
        cast.data.info = cast.data.info[ , !(names(cast.data.info) %in% drops)]
        cast.data.info[, "Year"] = format(cast.data.info[,"Date (MM/DD/YYYY)"], "%Y")
        
        # Add INT & B column
        # B depth round to 0.1m
        cast.data.info[,5] = sapply(cast.data.info[,5], as.numeric)
        cast.data.info[,5] = round(cast.data.info$`B Depth m`, digits = 1)
        
        for(i in 1:nrow(cast.data.info)){
          if(cast.data.info$`B Depth m` [i] == cast.data.info$`Depth m`[i] ) {
            cast.data.info$depth.category[i:nrow(cast.data.info)] = "B"
            cast.data.info$depth.category[1:(i-1)] = "INT"
          } else {
            bvalues = which(cast.data.info$`Depth m` >= cast.data.info$`B Depth m`)
            cast.data.info$depth.category[bvalues] = "B"
            cast.data.info$depth.category[-c(bvalues)] = "INT"
          }
        }                                                                                                                         
        
        # More formatting
        cast.data.info = cast.data.info[,c(1,32,2,3,4,33,7,8,5,6,9,10,11,12,13,14,15,16,
                                           17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)]
        names(cast.data.info)[6] = "Depth Category"
        
        # this isn't working (change time back to HH:MM:SS after being converted to decimal hours for processing)
        #cast.data.info[,6] = sapply(as.character(cast.data.info[,6]), as.hms)
        
        # Add Value Qualifiers
        for(i in 1:nrow(cast.data.info))
          if(!is.null(cast.data.info$count[i]) & cast.data.info$count[i] == 2) {
            cast.data.info$'ValueQualifier'[i] = 'BCT'
          }
        
        # Combine file with other cast data
        if(!exists("all.casts")){
          all.casts = cast.data.info
        } else{
          all.casts = rbind.fill(all.casts, cast.data.info)
        }
        
        # Close bracket for if file exists
      } else {print(paste(file.name2, "cast does not exist"))
      }
      
      # Close bracket for file loop
    }
    
    # After adding data to ctd.all file, remove all dfs/values/functions in the environment so we can run another file
    # This keeps the id info from GLClad which we need for every loop (& the ctd.all file)
    rm(data, col.only, in.water, data.downcast, data.ag.downcast, data.count, cast.data, cast.data.processed, 
       bins2.data, gap.info, data.upcast, data.ag.upcast, temp.comp, data.ag.up.and.down.cast, up.and.down.data.count, 
       up.and.down.data, up.and.down.bins2.data, up.and.down.gap.info, downcast.gap.count, file.name, 
       file.name2, gap.count.up.down, max.index, min.index, note.downcast.gaps, note.temp.diff, note.up.and.down.gaps, 
       start.row, temp.diff, downcast.bins2.qaqc.graphs, downcast.qaqc.graphs, 
       up.and.down.cast.bins2.qaqc.graphs, up.and.down.cast.qaqc.graphs,cast.data.info, downcast.1.5m.gap.count, 
       up.down.1.5m.gap.count, note.downcast.1.5m.gap.count, note.up.down.1.5m.gap.count)
    if(exists("bins2")) {rm(bins2)}
    if(exists("note.bins2.downcast")) {rm(note.bins2.downcast)}
    if(exists("note.bins2.up.and.down")) {rm(note.bins2.up.and.down)}
    if(exists("cast2.data")) {rm(cast2.data)}
    if(exists("up.and.down2.data")) {rm(up.and.down2.data)}
    if(exists("day")) {rm(day)}
    if(exists("lchem")) {rm(lchem)}
    if(exists("note.temp.diff.na")) {rm(note.temp.diff.na)}
    if(exists("siteandstation")) {rm(siteandstation)}
    
    # Save file to server
    write.csv(all.casts, file = choose.files(multi = F, caption = "Save all.casts file"),
    row.names = FALSE)
    
    # Save output of function into environment
    return(all.casts)
    
    # Close bracket for whole ctdprocess() function
  }
  
  ### RUN FUNCTION ###
  all.casts=ctdprocess()
  
  # Close bracket for HABs function
}

## RUN HABs FUNCTION
HABsWQP()

# Close bracket for if/else statement about which project
}
