#' Get package resources
#'
#' This function allows you to easily source package resources
#' like images or style sheets. The function will return a file
#' path to a resource stored in your package.
#'
#' @param ... arguments to pass to \code{system.file}
#'
#' @return string
#' @export pkg_resource
#'
#' @examples
#'
#' logoEHA <- pkg_resource("eha_icon_logo.png")
#' print(logoEHA)
pkg_resource = function(...) {
  system.file(..., package = "ehastyle")
}