## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(tidyfst)
diamonds <- ggplot2::diamonds
n = 1e5  #如果想做工业级测试，可以继续增加数量
set.seed(2020)
dtranges <- seq.Date(from = as.Date("2011-01-01"),
                     to = as.Date("2020-01-01"),
                     by = 1)
n1 <- sample(nrow(diamonds), n, replace = TRUE)
dat1 <- as.data.table(diamonds[n1, ])
dat1[, "dt"] <- sample(dtranges, n, replace = TRUE)  # 增加dt列
n2 <- sample(nrow(dat1), nrow(dat1)/1000)
dat1[n2, "price"] <- NA # price列构造千分之一缺失值
dat2 <- data.table(dt = sample(dtranges, min(n/1000, length(dtranges))),
                   price1 = sample(1000, min(n/1000, length(dtranges)), replace = TRUE))

dat3 <- data.table(dt = sample(dtranges, min(n/1000, length(dtranges))),
                   price2 = sample(1000, min(n/1000, length(dtranges)), replace = TRUE))

print(dat1)

## -----------------------------------------------------------------------------
dat1 = arrange_dt(dat1,dt)
dat1

## -----------------------------------------------------------------------------
sys_time_print({
  r1_1 <- dat1 %>% 
    summarise_dt(
      by = .(cut,color),
      mean_price = mean(price, na.rm = TRUE),
      median_price = median(price, na.rm = TRUE),
      max_price = max(price, na.rm = TRUE)
    )
})
r1_1

## -----------------------------------------------------------------------------
sys_time_print({
  r1_2 <- dat1 %>% 
    arrange_dt(dt,-price) %>% 
    drop_na_dt(price) %>% 
    group_dt(
      by = dt,
      head(1)
    )
})
r1_2

## -----------------------------------------------------------------------------
sys_time_print({
  r2_1 <- dat1 %>% 
    left_join_dt(dat2,by = "dt")
})
r2_1

## -----------------------------------------------------------------------------
sys_time_print({
  mymerge <- function(x, y) left_join_dt(x, y, by = "dt")
  r2_2 <- Reduce(mymerge, list(dat1, dat2, dat3))
})
r2_2

## -----------------------------------------------------------------------------
sys_time_print({
  mean1 <- function(x) mean(x, na.rm = TRUE)
  max1 <- function(x) max(x, na.rm = TRUE)
  r3_1 <-dat1 %>% 
    wider_dt(cut,
             value = c("depth", "price"),
             name = "color",
             fun = list(mean1,max1))
})
r3_1

## -----------------------------------------------------------------------------
sys_time_print({
  r3_2 <-dat1 %>% 
    select_dt(cut,color,x,y,z) %>% 
    longer_dt(cut,color,
              name = "xyz",
              value = "xyzvalue")
})

r3_2 

## -----------------------------------------------------------------------------
sys_time_print({
  dat1 %>% fill_na_dt(price) -> dat1
})
dat1


## -----------------------------------------------------------------------------

sys_time_print({
  mutate_dt(dat1,
           mean_price = mean(price, na.rm = TRUE),
           sd_price = sd(price, na.rm = TRUE),
           by = .(cut, color))
})

dat1

## -----------------------------------------------------------------------------

sys_time_print({
  dat1 %>% 
  group_dt(
    by = dt,
    mutate_dt(id = seq(.N))
  ) -> dat1
})
dat1

## -----------------------------------------------------------------------------

sys_time_print({
  dat1 %>% 
    group_dt(
      by = color,
      mutate_dt(
        MA10_price = frollmean(price, 10),
        MSD10_price = frollapply(price, 10, FUN = sd)
      )
    ) -> dat1
})

dat1

## -----------------------------------------------------------------------------
sessionInfo()

