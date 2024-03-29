% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_templates.R
\name{check_templates}
\alias{check_templates}
\title{Check that all templates build properly}
\usage{
check_templates(
  style = c("classic", "avenir", "predict"),
  format = c("pptx", "xar", "flex"),
  aspect = c("4x3", "16x9"),
  check_all = FALSE,
  render = TRUE,
  outdir = "./",
  recursive = TRUE
)
}
\arguments{
\item{style}{String. One of "classic", "avenir", or "predict"}

\item{format}{String. One of "pptx","xar", or"flex"}

\item{aspect}{String. One of "4x3" or "16x9"}

\item{check_all}{Logical. Should we open all the templates as RMDs?}

\item{render}{Logical. Should we render the templates we open?}

\item{outdir}{String. Where should files be stored}

\item{recursive}{Logical. Should subfolders of outdir be created}
}
\description{
Opens markdown templates as rmd files and/or renders them into their
appropriate format.
}
