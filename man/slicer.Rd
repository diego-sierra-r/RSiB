% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_wrangling_functions.R
\name{slicer}
\alias{slicer}
\title{Pick slices of a data.frame}
\usage{
slicer(df, slice, wide)
}
\arguments{
\item{df}{A data.frame.}

\item{slice}{An integer or an object which can be coerced to such, the slice number to keep.}

\item{wide}{An integer or an object which can be coerced to such, the number of rows the slice is going to have.}
}
\value{
a data.frame
}
\description{
With \code{\link[=slicer]{slicer()}} it's possible subset rows choosing how wide you want the resulting data.drame and which slice you want to pick.
}
\examples{
slicer(iris,1,4)
slicer(iris,6,2)
}
