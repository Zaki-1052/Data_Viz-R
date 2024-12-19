library(tidyverse)
library(plotly)

#' Create an interactive heatmap of gene expression data
#' @param data Processed expression data frame
#' @return plotly heatmap object
create_expression_heatmap <- function(data) {
  # Reshape data to wide format for heatmap
  heatmap_data <- data %>%
    pivot_wider(
      names_from = sample,
      values_from = expression,
      id_cols = gene_id
    ) %>%
    as.data.frame()
  
  # Convert gene_id to rownames
  rownames(heatmap_data) <- heatmap_data$gene_id
  heatmap_data$gene_id <- NULL
  
  # Create heatmap using plotly
  plot_ly(
    x = colnames(heatmap_data),
    y = rownames(heatmap_data),
    z = as.matrix(heatmap_data),
    type = "heatmap",
    colors = colorRamp(c("navy", "white", "red")),
    hoverongaps = FALSE
  ) %>%
    layout(
      title = "Gene Expression Heatmap",
      xaxis = list(title = "Samples"),
      yaxis = list(title = "Genes")
    )
}

#' Create a violin plot of expression distribution
#' @param data Processed expression data frame
#' @return ggplot object
create_expression_violin <- function(data) {
  ggplot(data, aes(x = sample, y = expression, fill = sample)) +
    geom_violin(alpha = 0.7) +
    geom_boxplot(width = 0.1, fill = "white", alpha = 0.5) +
    theme_minimal() +
    labs(
      title = "Expression Distribution by Sample",
      x = "Sample",
      y = "Log2 Expression"
    ) +
    theme(legend.position = "none")
}