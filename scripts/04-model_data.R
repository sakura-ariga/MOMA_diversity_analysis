#### Preamble ####
# Purpose: Created models for paper analysis 
# Author: Sakura Ariga
# Data: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Model 1 ####
# Create new dataset for model 
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
    directors_gender_percentage <- temp
  } else {
    directors_gender_percentage <- directors_gender_percentage |> 
      rows_append(temp)
  }
}

directors_gender_percentage <- 
  directors_gender_percentage |> 
  mutate(PercentageFemale = 100 - PercentageMale)

# Create model from created dataset above
model_directors_percentage_female <- 
  lm(
    formula = PercentageFemale ~ Year,
    data = directors_gender_percentage
  )

summary(model_directors_percentage_female) 


#### Model 2 ####
# Create dataset for model 
exhibits_gender_percentage <- 
    cleaned_momaexhibit_data |> 
    filter(ExhibitionRole == "Artist") |> 
    group_by(ExhibitionTitle, Gender, Year) |> 
    summarise(n = n()) |> 
    group_by(ExhibitionTitle, Year) |> 
    mutate(PercentageMale = (n / sum(n)) * 100) |> 
    filter(Gender == "Male") |>
    select(PercentageMale)

exhibits_gender_percentage <- 
  exhibits_gender_percentage |> 
  mutate(PercentageFemale = 100 - PercentageMale)

# Create model from created dataset above
model_exhibits_percentage_female <- 
  lm(
    formula = PercentageFemale ~ Year,
    data = exhibits_gender_percentage
  )

summary(model_exhibits_percentage_female) 

#### Model 3 ####
merged_gender_percentage <- 
  left_join(exhibits_gender_percentage, directors_gender_percentage, by = "Year")

# merged_gender_percentage <- 
#   merged_gender_percentage |> 
#   rename = ("PercentageMaleArtists" = "PercentageMale.x")
#             "PercentageFemaleArtists" = "PercentageFemale.x",
#             "PercentageMaleDirectors" = "PercentageMale.y",
#             "PercentageFemaleDirectors" = "PercentageFemale.y")

model_exhibits_on_directors <- 
  lm(
    formula = PercentageFemale.x ~ PercentageFemale.y + Year,
    data = merged_gender_percentage
  )

summary(model_exhibits_on_directors)

#### Save models ####
saveRDS(
  model_directors_percentage_female, 
  file = "outputs/models/model_directors_percentage_female.rds"
)

saveRDS(
  model_exhibits_percentage_female, 
  file = "outputs/models/model_exhibits_percentage_female.rds"
)

saveRDS(
  model_exhibits_on_directors, 
  file = "outputs/models/model_exhibits_on_directors.rds"
)