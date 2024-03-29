#' EHA Xaringan Theme
#'
#' A function to produce an EHA Xaringan theme with the classic font. This
#' function leans on \code{\link[xaringanthemer]{style_mono_light}} for many of
#' the theme arguments. It uses \code{\link[xaringan]{moon_reader}} to create
#' the markdown renderable object. Unlike \code{\link{eha_classic_pptx}}, you
#' cannot create editable plots with \code{\link[rvg]{dml}}.  However, you can
#' include interactive html widgets.
#'
#' @note There is an issue using \code{\link[sysfonts]{sysfonts}} with
#' M1 mac machines therefore\code{\link[xaringanthemer]{theme_xaringan}} is not
#' able to use \code{\link[xaringanthemer]{google_font}} when creating ggplot themes.
#'
#'
#' @param aspect String. Aspect ratio for slides.
#' Either "16x9" or "4x3". Default is "16x9"
#' @param self_contained Whether to produce a self-contained HTML file by
#'   embedding all external resources into the HTML file.
#' @param ... other arguments passed to \code{\link[xaringan]{moon_reader}} or
#'   \code{\link[rmarkdown]{html_document}}
#' @importFrom xaringanthemer google_font
#'
#' @return xaringan theme
#' @export eha_classic_xar
#'
eha_classic_xar <- function(aspect = "16x9", self_contained = TRUE, ...){

  ## get resources from package ----

  if (aspect == "16x9") {
    ehaTitlePng <- pkg_resource("eha_title_16x9.png")
    ehaBackgroundPng <- pkg_resource("eha_bg_16x9.png")
  } else if (aspect == "4x3") {
    ehaTitlePng <- pkg_resource("eha_title_4x3.png")
    ehaBackgroundPng <- pkg_resource("eha_bg_4x3.png")
  } else {
    stop("Aspect must be 16x9 or 4x3")
  }

 ## generate css for slides ----

  xaringanthemer::style_mono_light(
    text_font_base = "Courier",
    base_color = "#000000",
    base_font_size = "22px",
    title_slide_background_color = "#FFFFFF",
    title_slide_background_image = ehaTitlePng,
    title_slide_background_size = "contain",
    #title_slide_text_color = "#509935",
    title_slide_text_color = "#000000",
    background_image = ehaBackgroundPng,
    header_font_google = google_font("Fira Sans", "300"),
    text_font_google = google_font("Fira Sans"),
    code_font_google = google_font("Fira Mono"),
    code_font_size = "0.7rem",
    text_slide_number_font_size = "1em",
    link_color = "#8ec549",
    outfile = "eha-xaringan-themer.css"
  )

  # convert aspect to ratio format ----
  ratio <- gsub(pattern = "x",replacement = ":",x = aspect)

  ## provide presentation config arguments ----
  # https://github.com/gnab/remark/wiki/Configuration
  ## this maybe where we allow customization
  natureList <- list(highlightStyle = "github",
                     highlightLines = "true",
                     countIncrementalSlides = "false",
                     titleSlideClass = c("right", "bottom"),
                     ratio = ratio)

  ## combine theme and config  ----
  xaringan::moon_reader(css = "eha-xaringan-themer.css", self_contained = self_contained, lib_dir = "libs",nature = natureList )

}
