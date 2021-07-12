#' Check PPT template for duplicates
#'
#' Checks for duplicate PH elements that would break rendering.
#'
#' @param ppt_template String. Path to ppt template
#' @param print Logical. Should the dataframe be printed?
#'
#' @return dataframe
#' @export ph_duplicate_check
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by arrange count filter
#'
#' @examples
ph_duplicate_check <- function(ppt_template, print = FALSE){
  ppt <- officer::read_pptx(ppt_template)

  duplicates <- ppt %>%
    officer::layout_properties() %>%
    group_by(name, ph_label) %>%
    arrange(name, ph_label) %>%
    count(n_ph_label = ph_label) %>%
    filter(n > 1)


  if(print){
    print(duplicates)
  }

  # will check that nrows == 0
  return(duplicates)

}


#' Print Powerpoint Layout
#'
#' Convenience wrapper for\code{\link[officer]{layout_summary}} used to debug
#' issues with powerpoint templates. Returns all layout and master names for a
#' given ppt.
#'
#' @param ppt_template String. Path to ppt file
#' @param print Logical. Should layout be printed
#'
#' @return data.frame
#' @export ppt_layout
ppt_layout <- function(ppt_template, print=FALSE){

  ppt <- officer::read_pptx(ppt_template)
  df <- officer::layout_summary(ppt)
  if(print){
    print(df)
  }
  master <- unique(df$master)

  out <- list(master = master, layout = df)
  return(out)

}


#' Check Powerpoint
#'
#' Checks for duplicate ph elements and matching master arugments
#'
#' @param ppt_template String. Path to ppt template
#' @param print Logical. Should items be printed
#' @param master String. Name of master slide template
#'
#' @return
#' @export
#'
#' @examples
ppt_check <- function(ppt_template, master, print = FALSE){

  dup_check <- ph_duplicate_check(ppt_template,print = print)

  if(nrow(dup_check)!= 0){
    stop("There are duplicate ph elements in your power point template. Use
         ph_duplicate_check to see which elements are duplicated")
  }

  master_check <- ppt_layout(ppt_template, print = print)

  if(master_check$master != master){
    stop(glue::glue("Master arugment '{master}' does not match ppt master
                    '{master_check$master}'. Either correct the input or correct
                    the ppt template."))
  }

  if(print){
    message("No duplicates and slide master is properly named")
  }

}
