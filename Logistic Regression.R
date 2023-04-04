# Logistic Regression

# load packages
library(ggplot2)

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

# rename some columns
names(wcadcp)[1] = "Year"
names(wcws)[1] = "Year"
names(wcadcp)[2] = "Transect"
names(wcadcp)[3] = "DateTime"
names(wcws)[3] = "DateTime"

# format column
inputx$X = as.numeric(inputx$X)

#fit logistic regression model
model <- glm(logitChl ~ Avg48hrSWH, family=binomial(), data=wcadcp)
options(scipen=999)   #disable scientific notation for model summary
summary(model)
capture.output(summary(model), file = paste("logitAmm x Avg48hrSpdCell01.csv"))

# find values from model (x cutoff, p value, AIC)
# predictor(x) variable = log odds - intercept/x_coeff
xval = (log(0.1/(1-0.1)) - coef(model)[1])/coef(model)[2]
pvalue = coef(summary(model))[2,4] # 2nd row (predictor), 4th value in summary (p value)
aic = AIC(model)

# plot
plot = ggplot(df, aes(Avg48hrSpdCell01, logitTP)) + 
  geom_point(data = wcadcp, aes(x = Avg48hrSpdCell01, y = abs(logitTP))) +
  stat_smooth(method = "glm", method.args = list(family=binomial), se = TRUE) + 
  xlab("Avg48hrSpdCell01") +
  ylab("logitAmm") #+
  #geom_vline(xintercept = xval)
ggexport(plot, filename = paste(modelname, ".pdf"))


# gather each parameter combination
columnames = c("Modelname", "Xval")
temp_df = data.frame(matrix(ncol = 2))
colnames(temp_df) <- columnames

for(i in 1:nrow (inputx)) {
  #i = 1
  logit = inputx$Nutrient[i]
  physical = inputx$ColumnName[i]
  if (inputx$Parameter[i] == "Wind Speed"){
    df = wcws
  } else {
    df = wcadcp
  }
  xlab = inputx$ColumnName[i]
  ylab = inputx$Nutrient[i]
  modelname = paste(logit, " x ", physical, sep = "")

# function for run model, calculate x, plot logit
modelall = function(logit, physical, df, xlab, ylab, modelname, data) {

# run model
model = glm(df[, c(logit)] ~ df[, c(physical)], family=binomial(), data= df)
options(scipen=999)
summary = summary(model)

# 1) save model output as a .csv
capture.output(summary(model), file = paste(modelname, ".csv"))

# 2) solve logit equation for x, using 10% probability and model coefficients
xval = as.numeric( (log(0.1/(1-0.1)) - coef(model)[1])/coef(model)[2] )
#inputx$X[i] = as.numeric( (log(0.1/(1-0.1)) - coef(model)[1])/coef(model)[2] )

#newrow <- c(modelname, xval)
#data[i, ] <- newrow
#print(c(modelname, xval))

# plot
plot = ggplot(df, aes(physical, logit)) + 
  geom_point(data = df, aes(x = df[, c(physical)], y = abs(df[,c(logit)]))) +
  stat_smooth(method = "glm", method.args = list(family=binomial), se = TRUE) + 
  scale_x_discrete()+
  xlab(xlab) +
  ylab(ylab)
ggexport(plot, filename = paste(modelname, ".pdf"))

return(inputx)
}

modelall(logit, physical, df, xlab, ylab, modelname)




}

