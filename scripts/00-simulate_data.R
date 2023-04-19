#### Preamble ####
# Purpose: Simulates the data that I would like to obtain from the MoMA's public GitHub for my analysis
# Author: Sakura Ariga 
# Data: 15 April 2023
# Contact: sakura.ariga@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
# Create dataset with: year, percentage of female artists, percentage of non-white artists, and the position of the individual in the MoMA exhibit
set.seed(853)

artists_simulated_data <-
  tibble(
    year = c(1929:2023),
    percentage_female = runif(
      n = 95, 
      min = 0, 
      max = 100),
    percentage_notwhite = runif(
      n = 95, 
      min = 0, 
      max = 100),
    position = sample(
      x = c("Artist"),
      size = 95,
      replace = TRUE)
 )

# Create dataset with: year, percentage of female directors or department head, percentage of non-white directors or department head, and the position of the individual in MoMA
directors_simulated_data <-
  tibble(
    year = c(1929:2023),
    percentage_female = runif(
      n = 95, 
      min = 0, 
      max = 100),
    percentage_notwhite = runif(
      n = 95, 
      min = 0, 
      max = 100),
    position = sample(
      x = c("Director or Department Head"),
      size = 95,
      replace = TRUE)
  )


#### Save simulated data ####
write_csv(artists_simulated_data, "outputs/data/artists_simulated_data.csv")
write_csv(directors_simulated_data, "outputs/data/directors_simulated_data.csv")