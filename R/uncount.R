
#' @title "Uncount" a data frame
#' @description  Duplicating rows according to a weighting variable.
#'  This is the opposite operation of `count_dt`.
#'  Analogous to `tidyr::uncount`.
#' @param .data A data.frame
#' @param wt A vector of weights.
#' @param .remove Should the column for \code{weights} be removed?
#' Default uses \code{TRUE}.
#' @seealso \code{\link[dplyr]{count}}, \code{\link[tidyr]{uncount}}
#' @examples
#'
#' df <- data.table(x = c("a", "b"), n = c(1, 2))
#' uncount_dt(df, n)
#' uncount_dt(df,n,FALSE)
#' @export

uncount_dt = function(.data,wt,.remove = TRUE){
  dt = as_dt(.data)
  if(.remove) eval.parent(substitute(dt[rep(1:.N,wt)][,wt:=NULL][]))
  else eval.parent(substitute(dt[rep(1:.N,wt)]))
}

