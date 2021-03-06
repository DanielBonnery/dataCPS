% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data_from_web.R
\name{download.instruction.file}
\alias{download.instruction.file}
\title{Instruction file  download function}
\usage{
download.instruction.file(m)
}
\arguments{
\item{m}{a date}
}
\value{
a character string, the path to the unzipped file
}
\description{
Instruction file  download function
}
\details{
download the instruction file for a specific month
Not any month is valid
}
\examples{
download.instruction.file(as.Date("20040501","\%Y\%m\%d"))
}
