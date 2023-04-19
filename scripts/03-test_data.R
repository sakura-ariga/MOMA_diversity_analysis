#### Preamble ####
# Purpose: Tests the simulated data found in file "00-simulate_data.R"
# Author: Sakura Ariga
# Data: 15 April 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Download data ####
artists_simulated_data <- read_csv("outputs/data/artists_simulated_data.csv")
directors_simulated_data <- read_csv("outputs/data/directors_simulated_data.csv")


#### Test data ####
artists_simulated_data$percentage_female |> 
  class() == "numeric"

artists_simulated_data$year |> 
  class() == "numeric"

artists_simulated_data$year |> 
  min() == 1929

directors_simulated_data$year |> 
  max() == 2023

directors_simulated_data$percentage_female |> 
  min() >= 0

directors_simulated_data$percentage_female |> 
  max() <= 100