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
raw_momaexhibit_data <- read_csv("inputs/data/MoMAExhibitions1929to1989.csv")
raw_momadirectors_data <- read_csv("inputs/data/MoMADirectorsDepartmentHeads.csv")

#### Clean data ####
# Remove unneeded info in Exhibit data
cleaned_momaexhibit_data <- 
  raw_momaexhibit_data |> 
  select(ExhibitionTitle, ExhibitionBeginDate, ExhibitionEndDate, ExhibitionRole, 
         ExhibitionRoleinPressRelease, ConstituentType, DisplayName, AlphaSort, 
         Institution, Nationality, ConstituentBeginDate, ConstituentEndDate, ArtistBio,
         Gender)
# Remove unneeded info in Directors data
cleaned_momadirectors_data <- 
  raw_momadirectors_data |> 
  select(DepartmentFullName, DepartmentBeginYear, DepartmentEndYear, DisplayName, PositionNote, 
         PositionBeginYear, PositionEndYear, ConstituentType, AlphaSort, Nationality, 
         ConstituentBeginDate, ConstituentEndDate, ArtistBio, Gender)

# Create age variables in Directors data by subtracting start dates from end dates 
cleaned_momadirectors_data <-
  cleaned_momadirectors_data |>
  mutate(ConstituentAge = ConstituentEndDate - ConstituentBeginDate,
         PositionAge = PositionEndYear - PositionBeginYear, 
         DepartmentAge = DepartmentEndYear - DepartmentBeginYear)

# Remove NAs from PositionEndYear in Directors data
cleaned_momadirectors_data$PositionEndYear[is.na(cleaned_momadirectors_data$PositionEndYear)] <- 2023

# Create year-specific variables for start and end dates in Exhibit data
cleaned_momaexhibit_data <-
  cleaned_momaexhibit_data |>
  mutate(StartYear = str_sub(ExhibitionBeginDate, -4),
         Year = str_sub(ExhibitionEndDate, -4)
  )

# Remove NAs from Year in Exhibit data
cleaned_momaexhibit_data$Year[is.na(cleaned_momaexhibit_data$Year)] <- 2023

# Convert Year from string to numeric in Exhibit
cleaned_momaexhibit_data <-
  cleaned_momaexhibit_data |>
  mutate(Year = as.numeric(Year))
         

# Edit gender variable to remove duplicates and null from Exhibit
# cleaned_momaexhibit_data <- 
#   cleaned_momaexhibit_data |>
#   filter(Gender == "Female" | Gender == "Male")

#### Save data ####
write_csv(cleaned_momaexhibit_data, "outputs/data/cleaned_momaexhibit_data")
write_csv(cleaned_momadirectors_data, "outputs/data/cleaned_momadirectors_data")