#### Preamble ####
# Purpose: Cleans MoMA data originally downloaded from the MoMA's public GitHub
# Author: Sakura Ariga
# Data: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT 


#### Workspace setup ####
library(tidyverse)
library(stringr)

#### Download data ####
raw_momaexhibit_data <- read_csv("inputs/data/raw_momaexhibit_data")
raw_momadirectors_data <- read_csv("inputs/data/raw_momadirectors_data")

#### Clean data ####
# Remove unneeded info in Exhibit data
cleaned_momaexhibit_data <- 
  raw_momaexhibit_data |> 
  filter(ExhibitionRole == "Artist") |> 
  select(ExhibitionTitle, ExhibitionRole, ExhibitionBeginDate, ExhibitionEndDate, DisplayName, 
         Nationality, Gender)
# Remove unneeded info in Directors data
cleaned_momadirectors_data <- 
  raw_momadirectors_data |> 
  select(DepartmentFullName, DisplayName, PositionBeginYear, PositionEndYear, 
         Nationality, Gender)

# Remove NAs from PositionEndYear in Directors data
cleaned_momadirectors_data$PositionEndYear[is.na(cleaned_momadirectors_data$PositionEndYear)] <- 2023

# Create year-specific variables for start and end dates in Exhibit data
cleaned_momaexhibit_data <-
  cleaned_momaexhibit_data |>
  mutate(StartYear = str_sub(ExhibitionBeginDate, -4),
         Year = str_sub(ExhibitionEndDate, -4)
  )

# Convert Year from string to numeric in Exhibit
cleaned_momaexhibit_data <-
  cleaned_momaexhibit_data |>
  mutate(Year = as.numeric(Year))

# Remove unneeded info in Exhibit data
cleaned_momaexhibit_data <- 
  cleaned_momaexhibit_data |> 
  select(ExhibitionTitle, DisplayName, Nationality, Gender, StartYear, Year)

# Remove NAs from both datasets 
cleaned_momaexhibit_data <- 
  cleaned_momaexhibit_data |> 
  drop_na()

cleaned_momadirectors_data <- 
  cleaned_momadirectors_data |> 
  drop_na()
         

# Edit gender variable to remove duplicates and null from Exhibit
# cleaned_momaexhibit_data <- 
#   cleaned_momaexhibit_data |>
#   filter(Gender == "Female" | Gender == "Male")

cleaned_momaexhibit_data <- 
  cleaned_momaexhibit_data[Gender == 'Female']

#### Save data ####
write_csv(cleaned_momaexhibit_data, "outputs/data/cleaned_momaexhibit_data")
write_csv(cleaned_momadirectors_data, "outputs/data/cleaned_momadirectors_data")