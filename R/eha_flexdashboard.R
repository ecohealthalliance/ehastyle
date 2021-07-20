#' EcoHealth Alliance Flex Dashboard Theme
#'
#' Function to create a custom flexdashboard theme for EHA.
#'
#' @section CSS Font Properties:
#' See W3 description of \href{https://www.w3schools.com/cssref/pr_font_font.asp}{font property}
#' for additional details about customizing fonts.
#'
#'
#' @param orientation Determines whether level 2 headings are treated as dashboard rows or dashboard columns.
#' @param bg Background color for \code{bs_theme}
#' @param fg Foreground color for \code{bs_theme}
#' @param primary Primary color for \code{bs_theme}
#' @param secondary Secondary color for code \code{bs_theme}
#' @param version Bootstrap version to use with \code{bs_theme}
#' @param fontUrl URL where font is hosted
#' @param family String. Name of font family when using fontURL
#' @param style  String. Name of font style. Choose from normal, italic,oblique,
#' initial, or inherit
#' @param weight String. Defines from thin to thick characters.
#' 400 is the same as normal, and 700 is the same as bold. Can also use
#' normal, bold, bolder, or lighter
#' @param ... Additional arguments to be passed to \code{flex_dashboard}
#'
#' @seealso
#' \code{\link[flexdashboard:flex_dashboard]{flexdashboard::flex_dashboard()}}
#' \code{\link[bslib:bs_theme]{bslib::bs_theme()}}
#'
#' @return function
#' @export eha_flex_dashboard
#'
eha_flex_dashboard <- function(orientation = "rows",bg = "#224A55",fg = "#5EB9D6",
                               primary = "#97C83E",secondary = "#B0A28A", version = 4,
                               fontUrl="https://font-avenir.s3.us-east-2.amazonaws.com/AvenirLTW04-85Heavy.woff2",family = "Avenir", style = "normal",
                               weight = "500",...){


  ### get logo resources ----
  pkg_resource = function(...) {
    system.file(..., package = "ehastyle")
  }

  logoEHA <- pkg_resource("eha_icon_logo.png")

  ### create theme  components ----

  if(is.null(fontUrl)){
    message("using no font selection")

    ehaDashTheme <- list(bg = bg,
                                    fg = fg,
                                    primary = primary,
                                    secondary = secondary,
                                    version = version)
  } else {

    srcFont <- sprintf("url(%s)format('woff2')",fontUrl)

    base_font <- bslib::font_face(family = family,
                                  style = style,
                                  weight = weight,
                                  src = srcFont)


    ehaDashTheme <- list(bg = bg,
                                    fg = fg,
                                    primary = primary,
                                    secondary = secondary,
                                    base_font = base_font,
                                    version = version)
  }



  ### build flexdash function ----

  flexdashboard::flex_dashboard(orientation = orientation,
                                logo = logoEHA,
                                favicon = logoEHA,
                                theme = ehaDashTheme,
                                ...)

}