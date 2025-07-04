% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{analysis.np}
\alias{analysis.np}
\title{a function to perform nonparametric correction}
\usage{
analysis.np(obstimes, obseta, valw, valt, valeta, valdelta, taus_)
}
\arguments{
\item{obstimes}{observed event times in main study}

\item{obseta}{observed event indicators in main study}

\item{valw}{error-prone event times in validation study}

\item{valt}{gold standard event times in validation study}

\item{valeta}{error-prone event indicators in validation study}

\item{valdelta}{gold standard event indicators in validation study}

\item{taus_}{time points of interest}
}
\value{
estimated risk at each time in \code{taus_}
}
\description{
a function to perform nonparametric correction
}
\examples{
analysis.np(dat$w, dat$eta, val$w, val$t, val$eta, val$delta, 4*365.25)

}
