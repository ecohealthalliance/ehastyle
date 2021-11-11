#' Check that all templates build properly
#'
#' Opens markdown templates as rmd files and/or renders them into their
#' appropriate format.
#'
#' @param outdir String. Where should files be stored
#' @param recursive Logical. Should subfolders of outdir be created
#' @param style String. One of "classic", "avenir", or "predict"
#' @param format String. One of "pptx","xar", or"flex"
#' @param aspect String. One of "4x3" or "16x9"
#' @param check_all Logical. Should we open all the templates as RMDs?
#' @param render Logical. Should we render the templates we open?
#'
#' @return
#' @export check_templates
#'
#' @examples
check_templates <- function(style = c("classic", "avenir", "predict"),
                            format = c("pptx","xar", "flex"),
                            aspect = c("4x3","16x9"),
                            check_all = FALSE,
                            render = TRUE,
                            outdir = "./",recursive = TRUE ){

  if(check_all){
  rmdTemps  <- system.file("rmarkdown/templates",package = "ehastyle")
  tempNames <- list.dirs(rmdTemps,recursive = FALSE,full.names = FALSE)

  ## map2 over style and format

  purrr::map(tempNames, function(style, format, dir = outdir){
    rmdPath <- sprintf("./%s/%s.rmd", tempNames,format)
    rmarkdown::draft(rmdPath,template = "eha-avenir-pptx",package = "ehastyle",edit = FALSE)
    knitr::knit()
  })



  }
  templates <- c("classic", "avenir", "predict")

  if(sum(style %in% templates) < length(template)){
    stop(glue::glue_collapse("Template arugment '{template}'not found. Please select from: {templates}", sep = ", "))
  }

  aspects <- c("4x3","16x9")

  if( sum(aspect %in% aspects) < length(aspect)){
    stop(glue::glue_collapse("Aspect argument '{aspect}' not found. Please select from: {aspects}", sep = ", "))
  }


  if(length(style) == 3 & length(aspect) == 2){
    message("Opening all templates")

    template <- c(style,rev(style))
    aspect <- rep(aspect,length(style))

  }

  ppt_temp <- sprintf("EcoHealthAlliancePPT%s_%s.pptx",aspect, style)

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