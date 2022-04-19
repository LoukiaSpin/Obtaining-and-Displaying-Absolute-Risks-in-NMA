#*******************************************************************************
#*
#*
#*                            Use Network Meta-Analysis results
#*                    <Absolute risks using transitive risks assumption>                    
#*       
#*                     
#*******************************************************************************



## Load libraries
list_of_packages <- "readxl"
lapply(list_of_packages, require, character.only = TRUE); rm(list_of_packages) 



## Load R functions
source("./32_R models/obtain.absolute.risks_function.R")



## Load datasets
# Baker
baker <- as.data.frame(
  read_excel("./31_Datasets/Baker_Dataset.xlsx", na = "NA", sheet = "Analysis"))



## Obtain absolute risks
res <- absolute_risk(data = baker, 
                     ref = "PBO", 
                     base_risk = 0.34,
                     measure = "OR",
                     log = FALSE) 



## Obtain risk difference (as function of absolute risks)
rd <- data.frame(res$`versus PBO`, 
                 res$point - 340, 
                 res$lower - 340, 
                 res$upper - 340)
colnames(rd) <- colnames(res); rd




## Using LABA-comparisons and baseline risk for LABA from above
# dataset
data2 <- data.frame(LABA_comp = c("tiotropium", "ICS", "ICS+LABA", "PBO"),
                    point = c(0.82, 1.01, 0.90, round(1/0.84, 2)),
                    lower = c(0.72, 0.89, 0.80, round(1/0.92, 2)),
                    upper = c(0.93, 1.15, 1.01, round(1/0.76, 2)))

# Obtain absolute risks
absolute_risk(data = data2, 
              ref = "LABA", 
              base_risk = 0.302,
              measure = "OR",
              log = FALSE)
