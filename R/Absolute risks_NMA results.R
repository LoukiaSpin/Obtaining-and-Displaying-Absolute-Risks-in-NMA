#*******************************************************************************
#*
#*
#*                            Use Network Meta-Analysis results
#*                    <Absolute risks using transitive risks assumption>                    
#*       
#*                     
#*******************************************************************************



## Load R functions
source("./R/obtain.absolute.risks_function.R")



## Load dataset
load("./data/baker_published.RData")



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
colnames(rd) <- colnames(res);



## Bring all together
table1 <- data.frame(baker,        # odds ratio (basic parameters) as published
                     res[, 2:4],   # calculated absolute risks
                     rd[, 2:4])    # caclulated risk differences
colnames(table1) <- c("versus PBO", 
                      "OR", "lower", "upper",
                      "AR", "lower", "upper",
                      "RD", "lower", "upper");table1


## Create Table 1 
table1[order(table1$OR),]