#' Open EHA Powerpoint templte
#'
#' Open avenir, classic, and predict powerpoint templates. Providing no arguments
#' will open all six templates. Providing either an aspect or a template will
#' return all the corresponding templates. For example, if classic is provided
#' to template, then classic 16x9 and classic 4x3 will be opened.
#'
#' @param template String. Either classic or avenir. Defines the template to be use.
#' @param outdir String. Where should files be copied to before opening?
#' @param recursive Logical. Should elements of the path other than the last be
#' created? If true, like the Unix command mkdir -p. See \code{\link[base]{dir.create}}
#' @param aspect String. Either 16x9 or 4x3. Defines the aspect ratio of the slides
#'
#' @return pptx
#' @export eha_pptx_template
#'
#' @examples
#' #open all the templates
#' \dontrun{eha_pptx_template()}
#'
eha_pptx_template <- function(template = c("classic", "avenir", "predict"),
                              aspect = c("16x9", "4x3"),
                              outdir = "./",recursive = TRUE ){

  templates <- c("classic", "avenir", "predict")
  aspects <- c("16x9", "4x3")

  if(sum(template %in% templates) < length(template)){
    stop(glue::glue_collapse("Template arugment '{template}'not found. Please select from: {templates}", sep = ", "))
  }

  if( sum(aspect %in% aspects) < length(aspect)){
    stop(glue::glue_collapse("Aspect argument '{aspect}' not found. Please select from: {aspects}", sep = ", "))
  }


  if(length(template) == 3 & length(aspect) == 2){
    message("Opening all templates")

    template <- c(template,rev(template))
    aspect <- rep(aspect,3)

  }

  ppt_temp <- sprintf("EcoHealthAlliancePPT%s_%s.pptx",aspect, template)

  ppt_path <- pkg_resource(ppt_temp)

  outfile <- sprintf("%s/%s", outdir, ppt_temp)

  if(!dir.exists(outdir)){
    dir.create(outdir,recursive = recursive)
  }

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