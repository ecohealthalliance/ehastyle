#' Classic EHA powerpoint template
#'
#' Styles for eha rmarkdown ppt. Used with a template to create presentations
#' that dynamically update with your data.
#'
#' @param aspect String. Aspect ratio for power point slides.
#' Either "16x9" or "4x3". Default is "16x9"
#' @param toc Logical. Should the slides have a table of contents?
#' Default is FALSE
#' @param toc_depth Numeric. How many levels should the table of contents have.
#' Default is 2.
#' @param fig_width Numeric. Width of figures. Default is 9.4
#' @param fig_height Numeric. Height of figures. Default is 4.24
#' @param fig_caption Logical. Should figures have captions? Default is TRUE
#' @param df_print String. Print data frames? Default is "default"
#' @param keep_md Logical. Should markdown document be kept? Default is FALSE
#' @param smart Logical. Produce typographically correct outs. Default is TRUE
#' @param md_extensions String. Additional \href{https://pandoc.org/MANUAL.html#pandocs-markdown}{markdown extensions}.
#' Default is NULL
#' @param slide_level Numeric. Defines the heading level that defines individual
#'  slides. Default is NULL
#' @param pandoc_args Arguments to pass to pandoc.
#'
#' @seealso \code{\link[rmarkdown]{powerpoint_presentation}}, \code{\link[officedown]{rpptx_document}}
#'
#' @importFrom rmarkdown knitr_options output_format pandoc_available powerpoint_presentation pandoc_options
#' @importFrom officedown rpptx_document
#' @export
eha_classic_pptx <- function(aspect = "16x9",
                     toc = FALSE, toc_depth = 2, fig_width = 9.4,
                     fig_height = 4.24, fig_caption = TRUE, df_print = "default",
                     keep_md = FALSE,
                     smart = TRUE, md_extensions = NULL,
                     slide_level = NULL,  pandoc_args = NULL) {

  if (aspect == "16x9") {
    ppt_template = system.file("EcoHealthAlliancePPT16x9_classic.pptx", package = "ehastyle")
  } else if (aspect == "4x3") {
    ppt_template = system.file("EcoHealthAlliancePPT4x3_classic.pptx", package = "ehastyle")
  } else {
    stop("Aspect must be 16x9 or 4x3")
  }

  # cache prefix is not an argument we can pass to rpptx_document
  # do not need to specify a dpi if we are passing svgs to ppt
  # relying on templates to place logos
  # knitr options passed via rpptx_document
  # pandoc options passed via rpptx_document


  if(smart){
    md_extensions <- c(md_extensions, "+smart")
  }

  md_extensions <- unique(c("+raw_attribute", md_extensions))


  officedown::rpptx_document(master = "EcoHealth Alliance",
                             reference_doc = ppt_template,
                             toc = toc,
                             toc_depth = toc_depth,
                             fig_width = fig_width,
                             fig_height = fig_height,
                             fig_caption = fig_caption,
                             df_print = df_print,
                             keep_md = keep_md,
                             # cache_prefix = cache_prefix,
                             md_extensions = md_extensions,
                             slide_level = slide_level,
                             pandoc_args = pandoc_args)
}
