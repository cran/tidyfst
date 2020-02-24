## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidyfst)

iris %>% count_dt(Species) -> a
class(a)

# turn on
print.data.table = show_tibble(TRUE)
a
class(a)

# shut off
print.data.table = show_tibble(FALSE)
a
class(a)

