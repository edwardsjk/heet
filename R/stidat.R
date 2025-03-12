#' STI reinfection data
#' 
#' To illustrate use of the package, we induced outcome misclassification into publicly available data on time to reinfection for patients with sexually transmitted diseases, published on the website for Survival Analysis Techniques for Censored and Truncated Data, 2nd ed. by Klein and Moeshberger and described in section 1.12 of the book. This dataset followed 877 individuals from initial diagnosis of gonorrhea or chlamydia to reinfection or censoring.
#' 
#' We induced misclassification into the original dataset by creating w and eta and drawing a hypothetical internal validation study for with t and delta were available.
#' 
#' Therefore, this dataset should not be expected to reflect the real data in the textbook
#' 
#' @format ## `stidat`
#' A dataframe with 877 rows and 7 columns:
#' \describe{
#'    \item{id}{Participant ID}
#'    \item{age}{Age}
#'    \item{r}{Indicator of inclusion in validation study}
#'    \item{w}{Error-prone outcome time}
#'    \item{eta}{Error-prone outcome indicator}
#'    \item{t}{True event time}
#'    \item{delta}{True event indicator}
#'}
