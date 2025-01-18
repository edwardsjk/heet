# `heet`: Handling error in event times

`heet` is an `R` package to account for outcome misclassification in risk and survival functions. Full methods provided in "Risk functions with outcome misclassification", full citation to be provided upon publication.

The current version of the package assumes the user has access to a main study dataset with an error prone event time and event indicator. This dataset may be subject to right censoring. The package also requires a validation study datasets that contains both error-prone and gold standard event times and indicators. The validation dataset may also be subject to right censoring.

The package provides 2 high level functions to account for outcome misclassification: 
1. `analysis_np` implements a nonparametric estimator to account for outcome misclassification. In this version of the estimator, the misclassification probabilities are computed empirically at each observed event time.
2. `analysis_p` impelements a parametric estimator to account for outcome misclassification. In this version of the estimator, parametric functions for the misclassification probabilities are computed up through each timepoint of interest in a piecewise manner.

Both functions allow the user to specify the timepoints of interest `taus_`. If the only timepoint of interest is the end of follow-up, `taus_` should be set to a single value corresponding to the end of follow up. If the entire risk function is of interest, `taus_` should be a vector containing each observed event time. 

In addition to the high level functions, the package provides a specialty bootstrapping function `misclass.boot` to resample the main study data and validation data and apply `analysis_np` or `analysis_p` functions. The `misclass.boot` function outputs `B` point estimates, where `B` is the requested number of bootstrap iterations. The standard error of the estimator may be computed as the standard deviation of these `B` estimates.

Finally, the package also provides helper functions used in intermediate steps of the analysis (e.g., to compute empirical misclassification probabilities at each event time and their parametric counterparts). 

This package may be installed using `dev_tools` by running `install_github("edwardsjk/heet")`
