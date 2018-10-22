#' @importFrom rmarkdown knitr_options output_format pandoc_available powerpoint_presentation pandoc_options
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

  output_format(knitr = eha_pptx_knit_opts,
                pandoc = pandoc_options(to = "pptx",
                                        from = from_rmarkdown(fig_caption,
                                                              md_extensions),
                                        args = args),
               keep_md = keep_md,
               df_print = df_print)
}
