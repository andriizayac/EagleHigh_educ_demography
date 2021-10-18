
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(deSolve)
library(raster)
library(viridis)
library(png)
library(rphylopic)
library(grid)
library(ggplot2)
library(rgdal)

# === load aspect raster
asp <- raster(paste0(getwd(),"/www/dcewaspect.tif"))
northness <- (cos(asp*pi/180)+1)/2
idx <- is.na(northness) == FALSE 
mat <- northness
# === load RGB image
dcew <- stack(paste0(getwd(),"/www/dcewRGB.tif"))
dcew[values(dcew[[1]]) == 0] <- NA

# define an ODE function and covariates
year0 <- 1996
model <- function (time, u0, parms) {
  with(as.list(c(u0, parms)), {
    # gr = -r/1.01; ch = -k/2
    # h = r + eta*gr
    # g = k + gamma*ch
    dN <-   r * N * (1 - N / k) 
    list(dN) })
}
u0 <- c(N = 1)
pulsefn <- function(x) {
  data.frame(var = "N", 
             time = 1:100 * rbinom(100, 1, x), 
             value = .01, 
             method = "multiply")
}
# === load icons
#grass <- readPNG(paste0(getwd(),"/www/grass.png"))
grass <- image_data("4a00d067-54e4-45dd-abce-9a0b606a34dd", size = 512)[[1]]
cow <- image_data("dc5c561e-e030-444d-ba22-3d427b60e58a", size = 512)[[1]]
ncows <- 10
img <- readPNG("www/fire.png")

shinyServer(function(input, output) {
  ldat <- reactive({
    u0 = c(N = 1)
    times = 1:100
    params = c(r = input$r, k = input$k, 
               gamma = input$cheat, eta = input$graze)
    events = pulsefn(input$cheat*.1)
    events[ 1:15 , "time"] <- 0
    return(list(ode = ode(u0, times, model, params, method = "impAdams", 
               events = list(data = events)), events = events)
           )
  })
  output$growthPlot <- renderPlot({
    dat  <- ldat()
    out <- dat$ode
    events <- dat$events
    burns <- if(sum(events$time) > 0) {
      events$time[which(events$time > 0)]
    } else {NA}

    par(mar = c(4,5,0,1))
    # plot the solution
    plot(out, xlim = c(-10, 100), ylim = c(0, input$k + 5), xaxt = "n",
         lwd = 5, main = "", xlab = "Years", ylab = "Sagebrush cover, %", cex.lab = 1.5)
    axis(1, at = seq(-10,100, by = 10), labels = seq(-10,100, by = 10)+ 1996)
    lines(x = c(-10, input$T), y = rep(out[dim(out)[1],2], length(c(-10, input$T))), lty = "dashed", col = "gray")
    lines(c(-10, -1), c(rep(input$k, 2)), lwd=5, lty = "dashed", col = rgb(.1,1,.1, .75))
    lines(c(-1, 0), c(input$k, 1), lwd=5, lty = "dashed", col = rgb(1,.1,.1, .75))
    legend("top", legend = c("Pre-wildfire", "Wildfire effect", "Post-wildfire"), 
           col = c(rgb(.1,1,.1, .75), rgb(1,.1,.1, .75), "black"), 
           lty = c(2, 2, 1),  cex = 1, lwd = 3, ncol = 3, bty = "o")
    
    grid.raster(img, x = c(.22, burns/130 + .22), y = .07, width = .075, just = "center")
  }, width = 620, height = 300)
  output$phylopicPlot <- renderPlot({
    par(mar = c(4,5,0,0))
    (p <- ggplot(data.frame()) + xlim(0, 1) + ylim(0, 2) + 
        geom_point(color = rgb(0,0,0,0)) )
    for (i in 1:round(input$cheat*50) ) {
      p <- p + add_phylopic(grass, 1, runif(1, 0, 1), 
                            runif(1, .25, .75),.75, color = "darkgreen") 
    }
    p + theme_phylo_blank2()

  }, width = 620, height = 150)
  output$landscapePlot <- renderPlot({
    out  <- ldat()
    mat[idx] = mean(out$ode[,2]) - northness[idx]*(1-input$aspect)*input$k
    
    mat[mat < 0] <- u0
    cuts <- round(seq(0, input$k, l = input$k))
    par(mfrow = c(1, 2))
    mtext("My 'Title' in a strange place", side = 3, line = -6, outer = TRUE)
    raster::plotRGB(dcew, margins = T, main = "Satellite View")
    raster::plot(mat, breaks = cuts, col = rev(viridis(input$k)), 
                 box = F, axes = F, main = "Sagebrush cover, %")
    par()
  })
})
