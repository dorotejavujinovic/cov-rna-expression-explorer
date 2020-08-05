library(vroom)
library(shiny)
library(tidyverse)
library(ggplot2)
inputdata <- load("data/appdata.RData")
genes <- unique(final$GENE_SYMBOL)

ui <- fluidPage(
  titlePanel("Gene expression over time"),
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", label = "Select a gene:",
                  choices = NULL, multiple = FALSE)
    ),
    mainPanel(
      tableOutput("idk")
    )
  )
)
server <- function(input, output, session) {
  updateSelectizeInput(session, inputId = "gene", choices = genes, server = TRUE)
  
  output$idk <- renderTable(final%>%filter(GENE_SYMBOL == input$gene))
  
}
shinyApp(ui,server)