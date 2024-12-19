library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("Bioinformatics Data Visualization Tool"),
  
  sidebarLayout(
    sidebarPanel(
      # File upload
      fileInput("file", "Upload Expression Data (CSV)",
                accept = c("text/csv", ".csv")),
      
      # Plot type selection
      selectInput("plot_type", "Select Visualization",
                  choices = c("Heatmap" = "heatmap",
                              "Violin Plot" = "violin",
                              "Raw Data Table" = "table")),
      
      # Conditional parameters based on plot type
      conditionalPanel(
        condition = "input.plot_type == 'heatmap'",
        selectInput("color_scheme", "Color Scheme",
                    choices = c("Red-White-Blue" = "RdBu",
                                "Yellow-Red" = "YlOrRd",
                                "Blue-Yellow" = "BlYel"))
      ),
      
      # Download button
      downloadButton("download_plot", "Download Plot")
    ),
    
    mainPanel(
      # Plot output
      plotlyOutput("plot_output", height = "600px"),
      # Data table output
      DTOutput("table_output")
    )
  )
)