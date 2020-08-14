

# Solutions (i)
#########################################################################################################


# 1. Start R. If not yet done, install the `gdalcubes` package from CRAN, and load it.
# install.packages("gdalcubes)
library(gdalcubes)
#gdalcubes_options(threads = 8)


#2. If not yet done, download the sample dataset from https://uni-muenster.sciebo.de/s/e5yUZmYGX0bo4u9/download and unzip.
dir = tempdir()
download.file("https://uni-muenster.sciebo.de/s/e5yUZmYGX0bo4u9/download", destfile = file.path(dir, "L8_Amazon.zip"), mode = "wb")
unzip(file.path(dir, "L8_Amazon.zip"), exdir = file.path(dir, "L8_Amazon"))


# 3. Create an image collection from all GeoTIFF files in the unzipped directory.
files = list.files(file.path(dir, "L8_Amazon"), pattern=".tif", recursive = TRUE, full.names = TRUE)
L8.col =  create_image_collection(files, "L8_SR")
L8.col


#4. Create a *yearly* data cube from the image collection, covering the full spatiotemporal extent at 1 km resolution, using a *Brazil Mercator* projection (EPSG:5641).
v = cube_view(srs="EPSG:5641", extent=L8.col, dt="P1Y", dx=1000, aggregation = "median", resampling = "average")
raster_cube(L8.col, v) 


#5. Select the near infrared band (`"B05"`) and plot the cube.
plot(select_bands(raster_cube(L8.col, v), "B05"), key.pos=1, col=viridis::viridis, zlim=c(0, 5000), nbreaks=50)


#6. Create a false-color image for the year 2017, using the  red (`"B04"`), swir2 (`"B07"`), and blue (`"B02"`) bands as red, green, and blue channels.  You can select the year 2017 by creating a new data cube view (derived from the previous view, and setting both `t0 = "2017"`, and `t1 = "2017"`)
v.2017 = cube_view(view = v, extent=list(t0="2017",t1="2017"))
v.2017
plot(select_bands(raster_cube(L8.col, v.2017), c("B04", "B07", "B01")), rgb=1:3)


# 7. Create a data cube for a spatial subarea (use the data cube view and mask below).
v.subarea = cube_view(extent=list(left=-6320000, right=-6220000, bottom=-600000, top=-500000, 
                                  t0="2014-01-01", t1="2018-12-31"), dt="P1M", dx=100, dy=100, srs="EPSG:3857", 
                      aggregation = "median", resampling = "bilinear")
L8.clear_mask = image_mask("PIXEL_QA", values=c(322, 386, 834, 898, 1346, 324, 388, 836, 900, 1348), invert = TRUE)
raster_cube(L8.col, v.subarea, mask=L8.clear_mask)


# 8. Calculate the normalized difference moisture index (NDMI) using the formula "(B05-B06)/(B05+B06)".
library(magrittr)
raster_cube(L8.col, v.subarea, mask=L8.clear_mask) %>%
  select_bands(c("B05","B06")) %>%
  apply_pixel("(B05-B06)/(B05+B06)", "NDMI")


# 9. Compute minimum, maximum, median, and mean NDMI values over time and plot the result.
raster_cube(L8.col, v.subarea, mask=L8.clear_mask) %>%
  select_bands(c("B05","B06")) %>%
  apply_pixel("(B05-B06)/(B05+B06)", "NDMI") %>%
  reduce_time("min(NDMI)", "max(NDMI)", "median(NDMI)", "mean(NDMI)") %>%
  plot(col=viridis::viridis, zlim=c(-1,1), nbreaks=50, key.pos=1)


