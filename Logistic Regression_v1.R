# Logistic Regression

# load packages
library(ggplot2)
library(readr)

# setwd
setwd("C:/Users/melewan/Desktop/Data files")

# load files
wcadcp <- read.csv("C:/Users/melewan/Desktop/Data files/wc_adcp_all.csv", header = TRUE)
wcws <- read.csv("C:/Users/melewan/Desktop/Data files/wc_ws_all.csv", header = TRUE)
inputx <- read.csv("C:/Users/melewan/Desktop/Data files/logit - nutrient x physical parameters.csv", header = TRUE)

# remove unnecessary columns
wcadcp <- subset(wcadcp, select = -c(1,2,5:8,10:12,14:15,17:18,20:21,23:24,26:27,29:33,35:36,
                                     38:39, 41:42, 44:55))
wcws <- subset(wcws, select = -c(1,2,5:8,10:12,14:15,17:18,20:21,23:24,26:27,29:33,35:36,
                                     38:39, 41:42, 44:52))

# remove outliers
wcws$Max24hrWSPD [wcws$Max24hrWSPD > 20] <- NA
wcws$Max48hrWSPD [wcws$Max48hrWSPD > 20] <- NA
wcadcp$Avg48hrSWH [wcadcp$Max48hrSWH > 60] <- NA

# rename some columns
names(wcadcp)[1] = "Year"
names(wcws)[1] = "Year"
names(wcadcp)[2] = "Transect"
names(wcadcp)[3] = "DateTime"
names(wcws)[3] = "DateTime"

# make 1,0 columns numeric
wcadcp[,c(4:13)] = sapply(wcadcp[,c(4:13)], as.numeric)
wcws[,c(4:13)] = sapply(wcws[,c(4:13)], as.numeric)

# create new df for xval output
columnames = c("Modelname", "Xval", "Pvalue", "AIC")
temp_df = data.frame(matrix(ncol = 4))
colnames(temp_df) <- columnames

# gather info for each parameter combination and loop through all
for(i in 1:nrow (inputx)) {
  #i = 1
  logit = inputx$Nutrient[i]
  physical = inputx$ColumnName[i]
  if (inputx$Parameter[i] == "Wind Speed"){
    df_list = list(wcws = wcws)
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
