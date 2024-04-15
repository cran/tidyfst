## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidyfst)
iris %>% 
  as_dt()%>%  #coerce a data.frame to data.table
  .[,.SD[1],by = Species]


## -----------------------------------------------------------------------------
iris %>% 
  in_dt(,.SD[1],by = Species)

