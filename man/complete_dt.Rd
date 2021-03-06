% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/complete.R
\name{complete_dt}
\alias{complete_dt}
\title{Complete a data frame with missing combinations of data}
\usage{
complete_dt(.data, ..., fill = NA)
}
\arguments{
\item{.data}{data.frame}

\item{...}{Specification of columns to expand.The selection of columns is
supported by the flexible \code{\link[tidyfst]{select_dt}}.
To find all unique combinations of provided columns, including those not found in the data,
supply each variable as a separate argument. But the two modes (select the
needed columns and fill outside values) could not be mixed,
find more details in examples.}

\item{fill}{Atomic value to fill into the missing cell, default uses \code{NA}.}
}
\value{
data.table
}
\description{
Turns implicit missing values into explicit missing values.
 All the combinations of column values (should be unique) will be constructed.
 Other columns will be filled with NAs or constant value.
}
\details{
When the provided columns with addtion data are of different length,
all the unique combinations would be returned. This operation should be used
only on unique entries, and it will always returned the unique entries.

If you supply fill parameter, these values will also replace existing explicit missing values in the data set.
}
\examples{
df <- data.table(
  group = c(1:2, 1),
  item_id = c(1:2, 2),
  item_name = c("a", "b", "b"),
  value1 = 1:3,
  value2 = 4:6
)

df \%>\% complete_dt(item_id,item_name)
df \%>\% complete_dt(item_id,item_name,fill = 0)
df \%>\% complete_dt("item")
df \%>\% complete_dt(item_id=1:3)
df \%>\% complete_dt(item_id=1:3,group=1:2)
df \%>\% complete_dt(item_id=1:3,group=1:3,item_name=c("a","b","c"))

}
\seealso{
\code{\link[tidyr]{complete}}
}
