## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# load packages
library(tidyfst)
library(data.table)
library(dplyr)
library(bench)

# generate the data
# if you have a HPC and want to try larger data sets, increase N
N = 1e4 
K = 1e2

set.seed(2020)

cat(sprintf("Producing data of %s rows and %s K groups factors\n", N, K))

DT = data.table(

  id1 = sample(sprintf("id%03d",1:K), N, TRUE),      # large groups (char)

  id2 = sample(sprintf("id%03d",1:K), N, TRUE),      # large groups (char)

  id3 = sample(sprintf("id%010d",1:(N/K)), N, TRUE), # small groups (char)

  id4 = sample(K, N, TRUE),                          # large groups (int)

  id5 = sample(K, N, TRUE),                          # large groups (int)

  id6 = sample(N/K, N, TRUE),                        # small groups (int)

  v1 =  sample(5, N, TRUE),                          # int in range [1,5]

  v2 =  sample(5, N, TRUE),                          # int in range [1,5]

  v3 =  round(runif(N,max=100),4)                    # numeric e.g. 23.5749

)

object_size(DT)

## -----------------------------------------------------------------------------
bench::mark(
  data.table = DT[,.(median_v3 = median(v3),
                     sd_v3 = sd(v3)),
                  by = .(id4,id5)],
  tidyfst = DT %>%
    summarise_dt(
      by = "id4,id5",
      median_v3 = median(v3),
      sd_v3 = sd(v3)
    ),
  dplyr = DT %>%
    group_by(id4,id5,.drop = TRUE) %>%
    summarise(median_v3 = median(v3),sd_v3 = sd(v3)),
  check = FALSE,iterations = 10
) -> q1

q1

## -----------------------------------------------------------------------------
bench::mark(
  data.table =DT[,.(range_v1_v2 = max(v1) - min(v2)),by = id3],
  tidyfst = DT %>% summarise_dt(
    by = id3,
    range_v1_v2 = max(v1) - min(v2)
  ),
  dplyr = DT %>%
    group_by(id3,.drop = TRUE) %>%
    summarise(range_v1_v2 = max(v1) - min(v2)),
  check = FALSE,iterations = 10
) -> q2

q2

## -----------------------------------------------------------------------------
bench::mark(
  data.table =DT[order(-v3),.(largest2_v3 = head(v3,2L)),by = id6],
  tidyfst = DT %>%
    in_dt(order(-v3),.(largest2_v3 = head(v3,2L)),by = id6),
  dplyr = DT %>%
    select(id6,largest2_v3 = v3) %>%
    group_by(id6) %>%
    slice_max(largest2_v3,n = 2,with_ties = FALSE),
  check = FALSE,iterations = 10
) -> q3

q3

## -----------------------------------------------------------------------------
bench::mark(
  data.table =DT[,lapply(.SD,mean),by = id4,.SDcols = v1:v3],
  tidyfst = DT %>%
    summarise_vars(
      v1:v3,
      mean,
      by = id4
    ),
  dplyr = DT %>%
    group_by(id4) %>%
    summarise(across(v1:v3,mean)),
  check = FALSE,iterations = 10
) -> q4

q4

## -----------------------------------------------------------------------------
bench::mark(
  data.table =DT[,.(v3 = sum(v3),count = .N),by = id1:id6],
  tidyfst = DT %>%
    summarise_dt(
      by = id1:id6,
      v3 = sum(v3),
      count = .N
    ),
  dplyr = DT %>%
    group_by(id1,id2,id3,id4,id5,id6) %>%
    summarise(v3 = sum(v3),count = n()),
  check = FALSE,iterations = 10
) -> q5

q5

## -----------------------------------------------------------------------------
sessionInfo()

