#' @import rmarkdown
#' @import knitr
NULL

#' R Markdown format for EHA Outbreak Scenarios Reports
#'
#' @param self_contained Include all dependencies
#' @param theme Bootstrap theme
#' @param lib_dir Local directory to copy assets
#' @param keep_md Keep knitr-generated markdown
#' @param mathjax Include mathjax, "local" or "default"
#' @param pandoc_args Other arguments to pass to pandoc
#' @param ... Additional function arguments to pass to the base R Markdown HTML
#'   output formatter

#' @export
outbreak <- function(self_contained = TRUE, lib_dir = NULL, keep_md = FALSE, cache_prefix = "cache/", ...) {

  outbreak_css <- pandoc_path_arg(system.file("outbreak-template.css", package = "ehastyle"))
  outbreak_template <- pandoc_path_arg(system.file("outbreak-template.html", package = "ehastyle"))
  outbreak_writer <- pandoc_path_arg(system.file("outbreak.lua", package = "ehastyle"))
  outbreak_csl <- pandoc_path_arg(system.file("elsevier-with-titles.csl", package="ehastyle"))

  #file.copy(outbreak_writer, file.path(getwd(), "outbreak.lua"))

  sidelogo <- system.file("sidebar.png", package = "ehastyle")
  footer <- system.file("predictfooter.png", package="ehastyle")

  default_date = as.character.Date(Sys.Date(), format = "%B %d, %Y")

  last_commit = try(substr(git2r::commits()[[1]]@sha, 1, 7))

  outbreak_pan_opts <- pandoc_options(to="html", ext=".html", args = c("--css", outbreak_css, "--section-divs", "--template", outbreak_template, "--variable", paste0("default_date:", default_date), "--variable", paste0("sidelogo:", sidelogo),  "--variable", paste0("footer:", footer), "--variable", "mathjax-url:https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML", "--csl", outbreak_csl))

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
      default_contact = "For details on methods or analysis contact: PREDICTmodeling@\u200Becohealthalliance.org"
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
    keep_md = keep_md,
    clean_supporting = TRUE,
    base_format = html_document_base(smart = TRUE, theme = NULL, mathjax = NULL, self_contained = TRUE,
                                     template = outbreak_template, ...))
}

#' @import officer
#' @import magrittr
#' @export
outbreak_word <- function(cache_prefix = "cache/", keep_md = FALSE, proposal = FALSE, usaid = FALSE, usaid_panel = 1, ...) {

  outbreak_docx = ifelse(proposal,
                         system.file("template-proposal.docx", package = "ehastyle"),
                         ifelse(usaid,
                                system.file("template-usaid.docx", package = "ehastyle"),
                                system.file("template.docx", package = "ehastyle")))

  pb_filter <- pandoc_path_arg(system.file("pagebreak.R", package="ehastyle"))

  sidelogo <- ifelse(proposal,
                     system.file("sidebar-proposal.png", package = "ehastyle"),
                     ifelse(usaid,
                            system.file(paste0("sidebar_usaid", usaid_panel, ".png"), package = "ehastyle"),
                            system.file("sidebar.png", package = "ehastyle")))

  footer <- system.file("predictfooter.png", package="ehastyle")

  default_date = as.character.Date(Sys.Date(), format = "%B %d, %Y")
  last_commit = try(substr(git2r::commits()[[1]]@sha, 1, 7))

  outbreak_csl <- pandoc_path_arg(system.file("elsevier-with-titles.csl", package="ehastyle"))

  outbreak_knit_opts <- knitr_options(opts_chunk= list(dev = 'png', dpi=300,
                                                       dev.args = list(bg = 'transparent'),
                                                       warning = FALSE,
                                                       cache.path = cache_prefix))


  output_format(
    knitr = outbreak_knit_opts,
    pandoc = pandoc_options(to="docx", from=rmarkdown_format(), args = c("--metadata", "date:FALSE", "--metadata", "author:FALSE", "--metadata", "title:FALSE", "--csl", outbreak_csl, "--filter", pb_filter)),
    post_processor = function(metadata, input_file, output_file, clean, verbose) {

      # create new officer doc
      doc = read_docx(path = outbreak_docx)

      # add title and abstract
      if(!is.null(metadata$title)) {
        doc %<>% body_add_par(metadata$title, style="Title")
      }
      if(!is.null(metadata$summary)) {
        doc %<>% body_add_par(metadata$summary, style="Abstract")
      }

      # insert external docx
      doc %<>% body_add_docx(output_file)

      # add side logo
      doc %<>% body_replace_img_at_bkm(bookmark = "logo", value=external_img(src = sidelogo, width=1.77, height = 6.031))

      # add footer image
      doc %<>% body_replace_img_at_bkm(bookmark = "footer", value=external_img(src = footer, width=8, height = 0.73))

      # add date
      if(!is.null(metadata$date)) {
        doc %<>%
          body_replace_text_at_bkm(bookmark = "date", value = metadata$date)
      } else {
        doc %<>%
          body_replace_text_at_bkm(bookmark = "date", value = default_date)
      }

      # add contact info
      if(!is.null(metadata$contact)) {
        doc %<>%
          body_replace_text_at_bkm(bookmark = "contact", value = metadata$contact)
      } else {
        doc %<>%
          body_replace_text_at_bkm(bookmark = "contact", value = "For details on methods or analysis contact: PREDICTmodeling@\u200Becohealthalliance.org")
      }

      # save document
      print(doc, target=output_file)
      return(output_file)
    },
    clean_supporting = TRUE,
    keep_md=keep_md,
    base_format = word_document(fig_caption = TRUE, reference_docx = outbreak_docx, ...))
}
