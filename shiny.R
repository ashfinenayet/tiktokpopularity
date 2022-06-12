library(shiny)
modifiedtiktok <- read_excel("code/python/pythonpractice/tiktok/modifiedtiktok.xlsx")
ui <- fluidPage()

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)