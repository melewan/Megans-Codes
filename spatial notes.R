

# spatial data

# more complex than just x,y coord

# main data types:

  #raster - terra package
    # cells of equal size, grid arrangement, like a picture with pixels (data in each pixel)
    # spatraster packages - multilayer
    # csr, how we project the round characteristic of the earth into a flat plane (computer screen) (crs? coord. ref?)
    # epsg - coordinate reference system
  # not super fast, memory issues, data might be too big (spatraster allows you to keep it in a different place)
    


    terra:rast()
    #    adding values
    
    # behaves just like a matrix/df
    # layers (lyr)
    terra::as.data.frame() #can use this to do calculations or whatever you want to do
    # you can also read in a raster as is (national land cover dataset page)
    
    
    # cropping the raster because it's a lot of data
    terra::ext() #creates an extent, a box of 4 corners (gps) make htis an object
    # transform the extent into a roster (has no values yet)
    # project that into the same crs
    
    
    # reclassify
    
    terra::classify
    # create a new matrix, first column is old classes, 
    # 2nd columnm, repeat what you want tree times
    
    # for example: 21 classify becomes 2
    22 becomes 2
    45 becomes 1 or whatever
    # in other cases use NA





    
    

  #vector - sf package
    # representation of spatial objects
    # sp is older package that you might need in the background
    # 1) point
    # 2)linestring
    # 3)polygon
    # for each class you can do multi
    
    sf::st_*
      # load
    sf::st_read()
    # extent = bounding box
    
    # simple features
      # it is spatial data but it very useful to treat like datframe and fits into tidyverse
   # geometry column is where the spatial data is stored 
    st_area: allows you to calculat the area of a polygon (needs as.numeric wrapped around)
    dplyr::arrange(-area_km) #arrange - sorts data by decreasing area 
    
    
    # filter spatially too, not just by the data
    sf::st_intersects #checks if 2 objects spatially intercept
    
    # ggplot + spatial
    ggplot() + geom_sf(data = regions, aes(fill = area ))
    
    
    
  # rastor and vector together
    plot(states_mainland$geometry)  #if you want to plot the outline, plot the geometry column
    # have to make sure they are in teh same crs
    # crop() - cuts out parts using extent
    # mask() changes all values outside the border (they are still there but not visible or something)
    # terra:extract()
      create objects from extracted 
      how this works behind the scenes: 
        puts points on top of the raster, and then gets information off of the cell that the point falls into
      gives you the cell number
      you have a point that you want to see within a classsification it will tell you
    
    
    
    
    
      ---
        title: "Exercise _Spatial data_"
      author: "Maximilian H.K. Hesselbarth"
      date: 2022/10/24
      editor_options: 
        chunk_output_type: console
      ---
        
        ```{r, setup, include = FALSE}
      knitr::opts_chunk$set(
        collapse = TRUE
      )
      
      library(downloadthis)
      ```
      
      ```{r tidyfigure, echo = FALSE, fig.align = "center", out.width = '65%'}
      knitr::include_graphics("img/sf.png", auto_pdf = FALSE)
      ```
      
      ```{r download, echo = FALSE}
      download_link(link = "https://raw.githubusercontent.com/mhesselbarth/advanced-r-workshop/main/exercise-spatial.Rmd",
                    button_label = "Download .Rmd file", 
                    button_type = "danger")
      ```
      
      <br><br>
        
        Make sure you can install and load all packages. This includes `terra` and `sf`, but also the `tidyverse`.
      
      ```{r load_libs}
      # Insert code here
      
      
      
      # End
      ```
      
      Next, go to [https://www.naturalearthdata.com](https://www.naturalearthdata.com) and download the "Small scale data, 1:110m" > "Cultural" > "Admin 1 - States, Provinces" data set. Additionally, download the 
      "NLCD 2019 Land Cover (CONUS)" data set from [https://www.mrlc.gov](https://www.mrlc.gov). 
      
      Once you downloaded all the data, read it into your R Session using the corresponding packages.
      
      ```{r read}
      # Insert code here
      
      
      
      # End
      ```
      
      Make sure both the vector and the raster data have the same CRS (Hint: It's often faster to project vectors instead of raster. If projecting the raster, have a look at the 'method' argument).

```{r crs}
# Insert code here



# End
```

Next, remove Alaska and Hawaii from the states vector because there is no NLCD data for these states. Next select only the 5 largest states in area

```{r states_size}
# Insert code here



# End
```

First plot the NLCD data and add the largest states to the map. Try to use the region as shape fill.

```{r plot}
# Insert code here



# End
```

Now, pick one state (your home state, a state you recently visited, a state you want to visit, ...) and get the NLCD data for that state only.

```{r crop}
# Insert code here



# End
```

Next, get all values of the cropped NLCD data and remove all `NA` and `NaN` values. Calculate the relative amount of all remaining values. Which one is the most dominant land-cover class in your state?

```{r rel_class}
# Insert code here



# End
```

Last, try to reclassify the raster into less classes (e.g., use the bigger classification found at[NLCD classes](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description))

```{r classification}
# Insert code here



# End
```
    
    
    
    
  ## Solutions notes #
  # naturalearthdata.com
  # masking still has all of the values but just makes it NA
  
    
    
