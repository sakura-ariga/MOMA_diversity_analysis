#### Preamble ####
# Purpose: Simulates the data that I would like to obtain from the MoMA's public GitHub for my analysis
# Author: Sakura Ariga 
# Data: 15 April 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(853)

artists_simulated_data <-
  tibble(
    year = c(1929:2023),
    percentage_female = runif(
      n = 95, 
      min = 0, 
      max = 100),
    race = sample(
      x = c(1:7),
      size = 95,
      replace = TRUE),
    position = sample(
      x = c("Artist"),
      size = 95,
      replace = TRUE)
 )
head(artists_simulated_data)

directors_simulated_data <-
  tibble(
    year = c(1929:2023),
    percentage_female = runif(
      n = 95, 
      min = 0, 
      max = 100),
    race = sample(
      x = c(1:7),
      size = 95,
      replace = TRUE),
    position = sample(
      x = c("Director or Department Head"),
      size = 95,
      replace = TRUE)
  )
head(directors_simulated_data)


#### Save simulated data ####
write_csv(artists_simulated_data, "outputs/data/artists_simulated_data.csv")
write_csv(directors_simulated_data, "outputs/data/directors_simulated_data.csv")