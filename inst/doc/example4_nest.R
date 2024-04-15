## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidyfst)

# nest by "cyl" column
mtcars_nested <- mtcars %>% 
  nest_dt(cyl) # you can use "cyl" too, very flexible

# inspect the output data.table
mtcars_nested


## -----------------------------------------------------------------------------
mtcars_nested2 <- mtcars_nested %>% 
  mutate_dt(model = lapply(ndt,function(df) lm(mpg ~ wt, data = df)))

mtcars_nested2

## -----------------------------------------------------------------------------
mtcars_nested3 <- mtcars_nested2 %>% 
  mutate_dt(model_predict = lapply(model, predict))
mtcars_nested3$model_predict

## -----------------------------------------------------------------------------
mtcars_nested3 %>% unnest_dt(model_predict)

