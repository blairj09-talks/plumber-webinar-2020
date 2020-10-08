# Packages ----
library(plumber)
# For model predictions
library(parsnip)
library(ranger)

# Load model
model <- readr::read_rds("model.rds")

#* @apiTitle Penguin Predictions

#* Determine if the API is running and listening as expected
#* @get /health-check
function() {
  "All Good"
}

#* Predict penguin species based on input data
#* @parser json
#* @post /predict
function(req, res) {
  # req$body is the parsed input
  predict(model, new_data = req$body)
}

