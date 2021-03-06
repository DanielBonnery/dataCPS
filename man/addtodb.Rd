% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data_from_web.R
\name{addtodb}
\alias{addtodb}
\title{Create an R file function}
\usage{
addtodb(m)
}
\arguments{
\item{m}{a date}
}
\description{
Create an R file function
}
\details{
creates a SQLite database if not existing and loads a downloaded file into it.
}
\examples{
download.instruction.file(as.Date("20040501","\%Y\%m\%d"))
}
