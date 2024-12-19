

# Install and load required packages
install_required_packages <- function() {
  # List of required packages
  packages <- c(
    "tidyverse",    # Data manipulation and visualization
    "ggplot2",      # Advanced plotting
    "shiny",        # Interactive web applications
    "plotly",       # Interactive plots
    "BiocManager",  # Bioconductor package manager
    "heatmaply",    # Interactive heatmaps
    "DT",           # Interactive tables
    "scales"        # Scale functions for visualization
  )
  
  # Install missing packages
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages) > 0) {
    install.packages(new_packages)
  }
  
  # Install Bioconductor packages
  if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  
  BiocManager::install(c("DESeq2", "GenomicRanges"), update = FALSE)
  
  # Load all packages
  invisible(lapply(packages, library, character.only = TRUE))
}

# Run the installation
install_required_packages()

