***

# Obtaining and displaying absolute risks in the context of multiple comparisons

## Description of the repository

The repository offers the typical structure of separate folders for data, and R scripts, respectively.
* The __data__ folder includes three input .RData files: _baker_published_, _baker_network_, and _dogliotti_afresh_;
* The __R__ folder includes three analysis scripts (_Network plots.R_, _Absolute risks_NMA afresh.R_, and _Absolute risks_NMA results.R_) to replicate Figures 1 and 2 and Table 1 of the manuscript, and the script _obtain.absolute.risks_function.R_ to obtain the unique absolute risks using the results of a published systematic review with network meta-analysis. 

After downloading/cloning the repo, the user can use the .Rproj file to source all code.

## Output 

[rnmamod](https://CRAN.R-project.org/package=rnmamod) is the prerequisite R package.

### Replicate the results

Open and run the R script of interest to replicate the results of the manuscript.

### Obtain unique absolute risks using the published NMA results

To obtain the unique absolute risks for each intervention using the results of a published systematic review, we have developed the function `absolute_risk()` which has the following syntax: 

```r
absolute_risk(data, 
              ref, 
              base_risk, 
              measure, 
              log)
```
#### Explaining the arguments

* data: A data-frame with the NMA effects of comparisons with the reference intervention of the network, known as basic parameters. The data-frame has _T-1_ rows (_T_ is the number of interventions in the network) and four columns that contain the name of the non-reference interventions, the point estimate, the lower and upper bound of the 95% (confidence or credible) interval of the corresponding basic parameters.
* ref: Character string with the name of the reference intervention.
* base_risk: A number in the interval (0, 1) that indicates the baseline risk for the selected reference intervention.
* measure: Character string indicating the effect measure of _data_. The following can be considered: _"OR"_, _"RR"_ or _"RD"_ for the odds ratio, relative risk, and risk difference, respectively. 
* log: Logical to indicate whether to exponentiate the dataset or not.

#### Using the example 

Read the data from the systematic review of [Baker et al. (2009)](https://pubmed.ncbi.nlm.nih.gov/19637942/) (see _baker_published_ in the __data__ folder). The data are odds ratios of comparisons with the placebo.

```r
baker
       PBO_comp point lower upper
#> 1       LABA  0.84  0.76  0.92
#> 2 Tiotropium  0.69  0.61  0.76
#> 3        ICS  0.85  0.75  0.97
#> 4   ICS+LABA  0.76  0.67  0.85
```

Next, use the `absolute_risk()` function to obtain unique absolute risks assuming a baseline risk of 0.34 for the placebo (the median risk event across the placebo-controlled trials).

```r
absolute_risk(data = baker, 
              ref = "PBO", 
              base_risk = 0.34, 
              measure = "OR", 
              log = FALSE)
```
```r
     versus PBO point lower upper
#> 1       LABA   302   281   322
#> 2 Tiotropium   262   239   281
#> 3        ICS   305   279   333
#> 4   ICS+LABA   281   257   305
```
