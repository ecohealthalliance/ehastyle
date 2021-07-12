#' Open EHA Powerpoint templte
#'
#' Open avenir and classic powerpoint templates. Providing no arguments will open
#' all four templates. Providing either an aspect or a template will return the
#' two corresponding templates. For example, if classic is provided to template,
#' then classic 16x9 and classic 4x3 will be opened.
#'
#' @param template String. Either classic or avenir. Defines the template to be use.
#' @param aspect String. Either 16x9 or 4x3. Defines the aspect ratio of the slides
#' @param outfile String. Name of output file
#'
#' @return
#' @export eha_pptx_template
#'
#' @examples
#' #open all the templates
#' eha_pptx_template()
eha_pptx_template <- function(template = c("classic", "avenir"),
                              aspect = c("16x9", "4x3"),
                              outdir = "./" ){

  if(length(template) == 2 & length(aspect) == 2){
    message("Opening all templates")

    template <- c(template,rev(template))
    aspect <- rep(aspect,2)

  }

  ppt_temp <- sprintf("EcoHealthAlliancePPT%s_%s.pptx",aspect, template)

  ppt_path <- pkg_resource(ppt_temp)

  outfile <- sprintf("%s%s", outdir, ppt_temp)

  out_path <- path.expand(outfile)

  file.copy(from = ppt_path,to = out_path,overwrite = TRUE)

  if(Sys.info()["sysname"] == "Windows"){
    for(i in out_path){
      shell.exec(i)
      }
  } else {
    for(i in out_path)
      system(paste("open", i))
  }

}