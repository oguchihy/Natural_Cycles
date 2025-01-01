# setupDataDirectories.R

# Function to create raw and processed directories for each data category
create_data_directories <- function(categories) {
  for(category in categories) {
    raw_dir <- file.path("data", category, "raw")
    processed_dir <- file.path("data", category, "processed")
    
    # Create raw directory if it doesn't exist
    if(!dir.exists(raw_dir)) {
      dir.create(raw_dir, recursive = TRUE)
      message(sprintf("Created directory: %s", raw_dir))
    } else {
      message(sprintf("Directory already exists: %s", raw_dir))
    }
    
    # Create processed directory if it doesn't exist
    if(!dir.exists(processed_dir)) {
      dir.create(processed_dir, recursive = TRUE)
      message(sprintf("Created directory: %s", processed_dir))
    } else {
      message(sprintf("Directory already exists: %s", processed_dir))
    }
  }
}

# Define the data categories
data_categories <- c("demographics", "financial", "energy", "climate", "education", "maritime", "transportation", "additional")

# Execute the function to create directories
create_data_directories(data_categories)
