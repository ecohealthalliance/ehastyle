#' @import rmarkdown
#' @import knitr
NULL

#' R Markdown format for EHA Outbreak Scenarios Reports
#'
#' #' @param self_contained Include all dependencies
#' @param theme Bootstrap theme
#' @param lib_dir Local directory to copy assets
#' @param keep_md Keep knitr-generated markdown
#' @param mathjax Include mathjax, "local" or "default"
#' @param pandoc_args Other arguments to pass to pandoc
#' @param ... Additional function arguments to pass to the base R Markdown HTML
#'   output formatter
#' @export
#'

outbreak <- function(self_contained = TRUE,
                               lib_dir = NULL,
                               keep_md = TRUE,
                     cache_prefix = "cache/", ...) {

  outbreak_css <- pandoc_path_arg(system.file("outbreak-template.css", package = "ehastyle"))
  outbreak_template <- pandoc_path_arg(system.file("outbreak-template.html", package = "ehastyle"))
  outbreak_writer <- pandoc_path_arg(system.file("outbreak.lua", package = "ehastyle"))
  outbreak_csl <- pandoc_path_arg(system.file("chicago-fullnote-no-bibliography.csl", package="ehastyle"))

  #file.copy(outbreak_writer, file.path(getwd(), "outbreak.lua"))

  sidelogo <- system.file("sidebar.png", package = "ehastyle")
  footer <- system.file("predictfooter.png", package="ehastyle")

  default_date = as.character.Date(Sys.Date(), format = "%B %d, %Y")


  last_commit = try(substr(git2r::commits()[[1]]@sha, 1, 7))

  outbreak_pan_opts <- pandoc_options(to="html", ext=".html", args = c("--css", outbreak_css, "--section-divs", "--template", outbreak_template, "--variable", paste0("default_date:", default_date), "--variable", paste0("sidelogo:", sidelogo),  "--variable", paste0("footer:", footer), "--variable", "mathjax-url:https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"))

if(!("try-error" %in% class(last_commit))) {
  outbreak_pan_opts = c(outbreak_pan_opts, "--variable", paste0("last_commit:", last_commit))
}

  outbreak_knit_opts <- knitr_options(opts_chunk= list(dev = 'png', dpi=300,
                                                       warning = FALSE,
                                                       dev.args = list(bg = 'transparent'),
                                                       cache.path = cache_prefix))


  output_format(
    knitr = outbreak_knit_opts,
    pandoc = outbreak_pan_opts,
    pre_processor =  function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
      out_args = character()
      default_contact = "For details on methods or analysis contact: P2modeling@\u200Becohealthalliance.org"
      hypothes_is = "https://github.com/ecohealthalliance/outbreak-scenarios"
      if(is.null(metadata$contact)) {
        out_args = c(out_args, "--variable", paste0("contact:", default_contact))
      }
      out_args = c(out_args, "--variable", paste0("hypothes_is:", hypothes_is))
      return(out_args)
    },
     post_processor = function(metadata, input_file, output_file, clean, verbose) {
     #   file.remove("outbreak.lua")
        pandoc_self_contained_html(output_file, output_file)
       },

    clean_supporting = FALSE,
    keep_md=TRUE,
    base_format = html_document_base(smart = TRUE, theme = NULL, mathjax = NULL, self_contained = TRUE,
                                     template = outbreak_template, ...))
}

#' @import ReporteRs
#' @export
outbreak_word <- function(cache_prefix = "cache/", ...) {

  outbreak_docx = system.file("template.docx", package = "ehastyle")

  sidelogo <- system.file("sidebar.png", package = "ehastyle")
  footer <- system.file("predictfooter.png", package="ehastyle")

  default_date = as.character.Date(Sys.Date(), format = "%B %d, %Y")

  default_date = as.character.Date(Sys.Date(), format = "%B %d, %Y")
  last_commit = try(substr(git2r::commits()[[1]]@sha, 1, 7))

  outbreak_csl <- pandoc_path_arg(system.file("chicago-fullnote-no-bibliography.csl", package="ehastyle"))


  outbreak_knit_opts <- knitr_options(opts_chunk= list(dev = 'png', dpi=300,
                                                       dev.args = list(bg = 'transparent'),
                                                       warning = FALSE,
                                                       cache.path = cache_prefix))


  output_format(
    knitr = outbreak_knit_opts,
    pandoc = pandoc_options(to="docx", args = c("--metadata", "date:FALSE", "--metadata", "author:FALSE", "--metadata", "title:FALSE")),
    post_processor = function(metadata, input_file, output_file, clean, verbose) {
      doc = docx(title = metadata$title, template = outbreak_docx)
      if(!is.null(metadata$title)) {
        doc = addParagraph(doc, metadata$title, stylename="Title")
      }

      doc = addDocument(doc, output_file)
      doc = addImage(doc, sidelogo, bookmark="logo", par.properties = parProperties(text.align = "left", padding=0), width=1.77, height = 6.031)
      doc = addImage(doc, footer, bookmark="footer", par.properties = parProperties(text.align = "left", padding=0), width=8.5, height = 0.79)
      #doc = deleteBookmark(doc, "start")
      if(!is.null(metadata$date)) {
        doc = addParagraph(doc, metadata$date, bookmark = "date", stylename="sidedate")
      } else {
        doc = addParagraph(doc, default_date, bookmark = "date", stylename="sidedate")
      }

      if(!is.null(metadata$contact)) {
        doc = addParagraph(doc, metadata$contact, bookmark = "contact", stylename="sidedate")
      } else {
        doc = addParagraph(doc, "For details on methods or analysis contact: P2modeling@\u200Becohealthalliance.org", bookmark = "contact", stylename="sidedate")
      }


      writeDoc(doc, output_file)
      return(output_file)
    },
    clean_supporting = TRUE,
    keep_md=TRUE,
    base_format = word_document(fig_caption = TRUE, reference_docx = outbreak_docx, ...))
}