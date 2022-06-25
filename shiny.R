library(shiny)
library(ggplot2)
library(plotly)
library(cowplot)
library(readxl)
modifiedtiktok2 <- read_excel("~/Documents/Datasets/modifiedtiktok2.xlsx")
ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel("Tiktok Popular Songs"),
  sidebarLayout(
    
    #inputs: select variables to plot
    sidebarPanel(
      
      # select variable for y-axis
      selectInput(
        inputId = "y",
        label = "Y-axis",
        choices = c("danceability", "energy", "loudness", "speechiness", 
                    "acousticness", "liveness", "valence", "tempo"),
        selected = "danceability"
      ),
      selectInput(
        inputId = "x",
        label = "X-axis",
        choices = c("danceability", "energy", "loudness", "speechiness", 
                    "acousticness", "liveness", "valence", "tempo"),
        selected = "energy")
  ),
  
  # Select variable for color
  selectInput(inputId = "z", 
              label = "Color by:",
              choices = c("danceability", "energy", "loudness", "speechiness", 
                          "acousticness", "liveness", "valence", "tempo"),
              selected = "loudness")
  
  ),
  # Output: Show scatterplot
  mainPanel(
    plotlyOutput("scatterplot"),
    plotlyOutput("histogram")
  )
)


server <- function(input, output, session) {
  thematic::thematic_shiny()
  output$scatterplot <- renderPlotly({
    ggplot(data = modifiedtiktok2, aes_string(x = input$x, y = input$y, 
          color = input$z)) + geom_point(aes(text = 
                                               paste("Song Info:", 
                                                          track_name, 
                                                          "by", artist_name )))
  })
  output$histogram <- renderPlotly({
    ggplot(data = modifiedtiktok2, aes_string(x = input$x)) + geom_histogram()
  })

}
# create a shiny app object
shinyApp(ui, server)