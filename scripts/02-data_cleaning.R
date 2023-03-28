#### Preamble ####
# Purpose: Cleans.... [...UPDATE THIS...]
# Author: Sakura Ariga
# Data: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Download data ####
raw_momaexhibit_data <- read_csv("inputs/data/MoMAExhibitions1929to1989.csv")
raw_momadirectors_data <- read_csv("inputs/data/MoMADirectorsDepartmentHeads.csv")
raw_momaartists_data <- read_csv("inputs/data/MoMAArtists.csv")
raw_momaartworks_data <- read_csv("inputs/data/MoMAArtworks.csv")

#### Clean data ####
# Remove unneeded info in raw_momaexhibit_data
cleaned_momaexhibit_data <- 
  raw_momaexhibit_data |> 
  select(ExhibitionTitle, ExhibitionBeginDate, ExhibitionEndDate, ExhibitionRole, 
         ExhibitionRoleinPressRelease, ConstituentType, DisplayName, AlphaSort, 
         Institution, Nationality, ConstituentBeginDate, ConstituentEndDate, ArtistBio,
         Gender)
# Remove unneeded info in raw_momadirectors_data
cleaned_momadirectors_data <- 
  raw_momadirectors_data |> 
  select(DepartmentFullName, DepartmentBeginYear, DepartmentEndYear, DisplayName, PositionNote, 
         PositionBeginYear, PositionEndYear, ConstituentType, AlphaSort, Nationality, 
         ConstituentBeginDate, ConstituentEndDate, ArtistBio, Gender)
# Remove unneeded info in raw_momaartists_data
cleaned_momaartists_data <- 
  raw_momaartists_data |> 
  select(DisplayName, ArtistBio, Nationality, Gender, BeginDate, EndDate)
# Remove unneeded info in raw_momaartworks_data
cleaned_momaartworks_data <- 
  raw_momaartworks_data |> 
  select(Title, Artist, ArtistBio, Nationality, BeginDate, EndDate, Date, Medium, Dimensions, 
         CreditLine, Classification, Department, DateAcquired, `Circumference (cm)`,
         `Depth (cm)`, `Diameter (cm)`, `Height (cm)`, `Length (cm)`, `Weight (kg)`, 
         `Width (cm)`, `Seat Height (cm)`, `Duration (sec.)`)

# Create age variables by subtracting start dates from end dates 
cleaned_momadirectors_data <-
  cleaned_momadirectors_data |>
  mutate(ConstituentAge = ConstituentEndDate - ConstituentBeginDate,
         PositionAge = PositionEndYear - PositionBeginYear, 
         DepartmentAge = DepartmentEndYear - DepartmentBeginYear)
# Create age variables by subtracting start dates from end dates 
cleaned_momaartists_data <-
  cleaned_momaartists_data |>
  mutate(, 
         Age = EndDate - BeginDate)

#### Save data ####
write_csv(cleaned_momaexhibit_data, "outputs/data/cleaned_momaexhibit_data")
write_csv(cleaned_momadirectors_data, "outputs/data/cleaned_momadirectors_data")
write_csv(cleaned_momaartists_data, "outputs/data/cleaned_momaartists_data")
write_csv(cleaned_momaartworks_data, "outputs/data/cleaned_momaartworks_data")