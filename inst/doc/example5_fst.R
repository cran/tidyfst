## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----setup--------------------------------------------------------------------
# library(tidyfst)
# 
# # Generate some random data frame with 10 million rows and various column types
# nr_of_rows <- 1e7
# 
# df <- data.frame(
#     Logical = sample(c(TRUE, FALSE, NA), prob = c(0.85, 0.1, 0.05), nr_of_rows, replace = TRUE),
#     Integer = sample(1L:100L, nr_of_rows, replace = TRUE),
#     Real = sample(sample(1:10000, 20) / 100, nr_of_rows, replace = TRUE),
#     Factor = as.factor(sample(labels(UScitiesD), nr_of_rows, replace = TRUE))
#   )
# 
# # write the fst file, make sure you do not have the file with same name in the directory
# export_fst(df,"fst_test.fst")
# 
# # remove all variables in the environment
# rm(list = ls())

## -----------------------------------------------------------------------------
# parse_fst("fst_test.fst") -> ft
# ft

## -----------------------------------------------------------------------------
# ft %>%
#   select_fst(Factor) %>%
#   count_dt(Factor) -> factor_info
# 
# factor_info

## -----------------------------------------------------------------------------
# ft %>%
#   select_fst(Integer,Factor) %>%
#   summarise_dt(avg = mean(Integer),by = Factor) -> avg_info
# 
# avg_info
# 

## -----------------------------------------------------------------------------
# # delete the output file
# unlink("fst_test.fst")

## -----------------------------------------------------------------------------
# iris %>% as_fst() -> iris_fst
# mtcars %>% as_fst() -> mtcars_fst
# 
# iris_fst
# mtcars_fst

