#*******************************************************************************
#*
#*
#*                           A Panel of Network Plots 
#*         (Baker et al.PMID: 19637942 - Moderate median baseline risk)                          
#*        (Dogliotti et al.; PMID: 24009224 - Low median baseline risk)                             
#*       
#*                     
#*******************************************************************************



## Load library
library("rnmamod")



## Load datasets
# Baker
load("./data/baker_network.RData")

# Dogliotti
load("./data/dogliotti_afresh.RData")



## Interventions names
baker_names <- c("placebo", "LABA", "ICS", "ICS plus \n LABA", "tiotropium")

dogliotti_names <- c("control", "vitamin K \n  antagonists", "apixaban", "aspirin", 
                     "aspirin plus \n clopidogrel", "dabigatran 110mg", 
                     "dabigatran 150mg", "rivaroxaban")



# Create the networks
layout(matrix(c(1, 2, 3, 3), 1, 2, byrow = TRUE))

netplot(data = baker,
        drug_names = baker_names,
        save_xls = FALSE)

mtext(paste('(a)'), 1, line = 0)

netplot(data = dogliotti,
        drug_names = dogliotti_names,
        save_xls = FALSE)
mtext(paste('(b)'), 1, line = 0)
