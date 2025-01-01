# download_US_population_corrected.R

# Load necessary libraries
if (!require(tidyverse)) {
  install.packages("tidyverse")
  library(tidyverse)
}

# Define the URL of the dataset
dataset_url <- "https://raw.githubusercontent.com/datasets/population/master/data/population.csv"

# Define the destination file path within data/demographics/raw/
destination_file <- file.path("data", "demographics", "raw", "population_us.csv")

# Download the dataset
download_dataset <- function(url, destfile) {
  tryCatch({
    download.file(url, destfile, method = "curl")
    message("Dataset downloaded successfully.")
  }, error = function(e) {
    stop("Error downloading the dataset: ", e)
  })
}

download_dataset(dataset_url, destination_file)

# Read the dataset into R
read_dataset <- function(file_path) {
  tryCatch({
    data <- read_csv(file_path)
    message("Dataset read successfully.")
    return(data)
  }, error = function(e) {
    stop("Error reading the dataset: ", e)
  })
}

population_data <- read_dataset(destination_file)

# Inspect the first few rows of the dataset
head(population_data)

# Filter data for a specific country (e.g., United States) from 1990 onwards
# You can change "United States" to any other country of interest
country_name <- "United States"
filtered_data <- population_data %>%
  filter(`Country Name` == country_name, Year >= 1990) %>%
  arrange(Year)

# Check if the filtered data is sufficient
if(nrow(filtered_data) < 2){
  stop("Insufficient data for the selected country and time range.")
}

# Display the filtered data
print(filtered_data)

# Plot the Population over Years
ggplot(filtered_data, aes(x = Year, y = Value)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  ggtitle(paste("Population Growth in", country_name)) +
  xlab("Year") +
  ylab("Population") +
  theme_minimal()

# Evaluate Exponential Growth

# Add a column for the natural logarithm of the population
filtered_data <- filtered_data %>%
  mutate(log_population = log(Value))

# Plot the Log of Population over Years to assess linearity
ggplot(filtered_data, aes(x = Year, y = log_population)) +
  geom_line(color = "green") +
  geom_point(color = "orange") +
  ggtitle(paste("Log of Population Growth in", country_name)) +
  xlab("Year") +
  ylab("Log(Population)") +
  theme_minimal()

# Fit a linear model to the log-transformed data
model <- lm(log_population ~ Year, data = filtered_data)

# Summarize the model
summary(model)

# Plot the regression line on the log-transformed data
ggplot(filtered_data, aes(x = Year, y = log_population)) +
  geom_line(color = "green") +
  geom_point(color = "orange") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  ggtitle(paste("Exponential Growth Fit for", country_name)) +
  xlab("Year") +
  ylab("Log(Population)") +
  theme_minimal()

# Interpret the Results
intercept <- coef(model)[1]
slope <- coef(model)[2]
growth_rate <- slope * 100  # Convert to percentage

cat(sprintf("The estimated exponential growth rate for %s is %.2f%% per year.\n", country_name, growth_rate))

# Optional: Calculate R-squared to assess model fit
r_squared <- summary(model)$r.squared
cat(sprintf("The R-squared of the model is %.4f, indicating that %.2f%% of the variability in log population is explained by the model.\n", r_squared, r_squared * 100))
