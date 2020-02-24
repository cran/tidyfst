## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(tidyfst)
library(nycflights13)

data.table(flights)

## -----------------------------------------------------------------------------
filter_dt(flights, month == 1, day == 1)

## -----------------------------------------------------------------------------
arrange_dt(flights, year, month, day)

## -----------------------------------------------------------------------------
arrange_dt(flights, -arr_delay)

## -----------------------------------------------------------------------------
select_dt(flights, year, month, day)

## -----------------------------------------------------------------------------
select_dt(flights, "^dep")

## -----------------------------------------------------------------------------
select_dt(flights, tail_num = tailnum)
rename_dt(flights, tail_num = tailnum)

## -----------------------------------------------------------------------------
mutate_dt(flights,
  gain = arr_delay - dep_delay,
  speed = distance / air_time * 60
)

## ----eval=FALSE---------------------------------------------------------------
#  mutate_dt(flights,
#    gain = arr_delay - dep_delay,
#    gain_per_hour = gain / (air_time / 60)
#  )

## -----------------------------------------------------------------------------
mutate_dt(flights,gain = arr_delay - dep_delay) %>%
  mutate_dt(gain_per_hour = gain / (air_time / 60))

## -----------------------------------------------------------------------------
transmute_dt(flights,
  gain = arr_delay - dep_delay
)

## -----------------------------------------------------------------------------
summarise_dt(flights,
  delay = mean(dep_delay, na.rm = TRUE)
)

## -----------------------------------------------------------------------------
sample_n_dt(flights, 10)
sample_frac_dt(flights, 0.01)

## ----eval=FALSE---------------------------------------------------------------
#  by_tailnum <- group_by(flights, tailnum)
#  delay <- summarise(by_tailnum,
#    count = n(),
#    dist = mean(distance, na.rm = TRUE),
#    delay = mean(arr_delay, na.rm = TRUE))
#  delay <- filter(delay, count > 20, dist < 2000)

## -----------------------------------------------------------------------------
flights %>% 
  summarise_dt( count = .N,
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE),by = tailnum)

## -----------------------------------------------------------------------------
# the dplyr syntax:
# destinations <- group_by(flights, dest)
# summarise(destinations,
#   planes = n_distinct(tailnum),
#   flights = n()
# )

summarise_dt(flights,planes = uniqueN(tailnum),flights = .N,by = dest) %>% 
  arrange_dt(dest)


## -----------------------------------------------------------------------------
# the dplyr syntax:
# daily <- group_by(flights, year, month, day)
# (per_day   <- summarise(daily, flights = n()))

flights %>% 
  summarise_dt(by = .(year,month,day),flights = .N)

# (per_month <- summarise(per_day, flights = sum(flights)))
flights %>% 
  summarise_dt(by = .(year,month,day),flights = .N) %>% 
  summarise_dt(by = .(year,month),flights = sum(flights))

# (per_year  <- summarise(per_month, flights = sum(flights)))
flights %>% 
  summarise_dt(by = .(year,month,day),flights = .N) %>% 
  summarise_dt(by = .(year,month),flights = sum(flights)) %>% 
  summarise_dt(by = .(year),flights = sum(flights))

