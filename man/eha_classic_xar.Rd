% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eha_classic_xar.R
\name{eha_classic_xar}
\alias{eha_classic_xar}
\title{EHA Xaringan Theme}
\usage{
eha_classic_xar(aspect = "16x9", self_contained = TRUE, ...)
}
\arguments{
\item{aspect}{String. Aspect ratio for slides.
Either "16x9" or "4x3". Default is "16x9"}

\item{self_contained}{Whether to produce a self-contained HTML file by
embedding all external resources into the HTML file.}

\item{...}{other arguments passed to \code{\link[xaringan]{moon_reader}} or
\code{\link[rmarkdown]{html_document}}}
}
\value{
xaringan theme
}
\description{
A function to produce an EHA Xaringan theme with the classic font. This
function leans on \code{\link[xaringanthemer]{style_mono_light}} for many of
the theme arguments. It uses \code{\link[xaringan]{moon_reader}} to create
the markdown renderable object. Unlike \code{\link{eha_classic_pptx}}, you
cannot create editable plots with \code{\link[rvg]{dml}}.  However, you can
include interactive html widgets.
}
\note{
There is an issue using \code{\link[sysfonts]{sysfonts}} with
M1 mac machines therefore\code{\link[xaringanthemer]{theme_xaringan}} is not
able to use \code{\link[xaringanthemer]{google_font}} when creating ggplot themes.
}
