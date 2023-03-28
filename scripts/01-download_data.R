#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Sakura Ariga
# Date: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca 
# License: MIT [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Download data ####
raw_momaexhibit_data <- read_csv("inputs/data/MoMAExhibitions1929to1989.csv")
raw_momadirectors_data <- read_csv("inputs/data/MoMADirectorsDepartmentHeads.csv")
raw_momaartists_data <- read_csv("inputs/data/MoMAArtists.csv")
raw_momaartworks_data <- read_csv("inputs/data/MoMAArtworks.csv")

#### Save data ####
write_csv(raw_momaexhibit_data, "inputs/data/raw_momaexhibit_data") 
write_csv(raw_momadirectors_data, "inputs/data/raw_momadirectors_data") 
write_csv(raw_momaartists_data, "inputs/data/raw_momaartists_data") 
write_csv(raw_momaartworks_data, "inputs/data/raw_momaartworks_data") 