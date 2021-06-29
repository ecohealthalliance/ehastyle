# see https://github.com/ecohealthalliance/xlsform/blob/main/tips-tricks-session1.Rmd

#' EHA Xaringan Theme
#'
#' A function to produce an EHA Xaringan theme.
#'
#' @param ... not used
#'
#' @return xaringan theme
#' @export eha_xaringan
#'
#' @examples
eha_xaringan <- function(...){

  ## get resources from package ----
  ehaTitlePng <- pkg_resource("ecohealth_title_background_4by3.png")
  ehaBackgroundPng <- pkg_resource("ecohealth_slide_background_4by3.png")
  # avenirCss <- pkg_resource("avenir.css")

  xaringanthemer::style_mono_light(text_font_base = "Courier",
    base_color = "#000000",
    base_font_size = "22px",
    title_slide_background_color = "#FFFFFF",
    title_slide_background_image = ehaTitlePng,
    title_slide_background_size = "contain",
    #title_slide_text_color = "#509935",
    title_slide_text_color = "#000000",
    background_image = ehaBackgroundPng,
    header_font_family ="Avenir",
    header_font_url = "https://font-avenir.s3.us-east-2.amazonaws.com/Avenir.css",
    text_font_family = "Avenir",
    text_font_url = "https://font-avenir.s3.us-east-2.amazonaws.com/Avenir.css",
    code_font_google = xaringanthemer::google_font("Fira Mono"),
    code_font_size = "0.7rem",
    text_slide_number_font_size = "1em",
    link_color = "#509935",
    outfile = "eha-xaringan-themer.css"
  )

  ## provide presentation config arguments ----
  # https://github.com/gnab/remark/wiki/Configuration
  ## this maybe where we allow customization
  natureList <- list(highlightStyle = "github",
                     highlightLines = "true",
                     countIncrementalSlides = "false",
                     titleSlideClass = c("right", "bottom"))

  ### combine theme and config  ----
  xaringan::moon_reader( css = "eha-xaringan-themer.css", lib_dir = "libs",nature = natureList )

}
