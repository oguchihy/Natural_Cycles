# ================================
# Project Directory Setup Script
# ================================

# Load necessary library
# No additional libraries are required for this script.

# ----------------
# 1. Define Project Path
# ----------------

setwd(getwd())

# Specify the base path where you want to create your project directory.
# Replace "path/to/your/project" with your desired path.
# For example, to create the project in your current working directory, use getwd()

#base_path <- "path/to/your/project"  # <-- Replace with your desired path

# Alternatively, to use the current working directory:
base_path <- getwd()

# ----------------
# 2. Define Directory Structure
# ----------------

# Create a vector of all directories to be created, relative to the base path.
directories <- c(
  "data/financial",
  "data/climate",
  "data/maritime",
  "data/education",
  "data/energy",
  "data/transportation",
  "data/additional",
  "scripts",
  "reports",
  "visualizations"
)

# ----------------
# 3. Create Directories
# ----------------

# Function to create directories safely
create_directories <- function(base, dirs) {
  for(dir in dirs) {
    # Construct the full path
    full_path <- file.path(base, dir)
    
    # Check if the directory already exists
    if(!dir.exists(full_path)) {
      # Create the directory with recursive = TRUE to create nested directories
      dir.create(full_path, recursive = TRUE, showWarnings = FALSE)
      message("Created directory: ", full_path)
    } else {
      message("Directory already exists: ", full_path)
    }
  }
}

# Call the function to create directories
create_directories(base_path, directories)

# ----------------
# 4. Verify Creation (Optional)
# ----------------

# List all created directories to verify
list_created_dirs <- function(base, dirs) {
  sapply(dirs, function(dir) {
    full_path <- file.path(base, dir)
    if(dir.exists(full_path)) {
      return(full_path)
    } else {
      return(NA)
    }
  })
}

# Get the list of successfully created directories
created_dirs <- list_created_dirs(base_path, directories)

# Display the list
print("List of Created Directories:")
print(created_dirs)

# ================================
# End of Script
# ================================
