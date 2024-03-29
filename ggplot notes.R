## ggplot

# Notes ####


# aesthetics layer + geom layer + 

# mapping layer
  # within the geom point you can create another aesthetic call to specify colors of that geom
  # when colors or size are matched wtih the data

# scaling layer
  # allows you to change how your data gets related to the aesthetic
  # can create a vector of colors and call the vector instead of the individual colors
  # scale_x_continous, creating his own function, make his limits/breaks (ticks) based on calicualtions 
    #can make it scale to a certain percentage of the data

# themes
  # theme(face = bold) < bolds the title

# geoms
  # geom_smooth - regression line
  # method = "lm" linear model
  # geom_label - print into the plot


# facet wrapping
  # create panels according to groups
  facet_wrap(. ~ island) "use everything and wrap that depending ont he grouping of the island"

  facet_grid - same thing but pulls it into a grid, will put all combinations on teh grid
  
# combine figures
  cowplot / patchwork
  cowplot::plot_grid(p1, p2, nrow = 3)
  
# more figures
  # use tidyverse to prep data before ggplot, make data tidy\
  # use group to set interaction of all variables
  geom_line(
    aes(group = interaction(sex, name))
  )  # can make a line based on groupings
  
  # alpha is transparency
  
  # guides(colour = guide_legend())
  # which colors to which variables - choose
  # make a vector 
    # adelie = #5473895 color
  # (tidy data means grouped variables appear on each row with every observation)
  
  
# segments
  # draw lines in the plot not really related to the data
  geom_segment()
  geom segment(aes(xend = 1:n, yend ))
  # annotate = allows you to write in the plot (UNRELATED to data), UNLIKE geom_label, which is related to the data
    annotate(geom = "rect") geom is the type of annotation, rectangle, text, etc.
    # can make a rectangle then add another annotate layer for just text and can position that in same place
    

# densities plot
    
  #geom_density()
   x = xvar, y = ..density..
            y = -..density.. # (puts values physically under y = 0, upside down, negative)
   # density of xvar
          can also do other things other than density
          
          
# gganimate
  # transition_states(states =) # states = the thing that will move, species
          # lots of animation options
          # gganimate::animate(p)
   # geom_histogram added histogram bars to density plot
  
    
          
          
          
          
          
# Exercise ####
          
          ---
            title: "Exercise _Data visualization using ggplot2_"
          author: "Maximilian H.K. Hesselbarth"
          date: 2022/10/24
          editor_options: 
            chunk_output_type: console
          ---
            
            ```{r, setup, include=FALSE}
          knitr::opts_chunk$set(
            collapse = TRUE
          )
          
          library(downloadthis)
          ```
          
          ```{r tidyfigure, echo = FALSE, fig.align = "center", out.width = '65%'}
          knitr::include_graphics("img/ggplot2_exploratory.png", auto_pdf = FALSE)
          ```
          
          ```{r download, echo = FALSE}
          download_link(link = "https://raw.githubusercontent.com/mhesselbarth/advanced-r-workshop/main/exercise-ggplot.Rmd",
                        button_label = "Download .Rmd file", 
                        button_type = "danger")
          ```
          
          <br><br>
            
            Again, we are using the `palmerpenguins` package, as well as the `ggplot2` package. Since `ggplot2` is part of the tidyverse, 
          you can just load the entire `tidyverse` again. Last, load the `cowplot` packages to combine plots.
          
          ```{r load_libs}
          # Insert code here
          
          
          
          # End
          ```
          
          Take either the `penguins` or the `penguins_raw` data set and create a scatterplot using two continuous variables. 
          Make sure to format the axis titles and add a figure title.
          
          ```{r}
          # Insert code here
          
          names(penguins_raw) [13] = "mass"
          
          ggplot(data = penguins_raw, aes(x = Species, y = mass) +
                   geom_point())
          
          ggplot(NULL, aes(x = DateTime, y = AveTurb)) +
            geom_line(data = dat1, mapping = aes(color = "moored"), size = 0.25) +
            geom_point(data = dat2, shape=21, size = 3, fill = "lightseagreen", aes(color = "0.7 m above bottom")) +
            geom_point(data = dat3, shape=24, size = 3, fill = "darkviolet", aes(color = "bottom")) +
            scale_color_manual("Data Type", limits=c("moored", "0.7 m above bottom", "bottom"), values = c("black", "lightseagreen", "darkviolet")) +
            guides(colour = guide_legend(override.aes = list(pch = c(NA, 21, 24), fill = c("black", "lightseagreen", "darkviolet"), linetype = c(1,0,0)))) +
            labs(subtitle="Turbidity Profile Cast vs Moored plots", 
                 y="Turbidity", 
                 x="Date", 
                 title= mytitle)  +
            theme(text= element_text (size=14))
          
          # End
          ```
          
          Next, change, the overall theme, use a different point shape, size and point color. 
          
          ```{r}
          # Insert code here
          
          
          
          # End
          ```
          
          Next, use at least one of the discrete variables in the data set and use it to a) set different point colors based on the discrete variable and b) wrap the plot using facets. Try to use different colors than the default color scheme.

```{r}
# Insert code here



# End
```

```{r}
# Insert code here



# End
```

Try to make a histogram of the bill depth separated by species and sex. You can use colors, fills, facets or any other idea you have to separate the discrete classes. Try out different bin widths and see how much the plots changes. Last, can you add a density curve to the histogram? To compare the bin widths, combine at least two different plots to one (using `cowplot`)

```{r}
# Insert code here



# End
```

Visualize the body mass of all species using a boxplot. Additionally, to the boxplot, also add the raw data distribution (as points), the number of individuals for each species (as text) and some information about the sex differences (however you want). 

```{r}
# Insert code here



# End
```

Summarize the `penguins` data set by two discrete variables and calculate the mean flipper length. Create a plot showing the mean length for the two groups including an error measure (e.g., mean +/- sd). 

```{r}
# Insert code here



# End
```

<br><br>
  
  ```{r, echo = FALSE, message = FALSE, fig.align = "center", out.width = "75%"}
library(ggplot2)
library(ggcats)

x <- 1:10 + runif(n = 10)
y <- 1:10 + runif(n = 10)

df <- tibble::tibble(x = x, y = y, img = sample(x = c("colonel", "grumpy", "hipster", "lil_bub",
                                                      "maru", "mouth", "pop_close"), 
                                                size = 10, replace = TRUE))

ggplot(df) + geom_cat(aes(x = x, y = y, cat = img), size = 2.5) + 
  labs(x = "Number of cats", y = "Having a good time") + 
  theme_classic()
```       
          
# Solution notes

# sometimes warnings are not imperative or important (removed 2 rows containing missing points)
# theme_*() many options
# can create a vector with, for example, histogram bin width 
bins = c(0.25, 0.5, etc.)
labs() #line of code, check this for how to implement vector
position = position_dodge # have for example the 2 x points not directly next to each other





          