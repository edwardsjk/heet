% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{p.cor}
\alias{p.cor}
\title{a function to implement parametric correction}
\usage{
p.cor(times, obsfxn, fp_rate, d_rate, theta)
}
\arguments{
\item{times}{a vector of ordered unique observed event times}

\item{obsfxn}{a vector of risk estimates of each time}

\item{fp_rate}{estimated false positive rate (can be a vector of the same length as time or a scalar)}

\item{d_rate}{estimated detection rate (can be a vector of the same length as time or a scalar)}

\item{theta}{estiamted probability of observing an event on time (can be a vector of the same length as time or a scalar)}
}
\description{
a function to implement parametric correction
}
\examples{
p.cor(obsrisk$time, obsrisk$risk, est_Fp_rate, est_d_rate, est_theta)

}
