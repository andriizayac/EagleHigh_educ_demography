# This is an application to demonstrate demographic growth of big sagebrush in Boise foothills

ui <- fluidPage(
  theme = shinythemes::shinytheme("yeti"),
  # theme = bs_theme(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "theme_edit.css"),
    tags$link(rel = "icon", type = "image/png", sizes = "32x32", href = "sage_icon.png")
  ),
  # tags$script(src = "myscript.js"), # engage for image rotation
  # 
  navbarPage("Sagebrush and Wildfires", collapsible = TRUE,
             # Introduction page
             tabPanel("Welcome",
                HTML('<div class="bg"> <!-- setting for the iterative images class="welcomebg" id="welcomebg"> -->
                      </div>   
                      <div class="hole">
                        <div class="factText" style="padding-top:155px; padding-left:55px;">
                          <h3 style="margin-bottom:0px;">What do we think of when we see sagebrush landscapes?<h3> 
                          <h4 style="color:rgba(0,0,0,.75);">In this app we will explore wildfires, sagebrush ecology, and the environments sagebrush creates for people, animals, and other plants of the West.</h4>
                        </div>
                      </div>
                      ')
             ), # close panel
             
             # === Local history === 
             tabPanel("Local History",
              HTML('
                    <div class="container">
                              <h3 style="align-text:center; padding=0px;">Wildfires in Boise, Idaho</h3>
                              <p style="align:center;"><iframe src="https://www.youtube.com/embed/1UxSjP-Dn2o" style="width:50vw; height:50vh;" 
                                      frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></p>
                              <p style="align-text:center; padding=0px;">In late August of 1996, a wildfire raged through the Boise foothills. The fire was started by someone practicing target shooting around the Military Reserve Park. Eventually, the fire burned over 15,000 acres. After the fire had scorched the vegetation on the slopes, the city residents feared severe mudslides. Just a few decades prior, a devastating fire had swept through the foothills in 1959. The loss of vegetation mixed with a heavy rainstorm caused horrific mudslides that damaged and destroyed many people’s homes</p>
                       </div>
                    
                    ')     
                      ),
             tabPanel("Wildfires in Idaho",
                      tags$div(class = "container",
                               tags$h3("What is the Wildfire History in the Great Basin?"),
                               tags$p("click on a fire to learn more about it", style="color:rgba(0,0,0,.7);"),
                               leafletOutput("mymap", height = 500),
                               sliderInput("range", "Year of Fire", min = 1870, max = 2015, value = c(2000, 2010), sep = "")
                               )
             ), # close panel
             
             # === Explore sagebrush recovery === 
             tabPanel("Explore Recovery",
                      tags$div(class = "container", 
                               tags$h3("How Does Cheatgrass Affect Wildfire Cycles and Sagebrush Recovery?", style="padding-left:50px;"),
                               tags$p('Because of the mudslide threat, the city of Boise planned an immediate response to stabilize the soils and restore the vegetation in the foothills. In this lab, we will explore the recovery of big sagebrush, a native shrub in the foothills and the Great Basin. Sagebrush allows for more stable soil and provides essential habitats and food for wildlife.'), #close paragraph
                               tags$p('Explore how fast big sagebrush can recover (or not) by adjusting the interactive sliders below. In trying different settings for the sliders try to get a sense of what aspects of recovery they influence.'),
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
                               tags$div(checkboxInput("firestoch", "Add Chance Events", FALSE)),
                               tags$div(tags$p("Wildfires are difficult to predict, there is always an element of chance associated with its occurrence. Negligence during target shooting, a lightning strike, campfires, and more can all be the starting spark. Nevertheless, if we observe heat waves, high recreational use, and summer thunderstorms, we are better able to tell if a wildfire will happen. Check the ‘Add Chance Events’ box above to see how chance events can affect sagebrush populations (Tip: Play around with the Cheatgrass slider a bit to see how its presence leads to the most unpredictable outcomes)."))
                               )
             ), # close panel
             
             # === Scenarios and assignments 
             tabPanel("Respond", 
                      HTML('<div class="container">
                              <h3 style="align-text:center;">What Would Be Your Response as a City Manager?</h3>
                              <p style="align:center;">Let’s think about how land managers can plan to rehabilitate an area in order to speed up the recovery of big sagebrush. There are several things to consider. Cheatgrass, an invasive species, has spread widely throughout the Great Basin and the Boise foothills. Cheatgrass can increase the chance of wildfires since it burns easily and spreads fire for longer distances. Because cheatgrass fuels intense fires, this can drastically change how big sagebrush recovers. You can see this effect by moving the Cheatgrass Slider in the Explore Recovery section.</p>
                              <p style="align:center;">Thankfully, management intervention and ecological restoration can greatly facilitate the recovery. Compare the predicted abundance of big sagebrush for 2036 under two scenarios:</p>
                                <div >
                                  <p >(i) Without Cheatgrass (slider set to 0)<p>
                                  <p >(ii) With moderate Cheatgrass invasion (slider set to 0.5)</p>
                                </div>
                              <p style="align:center;">Keep the sliders for growth rate and carrying capacity parameters set to 0.1 and 20, respectively (make sure the ‘Add Chance Events’ box is blank).</p>
                              <p style="align:center;"> Write a letter to various land managers with a recommendation for how to respond to cheatgrass invasion. In your proposed restoration project, provide options restoration crews can focus on to compensate for cheatgrass invasion. You will need to explain and defend your findings for future sagebrush recovery.</p>
                              <p style="align:center;">You can learn more about Ridge to Rivers initiative, recreation, and restoration programs in Boise foothills
                                                       <a href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/"> here.</a>
                              </p>
                              <a href = "https://www.ridgetorivers.org/about/trail-news/2018/march/foothills-restoration-work-set-to-begin/">
                                                          <img src="ridgetorivers.png" style="align:center; width:200px">
                              </a>
                           </div>')
                      ), # close panel
             
             # === Extra Information ===
             navbarMenu("Learn More",
                  tabPanel("Interesting facts",
                      HTML('<div style="padding-top:20px; background-color: white;">

                             <div class="factContainer" style="background-color:lightblue;">
                              <div class="factText">
                                <h4>What is a Wildfire?</h4>
                                <p>Wildfires are unplanned and uncontrolled fires
                                               that burn in natural areas. In contrast to wildfires,
                                               <a href="https://www.frames.gov/idahoprescribedfirecouncil/resources">prescribed fires</a>
                                               is a management tool that can help people keep
                                               fire-dependent ecosystems healthy.</p>
                              </div>
                              <img style="width:50%; height:50%" src="wildfire.jpg">
                             </div>

                             <div class="factContainer" style="background-color:lightgreen;">
                              <img style="width:45%; height:45%" src="campfire.jpg">
                              <div class="factText">
                                <h4>How Do Wildfires Start?</h4>
                                <p>There is a wide range of natural and human activities and events that can cause a wildfire. Among the natural wildfires, lightning strikes are one of the most common sources. Human-caused wildfires often start from negligence of campfires, smoking, vehicle sparks, and other activities. Learn more about wildfires in Idaho
                                    <a href="https://idahofirewise.org/fire-prevention/common-causes-of-wildfires/">here.</a>
                                </p>
                              </div>
                             </div>

                             <div class="factContainer" style="background-color:lightmagenta;">
                              <div class="factText">
                                <h4>What Do We Mean by Sagebrush?</h4>
                                <p>There are more than ten species in the sagebrush steppe that we call sagebrush. The most common one, big sagebrush, spreads throughout the Intermountain West - from the Rockies in the East and Cascades and Sierra Mountains in the West. Big sagebrush is most likely seen from outside our windows or on hikes in Idaho landscapes. Despite being less common, species like black sagebrush and(or low sagebrush) are ecologically important plants too. For example, in winter times leaves of low sagebrush are an important source of food for sage grouse.</p>
                              </div>
                              <img style="width:40%; height:40%" src="sagebrush.jpg">
                             </div>

                             <div class="factContainer" style="background-color:rgba(246, 170, 154,0.75);">
                              <img style="width:40%; height:40%" src="genetics.png">
                              <div class="factText">
                                <h4>An Interesting Fact About Sagebrush</h4>
                                <p>Sagebrush is an interesting species from the standpoint of its genes. Many big sagebrush plants have multiple copies of chromosomes in their cells. We call these kinds of plants 
                                               <a href="https://en.wikipedia.org/wiki/Polyploidy">polyploids.</a>
                                               Polyploidy is common in other plants too, particularly in those that are in agricultural use, but generally is not typical among animals. For example, wheat and strawberries from grocery stores are polyploids too!
                                </p>
                              </div>
                             </div>

                             <div class="factContainer" style="background-color:lightyellow;">
                              <div class="factText">
                                <h4>Which Animals Live in the Sagebrush Steppe?</h4>
                                <p>Golden eagles, sage sparrows, and badgers are just a few examples of animals that we find in the sagebrush steppe. Sage grouse is found exclusively in the Great Basin and nowhere else in the world, and it depends deeply on healthy sagebrush ecosystems. At different times of the year, we can also see the largest hawk in the United States, the ferruginous hawk, soaring above Idaho landscapes.
                                </p>
                              </div>
                              <img style="width:45%; height:45%" src="quail.jpg">
                             </div>

                            </div> <!-- parent -->
                           ')
              ), # close panel
              tabPanel("Sagebrush Stories",
                          HTML('
                          <div class="container">
                                <div class = "body">
                                        <h4 style="text-align:center;">Sagebrush, Sage Grouse, and Human Livelihoods</h4>
                                </div>
                                <iframe class="vid" src="https://www.youtube.com/embed/cld6znzFUBg" style="width:50vw; height:50vh;" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                <div class = "body">
                                         <h4 style="text-align:center;">Cheatgrass and Wildfires</h4>
                                </div>
                                <iframe src="https://www.youtube.com/embed/wAhvGiML1F8" style="width:50vw; height:50vh;" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", allowfullscreen></iframe>

                                <div class = "body">
                                         <h4 style="text-align:center;">Which animals did you spot in the two videos about sagebrush and wildfires?</h4>
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
                                  <img src="animals/GRSG_Male2.jpeg" alt="Greater sage grouse" width="300">
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
                                  <img src="animals/BrewersSparrow_Boise2.jpeg" alt="Brewers sparrow" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="BS" name="brewsperrow" value="1"> Brewer&#39s sparrow
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/AmericanBadger.jpeg" alt="American badger" width="300">
                                  <div class="desc">
                                    <input type="checkbox" id="AB" name="badger" value="1"> American badger
                                  </div>
                                </div>
                                <div class="gallery">
                                  <img src="animals/hummingbird.jpg" alt="Costas hummingbird" width="300">
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
             ),
             tabPanel("About",
               HTML('<div style="padding-top:20px; padding-bottom:20px; background-color: white; border:10px; border-color:black;">
                      <h3>About this App</h3>
                      <p>This app was developed in a collaboration between Jennifer Foster (Eagle High School) and Andrii Zaiats, Amethyst Tagney, and Trevor Caughlin (Boise State Univeristy). 
                         If you have any thoughts or ideas about sagebrush and wildfires, we are 
                         always happy to chat about science, ecology, and local ecosystems. 
                         Any comments or questions about the app? Send us an  
                         <a href="mailto: andriizaiats@u.boisestate.edu">email</a>! 
                      </p>
                      <p>We thank Boise State University, Murdock Trust Program, and Idaho EPSCoR GEM3 programs for their support.</p>
                      
                        <img src="logos/bsu_logo.png" alt="BSU" style="width:12%; height:12%; padding-left:25px; padding-rigth:25px;">
                        <img src="logos/murdock_logo.png" alt="Murdock Trust" style="width:25%; height:15%; padding-left:25px; padding-rigth:25px;">
                        <img src="logos/gem3_logo.png" alt="EPSCoR GEM3" style="width:20%; height:15%; padding-left:25px; padding-rigth:25px;">
                      
                     </div>
                     ')
             )
             
             
  ) # close navbar layout
)
