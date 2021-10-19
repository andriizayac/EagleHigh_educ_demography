# This is an application to demonstrate demographic growth of big sagebrush in Boise foothills

# for references: http://shiny.rstudio.com
# path <- "~/Desktop/CodingClub/ShinyApps/MurdockEduc_demography/MurdockEduc_demography/"
library(shiny)
library(shinyWidgets)
# This is an application to demonstrate demographic growth of big sagebrush in Boise foothills

shinyUI(fluidPage(
  # setBackgroundColor(
  #   color = c("#A5F7E180", "#A5F7E180"), #ACEBF8 6ABFE7
  #   gradient = "linear",
  #   direction = "bottom"),
  setBackgroundColor("#bffbf3"),
  # Application title
  titlePanel("Big Sagebrush and Wildfires", windowTitle = "Sage Growth"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition="input.tabselected==1", h4("Background")),
      conditionalPanel(condition = "input.tabselected==3 || input.tabselected==2",
      sliderInput("r",
                  "Growth rate (r):", min = 0.01, max = 1,
                  value = .1),
      sliderInput("k",
                  "Carrying capacity (K):", min = 3, max = 50,
                  value = 20),
      sliderInput("cheat",
                  "Cheatgrass:", min = 0, max = 1,
                  value = 0)
      ),
      conditionalPanel(condition= "input.tabselected==3",
        sliderInput("aspect", 
                    "Snow accumulation", min = 0, max = 1, 
                    value = 0),
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel(paste("Introduction", emo::ji("sun")), value = 1, 
                           h5("Late August in 1996 was out of ordinary for Boise residents. Four days, August 26-30, a wildfire started during a target shooting raged through Boise foothills around the Military Reserve Park and burning more than 15,000 acres. After the fire had scorched the vegetation on the slopes, the city residents feared of severe mudslides to follow. The fears were ground in what Boise experienced just a few decades before, in 1959, when mud from the hills slid down and flooded residential homes."),
                           # br(), 
                           img(src='drawing.png', align = "center", width = 600),
                           br(), br(),
                           h5("Boise foothills, Summer 2020"),
                           img(src='drawing2.png', align = "center", width = 600)),
                  tabPanel(paste("Sagebrush and wildfire", emo::ji("flame")), value = 2,
                           h5("Because of the mudslide threat, the city of Boise planned an immediate response to stabilize the soils and restore the vegetation in the foothills. In this lab, we will explore the recovery of big sagebrush, a native shrub in the foothills and the Great Basin, that stabilizes soils and provides essential habitat and forage for wildlife."), 
                           h5("Explore how fast big sagebrush can recover using an equation for logistic population growth, and interactive sliders on the left. For example, using the plot try to see what sagebrush abundance may be like around 2050! Feel free to also change «r» and «K» parameters (we will explore the rest of sliders in a minute). How do r and K change the curve of recovery?"),

                           # withMathJax("$$ \\text{Logistic Growth Equation:} \\quad \\frac{dN}{dt} = rN(1 - \\frac{N}{K})$$"),
                           plotOutput("growthPlot", width = "100%", height = 300),
                           plotOutput("phylopicPlot", width = "100%", height = 150),
                           h5("Let’s see how the city of Boise can plan rehabilitation measures to speed up the recovery of big sagebrush. There are several things to consider. First, invasive species, Cheatgrass, has spread widely throughout the Great Basin and the Boise foothills that can drastically change how big sagebrush recovers through the change of fire behavior. Cheatgrass can increase the chance of wildfires because it can form continuous fuels that burn easily and carry fire longer distances.  Explore the effect of  «Cheatgrass»  slider."), 
                           h5("On the other hand, management intervention and ecological restoration can greatly facilitate the recovery. Compare the predicted abundance of big sagebrush abundance for 2036 under two scenarios: (i) without Cheatgrass (slider set to 0), and (ii) with moderate Cheatgrass invasion (slider set to 0.5). Keep the sliders for growth rate and carrying capacity parameters set to 0.1 and 0.5, respectively. Likely, sagebrush abundance will be different every time you reset the slider to the same value, which can be due to the fact that wildfires are unpredictable."),
                           h5("You can learn more about Ridge to Rivers initiative and  restoration programs in Boise foothills",
                              a("here.", href="https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/")),
                           img(src='ridgetorivers.png', align = "center", width = 100),
                           h5("Write a letter to the **city with a recommendation for how they can respond to cheatgrass invasion. In your proposed restoration project provide options restoration crews can focus on to compensate for Cheatgrass invasion. You will need to explain and defend your findings for future sagebrush recovery.")
                           ), 
                  tabPanel(paste("Snowfall and topography", emo::ji("snowflake")), value = 3, h4("Boise foothills in early Spring"),
                           img(src='drawing3.png', width = 600),
                           br(), h5("Consider the picture above and the two maps. On the left is the view of 
                                    Boise foothills from a satellite. On the right, same area only now
                                    showing the abundance of big sagebrush. Experiment with the Snow slider 
                                    and see how snow accumulation affects sagebrush growth. What 
                                    would happen if the snow was envenly distributed on the ground and why 
                                    this is not the case?"),
                           plotOutput("landscapePlot", width = 600)
                           ),
                  id = "tabselected"
                  )
      
                  )
                  )
))
