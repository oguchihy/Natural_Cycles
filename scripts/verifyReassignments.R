# verifyReassignments.R

# Function to list all files within each data category's raw directory
verify_raw_data <- function(categories) {
  for(category in categories) {
    raw_dir <- file.path(getwd(), "data", category, "raw")
    
    if(dir.exists(raw_dir)) {
      files <- list.files(path = raw_dir, pattern = "\\.csv$", full.names = TRUE)
      cat(sprintf("\n## Files in data/%s/raw/:\n", category))
      if(length(files) > 0){
        print(files)
      } else {
        cat("No files found.\n")
      }
    } else {
      cat(sprintf("\ndata/%s/raw/ directory does not exist.\n", category))
    }
  }
}

# Define the data categories
data_categories <- c("demographics", "financial", "energy", "climate", "education", "maritime", "transportation", "additional")

# Execute the verification
verify_raw_data(data_categories)
