## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
# library(tidyfst)
# library(nycflights13)
# library(data.table)
# 
# data.table(flights)

## -----------------------------------------------------------------------------
# filter_dt(flights, month == 1 & day == 1)

## -----------------------------------------------------------------------------
# arrange_dt(flights, year, month, day)

## -----------------------------------------------------------------------------
# arrange_dt(flights, -arr_delay)

## -----------------------------------------------------------------------------
# select_dt(flights, year, month, day)

## -----------------------------------------------------------------------------
# select_dt(flights, "^dep")

## -----------------------------------------------------------------------------
# select_dt(flights, tail_num = tailnum)
# rename_dt(flights, tail_num = tailnum)

## -----------------------------------------------------------------------------
# mutate_dt(flights,
#   gain = arr_delay - dep_delay,
#   speed = distance / air_time * 60
# )

## ----eval=FALSE---------------------------------------------------------------
# mutate_dt(flights,
#   gain = arr_delay - dep_delay,
#   gain_per_hour = gain / (air_time / 60)
# )

## -----------------------------------------------------------------------------
# mutate_dt(flights,gain = arr_delay - dep_delay) %>%
#   mutate_dt(gain_per_hour = gain / (air_time / 60))

## -----------------------------------------------------------------------------
# transmute_dt(flights,
#   gain = arr_delay - dep_delay
# )

## -----------------------------------------------------------------------------
# summarise_dt(flights,
#   delay = mean(dep_delay, na.rm = TRUE)
# )

## -----------------------------------------------------------------------------
# sample_n_dt(flights, 10)
# sample_frac_dt(flights, 0.01)

## ----eval=FALSE---------------------------------------------------------------
# by_tailnum <- group_by(flights, tailnum)
# delay <- summarise(by_tailnum,
#   count = n(),
#   dist = mean(distance, na.rm = TRUE),
#   delay = mean(arr_delay, na.rm = TRUE))
# delay <- filter(delay, count > 20, dist < 2000)

## -----------------------------------------------------------------------------
# flights %>%
#   summarise_dt( count = .N,
#   dist = mean(distance, na.rm = TRUE),
#   delay = mean(arr_delay, na.rm = TRUE),by = tailnum)

## -----------------------------------------------------------------------------
# # the dplyr syntax:
# # destinations <- group_by(flights, dest)
# # summarise(destinations,
# #   planes = n_distinct(tailnum),
# #   flights = n()
# # )
# 
# summarise_dt(flights,planes = uniqueN(tailnum),flights = .N,by = dest) %>%
#   arrange_dt(dest)
# 

## -----------------------------------------------------------------------------
# # the dplyr syntax:
# # daily <- group_by(flights, year, month, day)
# # (per_day   <- summarise(daily, flights = n()))
# 
# flights %>%
#   summarise_dt(by = .(year,month,day),flights = .N)
# 
# # (per_month <- summarise(per_day, flights = sum(flights)))
# flights %>%
#   summarise_dt(by = .(year,month,day),flights = .N) %>%
#   summarise_dt(by = .(year,month),flights = sum(flights))
# 
# # (per_year  <- summarise(per_month, flights = sum(flights)))
# flights %>%
#   summarise_dt(by = .(year,month,day),flights = .N) %>%
#   summarise_dt(by = .(year,month),flights = sum(flights)) %>%
#   summarise_dt(by = .(year),flights = sum(flights))

## -----------------------------------------------------------------------------
# library(tidyfst)
# library(data.table)
# library(nycflights13)
# 
# flights = data.table(flights) %>% na.omit()

## -----------------------------------------------------------------------------
# # data.table
# head(flights[origin == "JFK" & month == 6L])
# flights[1:2]
# flights[order(origin, -dest)]
# 
# # tidyfst
# flights %>%
#   filter_dt(origin == "JFK" & month == 6L) %>%
#   head()
# flights %>% slice_dt(1:2)
# flights %>% arrange_dt(origin,-dest)

## -----------------------------------------------------------------------------
# # data.table
# flights[, list(arr_delay)]
# flights[, .(arr_delay, dep_delay)]
# flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
# 
# # tidyfst
# flights %>% select_dt(arr_delay)
# flights %>% select_dt(arr_delay, dep_delay)
# flights %>% transmute_dt(delay_arr = arr_delay, delay_dep = dep_delay)

## -----------------------------------------------------------------------------
# # data.table
# flights[, sum( (arr_delay + dep_delay) < 0)]
# flights[origin == "JFK" & month == 6L,
#                .(m_arr = mean(arr_delay), m_dep = mean(dep_delay))]
# flights[origin == "JFK" & month == 6L, length(dest)]
# flights[origin == "JFK" & month == 6L, .N]
# 
# # tidyfst
# flights %>% summarise_dt(sum( (arr_delay + dep_delay) < 0))
# flights %>%
#   filter_dt(origin == "JFK" & month == 6L) %>%
#   summarise_dt(m_arr = mean(arr_delay), m_dep = mean(dep_delay))
# flights %>%
#   filter_dt(origin == "JFK" & month == 6L) %>%
#   nrow()
# flights %>%
#   filter_dt(origin == "JFK" & month == 6L) %>%
#   count_dt()
# flights %>%
#   filter_dt(origin == "JFK" & month == 6L) %>%
#   summarise_dt(.N)

## -----------------------------------------------------------------------------
# # data.table
# flights[, c("arr_delay", "dep_delay")]
# 
# select_cols = c("arr_delay", "dep_delay")
# flights[ , ..select_cols]
# flights[ , select_cols, with = FALSE]
# 
# flights[, !c("arr_delay", "dep_delay")]
# flights[, -c("arr_delay", "dep_delay")]
# 
# # returns year,month and day
# flights[, year:day]
# # returns day, month and year
# flights[, day:year]
# # returns all columns except year, month and day
# flights[, -(year:day)]
# flights[, !(year:day)]
# 
# # tidyfst
# flights %>% select_dt(c("arr_delay", "dep_delay"))
# 
# select_cols = c("arr_delay", "dep_delay")
# flights %>% select_dt(cols = select_cols)
# 
# flights %>% select_dt(-arr_delay,-dep_delay)
# 
# flights %>% select_dt(year:day)
# flights %>% select_dt(day:year)
# flights %>% select_dt(-(year:day))
# flights %>% select_dt(!(year:day))

## -----------------------------------------------------------------------------
# # data.table
# flights[, .N, by = .(origin)]
# flights[carrier == "AA", .N, by = origin]
# flights[carrier == "AA", .N, by = .(origin, dest)]
# flights[carrier == "AA",
#         .(mean(arr_delay), mean(dep_delay)),
#         by = .(origin, dest, month)]
# 
# # tidyfst
# flights %>% count_dt(origin) # sort by default
# flights %>% filter_dt(carrier == "AA") %>% count_dt(origin)
# flights %>% filter_dt(carrier == "AA") %>% count_dt(origin,dest)
# flights %>% filter_dt(carrier == "AA") %>%
#   summarise_dt(mean(arr_delay), mean(dep_delay),
#                by = .(origin, dest, month))

## -----------------------------------------------------------------------------
# # data.table
# flights[carrier == "AA", .N, by = .(origin, dest)][order(origin, -dest)]
# flights[, .N, .(dep_delay>0, arr_delay>0)]
# 
# # tidyfst
# flights %>%
#   filter_dt(carrier == "AA") %>%
#   count_dt(origin,dest,sort = FALSE) %>%
#   arrange_dt(origin,-dest)
# flights %>%
#   summarise_dt(.N,by = .(dep_delay>0, arr_delay>0))

## -----------------------------------------------------------------------------
# # data.table
# flights[carrier == "AA",
#         lapply(.SD, mean),
#         by = .(origin, dest, month),
#         .SDcols = c("arr_delay", "dep_delay")]
# 
# # tidyfst
# flights %>%
#   filter_dt(carrier == "AA") %>%
#   group_dt(
#     by = .(origin, dest, month),
#     at_dt("_delay",summarise_dt,mean)
#            )

## -----------------------------------------------------------------------------
# flights %>%
#   filter_dt(carrier == "AA") %>%
#   group_dt(
#     by = .(origin, dest, month),
#     at_dt("_delay",summarise_dt,mean) %>%
#       mutate_dt(sum = dep_delay + arr_delay)
#            )

## -----------------------------------------------------------------------------
# # data.table
# flights[, head(.SD, 2), by = month]
# 
# # tidyfst
# flights %>%
#   group_dt(by = month,head(2))

