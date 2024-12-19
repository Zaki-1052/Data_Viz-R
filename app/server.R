library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# Source our helper functions with correct relative paths from app directory
source("preprocessing.R")
source("plotting.R")

server <- function(input, output, session) {
  # Data reactive remains the same
  data <- reactive({
    req(input$file)
    expression_data <- load_expression_data(input$file$datapath)
    normalize_expression(expression_data)
  })
  
  # Plot output remains the same
  output$plot_output <- renderPlotly({
    req(data())
    switch(input$plot_type,
           "heatmap" = create_expression_heatmap(data()),
           "violin" = ggplotly(create_expression_violin(data())),
           NULL)
  })
  
  # Table output remains the same
  output$table_output <- renderDT({
    req(data())
    if(input$plot_type == "table") {
      datatable(data(),
                options = list(pageLength = 15,
                               scrollX = TRUE,
                               scrollY = "400px"))
    }
  })
  
  # Fixed download handler
  output$download_plot <- downloadHandler(
    filename = function() {
      paste0("plot-", input$plot_type, "-", Sys.Date(), ".png")
    },
    content = function(file) {
      # Create the appropriate static plot
      if(input$plot_type == "heatmap") {
        # Create static heatmap using ggplot2
        p <- ggplot(data(), aes(x = sample, y = gene_id, fill = expression)) +
          geom_tile() +
          scale_fill_gradient2(low = "navy", mid = "white", high = "red", 
                               midpoint = median(data()$expression)) +
          theme_minimal() +
          labs(title = "Gene Expression Heatmap",
               x = "Samples", 
               y = "Genes",
               fill = "Expression") +
          theme(axis.text.x = element_text(angle = 45, hjust = 1))
      } else if(input$plot_type == "violin") {
        p <- create_expression_violin(data())
      }
      
      # Save the plot
      ggsave(file, p, width = 10, height = 8, dpi = 300)
    }
  )
}