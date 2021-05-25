
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
library(rgdal)
library(raster)
library(viridis)
library(png)
library(rphylopic)

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
    gr = -r/1.1; ch = -k/2
    h = r + eta*gr
    g = k + gamma*ch
    
    dN <-   h * N * (1 - N / g) 
    list(dN) })
}
u0 <- c(N = 1)
# times = seq(0, 10, 1)
# parms <- c(r = .1, k = 10, gamma = 0.5, eta = 0.7)
# out <- ode(u0, times, model, parms)
# plot(out, xaxt = "n", xlim = c(-5,max(times)))
# axis(1, at=c((-5:max(times)) + 10) )
# lines(out, col = "purple")

# === load icons
#grass <- readPNG(paste0(getwd(),"/www/grass.png"))
grass <- image_data("4a00d067-54e4-45dd-abce-9a0b606a34dd", size = 512)[[1]]
cow <- image_data("dc5c561e-e030-444d-ba22-3d427b60e58a", size = 512)[[1]]

shinyServer(function(input, output) {
  ldat <- reactive({
    year = c(year0:input$T)  
    u0 = c(N = 1)
    times = seq(0, input$T, 1)
    params = c(r = input$r, k = input$k, 
               gamma = input$cheat, eta = input$graze) 
    return(ode(u0, times, model, params))
    
  })
  output$growthPlot <- renderPlot({
    out  <- ldat()
    par(xpd=TRUE, mar = c(5, 5, 9, 1))
    # plot the solution
    plot(out, xlim = c(-10, input$T-1), ylim = c(0, input$k + 5), xaxt = "n",
         lwd = 5, main = "", xlab = "Years", ylab = "Sagebrush cover, %", cex.lab = 1.5)
    axis(1, at = c(-10:input$T), labels = c(-10:input$T + 1996))
    lines(x = c(-10, input$T), y = rep(out[dim(out)[1],2], length(c(-10, input$T))), lty = "dashed", col = "gray")
    lines(c(-10, -1), c(rep(input$k, 2)), lwd=5, lty = "dashed", col = rgb(.1,1,.1, .75))
    lines(c(-1, 0), c(input$k, 1), lwd=5, lty = "dashed", col = rgb(1,.1,.1, .75))
    legend("top", legend = c("Pre-wildfire", "Wildfire effect", "Post-wildfire"), 
           col = c(rgb(.1,1,.1, .75), rgb(1,.1,.1, .75), "black"), 
           lty = c(2, 2, 1),  cex = 1, lwd = 3, ncol = 3, bty = "o")
    
    for(i in 1:round(input$graze*10)) {
      add_phylopic_base(cow, x = rnorm(1, .7, .1), y = rnorm(1, 1.3, 0.1), 
                        ysize = rnorm(1, .05, .02) + input$graze*.2, alpha = 1, color = rgb(139/255,69/255,19/255, 1))
    }
    for(i in 1:round(input$cheat*20)) {
      add_phylopic_base(grass, x = rnorm(1, .17, .1), y = rnorm(1, 1.3, .01),
                        ysize = rnorm(1, .03, 0.02) + input$cheat*.075, alpha = 1, color = "darkgreen")
    }
    
  }, width = 620, height = 400)
  output$landscapePlot <- renderPlot({
    out  <- ldat()
    mat[idx] = out[input$T,2] - northness[idx]*(1-input$aspect)*input$k
    
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
