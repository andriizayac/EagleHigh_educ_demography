# This is an application to demonstrate demographic growth of big sagebrush in Boise foothills

ui <- fluidPage(
  theme = shinythemes::shinytheme("yeti"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "theme_edit.css")
  ),
  # 
  navbarPage("Sagebrush and wildfires",
             # Introduction page
             tabPanel("Welcome",
                      fluidRow(
                        column(12,
                               # Why is sagebrush important
                               tags$div(class = "body", checked = NA, 
                                        tags$h3("What do we think of when we see sagebrush landscapes?", style="text-align: center;"),
                                        tags$h4("In this app we will explore sagebrush ecology and
                                                 the environments it creates for people, animals, and other plants of the West.", 
                                                style="text-align: center; text-indent: 0px; color: rgb(0,0,0,0.7);")))),
                      fluidRow(
                        column(6,
                               tags$div(class = "gallery1", checked = NA,
                                        HTML('<img src="sage_steppe.png" alt="landscape" style="width:100%; object-fit:contain;">')
                                        ),
                               ),
                        column(6,
                               tags$div(class = "gallery1", checked = NA,
                                        HTML('<img src="tablerock_fire__darin_oswald.png" alt="fire" style="width:100%; object-fit:contain;">')
                                        )
                               )
                      ),
                      fluidRow(
                        column(12, 
                               br(), br(),
                               tags$div(class = "gallery1", checked = NA,
                                        HTML('<img src="drawing2.png" alt="landscape"
                                             style="width:100%; object-fit:contain;">'),
                                        )
                        ), # close column
                        br(), br()
                      ) # close fluid row
             ), # close panel
             
             tabPanel("Local history",
                      tags$div(class = "header", checked = NA,
                               tags$h3("A wildfire in Boise, Idaho", )),
                      fluidRow(
                        column(12,
                               tags$p('In late August of 1996, a wildfire rage through the 
                                        Boise foothills.  The fire was started by someone practicing 
                                        target shooting around the Military Reserve Park.  Eventually, 
                                        the fire burned over 15,000 acres.  After the fire had scorched 
                                        the vegetation on the slopes, the city residents feared severe 
                                        mudslides.  Just a few decades prior, the same scenario played 
                                        out in the foothills.  After a devastating fire (1959), landslides that 
                                        saturated the residential area below 
                                        occurred because of flooding.'), # close paragraph
                               HTML('<iframe src="https://www.youtube.com/embed/1UxSjP-Dn2o" style="width:100%; height:500px;" 
                                      frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                               ))      
                      ),
             tabPanel("Wildfires in Idaho",
                      tags$div(class = "header", checked = NA, 
                               tags$h3("What is the wildfire history in the Great Basin?")),
                      fluidRow(
                        column(12, 
                               leafletOutput("mymap", height = 500),
                        )
                      ),
                      fluidRow(
                        column(12, 
                               sliderInput("range", "Year of Fire", min = 1870, max = 2015, value = c(2000, 2010), sep = ""))
                      )
             ), # close panel
             
             # === Explore sagebrush recovery === 
             tabPanel("Explore recovery",
                      fluidRow(
                        column(10, 
                               tags$div(class = "header", checked = NA, 
                                        tags$h3("How does cheatgrass affect wildfire cycle and sagebrush recovery?")),
                               
                               tags$div(tags$p('Because of the mudslide threat, the city of Boise planned an 
                               immediate response to stabilize the soils and restore the 
                               vegetation in the foothills. In this lab, we will explore 
                               the recovery of big sagebrush, a native shrub in the foothills 
                               and the Great Basin. Sagebrush allows for the stabilization of 
                               soils and provides essential habitat 
                               and forage for wildlife.'), #close paragraph
                                        tags$p('Explore how fast big sagebrush can recover using an equation 
                               for logistic population growth, and interactive sliders on the 
                               left. Feel free to also change «r» and «K» parameters (we will 
                               explore the rest of sliders in a minute).'))), # close column
                      ), # close fluid row
                      fluidRow(
                        column(3, 
                               sliderInput("r", "Growth rate (r):", min = 0.01, max = 1,value = .1)),
                        column(3, 
                               sliderInput("k", "Carrying capacity (K):", min = 3, max = 50, value = 20)),
                        column(3, 
                               sliderInput("cheat", "Cheatgrass:", min = 0, max = 1, value = 0))
                      ),
                      fluidRow(
                        column(10,
                               htmltools::div(style = "display:inline-block; width=100%; object-fit:contain; border: 3px solid black;",
                                              plotOutput("growthPlot", width = "100%", height = 300),
                                              plotOutput("phylopicPlot", width = "100%", height = 100))
                        ) # close column
                      ), #close row
                      br(),
                      fluidRow(
                        column(10, 
                               tags$div(tags$p("Wildfires are difficult to predict, there is always an element of chance 
                               associated with its occurance. Negligence during target shooting, a lightning strike, 
                                               or a campfire, these events are difficult to predict. Nevertheless, 
                                               if we observe heat waves, high recreational use, summer thunderstorms, 
                                               we can tell that the chance of wildfires increases. Check the foollowing box 
                                               to see how chance events can affect sagebrush populations by changing 
                                               wildfire regimes (tip: play around with the Cheatgrass slider a bit to see 
                                               what levels of it lead to most unpredictable outcomes).")),
                               checkboxInput("firestoch", "Add chance events", FALSE)
                               )
                      )
             ), # close panel
             
             # === Scenarios and assignments 
             tabPanel("Respond", 
                      fluidRow(
                        column(9, 
                               tags$div(class = "body", checked = NA,
                                        tags$h3("What would be your response as a city manager?"),
                                        tags$p("Let’s think how land managers can plan to rehabilitate the 
                 area in order to speed up the recovery of big sagebrush. 
                 There are several things to consider. Cheatgrass, an invasive 
                 species, has spread widely throughout the Great Basin and 
                 the Boise foothills. Cheatgrass can increase the chance of 
                 wildfires because it can form continuous fuels that burn 
                 easily and carry fire longer distances. Because Cheatgrass 
                 fuels intense fires, this can drastically change how big 
                 sagebrush recovers. Explore the effects 
                 of  «Cheatgrass»  slider."), # close paragraph
                                        tags$p('On the other hand, management intervention and ecological 
                 restoration can greatly facilitate the recovery. Compare the 
                 predicted abundance of big sagebrush abundance for 2036 under 
                 two scenarios: (i) without Cheatgrass (slider set to 0), and 
                 (ii) with moderate Cheatgrass invasion (slider set to 0.5). 
                 Keep the sliders for growth rate and carrying capacity parameters 
                 set to 0.1 and 0.5, respectively. Likely, sagebrush abundance will 
                 be different every time you reset the slider to the same value, 
                 which can be due to the fact that wildfires 
                 are unpredictable.'), # close paragraph
                                        tags$p('You can learn more about Ridge to Rivers initiative and 
                 restoration programs in Boise foothills', 
                                               tags$a(href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/", 'here')),
                                        tags$a(href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/",
                                               HTML('<img src="ridgetorivers.png" style="align:center; width:100px">')
                                               ),
                                        tags$p('Write a letter to various land managers with a recommendation 
                 for how to respond to cheatgrass invasion. In your proposed 
                 restoration project provide options restoration crews can 
                 focus on to compensate for Cheatgrass invasion. You will need 
                 to explain and defend your findings for 
                 future sagebrush recovery.')
                               ))
                      )), # close panel
             
             # === Extra Information ===
             navbarMenu("Learn More",
                  tabPanel("Interesting facts",
                      fluidRow(
                        column(8,
                               tags$div(class = "body", checked = NA,
                                        tags$h4('What is a wildfire?'),
                                        tags$p('Wildfires are unplanned and uncontrolled fires 
                                               that burn in natural areas. In contrast to wildfires, 
                                               prescribed fires is a management tool that can help people keep 
                                               fire-dependent ecosystems healthy.'),
                                        br(),
                                        tags$h4('How do wildfires start?'),
                                        tags$p('There is a wide range of activities and events that can 
                                               cause a wildfire, which broadly can be grouped into natural 
                                               and human-caused (or anthropogenic). Among the natural wildfires, 
                                               lightning strikes are one of the most common sources of ignition. 
                                               Human-caused wildfires often start from negligence, that can include 
                                               campfires, smoking, vehicle sparks. Learn more about 
                                               wildfires in Idaho ', 
                                               tags$a(href = 'https://idahofirewise.org/fire-prevention/common-causes-of-wildfires/','here'),'.'),
                                        br(),
                                        # tags$h4('Sagebrush as an indicator species'),
                                        # tags$p('...'),
                                        # br(),
                                        tags$h4('What do we mean by sagebrush?'),
                                        tags$p('There are more than ten species in the sagebrush steppe 
                                               that we call sagebrush. The most common one, big sagebrush, 
                                               spreads throughout the Intermountain West - from the Rockies 
                                               in the East and Cascades and Sierra Mountains in the West. 
                                               Big sagebrush is 
                                               most likely seen from outside our windows or on hikes 
                                               in Idaho landscapes. 
                                               Despite being less common, species like black sagebrush, or low sagebrush, 
                                               are ecologically important plants too. For example, in winter 
                                               times leaves of low sagebrush are an important source of food 
                                               for sage grouse.'),
                                        br(),
                                        tags$h4('Interesting facts about sagebrush'),
                                        tags$p('Sagebrush is an interesting species from the 
                                               standpoint of its genes. Many big sagebrush plants have multiple 
                                               copies of chromosomes in their cells and we call them',
                                               tags$a(href="https://en.wikipedia.org/wiki/Polyploidy", "polyploid plants."), 
                                               'Polyploidy is common in other plants too, particularly in those 
                                               that are in agricultural use, but generally is not typical among animals. 
                                               For example, wheat and strawberries from grocery stores are polyploids too!'),
                                        br(),
                                        tags$h4('What animals live in the sagebrush steppe?'),
                                        tags$p("Golden eagles, sage sparrows, badgers are just a few examples of animals that we 
                                               find in the sagebrush steppe. 
                                               Sage grouse is found exclusively in the Great Basin and nowhere else in the world, and 
                                               it depends deeply on healthy sagebrush ecosystems. 
                                               In different times of the year, we can also see the largest hawk in the United States, the 
                                               ferruginous hawk, soaring above Idaho landscapes."),
                                        
                               ))) # close fluid row
              ), # close panel
              tabPanel("Scavenger hunt!",
                       fluidRow(
                         column(12,
                                tags$div(class = "body", checked = NA,
                                         tags$h4('What animals did you spot in the two videos about sagebrush and wildfires?', style="text-align:center;")
                                ),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Golden eagle" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="GE" name="goldeneagle" value="1"> Golden eagle </div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Pronghorn" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="PR" name="pronghorn" value="1"> Pronghorn antelope </div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Mule deer" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="MD" name="muledeer" value="1"> Mule deer </div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Greater sage grouse" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="SG" name="sagegrouse" value="1"> Greater sage grouse</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Cliff swallow" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="CS" name="cliffswallow" value="1"> Cliff swallow</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Cottontail" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="CO" name="cottontail" value="1"> Cottontail rabbit</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Ferruginous hawk" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="FH" name="ferruge" value="1"> Ferruginous hawk</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Burrowing owl" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="BO" name="burrowl" value="1"> Burrowing owl</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Brewers sparrow" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="BS" name="brewsperrow" value="1"> Brewer&#39s sparrow</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="American badger" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="AB" name="badger" value="1"> American badger</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="Costas hummingbird" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="CH" name="humm" value="1"> Costa&#39s hummingbird</div> 
                                     </div>'),
                                HTML('<div class="gallery"> 
                                <img src="img_5terre.jpg" alt="GH owl" width="300"> 
                                <div class="desc">
                                <input type="checkbox" id="GHO" name="greathorned" value="1"> Great horned owl</div> 
                                     </div>')
                       )
              ), # close panel
              )
             ), 
             # === Extra Information ===
             tabPanel("Sagebrush stories",
                      fluidRow(
                        column(9,
                               tags$div(class = "body", checked = NA,
                                        tags$h4('Learn about the connection between sagebrush, sage grouse, and human livelihoods.')),
                               HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/cld6znzFUBg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
                               )
                        ), # close fluid row
                      fluidRow(
                        column(9, 
                               tags$div(class = "body", checked = NA, 
                                        tags$h4('Learn about the impact of cheatgrass on western landscapes.')),
                               tags$iframe(width="560", height="315", src="https://www.youtube.com/embed/wAhvGiML1F8", frameborder="0", allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", allowfullscreen=NA),
                               br(), br()
                               )
                      )
             ) # close panel
  ) # close navbar layout
)
