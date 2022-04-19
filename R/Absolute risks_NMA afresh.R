#*******************************************************************************
#*
#*
#*                      Run Network Meta-Analysis 'afresh'                     
#*     Binomial likelihood, logit link, Random Effects NMA (PMID: 23104435)     
#*     (Half-normal prior distribution on between-trial standard deviation)            
#*              <Absolute risks using transitive risks assumption>                                  
#*       
#*                     
#*******************************************************************************



## Load libraries
list_of_packages <- c("readxl", "rnmamod")
lapply(list_of_packages, require, character.only = TRUE); rm(list_of_packages) 



## Load 'rnmamod' from GitHub
#install.packages("devtools")
#devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)



## Load datasets
dogliotti <- as.data.frame(
  read_excel("./31_Datasets/Dogliotti_Dataset.xlsx", na = "NA"))[, 7:15]



## Interventions names
dogliotti_names <- c("control", "vitamin K antagonists", "apixaban", "aspirin", 
                     "aspirin plus clopidogrel", "dabigatran 110mg", 
                     "dabigatran 150mg", "rivaroxaban")



## Calculate median risk in reference intervention
netplot(data = dogliotti,
        drug_names = dogliotti_names,
        save_xls = FALSE)



## Run RE-NMA models
model_dogliotti <- run_model(data = dogliotti, 
                             measure = "RD",
                             model = "RE", 
                             heter_prior = list("halfnormal", 0, 1/(0.5)^2), 
                             D = 0, 
                             ref = 1,
                             base_risk = 0.07,
                             n_chains = 3, 
                             n_iter = 100000, 
                             n_burnin = 10000, 
                             n_thin = 10)
mcmc_diagnostics(model_dogliotti, 
                 par = c("abs_risk", "tau"))



## Create league-heatmap
tiff("./30_Analysis/Figure 2.tiff", 
     height = 25, 
     width = 40, 
     units = 'cm', 
     compression = "lzw", 
     res = 600)
league_table_absolute(full = model_dogliotti, 
                      drug_names = dogliotti_names)
dev.off()



################################################################################
forestplot(full = model_dogliotti,
           compar = "vitamin K antagonist",
           drug_names = dogliotti_names)

data2 <- data.frame(vitamin_comp = c("coumarin", "dab150", "apixaban", "dab110", "rivar", "warfarin", "aspirin+", "aspirin", "no treat", "pbo"),
                    point = c(0.51, 1.01, 1.04, 1.05, 1.06, 1.15, 1.27, 1.36, 1.69, 1.80),
                    lower = c(0.20, 0.50, 0.57, 0.51, 0.51, 0.65, 0.68, 0.82, 0.66, 1.08),
                    upper = c(1.23, 1.93, 1.88, 1.99, 2.01, 1.94, 2.24, 2.29, 4.33, 3.03))

absolute_risk(data = data2, 
              ref = "vitamin", 
              base_risk = 0.053,
              measure = "OR",
              log = FALSE)

