
#' @title Fast creation of dummy variables
#' @description Quickly create dummy (binary) columns from character and factor type columns in the inputted data (and numeric columns if specified.)
#' This function is useful for statistical analysis when you want binary columns rather than character columns.
#' @param .data data.frame
#' @param ... Columns you want to create dummy variables from.
#' Very flexible, find in the examples.
#' @param longname logical. Should the output column labeled with the
#' original column name? Default uses \code{TRUE}.
#' @return data.table
#' @details If no columns provided, will return the original data frame.
#'  When NA exist in the input column, they would also be considered. If
#'  the input character column contains both NA and string "NA", they would be
#'  merged.
#' @details This function is inspired by \pkg{fastDummies} package, but provides
#' simple and precise usage, whereas \code{fastDummies::dummy_cols} provides more
#' features for statistical usage.
#' @references https://stackoverflow.com/questions/18881073/creating-dummy-variables-in-r-data-table
#' @seealso \code{\link[fastDummies]{dummy_cols}}
#' @examples
#' iris %>% dummy_dt(Species)
#' iris %>% dummy_dt(Species,longname = FALSE)
#'
#' mtcars %>% head() %>% dummy_dt(vs,am)
#' mtcars %>% head() %>% dummy_dt("cyl|gear")
#'
#' # when there are NAs in the column
#' df <- data.table(x = c("a", "b", NA, NA),y = 1:4)
#' df %>%
#'   dummy_dt(x)
#'
#' # when NA  and "NA" both exist, they would be merged
#' df <- data.table(x = c("a", "b", NA, "NA"),y = 1:4)
#' df %>%
#'   dummy_dt(x)
#'

#' @export
dummy_dt = function(.data,...,longname = TRUE){
  # dt = as_dt(.data)
  dt = as.data.table(.data)
  if((substitute(list(...)) %>% deparse())=="list()")
    warning("No columns provided, return the orginal data.")
  else{
    dt[0] %>%
      select_dt(...) %>%
      names() -> col_names
    for(i in col_names){
      dummy_col(dt,i,longname = longname) -> dt
    }
  }
  dt[]
}

dummy_col = function(dt,col_name,longname){

  dt[is.na(dt[[col_name]]),(col_name) := "NA"]
  dt[[col_name]] %>% unique() %>% as.character()-> old_names

  if(longname) new_names = str_c(col_name,old_names,sep="_")
  else new_names = old_names

  dt[,(old_names):=0]

  for (current_value in old_names) {
    set(dt,i = which(chmatch(as.character(dt[[col_name]]),current_value,nomatch = 0) == 1L),j = current_value,value = 1L)
  }

  setnames(dt,old = old_names,new = new_names)[]
}

# # this version is slow
# dummy_col = function(dt,col_name,longname){
#
#   dt[[col_name]] %>% unique() -> old_values
#   if(is.character(old_values) & anyNA(old_values) & "NA" %in% old_values){
#     dt[is.na(dt[[col_name]]),(col_name):="NA"]
#     dt[[col_name]] %>% unique() -> old_values
#   }
#
#   dt[[col_name]] %>% unique() %>% as.character()-> old_names
#   old_names[is.na(old_values)] = "NA"
#   if(!longname){
#     dt[,(old_names):=lapply(old_values,function(x) {
#       sapply(as.list(dt[[col_name]]),FUN = identical,x)
#     })][
#       ,(old_names):=lapply(.SD,as.numeric),.SDcols = old_names
#     ][,(col_name):=NULL][]
#   }else{
#     str_c(col_name,old_names,sep="_") -> new_names
#     dt[,(old_names):=lapply(old_values,function(x) {
#       sapply(as.list(dt[[col_name]]),FUN = identical,x)
#     })]
#     setnames(dt,old = old_names,new = new_names)[
#       ,(new_names):=lapply(.SD,as.numeric),.SDcols = new_names
#     ][,(col_name):=NULL][]
#   }
# }

# # for this version, when there are NAs, yields an error
# dummy_col = function(dt,col_name,longname){
#
#   dt[[col_name]] %>% unique() %>% as.character()-> old_names
#   if(!longname){
#     dt[,(old_names):=lapply(old_names,function(x) x == dt[[col_name]])][
#       ,(old_names):=lapply(.SD,as.numeric),.SDcols = old_names
#     ][,(col_name):=NULL][]
#   }else{
#     str_c(col_name,old_names,sep="_") -> new_names
#     dt[,(old_names):=lapply(old_names,function(x) x == dt[[col_name]])]
#     setnames(dt,old = old_names,new = new_names)[
#       ,(new_names):=lapply(.SD,as.numeric),.SDcols = new_names
#     ][,(col_name):=NULL][]
#   }
# }




