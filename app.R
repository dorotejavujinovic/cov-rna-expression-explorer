library(vroom)
library(shiny)
library(tidyverse)
library(ggplot2)
inputdata <- load("data/appdata.RData")
genes <- unique(final$GENE_SYMBOL)
p <- ggplot(final, aes(x = time_point, y = value)) + geom_violin()

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
  output$violin <- renderPlot({ p +
      stat_summary(data = final%>%filter(GENE_SYMBOL == input$gene),
                   fun = mean, geom = "point", size = 2, color = "red") +
      stat_summary(data = final%>%filter(GENE_SYMBOL == input$gene),
                   fun = mean, geom = "line", aes(group = 1))
    
    })
}
shinyApp(ui,server)