library(tidyverse)
library(palmerpenguins)

# tidyverse

# packages inside

readr #read rectangular data
tibble #modern re-imagining of dataframes
stringr #functions to work with strings (ie. sequence of characters)
forcats #functions to modify factors (ie. categorical data)
tidyr #functions to tidy/reshape data
dplyr #functions for data manipulation
purrr #functional programming
ggplot2 #data visualization

# check conflicts when you're loading a package
# if unsure, use packagename::function


# pipe operator %>%

f(x)    ~   x %>% f
f(x,y)  ~   x %>% f(y)
f(y,x)  ~   x %>% f(y, .)

min(log(sort(x)))
 ~
x %>% sort() %>% log() %>% min()

# base r has a pipe operator |> now

%>%   ~   |>
  

readr #reads automatically into a tibble
# tibble is a fancy dataframe
# contains different read_* functions like:
  read_xl()
  read_txt() 
  write_csv()
  
  df_penguins <- readr::read_csv("data/penguins_raw.csv")
  

stringr #strings of data
str_remove_all(pattern = " ") #can specify a pattern to remove from strings
  
  names(df_penguins) <- names(df_penguins) |> 
    stringr::str_remove_all(pattern = " ") |> 
    stringr::str_remove_all(pattern = "\\([^()]+\\)") |>
    stringr::str_to_lower()
  head(df_penguins, n = 3)


tidyr #tidy data

pivot_longer() - #reshaping data
pivot_wider() - ''
  
#long to wide
names_from()
values_from()
names_prefix()

#wide to long
names_to()
values_to()
drop_na()
  df_penguins <- tidyr::drop_na(df_penguins, bodymass)
nest()
unnest()
  tidyr::nest(df, data = -island)
  #nice just to check on data, look at it, report, clean
    #answer
    ## # A tibble: 3 × 2
    ##   island    data               
    ##   <chr>     <list>             
    ## 1 Torgersen <tibble [51 × 16]> 
    ## 2 Biscoe    <tibble [167 × 16]>
    ## 3 Dream     <tibble [124 × 16]>

str_split()



## dplyr

filter() #subset rows
select() #subset columns
select_if(is.numeric) #put all columns that are numbers into another df

  dplyr::filter(df_penguins, bodymass >= quantile(bodymass, 0.75), sex != "FEMALE") |>
    dplyr::select_if(is.numeric)

pull() #converts one column as a vector
  dplyr::pull(df_penguins, flipperlength) |>
     head(n = 10)
  # ans. [1] 181 186 ....

mutate() #create/modify columns
summarise() #calculates a single value, summarizes, (per group) - reduces all values into one group with one value
group_by() # group by column; summarise() works well with groupby
  , .groups = "drop"  # add this after summarize, weird if you don't specify that, look into this
  n() #to count observations within each group (context dependent)
case_when() #create a column depending on the case
slice() #subset rows by position

# example using: select, mutate, case_when, slice
  dplyr::select(df_penguins, individualid, species, culmenlength) |>
    dplyr::mutate(culmenlength_cm = culmenlength / 10,
                  culmenlenth_class = 
                    dplyr::case_when(culmenlength < 35  ~ "small",
                                     culmenlength >= 35 & culmenlength <= 45 ~ "med", 
                                     culmenlength > 45 ~ "large")) |>
    dplyr::slice(sample(1:nrow(df_penguins), size = 3))

# example using: group_by, summarize, . , groups = "drop", 
  (df_penguins_sum <- dplyr::group_by(df_penguins, island, species) |>
      dplyr::summarise(n = dplyr::n(),
                       flipperlength_mn = mean(flipperlength), 
                       flipperlength_sd = sd(flipperlength), 
                       .groups = "drop"))  

  
*_join #combines columns from x and y using matching keys
  dplyr::left_join(x = df_penguins, y = df_penguins_sum, by = c("island", "species")) |>
    dplyr::select(species, island, tidyselect::starts_with("flipper")) |> 
    dplyr::slice(sample(1:nrow(df_penguins), size = 5))
#look at picture of joins from slides, very helpful

# example: create summarized dataframe
  (df_pen_sum <- dplyr::mutate(df_penguins, year = format(dateegg, "%Y"),
                               species = stringr::str_split(df_penguins$species, 
                                                            pattern = " ", simplify = TRUE)[, 1]) |> 
      dplyr::group_by(species, island, year) |> 
      dplyr::summarise(bodymass = mean(bodymass), .groups = "drop") |> 
      dplyr::filter(year %in% c(2007, 2009)))

purrr package - least understood in tidyverse
# similar to loops, might be better than loops
# species_names - in example, creating a vector
# purr and map allow you write functions
# 
map() always returns a list
map_int() returns as an integer



## regular expressions in R - ^, \\,

### Notes from tidyverse solutions

# tibble is a dataframe
# stringr - in addition to removing you can replace, replacement = " "
# tidyselect
# broom::glance() - clean output of linear regression model



