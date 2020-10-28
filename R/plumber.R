# Packages ----
# For API
library(plumber)
library(rapidoc)

# For model
library(parsnip)
library(ranger)

# Goal ----
model <- readr::read_rds("model.rds")

# predict(model, new_data = jsonlite::read_json("penguins.json", simplifyVector = TRUE), type = "prob")

#* Health Check - Is the API running
#* @get /health-check
status <- function() {
  list(
    status = "All Good",
    time = Sys.time()
  )
}

#* Predict species for new penguins
#* @serializer json
#* @post /predict
function(req, res) {
  predict(model, new_data = as.data.frame(req$body), type = "prob")
}

#* @plumber
function(pr) {
  pr %>% 
    pr_set_api_spec(yaml::read_yaml("openapi.yaml")) %>% 
    pr_set_docs(docs = "rapidoc")
}
