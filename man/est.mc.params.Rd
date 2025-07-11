% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{est.mc.params}
\alias{est.mc.params}
\title{a function to estimate fp_rate, event detection rate, and theta from validation data
this version repeats for each observed event time to get curves correct}
\usage{
est.mc.params(
  times,
  obs_times,
  true_times,
  obs_events,
  true_events,
  suppress = F
)
}
\arguments{
\item{times}{vector of ordered unique observed event times (if computing risk function) or tau}

\item{obs_times}{obs event times in validation data}

\item{true_times}{true event times in validation data}

\item{obs_events}{obs event indicator in validation data}

\item{true_events}{true event indicator in validation data}
}
\value{
a matrix with the estimated false positive rate, detection rate, and theta at each time
}
\description{
a function to estimate fp_rate, event detection rate, and theta from validation data
this version repeats for each observed event time to get curves correct
}
\examples{
est.mc.params(obsrisk$time, val$w, val$t, val$eta, val$delta)

}
