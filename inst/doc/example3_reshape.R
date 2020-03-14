## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidyfst)
library(tidyr)

## -----------------------------------------------------------------------------
relig_income

## ----eval=FALSE---------------------------------------------------------------
#  relig_income %>%
#    pivot_longer(-religion, names_to = "income", values_to = "count")

## ----warning=FALSE------------------------------------------------------------
relig_income %>% 
  longer_dt("religion",gathered_name = "income",gathered_value = "count")

## ----eval=FALSE---------------------------------------------------------------
#  billboard
#  
#  # tidyr way:
#   billboard %>%
#     pivot_longer(
#       cols = starts_with("wk"),
#       names_to = "week",
#       values_to = "rank",
#       values_drop_na = TRUE
#     )
#  
#  # tidyfst way:
#  billboard %>%
#    longer_dt("wk",negate = TRUE,
#              gathered_name = "week",
#              gathered_value = "rank",
#              na.rm = TRUE
#              )
#  # regex should select group_to_keep, negate could reverse that

## -----------------------------------------------------------------------------
## data
fish_encounters

## tidyr way:
fish_encounters %>% 
  pivot_wider(names_from = station, values_from = seen)

## tidyfst way:
fish_encounters %>% 
  wider_dt(name_to_spread = "station",value_to_spread = "seen")

## -----------------------------------------------------------------------------
fish_encounters %>% 
  wider_dt(name_to_spread = "station",value_to_spread = "seen",fill = 0)

