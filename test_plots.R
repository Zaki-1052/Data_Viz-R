# Load required functions
source("R/preprocessing.R")
source("R/plotting.R")

# Load and process data
data_path <- "data/example/example_data.csv"
expression_data <- load_expression_data(data_path)
normalized_data <- normalize_expression(expression_data)

# Create and display heatmap
heatmap <- create_expression_heatmap(normalized_data)
print(heatmap)

# Create and display violin plot
violin_plot <- create_expression_violin(normalized_data)
print(violin_plot)