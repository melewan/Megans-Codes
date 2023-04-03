### ANOVA in R ###



## Bring data in ##

# 1. Load required packages
library(readxl)


# 2. Set working directory 
setwd()

# example
setwd("F:/DATA/Coastal Ecosystems/Production Dynamics/Cladophora/Data/2020/DataRelease")

# Or, can use Session > Set Working Directory



# 3. Pull in necessary files (can use read.csv(), or read_excel() which needs a package)
dataframename = read_excel()

# example
benthicChem2020 = read_excel("BenthicChem2020_v2.xlsx",
                              sheet = "NewTissueBulkWeight2020")



## Manipulate data ##

# 4. subset (2 ways)

    # 4a. subset data by certain values 
      newdataframe = subset(dataframename, spcond > 180 & depth >= 0)

    # 4b. subset by columns you want to keep
      newdataframe = dataframename[c("Date (MM/DD/YYYY)", "Time (HH:MM:SS)", "Depth m", "Chlorophyll RFU", "ODO mg/L", "SpCond µS/cm", 
                                      "BGA PC RFU", "Turbidity FNU", "pH", "Temp °C")]


# 5. formatting (if applicable)

# Change BDLs to 0
benthicChem2020$DreissTotalWeight [benthicChem2020$DreissTotalWeight == "BDL"] <- 0
benthicChem2020$DreissTissueWeight [benthicChem2020$DreissTissueWeight == "BDL"] <- 0

# turn character columns into numeric format (2 ways)

  # a. make ALL columns numeric
    newdataframe = sapply(newdataframe, as.numeric, na.rm = TRUE)
    
  # b. make specified columns numeric
    newdataframe$column = as.numeric(newdataframe$column)
    
     # example
     benthicChem20outliers$DreissTotalWeight <- as.numeric(benthicChem20outliers$DreissTotalWeight)
     benthicChem20outliers$DreissTissueWeight <- as.numeric(benthicChem20outliers$DreissTissueWeight)
     
     

## ANOVA ##
     

# This function will calculate the test statistic for ANOVA
# and will determine whether there is a significant variation among the groups
     aov()

# one way     
onewayanova = aov(dependentvariable ~ independentvariable, data = dataframename, weights = )

# summary function will print results in the console below
summary(onewayanova)

# results
  # df = displays degrees of freedom
  # sum sq = displays the sum of squares (total variation between group means and overall mean)
  # mean sq = mean of the sum of squares (sum of squares divided by degrees of freedom)
  # F-value = test statistic from the F test (mean square of each independent variable divided by the mean square of the residuals)
  # Pr(>F) = p-value of the F-statistic


# two way
twowayanova = aov(dependentvariable ~ independentvariable1 + independentvariable2, data = dataframename)

summary(twowayanova)




# Test for best model fit (oneway or twoway) to explain the data (not sure if we need this part but wanted to include)

# AIC = akaike information criterion
  # calculates the information value of each model by balancing the variation explained against the number of parameters used

library(AICcmodavg)

model.set = list(onewayanova, twowayanova)
model.names = c("onewayanova", "twowayanova")

aictab(model.set, modnames = model.names)

# results
  # AICc value = lowest score means its the best fit
  # AICcWt = example: 0.71 = model explains 71% of the total variation


# Test for homoscedasticity = if all random variables have the same finite variance
 # par - can make multiple plots at once

par(mfrow = c(2,2)) # 4 graphs, 2x2
plot(twowayanova)
par(mfrow = c(1,1))

# the diagnostic plots show the unexplained variance (residuals)
# each plot gives a piece of information about the model fit, but it's enough to know:
    # the red line (representing the mean of the residuals) should be horizontal and centered on zero (or 1, in the scale-location plot),
         # meaning that there are no large outlier that would cause bias in the model
    # the normal Q-Q plot plots a regression between the theoretical residuals of a perfectly homoscedastic model and the actual residuals of your model
        # the closer to a slope of 1 it is, the better
# if this is true for our model, from these plots we can say that the model fits the assumption of homoscedasticity
    # if it does not fit this assumption, try Kruskall-Wallis instead





## Tukey's test ##

# ANOVA tells us if there is a difference among group means, but not what the differences ARE

tukey = TukeyHSD(twowayanova)
summary(tukey)

# results
  # p-value results show which groupings are significantly different from each other (2-1, 3-1, 1-2)





# source: https://www.scribbr.com/statistics/anova-in-r/ 



