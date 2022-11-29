#*******************************************************************************
#*
#*
#*                            Use Network Meta-Analysis results
#*                    <Absolute risks using transitive risks assumption>                    
#*       
#*                     
#*******************************************************************************



## Load 'rnmamod' R package (development version)
library(rnmamod)



## Load dataset
load("./data/baker_published.RData")



## Obtain league table of absolute and relative effects
league_table_absolute_user(data = baker,
                           measure = "OR",
                           base_risk = 0.34,
                           drug_names = c("placebo", "LABA", "TIO", "ICS", "ICS+LABA"),
                           show = NULL)


# Help for the function 'league_table_absolute_user'
?league_table_absolute_user

