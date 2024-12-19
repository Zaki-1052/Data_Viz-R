source("R/preprocessing.R")

# Test data loading and preprocessing
data_path <- "data/example/example_data.csv"

# Check if file exists
if (!file.exists(data_path)) {
  stop("Data file not found at: ", data_path)
}

# Load data with verbose output
print("Loading data...")
expression_data <- load_expression_data(data_path)
print("Data loaded. Showing structure:")
str(expression_data)

print("\nFirst few rows of raw data:")
print(head(expression_data))

print("\nNormalizing data...")
normalized_data <- normalize_expression(expression_data)
print("Normalized data structure:")
str(normalized_data)

print("\nFirst few rows of normalized data:")
print(head(normalized_data))