% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{misclass.boot}
\alias{misclass.boot}
\title{a function to bootstrap nonparametric and parametric estimators}
\usage{
misclass.boot(B, bootdata, valdata, taus_, risk_func)
}
\arguments{
\item{B}{number of bootstrap iterations}

\item{bootdata}{main study data}

\item{valdata}{validation study data}

\item{taus_}{timepoints of interest}

\item{risk_func}{choice of risk function. specify analysis_np, analysis_p, or a user-defined risk function with the same arguments}
}
\value{
a matrix with B rows containing risk at each time taus_ (in columns)
}
\description{
a function to bootstrap nonparametric and parametric estimators
}
