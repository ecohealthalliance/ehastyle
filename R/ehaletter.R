#' Create a letter on EHA letterhead
#'
#' This is a thin wrapper around the [linl::linl()] function which prints letters,
#' automatically using the EHA letterhead.  See that function's options for
#' further
#'
#' @param ... Additional parameters to pass to \code{\link[linl]{linl}}
#'
#' @export
#' @importFrom linl linl
eha_letter <- function(...) {
  letterhead <- system.file("EHA_letterhead.pdf", package = "ehastyle")
  linl(..., pandoc_args=paste0("--metadata=letterhead:", letterhead))
}