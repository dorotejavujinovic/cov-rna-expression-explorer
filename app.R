library(vroom)
library(shiny)
library(tidyverse)
library(ggplot2)
inputdata <- load("data/appdata.RData")
genes <- unique(final$GENE_SYMBOL)
p <- load("plots/violinplot.RData")
ui <- fluidPage(
  titlePanel("Gene expression over time"),
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", label = "Select a gene:", choices = NULL, multiple = TRUE)
    ),
    mainPanel(
      plotOutput("violin")
    )
  )
)
server <- function(input, output, session) {
  updateSelectizeInput(session, inputId = "gene", choices = genes, server = TRUE)
  dfg <- reactive({
    a <- final%>%filter(GENE_SYMBOL == input$gene)
    a <- droplevels(a)
    return(a)
  })
  output$violin <- renderPlot({p + layer(geom = "point", stat = "identity", 
                                         position = "identity", data = dfg(),
                                         params = list(na.rm = FALSE)) + 
      stat_summary(data = dfg(),fun = mean, geom = "point", size = 2, color = "red")+
      stat_summary(data = dfg(),fun = mean, geom = "line", aes(group = 1))
  })
  
}
shinyApp(ui,server)