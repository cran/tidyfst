## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,eval = FALSE)

## -----------------------------------------------------------------------------
#  library(tidyfst)
#  diamonds <- ggplot2::diamonds
#  n = 10000000
#  set.seed(1234)
#  dtranges <- seq.Date(from = as.Date("2011-01-01"),
#                       to = as.Date("2020-01-01"),
#                       by = 1)
#  n1 <- sample(nrow(diamonds), n, replace = TRUE)
#  dat1 <- as.data.table(diamonds[n1, ])
#  dat1[, "dt"] <- sample(dtranges, n, replace = TRUE)  # 增加dt列
#  n2 <- sample(nrow(dat1), nrow(dat1)/1000)
#  dat1[n2, "price"] <- NA # price列构造千分之一缺失值
#  dat2 <- data.table(dt = sample(dtranges, min(n/1000, length(dtranges))),
#                     price1 = sample(1000, min(n/1000, length(dtranges)), replace = TRUE))
#  
#  dat3 <- data.table(dt = sample(dtranges, min(n/1000, length(dtranges))),
#                     price2 = sample(1000, min(n/1000, length(dtranges)), replace = TRUE))
#  
#  print(dat1)

## -----------------------------------------------------------------------------
#  set_dt(dat1,order_by = "dt")
#  dat1

## -----------------------------------------------------------------------------
#  sys_time_print({
#    r1_1 <- dat1 %>%
#      summarise_dt(
#        by = .(cut,color),
#        mean_price = mean(price, na.rm = TRUE),
#        median_price = median(price, na.rm = TRUE),
#        max_price = max(price, na.rm = TRUE)
#      )
#  })
#  r1_1

## -----------------------------------------------------------------------------
#  sys_time_print({
#    r1_2 <- dat1 %>%
#      arrange_dt(dt,-price) %>%
#      drop_na_dt(price) %>%
#      group_dt(
#        by = dt,
#        head(1)
#      )
#  })
#  r1_2

## -----------------------------------------------------------------------------
#  sys_time_print({
#    r2_1 <- dat1 %>%
#      left_join_dt(dat2,by = "dt")
#  })
#  r2_1

## -----------------------------------------------------------------------------
#  sys_time_print({
#    mymerge <- function(x, y) left_join_dt(x, y, by = "dt")
#    r2_2 <- Reduce(mymerge, list(dat1, dat2, dat3))
#  })
#  r2_2

## -----------------------------------------------------------------------------
#  sys_time_print({
#    mean1 <- function(x) mean(x, na.rm = TRUE)
#    max1 <- function(x) max(x, na.rm = TRUE)
#    r3_1 <-dat1 %>%
#      wider_dt(cut,
#               value_to_spread = c("depth", "price"),
#               name_to_spread = "color",
#               fun = list(mean1,max1))
#  })
#  r3_1

## -----------------------------------------------------------------------------
#  sys_time_print({
#    r3_2 <-dat1 %>%
#      select_dt(cut,color,x,y,z) %>%
#      longer_dt(cut,color,
#                gathered_name = "xyz",
#                gathered_value = "xyzvalue")
#  })
#  
#  r3_2

## -----------------------------------------------------------------------------
#  sys_time_print({
#    dat1 %>%
#      set_dt(fill_cols = "price")
#  })
#  dat1
#  

## -----------------------------------------------------------------------------
#  
#  sys_time_print({
#    mutate_ref(dat1,
#             mean_price = mean(price, na.rm = TRUE),
#             sd_price = sd(price, na.rm = TRUE),
#             by = .(cut, color))
#  })
#  
#  set_dt(dat1,order_by = c("cut","color"))
#  dat1

## -----------------------------------------------------------------------------
#  set_dt(dat1,order_by = "dt")
#  
#  sys_time_print({
#    dat1 %>%
#    group_dt(
#      by = dt,
#      mutate_dt(id = seq(.N))
#    ) -> dat1
#  })
#  dat1

## -----------------------------------------------------------------------------
#  set_dt(dat1,order_by = "color")
#  
#  sys_time_print({
#    dat1 %>%
#      group_dt(
#        by = color,
#        mutate_dt(
#          MA10_price = frollmean(price, 10),
#          MSD10_price = frollapply(price, 10, FUN = sd)
#        )
#      ) -> dat1
#  })
#  
#  dat1

## -----------------------------------------------------------------------------
#  sessionInfo()

