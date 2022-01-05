# === load packages
library(shiny)
library(shinyWidgets)
library(deSolve)
library(raster)
library(viridis)
library(png)
library(rphylopic)
library(grid)
library(ggplot2)
library(rgdal)
library(emo)
library(leaflet)
library(sf)
library(dplyr)
library(htmltools)
library(bslib)



# # === load aspect raster
# asp <- raster(paste0(getwd(),"/www/dcewaspect.tif"))
# northness <- (cos(asp*pi/180)+1)/2
# idx <- is.na(northness) == FALSE 
# mat <- northness

# === load fire dataset and state boundaries
file <- "data/fires_1870_2015_simplified_v2.shp"
firesp <- st_read(file) %>% 
  filter(Hectares_B > 500) %>% 
  st_geometry() %>% 
  st_centroid() %>%
  st_transform(4326) 

fires <- st_read(file) %>% 
  filter(Hectares_B > 500) %>% 
  st_transform(4326) %>% 
  mutate(centroids = st_coordinates(firesp),
         cent.x = st_coordinates(firesp)[,1],
         cent.y = st_coordinates(firesp)[,2])

states <- st_read("data/cb_2018_us_state_5m/cb_2018_us_state_5m.shp") %>% 
  st_transform(4326)

# === load RGB image of the Dry Creek
dcew <- stack(paste0(getwd(),"/www/dcewRGB.tif"))
dcew[values(dcew[[1]]) == 0] <- NA

# === global variables
year0 <- 1996
u0 <- c(N = 1)
ncows <- 10
bgcolor <- "#bffbf3"
initial_zoom <- 10

# === functions: ODE , covariates, and the pulse function
model <- function (time, u0, parms) {
  with(as.list(c(u0, parms)), {
    # gr = -r/1.01; ch = -k/2
    # h = r + eta*gr
    # g = k + gamma*ch
    dN <-   r * N * (1 - N / k) 
    list(dN) })
}
pulsefn <- function(x) {
  set.seed(123)
  data.frame(var = "N", 
             time = 1:100 * rbinom(100, 1, x), 
             value = .01, 
             method = "multiply")
}
pulsefn.rand <- function(x) {
  data.frame(var = "N", 
             time = 1:100 * rbinom(100, 1, x), 
             value = .01, 
             method = "multiply")
}

# === load icons from rphylopic
#grass <- readPNG(paste0(getwd(),"/www/grass.png"))
grass <- image_data("4a00d067-54e4-45dd-abce-9a0b606a34dd", size = 512)[[1]]
cow <- image_data("dc5c561e-e030-444d-ba22-3d427b60e58a", size = 512)[[1]]
img <- readPNG("www/fire.png")


