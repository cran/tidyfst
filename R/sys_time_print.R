
#' @title Convenient print of time taken
#' @name sys_time_print
#' @description Convenient printing of time elapsed. A wrapper of
#' \code{data.table::timetaken}, but showing the results more directly.
#' @param expr Valid R expression to be timed.
#' @return  A character vector of the form HH:MM:SS,
#' or SS.MMMsec if under 60 seconds (invisibly for \code{show_time}). See examples.
#' @seealso \code{\link[data.table]{timetaken}}, \code{\link[base]{system.time}}
#' @examples
#'
#' sys_time_print(Sys.sleep(1))
#'
#' a = iris
#' sys_time_print({
#'   res = iris %>%
#'     mutate_dt(one = 1)
#' })
#' res

#' @rdname sys_time_print
#' @export
sys_time_print = function (expr) {
  started.at = proc.time()
  eval(substitute(expr), envir = parent.frame())
  paste("# Finished in", timetaken(started.at))
}

#' @rdname sys_time_print
#' @export
pst = sys_time_print




