

#' @title Count observations by group
#' @description Count the unique values of one or more variables.
#' @param .data data.table/data.frame data.frame will be automatically converted
#'   to data.table.
#' @param ... Variables to group by, could receive what `select_dt` receives.
#' @param sort logical. If TRUE result will be sorted in desending order by resulting variable.
#' @param .name character. Name of resulting variable. Default uses "n".
#'
#' @return data.table
#' @seealso \code{\link[dplyr]{count}}
#' @examples
#' iris %>% count_dt(Species)
#' iris %>% count_dt(Species,.name = "count")
#' iris %>% add_count_dt(Species)
#' iris %>% add_count_dt(Species,.name = "N")
#'
#' mtcars %>% count_dt(cyl,vs)
#' mtcars %>% count_dt("cyl|vs")
#' mtcars %>% count_dt(cyl,vs,.name = "N",sort = FALSE)
#' mtcars %>% add_count_dt(cyl,vs)
#' mtcars %>% add_count_dt("cyl|vs")
#'
#' @rdname count
#' @export

count_dt = function(.data,...,sort = TRUE,.name = "n"){
  dt = as_dt(.data)
  dt[0] %>% select_dt(...) %>% names() -> dot_string
  if(sort)
    eval(parse(text =
                 str_glue("dt[,.({.name} = .N),by = dot_string][order(-{.name})]")))
  else
    eval(parse(text = str_glue("dt[,.({.name} = .N),by = dot_string]")))
}

#' @rdname count
#' @export
add_count_dt = function(.data,...,.name = "n"){
  dt = as.data.table(.data)
  dt[0] %>% select_dt(...) %>% names() -> dot_string
  dt[,(.name):=.N,by = dot_string][]
}







