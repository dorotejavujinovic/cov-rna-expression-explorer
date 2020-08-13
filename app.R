library(shiny)
library(tidyr)
library(ggplot2)
if (!(exists("p") && exists("final") && exists("annotations") ))
  load("data/appdata.RData")
genes <- unique(final$gene_symbol)


ui <- fluidPage(
  titlePanel("Gene expression over time"),
  sidebarLayout(
    sidebarPanel(
      selectInput("gene", label = "Select a gene:",
                  choices = NULL, multiple = TRUE)
    ),
    mainPanel(
      plotOutput("violin")
    )
  )
)

server <- function(input, output, session) {
  updateSelectizeInput(session, inputId = "gene", choices = genes, server = TRUE)
  output$violin <- renderPlot({ 
    req(input$gene)
    dfg <- final[final$gene_symbol %in% input$gene, ]
    dfgh <-  group_by(dfg, gene_symbol, time_point) %>%
      summarise(value = mean(value))
    p + 
      geom_point(data = dfg, aes(color = factor(gene_symbol)), show.legend = TRUE)  +
      geom_point(data = dfgh, size = 2, color = "red") +
      stat_summary(data = dfg, fun = mean, geom = "line", aes(group = gene_symbol, color = factor(gene_symbol)))
     
  })
}

shinyApp(ui,server)