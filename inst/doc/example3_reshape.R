## ----include = FALSE----------------------------------------------------------
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
  longer_dt("religion",name = "income",value = "count")

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
#    longer_dt(-"wk",
#              name = "week",
#              value = "rank",
#              na.rm = TRUE
#              )
#  # regex could select the groups to keep, and minus could select the reverse

## -----------------------------------------------------------------------------
## data
fish_encounters

## tidyr way:
fish_encounters %>% 
  pivot_wider(names_from = station, values_from = seen)

## tidyfst way:
fish_encounters %>% 
  wider_dt(name = "station",value = "seen")

# if no keeped groups are selected, use all except for name and value columns

## -----------------------------------------------------------------------------
fish_encounters %>% 
  wider_dt(name = "station",value = "seen",fill = 0)

## -----------------------------------------------------------------------------
family <- fread("family_id age_mother dob_child1 dob_child2 dob_child3 gender_child1 gender_child2 gender_child3
1         30 1998-11-26 2000-01-29         NA             1             2            NA
2         27 1996-06-22         NA         NA             2            NA            NA
3         26 2002-07-11 2004-04-05 2007-09-02             2             2             1
4         32 2004-10-10 2009-08-27 2012-07-21             1             1             1
5         29 2000-12-05 2005-02-28         NA             2             1            NA")

family

## -----------------------------------------------------------------------------
#     family_id age_mother  child        dob gender
#         <int>      <int> <char>     <char> <char>
#  1:         1         30 child1 1998-11-26      1
#  2:         1         30 child2 2000-01-29      2
#  3:         1         30 child3       <NA>   <NA>
#  4:         2         27 child1 1996-06-22      2
#  5:         2         27 child2       <NA>   <NA>
#  6:         2         27 child3       <NA>   <NA>
#  7:         3         26 child1 2002-07-11      2
#  8:         3         26 child2 2004-04-05      2
#  9:         3         26 child3 2007-09-02      1
# 10:         4         32 child1 2004-10-10      1
# 11:         4         32 child2 2009-08-27      1
# 12:         4         32 child3 2012-07-21      1
# 13:         5         29 child1 2000-12-05      2
# 14:         5         29 child2 2005-02-28      1
# 15:         5         29 child3       <NA>   <NA>

## ----warning=FALSE------------------------------------------------------------
family %>% 
  longer_dt(1:2) %>% 
  separate_dt("name",into = c("class","child")) %>% 
  wider_dt(-"class|value",
           name = "class",
           value = "value")

