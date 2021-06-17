#' EcoHealth Alliance Flex Dashboard Theme
#'
#' Function to create a custom flexdashboard theme for EHA.
#'
#'
#' @param orientation Determines whether level 2 headings are treated as dashboard rows or dashboard columns.
#' @param bg Background color for \code{bs_theme}
#' @param fg Foreground color for \code{bs_theme}
#' @param primary Primary color for \code{bs_theme}
#' @param secondary Secondary color for code \code{bs_theme}
#' @param fontUrl URL where font is hosted
#' @param ... additional arguments to be passed to \code{flex_dashboard}
#'
#' @seealso \code{\link[flexdashboard:flex_dashboard]{flexdashboard::flex_dashboard()}}
#' \code{\link[bslib:bs_theme]{bslib::bs_theme()}}
#'
#' @return function
#' @export eha_flex_dashboard
#'
#' @examples
eha_flex_dashboard <- function(orientation = "row",bg = "#224A55",fg = "#5EB9D6",
                               primary = "#97C83E",secondary = "#B0A28A",
                               fontUrl,...){


  ### get logo resources ----
  pkg_resource = function(...) {
    system.file(..., package = "ehastyle")
  }

  logoEHA <- pkg_resource("inst/rmarkdown/templates/flexdash-airtable/skeleton/eha_logo.png")

  ### create theme  components ----
  srcFont <- sprintf("url(%s)format(\"woff2\")",fontUrl)

  base_font <- bslib::font_face("Avenir", style = "normal", weight = "500",  src = srcFont)

  ehaDashTheme <- bslib::bs_theme(bg = bg,fg = fg,primary = primary, secondary = secondary,
                                  base_font = base_font)

  ### build flexdash function ----

  flexdashboard::flex_dashboard(orientation = orientation,
                                logo = logoEHA,
                                favicon = logoEHA,
                                theme = ehaDashTheme,
                                ...)

}