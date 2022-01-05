# This is an application to demonstrate demographic growth of big sagebrush in Boise foothills

ui <- fluidPage(
  theme = shinythemes::shinytheme("yeti"),
  # theme = bs_theme(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "theme_edit.css")
  ),
  tags$script(src = "myscript.js"),
  # 
  navbarPage("Sagebrush and wildfires", collapsible = TRUE,
             # Introduction page
             tabPanel("Welcome",
                HTML('<div class="welcomebg" id="welcomebg"> 
                      </div>   
                      <div class="hole">
                        <div class="factText" style="padding-top:155px; padding-left:55px;">
                        <h3>What do we think of when we see sagebrush landscapes?<h3> 
                        <h4 style="color:rgba(0,0,0,.75);">In this app we will explore sagebrush ecology and
                                                 the environments it creates for people, animals, and other plants of the West.</h4>
                        </div>
                      </div>
                      ')
             ), # close panel
             
             # === Local history === 
             tabPanel("Local history",
              HTML('
                    <div class="container">
                              <h3 style="align-text:center; padding=0px;">A wildfire in Boise, Idaho</h3>
                              <p style="align:center;"><iframe src="https://www.youtube.com/embed/1UxSjP-Dn2o" style="width:50vw; height:50vh;" 
                                      frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></p>
                              <p style="align-text:center; padding=0px;">In late August of 1996, a wildfire rage through the 
                                        Boise foothills.  The fire was started by someone practicing 
                                        target shooting around the Military Reserve Park.  Eventually, 
                                        the fire burned over 15,000 acres.  After the fire had scorched 
                                        the vegetation on the slopes, the city residents feared severe 
                                        mudslides.  Just a few decades prior, the same scenario played 
                                        out in the foothills.  After a devastating fire (1959), landslides that 
                                        saturated the residential area below 
                                        occurred because of flooding.
                                        </p>
                       </div>
                    
                    ')     
                      ),
             tabPanel("Wildfires in Idaho",
                      tags$div(class = "container",
                               tags$h3("What is the wildfire history in the Great Basin?"),
                               leafletOutput("mymap", height = 500),
                               sliderInput("range", "Year of Fire", min = 1870, max = 2015, value = c(2000, 2010), sep = "")
                               )
             ), # close panel
             
             # === Explore sagebrush recovery === 
             tabPanel("Explore recovery",
                      tags$div(class = "container", 
                               tags$h3("How does cheatgrass affect wildfire cycle and sagebrush recovery?"),
                               tags$p('Because of the mudslide threat, the city of Boise planned an 
                               immediate response to stabilize the soils and restore the 
                               vegetation in the foothills. In this lab, we will explore 
                               the recovery of big sagebrush, a native shrub in the foothills 
                               and the Great Basin. Sagebrush allows for the stabilization of 
                               soils and provides essential habitat 
                               and forage for wildlife.'), #close paragraph
                               tags$p('Explore how fast big sagebrush can recover using an equation 
                               for logistic population growth, and interactive sliders on the 
                               left. Feel free to also change «r» and «K» parameters (we will 
                               explore the rest of sliders in a minute).'),
                               tags$div(
                                 column(4, 
                                        sliderInput("r", "Growth rate (r):", min = 0.01, max = 1,value = .1)),
                                 column(4, 
                                        sliderInput("k", "Carrying capacity (K):", min = 3, max = 50, value = 20)),
                                 column(4, 
                                        sliderInput("cheat", "Cheatgrass:", min = 0, max = 1, value = 0))
                               ),
                               htmltools::div(style = "display:inline-block; width=100%; object-fit:contain; border: 3px solid black;",
                                              plotOutput("growthPlot", width = "100%", height = 300),
                                              plotOutput("phylopicPlot", width = "100%", height = 100)),
                               tags$div(checkboxInput("firestoch", "Add chance events", FALSE)),
                               tags$div(tags$p("Wildfires are difficult to predict, there is always an element of chance 
                                               associated with its occurance. Negligence during target shooting, a lightning strike, 
                                               or a campfire, these events are difficult to predict. Nevertheless, 
                                               if we observe heat waves, high recreational use, summer thunderstorms, 
                                               we can tell that the chance of wildfires increases. Check the foollowing box 
                                               to see how chance events can affect sagebrush populations by changing 
                                               wildfire regimes (tip: play around with the Cheatgrass slider a bit to see 
                                               what levels of it lead to most unpredictable outcomes)."))
                               )
             ), # close panel
             
             # === Scenarios and assignments 
             tabPanel("Respond", 
                      HTML('<div class="container">
                           <h3 style="align-text:center;">What would be your response as a city manager?</h3>
                           <p style="align:center;">Let’s think how land managers can plan to rehabilitate the 
                              area in order to speed up the recovery of big sagebrush. 
                              There are several things to consider. Cheatgrass, an invasive 
                              species, has spread widely throughout the Great Basin and 
                              the Boise foothills. Cheatgrass can increase the chance of 
                              wildfires because it can form continuous fuels that burn 
                              easily and carry fire longer distances. Because Cheatgrass 
                              fuels intense fires, this can drastically change how big 
                              sagebrush recovers. Explore the effects 
                              of  «Cheatgrass»  slider.
                           </p>
                           <p style="align:center;"> On the other hand, management intervention and ecological 
                              restoration can greatly facilitate the recovery. Compare the 
                              predicted abundance of big sagebrush abundance for 2036 under 
                              two scenarios: (i) without Cheatgrass (slider set to 0), and 
                              (ii) with moderate Cheatgrass invasion (slider set to 0.5). 
                              Keep the sliders for growth rate and carrying capacity parameters 
                              set to 0.1 and 0.5, respectively. Likely, sagebrush abundance will 
                              be different every time you reset the slider to the same value, 
                              which can be due to the fact that wildfires 
                              are unpredictable.
                           </p>
                           <p style="align:center;">You can learn more about Ridge to Rivers initiative and 
                              restoration programs in Boise foothills
                              <a href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/"> here.</a>
                              <a href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/">
                                <img src="ridgetorivers.png" style="align:center; width:100px">
                              </a>
                           </p>
                           <p style="align:center;"> Write a letter to various land managers with a recommendation 
                              for how to respond to cheatgrass invasion. In your proposed 
                              restoration project provide options restoration crews can 
                              focus on to compensate for Cheatgrass invasion. You will need 
                              to explain and defend your findings for 
                              future sagebrush recovery.
                           </p>
                           </div>')
                      ), # close panel
             
             # === Extra Information ===
             navbarMenu("Learn More",
                  tabPanel("Interesting facts",
                      HTML('<div style="padding-top:20px; background-color: white;">

                             <div class="factContainer" style="background-color:lightblue;">
                              <div class="factText">
                                <h4>What is a wildfire?</h4>
                                <p>Wildfires are unplanned and uncontrolled fires
                                               that burn in natural areas. In contrast to wildfires,
                                               prescribed fires is a management tool that can help people keep
                                               fire-dependent ecosystems healthy.
                                 </p>
                              </div>
                              <img style="width:50%; height:50%" src="wildfire.jpg">
                             </div>

                             <div class="factContainer" style="background-color:lightgreen;">
                              <img style="width:45%; height:45%" src="campfire.jpg">
                              <div class="factText">
                                <h4>How do wildfires start?</h4>
                                <p>There is a wide range of activities and events that can
                                               cause a wildfire, which broadly can be grouped into natural
                                               and human-caused (or anthropogenic). Among the natural wildfires,
                                               lightning strikes are one of the most common sources of ignition.
                                               Human-caused wildfires often start from negligence, that can include
                                               campfires, smoking, vehicle sparks. Learn more about
                                               wildfires in Idaho
                                               <a href="https://idahofirewise.org/fire-prevention/common-causes-of-wildfires/">here.</a>
                                               </p>
                              </div>
                             </div>

                             <div class="factContainer" style="background-color:lightmagenta;">
                              <div class="factText">
                                <h4>What do we mean by sagebrush?</h4>
                                <p>There are more than ten species in the sagebrush steppe
                                               that we call sagebrush. The most common one, big sagebrush,
                                               spreads throughout the Intermountain West - from the Rockies
                                               in the East and Cascades and Sierra Mountains in the West.
                                               Big sagebrush is
                                               most likely seen from outside our windows or on hikes
                                               in Idaho landscapes.
                                               Despite being less common, species like black sagebrush, or low sagebrush,
                                               are ecologically important plants too. For example, in winter
                                               times leaves of low sagebrush are an important source of food
                                               for sage grouse.</p>
                              </div>
                              <img style="width:40%; height:40%" src="sagebrush.jpg">
                             </div>

                             <div class="factContainer" style="background-color:rgba(246, 170, 154,0.75);">
                              <img style="width:40%; height:40%" src="genetics.png">
                              <div class="factText">
                                <h4>An interesting fact about sagebrush</h4>
                                <p>Sagebrush is an interesting species from the
                                               standpoint of its genes. Many big sagebrush plants have multiple
                                               copies of chromosomes in their cells and we call them
                                               <a href="https://en.wikipedia.org/wiki/Polyploidy">polyploid plants.</a>
                                               Polyploidy is common in other plants too, particularly in those
                                               that are in agricultural use, but generally is not typical among animals.
                                               For example, wheat and strawberries from grocery stores are polyploids too!
                                               </p>
                              </div>
                             </div>

                             <div class="factContainer" style="background-color:lightyellow;">
                              <div class="factText">
                                <h4>What animals live in the sagebrush steppe?</h4>
                                <p>Golden eagles, sage sparrows, badgers are just a few examples of animals that we
                                               find in the sagebrush steppe.
                                               Sage grouse is found exclusively in the Great Basin and nowhere else in the world, and
                                               it depends deeply on healthy sagebrush ecosystems.
                                               In different times of the year, we can also see the largest hawk in the United States, the
                                               ferruginous hawk, soaring above Idaho landscapes.</p>
                              </div>
                              <img style="width:45%; height:45%" src="quail.jpg">
                             </div>

                            </div> <!-- parent -->
                           ')
              ), # close panel
              tabPanel("Sagebrush stories",
                          HTML('
                          <div class="container">
                                <div class = "body">
                                        <h4 style="text-align:center;">Sagebrush, sage grouse, and human livelihoods</h4>
                                </div>
                                <iframe class="vid" src="https://www.youtube.com/embed/cld6znzFUBg" style="width:50vw; height:50vh;" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                <div class = "body">
                                         <h4 style="text-align:center;">Cheatgrass and wildfires</h4>
                                </div>
                                <iframe src="https://www.youtube.com/embed/wAhvGiML1F8" style="width:50vw; height:50vh;" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", allowfullscreen></iframe>

                                <div class = "body">
                                         <h4 style="text-align:center;">What animals did you spot in the two videos about sagebrush and wildfires?</h4>
                              </div>
                                <div class="contGallery">
                                <div class="gallery">
                                  <img src="animals/golden-eagle.jpg" alt="Golden eagle" width="300">
                                  <div class="desc">
                                  <input type="checkbox" id="GE" name="goldeneagle" value="1"> Golden eagle </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/pronghorn.jpg" alt="Pronghorn" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="PR" name="pronghorn" value="1"> Pronghorn antelope
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/mule-deer.jpg" alt="Mule deer" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="MD" name="muledeer" value="1"> Mule deer
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/greater-sage-grouse.jpg" alt="Greater sage grouse" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="SG" name="sagegrouse" value="1"> Greater sage grouse
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/rabbit.jpg" alt="Cottontail" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="CO" name="cottontail" value="1"> Cottontail rabbit
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/ferruginous-hawk.jpg" alt="Ferruginous hawk" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="FH" name="ferruge" value="1"> Ferruginous hawk
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/burrowing-owl.jpg" alt="Burrowing owl" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="BO" name="burrowl" value="1"> Burrowing owl
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="img_5terre.jpg" alt="Brewers sparrow" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="BS" name="brewsperrow" value="1"> Brewer&#39s sparrow
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="img_5terre.jpg" alt="American badger" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="AB" name="badger" value="1"> American badger
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="img_5terre.jpg" alt="Costas hummingbird" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="CH" name="humm" value="1"> Costa&#39s hummingbird
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/great-horned-owl.jpg" alt="GH owl" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="GHO" name="greathorned" value="1"> Great horned owl
                                  </div>
                                </div>
                                                                <div class="gallery">
                                  <img src="animals/swallow.jpg" alt="Cliff swallow" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="CS" name="cliffswallow" value="1"> Cliff swallow
                                  </div>
                                </div>
                              </div>
                              </div>')
              ) # close panel
             )
             
  ) # close navbar layout
)
