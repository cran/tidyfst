## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(tidyfst)
library(nycflights13)

flights2 <- flights %>% 
  select_dt(year,month,day, hour, origin, dest, tailnum, carrier)


## -----------------------------------------------------------------------------
flights2 %>% 
  left_join_dt(airlines)

## -----------------------------------------------------------------------------
flights2 %>% left_join_dt(weather)
flights2 %>% left_join_dt(planes, by = "tailnum")
flights2 %>% left_join_dt(airports, c("dest" = "faa"))
flights2 %>% left_join_dt(airports, c("origin" = "faa"))

## -----------------------------------------------------------------------------
df1 <- data.table(x = c(1, 2), y = 2:1)
df2 <- data.table(x = c(1, 3), a = 10, b = "a")

df1 %>% inner_join_dt(df2) 
df1 %>% left_join_dt(df2)
df1 %>% right_join_dt(df2)
df1 %>% full_join_dt(df2)


## -----------------------------------------------------------------------------
df1 <- data.frame(x = c(1, 1, 2), y = 1:3)
df2 <- data.frame(x = c(1, 1, 2), z = c("a", "b", "a"))

df1 %>% left_join_dt(df2)

## -----------------------------------------------------------------------------
flights %>% 
  anti_join_dt(planes, by = "tailnum") %>% 
  count_dt(tailnum, sort = TRUE)

## -----------------------------------------------------------------------------
df1 <- data.frame(x = c(1, 1, 3, 4), y = 1:4)
df2 <- data.frame(x = c(1, 1, 2), z = c("a", "b", "a"))

# Four rows to start with:
df1 %>% nrow()

# And we get four rows after the join
df1 %>% inner_join_dt(df2, by = "x") %>% nrow()

# But only two rows actually match
df1 %>% semi_join_dt(df2, by = "x") %>% nrow()

