% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{est.np.ab}
\alias{est.np.ab}
\title{a function to compute a(t) and b(t) nonparametrically in validation data}
\usage{
est.np.ab(times, obs_times, true_times, obs_events, true_events)
}
\arguments{
\item{times}{unique observed event times}

\item{obs_times}{observed event times in validation data}

\item{true_times}{true event times in validation data}

\item{obs_events}{observed event indicator in validation data}

\item{true_events}{true event indicator in validation data}
}
\value{
a dataframe with times and values of a and b at each time
}
\description{
a function to compute a(t) and b(t) nonparametrically in validation data
}
\examples{
est.np.ab(obsrisk$time, val$w, val$t, val$eta, val$delta)

}
