# Packages ----
# For API
library(plumber)
library(rapidoc)
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
#* @serializer csv
#* @post /predict
function(req, res) {
  # req$body is the parsed input
  predict(model, new_data = as.data.frame(req$body))
}

# Update UI
#* @plumber
function(pr) {
  pr %>% 
    pr_set_api_spec(yaml::read_yaml("openapi.yaml")) %>%
    pr_set_docs(docs = "rapidoc")
}