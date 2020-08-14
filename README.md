# Creating and Analyzing Multi-Variable Earth Observation Data Cubes in R

_Tutorial at [OpenGeoHub summer school 2020](https://opengeohub.org/summer_school_2020)_


## Summary
This tutorial discusses Earth Observation (EO) data cubes and how they can be created and processed with the gdalcubes R package. In the first part, the package and its basic concepts (image collections, lazy evaluation, chunking, parallelization) are introduced using real world satellite-based Earth observations from Landsat. The second part will focus on the creation and processing of multi-variable data cubes, containing observations from different satellite-based EO missions. As such, we will look at two study cases on (i) combined vegetation monitoring with Sentinel-2, Landsat. and MODIS data, and (ii) combining vegetation observations with environmental variables (precipitation, soil moisture). Practical challenges, limitations, and ongoing work will be discussed. The tutorial will close with a short practical part, where participants can work on exercises using a smaller dataset.

## Documents

- Slides of plenary presentation (tbd)
- [Tutorial Part I](https://appelmar.github.io/opengeohub_summerschool2020/tutorial_01.html)
- [Tutorial Part II](https://appelmar.github.io/opengeohub_summerschool2020/tutorial_02.html)
- [Tutorial Part III](https://appelmar.github.io/opengeohub_summerschool2020/tutorial_03.html)
- [Exercise Solutions](https://github.com/appelmar/opengeohub_summerschool2020/blob/master/solutions.R)



## Installation instructions: 

1. Install R (latest version) and the following packages from CRAN: 
```
install.packages(c("gdalcubes", "sf", "stars", "magick", "magrittr", "viridis", "colorspace", "mapview", "zoo"))
```

2. To reproduce the first part and the practical exercises, download and unzip the sample dataset from https://uni-muenster.sciebo.de/s/e5yUZmYGX0bo4u9/download.


## References

- Appel, M., & Pebesma, E. (2019). On-Demand Processing of Data Cubes from Satellite Image Collections with the gdalcubes Library. Data, 4(3), 92. https://doi.org/10.3390/data4030092

