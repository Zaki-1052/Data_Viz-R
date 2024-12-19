#' Basic data preprocessing functions
library(tidyverse)

#' Load and preprocess expression data
#' @param file_path Path to the input file (CSV/TSV)
#' @return Preprocessed data frame
load_expression_data <- function(file_path) {
  # Read the data
  data <- read.csv(file_path, header = TRUE, row.names = 1)
  
  # Basic preprocessing steps
  processed_data <- data %>%
    # Remove rows with missing values
    na.omit() %>%
    # Convert to long format for easier plotting
    rownames_to_column("gene_id") %>%
    gather(key = "sample", value = "expression", -gene_id)
  
  return(processed_data)
}

#' Normalize expression data using log2 transformation
#' @param data Data frame containing expression values
#' @return Normalized data frame
normalize_expression <- function(data) {
  data %>%
    mutate(expression = log2(expression + 1))  # Add 1 to avoid log(0)
}