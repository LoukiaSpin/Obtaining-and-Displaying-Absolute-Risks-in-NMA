#*******************************************************************************
#*
#*
#*                  Run Frequentist Network Meta-Analysis 'anew'                                       
#*              <Absolute risks using transitive risks assumption>                                  
#*       
#*                     
#*******************************************************************************



## Load 'netmeta' and 'rnmamod' R packages 
library("netmeta"); library("rnmamod")



## Load dataset
load("./data/dogliotti_afresh.RData")



## Interventions names
dogliotti_names <- c("control", "vitamin K antagonists", "apixaban", "aspirin", 
                     "aspirin plus clopidogrel", "dabigatran 110mg", 
                     "dabigatran 150mg", "rivaroxaban")



## Obtain median risk in each intervention
netplot(data = dogliotti,
        drug_names = dogliotti_names,
        save_xls = FALSE)$table_interventions

# Help for the function 'netplot' (rnmamod)
?netplot



## Transform data from arm-based to contrast-based format
trans_data <- pairwise(treat = list(t1, t2, t3), 
                       event = list(r1, r2, r3),
                       n = list(n1, n2, n3),
                       data = dogliotti, 
                       studlab = as.factor(1:19))

# Help for the function 'pairwise' (netmeta)
?pairwise



## Run frequentist NMA
net_mortality <- netmeta(TE = TE, 
                         seTE = seTE, 
                         treat1 = treat1, 
                         treat2 = treat2, 
                         studlab = studlab,
                         data = trans_data, 
                         sm = "OR", 
                         random = TRUE)

# Help for the function 'netmeta' (netmeta)
?netmeta



## Prepare data for the 'league_table_absolute_user' function
# Keep the estimated basic parameters (comparisons with the reference, 'Treatment 1' (control))
point <- exp(net_mortality$TE.random)[, 1]
lower <- exp(net_mortality$lower.random)[, 1]
upper <- exp(net_mortality$upper.random)[, 1]

# Obtain the p-score (type ?netrank)
pscore <- netrank(net_mortality, 
                  small.values = "bad",
                  method = "P-score")$Pscore.random

# Rank the interventions based on their p-score
treat_rank <- rank(pscore)

#' See argument 'data' in 'league_table_absolute_user' function 
#' to understand the set-up of the 'dataset' below
#' (type ?league_table_absolute_user)
dataset <- cbind(point, lower, upper, treat_rank)



## Create the league-heatmap
league_table_absolute_user(data = dataset, 
                           measure = "OR",
                           base_risk = 0.07,
                           drug_names = dogliotti_names)

# Help for the function 'league_table_absolute_user' (rnmamod)
?league_table_absolute_user

#' Note: There is a typo in the 'Table: Relative and absolute effects' for OR; the results
#' refer to log OR - not OR. We will correct this mistake in the upcoming update of the 
#' 'rnmamod' package!
