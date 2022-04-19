#*******************************************************************************
#*
#*
#*                           A Panel of Network Plots                          
#*        (Dogliotti et al.; PMID: 24009224 - Low median baseline risk)                             
#*         (Baker et al.PMID: 19637942 - Moderate median baseline risk)
#*       
#*                     
#*******************************************************************************



## Load libraries
list.of.packages <- c("readxl", "rnmamod")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages) 



## Load datasets
# Baker
baker <- as.data.frame(read_excel("./31_Datasets/Baker_Dataset.xlsx", na = "NA", sheet = "Network_plot"))[, 7:18]
colnames(baker) <- c(paste0("t..", 1:4, "."), paste0("r..", 1:4, "."), paste0("n..", 1:4, "."))

# Dogliotti
dogliotti <- as.data.frame(read_excel("./31_Datasets/Dogliotti_Dataset.xlsx", na = "NA"))[, 7:15]
colnames(dogliotti) <- c(paste0("t..", 1:3, "."), paste0("r..", 1:3, "."), paste0("n..", 1:3, "."))



## Interventions names
baker_names <- c("PBO", "LABA", "ICS", "ICS plus \n LABA", "tiotropium")

dogliotti_names <- c("control", "vitamin K \n  antagonists", "apixaban", "aspirin", 
                     "aspirin plus \n clopidogrel", "dabigatran 110mg", 
                     "dabigatran 150mg", "rivaroxaban")

#dogliotti_names <- c("adjusted dose \n coumarin", "vitamin K \n antagonist", 
#                     "adjusted dose \n warfarin", "apixaban", "aspirin", 
#                     "aspirin plus \n clopidogrel", "dabigatran \n 110mg", 
#                     "dabigatran \n 150mg", "no treatment", "rivaroxaban", 
#                     "placebo")



# Create the networks
tiff("./30_Analysis/Figure 1.tiff", height = 20, width = 35, units = 'cm', compression = "lzw", res = 600)

layout(matrix(c(1, 2, 3, 3), 1, 2, byrow = TRUE))

netplot(data = baker,
        drug_names = baker_names,
        save_xls = FALSE)

mtext(paste('(a)'), 1, line = 0)

netplot(data = dogliotti,
        drug_names = dogliotti_names,
        save_xls = FALSE)
mtext(paste('(b)'), 1, line = 0)

dev.off()
