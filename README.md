***

# Obtaining and displaying absolute risks in the context of multiple comparisons (COPD network)

## Description of the repository

The repository offers the typical structure of separate folders for data, and R scripts, respectively.
* The __data__ folder includes three input .RData files: _baker_published_, _baker_network_, and _dogliotti_afresh_;
* The __R__ folder includes three analysis scripts: use _Network plots.R_ to replicate Figure 1, use _Absolute risks_NMA anew.R_ to replicate Figure 2, and use _Absolute risks_NMA results.R_ to replicate Table 1 and appendix Figure 1 of the manuscript.

After downloading/cloning the repo, the user can use the .Rproj file to source all code.

## Output 

[rnmamod](https://CRAN.R-project.org/package=rnmamod) is the prerequisite R package.

### Replicate the results

Open and run the R script of interest to replicate the results of the manuscript.

### Obtain unique absolute risks using the published NMA results

To obtain the unique absolute risks for each intervention using the results of a published systematic review, employ the function `league_table_absolute_user()` which has the following (minimum required) syntax: 

```r
league_table_absolute_user(data, 
                           measure, 
                           base_risk, 
                           drug_names)
```
#### Explaining the arguments

* data: A data-frame with the NMA effects of comparisons with the reference intervention of the network, known as basic parameters. The data-frame has _T_ rows (_T_ is the number of interventions in the network) and four columns that contain the point estimate, the lower and upper bound of the 95% (confidence or credible) interval of the corresponding basic parameters, and a ranking measure to indicate the order of the interventions in the hierarchy from the best to the worst with possible choices a non-zero positive integer for the rank, the SUCRA value ([Salanti et al., 2011](https://pubmed.ncbi.nlm.nih.gov/20688472/)) or p-score value ([Ruecker and Schwarzer, 2015](https://pubmed.ncbi.nlm.nih.gov/26227148/)).
* measure: Character string indicating the effect measure of _data_. The following can be considered: _"OR"_, _"RR"_ or _"RD"_ for the odds ratio, relative risk, and risk difference, respectively. 
* base_risk: A number in the interval (0, 1) that indicates the baseline risk for the selected reference intervention.
* drug_names: A vector of labels with the name of the interventions in the order they appear in the argument _data_. The first intervention should be the selected reference intervention.

Run `?league_table_absolute_user()` to open the help file of the function.

#### Using the example 

Read the data from the systematic review of [Baker et al. (2009)](https://pubmed.ncbi.nlm.nih.gov/19637942/) (see _baker_published_ in the __data__ folder). The data are odds ratios of comparisons with the placebo in the logarithmic scale.

```r
baker
          point      lower       upper order
#> 1  0.0000000  0.0000000  0.00000000     5
#> 2 -0.1743534 -0.2744368 -0.08338161     3
#> 3 -0.3710637 -0.4942963 -0.27443685     1
#> 4 -0.1625189 -0.2876821 -0.03045921     4
#> 5 -0.2744368 -0.4004776 -0.16251893     2
```

Next, use the `league_table_absolute_user()` function to obtain unique absolute risks assuming a baseline risk of 0.34 for the placebo (the median risk event across the placebo-controlled trials). The table includes the relative and absolute effects for the basic parameters. Interventions are sorted from the best to the worst based on the odds ratio value (see column 'order' in _baker_).

```r
league_table_absolute_user(data = baker,
                           measure = "OR",
                           base_risk = 0.34,
                           drug_names = c("PBO", "LABA", "TIO", "ICS", "ICS+LABA"))
```
```r
$table_relative_absolute_effects


Table: Relative and absolute effects

|Interventions |  OR  | lower | upper | AR  | lower | upper |RD  | lower | upper |
|:-------------|:----:|:-----:|:-----:|:---:|:-----:|:-----:|:---|:-----:|:-----:|
|TIO           | 0.69 | 0.62  | 0.77  | 262 |  239  |  281  |-78 | -101  |  -59  |
|ICS+LABA      | 0.76 | 0.67  | 0.86  | 281 |  257  |  305  |-59 |  -83  |  -35  |
|LABA          | 0.84 | 0.76  | 0.92  | 302 |  281  |  322  |-38 |  -59  |  -18  |
|ICS           | 0.85 | 0.75  | 0.97  | 305 |  279  |  333  |-35 |  -61  |  -7   |
|PBO           | 1.00 | 1.00  | 1.00  | 340 |  340  |  340  |0   |   0   |   0   |
```
### Obtain unique absolute risks by conducting a new NMA (mortality network)

When we have the arm-based data for all trials, we can obtain the unique absolute risks for each intervention via the function `league_table_absolute()` which has the following (minimum required) syntax: 

```r
league_table_absolute(full, 
                      drug_names)
```
#### Explaining the arguments

* full: An object of S3 class `run_model()`. First, we will use the function `run_model()` to conduct the NMA (see next subsection 'Using the example'). Run `?run_model()` to open the help file of the function.
* drug_names: A vector of labels with the name of the interventions in the order they appear in the argument data of `run_model()`.

Run `?league_table_absolute()` to open the help file of the function.

#### Using the example 

Read the data from the systematic review of [Dogliotti et al. (2014)](https://pubmed.ncbi.nlm.nih.gov/24009224/) (see _dogliotti_afresh_ in the __data__ folder). The data has the one-trial-per-row format with arm-level data: number of events (_r_) out of the total randomised (_n_) in each arm of every trial (19 trials). The intervention coding under the columns _t_ refers to _control_, _vitamin K antagonists_, _apixaban_, _aspirin_, _aspirin plus clopidogrel_, _dabigatran 110mg_, _dabigatran 150mg_, and _rivaroxaban_ for 1 to 8, respectively.

```r
dogliotti
      t1 t2 t3  r1  r2  r3   n1   n2   n3
#> 1   2  4  1   3  12  15  335  336  336
#> 2   2  1 NA  11  26  NA  212  208   NA
#> 3   2  1 NA  10   8  NA  187  191   NA
#> 4   2  4  1   6  39  50  210  552  568
#> 5   2  1 NA  15  22  NA  260  265   NA
#> 6   2  4  1  41 102  99  225  404  378
#> 7   2  4 NA  62  65  NA  555  545   NA
#> 8   2  4 NA  17  14  NA  170  169   NA
#> 9   2  4 NA  12  66  NA  131  319   NA
#> 10  4  1 NA   6   6  NA  194   91   NA
#> 11  2  5 NA 158 159  NA 3371 3335   NA
#> 12  4  1 NA  10   9  NA  426  445   NA
#> 13  5  4 NA 825 841  NA 3772 3782   NA
#> 14  2  4 NA 107 108  NA  488  485   NA
#> 15  2  4 NA   1   2  NA   36   39   NA
#> 16  6  7  2 446 438 487 6015 6076 6022
#> 17  8  2 NA 582 632  NA 7081 7090   NA
#> 18  3  2 NA 603 669  NA 9120 9081   NA
#> 19  3  4 NA 111 140  NA 2808 2791   NA
```

Next, use the `run_model()` function to obtain unique absolute risks assuming a baseline risk of 0.34 for the placebo (the median risk event across the placebo-controlled trials). The table includes the relative and absolute effects for the basic parameters. Interventions are sorted from the best to the worst based on the odds ratio value (see column 'order' in _baker_).

```r
league_table_absolute_user(data = baker,
                           measure = "OR",
                           base_risk = 0.34,
                           drug_names = c("PBO", "LABA", "TIO", "ICS", "ICS+LABA"))
```
