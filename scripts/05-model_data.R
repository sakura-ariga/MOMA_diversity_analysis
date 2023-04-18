#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Sakura Ariga
# Data: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Notes from last day of class ####
use default priors in the bayesian model --> can take it directly from telling stories with data (see quercus post for apr 6)
pretty much whats on his apr 6 quercus, just change the first line 

in paper: display the model equation, explain model, model justification (use olaedos paper as template)
for model justification part, talk about whether you expect a positive or negative relationship, then add a paragraph about each 
model section should be around a page in your paper 

results section in paper is where you read in the model that you created; also put a table summary of it here

#### Example model from Rohan ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

#### Draft model ####
numeric_momadirectors_data <- 
  cleaned_momadirectors_data |>
  mutate(Gender = case_when(
    Gender == "Female" ~ 1,
    Gender == "Male" ~ 2,
  ))

potential_model <-
  stan_glm(
    formula = Gender ~ DepartmentBeginYear + Gender,
    data = numeric_momadirectors_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

summary(potential_model)

#### Potential model 1 ####
potential_model_1 <- 
  stan_glm(
    formula = PositionAge ~ Gender + Nationality,
    data = numeric_momadirectors_data,
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  )
summary(potential_model_1)

#### Potential model 2.1 ####
# Create dataset for model 
for (i in 1929:2023) {
  temp <- 
    cleaned_momadirectors_data |> 
    filter(PositionBeginYear <= i & PositionEndYear >= i) |> 
    group_by(Gender) |> 
    summarise(n = n()) |> 
    mutate(PercentageMale = (n / sum(n)) * 100) |> 
    filter(Gender == "Male") |>
    select(PercentageMale) |> 
    mutate(Year = i)
  
  if (i == 1929) {
    directors_gender_proportion <- temp
  } else {
    directors_gender_proportion <- directors_gender_proportion |> 
      rows_append(temp)
  }
}

directors_gender_proportion <- 
  directors_gender_proportion |> 
  mutate(PercentageFemale = 100 - PercentageMale)

# Create model from created dataset above
model_directors_proportion_female <- 
  lm(
    formula = PercentageFemale ~ Year,
    data = directors_gender_proportion
  )

summary(model_directors_proportion_female) 


#### Potential model 2.2 ####
# Create dataset for model 
exhibits_gender_proportion <- 
    cleaned_momaexhibit_data |> 
    filter(ExhibitionRole == "Artist") |> 
    group_by(ExhibitionTitle, Gender, Year) |> 
    summarise(n = n()) |> 
    group_by(ExhibitionTitle, Year) |> 
    mutate(PercentageMale = (n / sum(n)) * 100) |> 
    filter(Gender == "Male") |>
    select(PercentageMale)

exhibits_gender_proportion <- 
  exhibits_gender_proportion |> 
  mutate(PercentageFemale = 100 - PercentageMale)

# Create model from created dataset above
model_exhibits_proportion_female <- 
  lm(
    formula = PercentageFemale ~ Year,
    data = exhibits_gender_proportion
  )

summary(model_exhibits_proportion_female) 

#### Potential model 2.3 ####
merged_gender_proportion <- 
  left_join(exhibits_gender_proportion, directors_gender_proportion, by = "Year")

model_exhibits_on_directors <- 
  lm(
    formula = PercentageFemale.x ~ PercentageFemale.y + Year,
    data = merged_gender_proportion
  )

summary(model_exhibits_on_directors)

#### Save model ####
saveRDS(
  gender_model, 
  file = "outputs/models/gender_model.rds"
)

#### Read data ####
analysis_data <- read_csv("outputs/data/analysis_data.csv")