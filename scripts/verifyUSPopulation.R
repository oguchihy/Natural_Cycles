# verifyUSPopulation.R

# Function to verify the presence of population_us.csv in data/demographics/raw/
verify_us_population <- function() {
  raw_dir <- file.path("data", "demographics", "raw")
  file_path <- file.path(raw_dir, "population_us.csv")
  
  if(file.exists(file_path)) {
    cat("Success: 'population_us.csv' exists in 'data/demographics/raw/'.\n")
  } else {
    cat("Error: 'population_us.csv' does NOT exist in 'data/demographics/raw/'.\n")
  }
}

# Execute the verification
verify_us_population()
