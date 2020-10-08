# Packages ----
library(plumber)
# For model predictions
library(parsnip)
library(ranger)

# Load model
model <- readr::read_rds("model.rds")

pr() %>% 
  pr_get(path = "/health-check",
         handler = function() "All Good") %>% 
  pr_post(path = "/predict",
          handler = function(req, res){
            predict(model, new_data = req$body)
          }) %>% 
  pr_run()
