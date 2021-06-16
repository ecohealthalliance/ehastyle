#' EHA Powerpoint for Predict
#'
#' Styles for eha rmarkdown ppt. After install the markdown template will be
#' available when you choose to create a new markdown file.
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
#' @param cache_prefix String. Directory for cache contents. Default is "cache/"
#' @param smart Logical. Produce typographically correct outs. Default is TRUE
#' @param md_extensions String. Additional \href{https://pandoc.org/MANUAL.html#pandocs-markdown}{markdown extensions}.
#' Default is NULL
#' @param slide_level Numeric. Defines the heading level that defines individual
#'  slides. Default is NULL
#' @param pandoc_args Arguments to pass to pandoc. See \code{\link[MASS]{stats}}
#'
#' @importFrom rmarkdown knitr_options output_format pandoc_available powerpoint_presentation pandoc_options
#' @importFrom officer read_pptx on_slide ph_with external_img
#' @export
eha_pptx <- function(aspect = "16x9",
                     toc = FALSE, toc_depth = 2, fig_width = 9.4,
                     fig_height = 4.24, fig_caption = TRUE, df_print = "default",
                     keep_md = FALSE, cache_prefix = "cache/",
                     smart = TRUE, md_extensions = NULL,
                     slide_level = NULL,  pandoc_args = NULL) {

  if (aspect == "16x9") {
    ppt_template = system.file("EcoHealthAlliancePPT16x9.pptx", package = "ehastyle")
  } else if (aspect == "4x3") {
    ppt_template = system.file("EcoHealthAlliancePPT4x3.pptx", package = "ehastyle")
  } else {
    stop("Aspect must be 16x9 or 4x3")
  }

  eha_pptx_knit_opts <- knitr_options(opts_chunk = list(dev = 'png', dpi = 300,
                                                        dev.args = list(bg = 'white'),
                                                        warning = FALSE,
                                                        fig.width = fig_width, fig.height = fig_height,
                                                        cache.path = cache_prefix))

  if (smart)
    md_extensions <- c(md_extensions, "+smart")
  md_extensions <- unique(c("+raw_attribute", md_extensions))

  args <- c("--reference-doc", ppt_template)
  if (!is.null(slide_level))
    args <- c(args, "--slide-level", as.character(slide_level))
  if (toc) {
    args <- c(args, "--table-of-contents")
    args <- c(args, "--toc-depth", toc_depth)
  }
  args <- c(args, pandoc_args)

  eha_pptx_post_processor <- function(metadata, input_file, output_file, clean, verbose) {
    pf <- read_pptx(output_file)
    if (pf$slide$get_slide(1)$get_metadata()$layout_file == "../slideLayouts/slideLayout1.xml") {
      pf <- on_slide(pf, 1)
      eha_logo_path <- system.file("eha_title_logo.png",
                                   package = "ehastyle")
      if (aspect == "16x9") {
        # ph_with_img_at was removed from the officer package. Now use
        # external_img and ph_with
        eha_logo_169 <- external_img(src = eha_logo_path,
                                     width = 8.7,
                                     height = 2.24,
                                     alt = "eha-logo"
        )

        pf <- ph_with(pf,
                      eha_logo_169,
                      ph_location(
                        width = 8.7,
                        height = 2.24,
                        left = 1.1,
                        top = 0.89)
                      )
      } else if (aspect == "4x3") {

        eha_logo_43 <- external_img(src = eha_logo_path,
                                    width = 6.52,
                                    height = 1.68,
                                    alt = "eha-logo"
        )

        pf <- ph_with(pf,
                      eha_logo_43,
                      ph_location(
                        width = 6.52,
                        height = 1.68,
                        left = 0.82,
                        top = 1.22)
                      )
      }
    }
    print(pf, target = output_file)
    return(output_file)
  }

  output_format(knitr = eha_pptx_knit_opts,
                pandoc = pandoc_options(to = "pptx",
                                        from = from_rmarkdown(fig_caption,
                                                              md_extensions),
                                        args = args),
                keep_md = keep_md,
                df_print = df_print,
                post_processor = eha_pptx_post_processor)
}
