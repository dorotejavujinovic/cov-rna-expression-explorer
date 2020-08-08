library(vroom)
library(shiny)
library(tidyverse)
library(ggplot2)
load("data/appdata.RData")
genes <- unique(final$GENE_SYMBOL)


ui <- fluidPage(
  titlePanel("Gene expression over time"),
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", label = "Select a gene:",
                  choices = NULL, multiple = FALSE)
    ),
    mainPanel(
      plotOutput("violin")
    )
  )
)
server <- function(input, output, session) {
  updateSelectizeInput(session, inputId = "gene", choices = genes, server = TRUE)
  dfg <- reactive({ subset(final, GENE_SYMBOL %in% input$gene)
    
  })
  output$violin <- renderPlot({ p + layer(geom = "point", stat = "identity",
                                          position = "identity",
                                          data = dfg())  +
    stat_summary(data = dfg(), fun = mean, geom = "point", size = 2, color = "red") +
      stat_summary(data = dfg() , fun = mean, geom = "line", aes(group = 1))
    
  })
}
shinyApp(ui,server)