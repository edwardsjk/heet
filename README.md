
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `heet`: Handling error in event times

<!-- badges: start -->
<!-- badges: end -->

`heet` is an `R` package to account for outcome misclassification in
risk and survival functions. Full methods provided in “Risk functions
with outcome misclassification”, full citation to be provided upon
publication.

The current version of the package assumes the user has access to a main
study dataset with an error prone event time and event indicator. This
dataset may be subject to right censoring. The package also requires a
validation study datasets that contains both error-prone and gold
standard event times and indicators. The validation dataset may also be
subject to right censoring.

The package provides 2 high level functions to account for outcome
misclassification: 1. `analysis.np` implements a nonparametric estimator
to account for outcome misclassification. In this version of the
estimator, the misclassification probabilities are computed empirically
at each observed event time. 2. `analysis.p` impelements a parametric
estimator to account for outcome misclassification. In this version of
the estimator, parametric functions for the misclassification
probabilities are computed up through each timepoint of interest in a
piecewise manner.

Both functions allow the user to specify the timepoints of interest
`taus_`. If the only timepoint of interest is the end of follow-up,
`taus_` should be set to a single value corresponding to the end of
follow up. If the entire risk function is of interest, `taus_` should be
a vector containing each observed event time.

In addition to the high level functions, the package provides a
specialty bootstrapping function `misclass.boot` to resample the main
study data and validation data and apply `analysis.np` or `analysis.p`
functions. The `misclass.boot` function outputs `B` point estimates,
where `B` is the requested number of bootstrap iterations. The standard
error of the estimator may be computed as the standard deviation of
these `B` estimates.

Finally, the package also provides helper functions used in intermediate
steps of the analysis (e.g., to compute empirical misclassification
probabilities at each event time and their parametric counterparts).

## Installation

You can install the development version of heet from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("edwardsjk/heet")
```

## Example

To illustrate use of the package, we induced outcome misclassification
into publicly available data on time to reinfection for patients with
sexually transmitted diseases, published on the website for Survival
Analysis Techniques for Censored and Truncated Data, 2nd ed. by Klein
and Moeshberger and described in section 1.12 of the book. This dataset
followed 877 individuals from initial diagnosis of gonorrhea or
chlamydia to reinfection or censoring. The purpose of the original study
was to identify factors related to time to reinfection, but here we aim
to report the overall 4-year risk of reinfection. The manipulated
version of the dataset is stored in the package as `stidat`.

``` r
library(heet)
head(stidat)
#>   id age r    w eta   t delta
#> 1  1  19 1  984   0 984     0
#> 2  2  23 0  984   0  NA    NA
#> 3  3  33 0   42   0  NA    NA
#> 4  4  43 0   54   1  NA    NA
#> 5  5  30 0 1461   0  NA    NA
#> 6  6  24 0   70   0  NA    NA
```

We can apply the functions in the package to estimate the observed risk
function from the error-prone event times and indicators using

``` r
obsrisk <- est.riskfxn(stidat$w, stidat$eta)
#> Loading required package: survival
naiverisk_4years <- get.risk(obsrisk$time, obsrisk$risk, taus = 4*365.25)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
naiverisk_4years
#> [1] 0.4137436
```

To account for misclassification using the nonparametric estimator, we
first create a new dataset with only the validation data and then apply
the function `est.np.ab()` to compute `a` and `b` at each event time.
The `a` and `b` functions are then used to account for misclassification
in the risk function nonparametrically using `np.cor`.

``` r

val <- stidat %>% filter(r == 1)
ab <- est.np.ab(obsrisk$time, val$w, val$t, val$eta, val$delta)
npcor <- np.cor(obsrisk$time, obsrisk$risk, ab[,2], ab[,3])
npcor_risk_4yrs <- get.risk(npcor$time, npcor$risk, taus = 4*365.25)
npcor_risk_4yrs
#> [1] 0.563315
```

Rather than calling each function individually, we could use the wrapper
function `analysis.np()`, as seen below:

``` r

fullnp <- analysis.np(stidat$w, stidat$eta, val$w, val$t, val$eta, val$delta, 4*365.25)
fullnp
#> [1] 0.563315
```

To account for misclassification using the parametric estimator, we use
the validation dataset to estimate $\lambda_{fp}$, $\lambda_d$, and
$\theta$. Then we supply these parameters to the `p.cor()` function to
compute risk.

``` r

parms <- est.mc.params(obsrisk$time, val$w, val$t, val$eta, val$delta)
#> This function recomputes a and b at each time supplied in the `times` vector
pcor <- p.cor(obsrisk$time, obsrisk$risk, parms[,1], parms[,2], parms[,3])
pcor_risk_4yrs <- get.risk(pcor$time, pcor$risk, taus = 4*365.25)
pcor_risk_4yrs
#> [1] 0.625001
```

Again, rather than calling each function individually, we could use the
wrapper function `analysis.p()`, as seen below:

``` r

fullp <- analysis.p(stidat$w, stidat$eta, val$w, val$t, val$eta, val$delta, 4*365.25)
#> This function recomputes a and b at each time supplied in the `times` vector
fullp
#> [1] 0.6252066
```
