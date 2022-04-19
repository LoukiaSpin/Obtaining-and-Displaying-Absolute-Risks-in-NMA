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



## Load 'rnmamod' package
library("rnmamod")



## Load dataset
load("./data/dogliotti_afresh.RData")



## Interventions names
dogliotti_names <- c("control", "vitamin K antagonists", "apixaban", "aspirin", 
                     "aspirin plus clopidogrel", "dabigatran 110mg", 
                     "dabigatran 150mg", "rivaroxaban")



## Calculate median risk in each intervention
netplot(data = dogliotti,
        drug_names = dogliotti_names,
        save_xls = FALSE)$table_interventions



## Run RE-NMA model
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



## Check convergence of model parameters
mcmc_diagnostics(model_dogliotti, 
                 par = c("EM", "tau"))



## Create league-heatmap
league_table_absolute(full = model_dogliotti, 
                      drug_names = dogliotti_names)
