% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ppt_debug_functions.R
\name{ppt_check}
\alias{ppt_check}
\title{Check Powerpoint}
\usage{
ppt_check(ppt_template, master, print = FALSE)
}
\arguments{
\item{ppt_template}{String. Path to ppt template}

\item{master}{String. Name of master slide template}

\item{print}{Logical. Should items be printed}
}
\value{
message
}
\description{
Checks for duplicate ph elements using \code{\link{ph_duplicate_check}} and
matching master arguments using \code{\link{ppt_layout}}.
}
