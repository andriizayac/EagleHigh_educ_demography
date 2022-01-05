
shinyServer(function(input, output) {
  # bs_themer()
  # --- generate data inputs
  ldat <- reactive({
    times = 1:100
    params = c(r = input$r, k = input$k, 
               gamma = input$cheat, eta = input$graze)
    if(input$firestoch == TRUE) {
      events = pulsefn.rand(input$cheat*.05)
    } else {
      events = pulsefn(input$cheat*.05)
    }
    
    events[ 1:15 , "time"] <- 0
    return(list(ode = ode(u0, times, model, params, method = "impAdams", 
                          events = list(data = events)), events = events)
    )
  })
  fireIn <- reactive({
    return(filter(fires, Fire_Year >= input$range[1], Fire_Year <= input$range[2] ))
  })
  
  
  # --- sagebrush growth plot
  output$growthPlot <- renderPlot({
    dat  <- ldat()
    out <- dat$ode
    events <- dat$events
    burns <- if(sum(events$time) > 0) {
      events$time[which(events$time > 0)]
    } else {NA}
    
    par(mar = c(4,5,1,1))
    # plot the solution
    plot(out, xlim = c(-10, 100), ylim = c(0, input$k + 5), xaxt = "n",
         lwd = 7, main = "", xlab = "Years", ylab = "Sagebrush cover, %", cex.lab = 1.5)
    axis(1, at = seq(-10,100, by = 10), labels = seq(-10,100, by = 10)+ 1996)
    lines(x = c(-10, input$T), y = rep(out[dim(out)[1],2], length(c(-10, input$T))), lty = "dashed", col = "gray")
    lines(c(-10, -1), c(rep(input$k, 2)), lwd=7, lty = "dotted", col = rgb(.1,1,.1, .75))
    lines(c(-1, 0), c(input$k, 1), lwd=7, lty = "dotted", col = rgb(1,.1,.1, .75))
    legend("top", legend = c("Pre-wildfire", "Wildfire effect", "Post-wildfire"), 
           col = c(rgb(.1,1,.1, .75), rgb(1,.1,.1, .75), "black"), 
           lty = c(2, 2, 1),  cex = 1, lwd = 3, ncol = 3, bty = "o")
    
    grid.raster(img, x = c(.22, burns/130 + .22), y = .07, width = .075, just = "center")
  }, width = 620, height = 300)
  output$phylopicPlot <- renderPlot({
    par(mar = c(0,0,0,0), bg = bgcolor)
    (p <- ggplot(data.frame()) + xlim(0, 1) + ylim(0, 1) + 
        geom_point(color = rgb(0,0,0,0)) )
    for (i in 1:round(input$cheat*50) ) {
      p <- p + add_phylopic(grass, 1, runif(1, 0, 1), 
                            runif(1, .25, .75),.75, color = "darkgreen") 
    }
    p + theme_phylo_blank2() 
    
    
  }, width = 620, height = 100)
  
  # --- map
  output$mymap = renderLeaflet({
    firesInt <- fireIn()
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addPolygons(data = firesInt, weight = 1, col = "red", fill = TRUE, layerId = firesInt$Fire_Name) %>% 
      # addCircleMarkers(
      #   lng=firesInt$cent.x,
      #   lat=firesInt$cent.y,
      #   radius = log(firesInt$Hectares_B)/2,
      #   stroke = FALSE,
      #   layerId = firesInt$Fire_Name,
      #   fillOpacity = 0.8) %>%
      addPolygons(data = states, weight = 2, col = "black", fill = FALSE) %>% 
      setView(zoom = initial_zoom, lat = 43.6891288, lng = -116.3551687) 
  })
  
  # input$mymap_maker/shape_click
  observeEvent(input$mymap_shape_click, { # update the location selectInput on map clicks
    firesInt <- fireIn()
    event <- input$mymap_shape_click
    # event <- input$mymap_marker_click
    print(event) 
    obs <- filter(firesInt, Fire_Name == event$id)
    lab <- paste0("NAME: ", event$id, ", YEAR: ", obs$Fire_Year, ", AREA: ", round(obs$Hectares_B), " ha")
    leafletProxy("mymap") %>% 
      addPopups(event$lng, event$lat, lab)
  })
})
