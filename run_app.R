library(shiny)

# Get the current script's directory
current_dir <- getwd()

# Run the application
shinyApp(
  ui = source(file.path(current_dir, "app/ui.R"))$value,
  server = source(file.path(current_dir, "app/server.R"))$value,
  options = list(launch.browser = TRUE)
)