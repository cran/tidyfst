% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rec.R
\name{rec}
\alias{rec}
\alias{rec_num}
\alias{rec_char}
\title{Recode number or strings}
\usage{
rec_num(x, rec, keep = TRUE)

rec_char(x, rec, keep = TRUE)
}
\arguments{
\item{x}{A numeric or character vector.}

\item{rec}{String with recode pairs of old and new values.
Find the usage in examples.}

\item{keep}{Logical. Decide whether to keep the original values if not recoded.
Defaults to \code{TRUE}.}
}
\value{
A vector.
}
\description{
Recode discrete variables, including numerice and character
variable.
}
\examples{

x = 1:10
x
rec_num(x, rec = "1=10; 4=2")
rec_num(x, rec = "1:3=1; 4:6=2")
rec_num(x, rec = "1:3=1; 4:6=2",keep = FALSE)

y = letters[1:5]
y
rec_char(y,rec = "a=A;b=B")
rec_char(y,rec = "a,b=A;c,d=B")
rec_char(y,rec = "a,b=A;c,d=B",keep = FALSE)

}
\seealso{
\code{\link[sjmisc]{rec}}
}
