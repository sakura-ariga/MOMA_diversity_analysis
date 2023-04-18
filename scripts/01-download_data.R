#### Preamble ####
# Purpose: Downloads and saves the data from the MoMA's public GitHub
# Author: Sakura Ariga
# Date: 26 March 2023
# Contact: sakura.ariga@mail.utoronto.ca 
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Download data ####
raw_momaexhibit_data <- read_csv(
  file = "https://raw.githubusercontent.com/MuseumofModernArt/exhibitions/master/MoMAExhibitions1929to1989.csv",
  show_col_types = FALSE, 
  skip = 0)
raw_momadirectors_data <- read_csv(
  file = "https://raw.githubusercontent.com/MuseumofModernArt/exhibitions/master/MoMADirectorsDepartmentHeads.csv",
  show_col_types = FALSE,
  skip = 0)
raw_momaartists_data <- read_csv(
  file = "https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artists.csv",
  show_col_types = FALSE,
  skip = 0)
#raw_momaartworks_data <- read_csv(
#  file = "https://media.githubusercontent.com/media/MuseumofModernArt/collection/master/Artworks.csv",
#  show_col_types = FALSE,
#  skip = 0)

#### Save data ####
write_csv(raw_momaexhibit_data, "inputs/data/raw_momaexhibit_data") 
write_csv(raw_momadirectors_data, "inputs/data/raw_momadirectors_data") 
write_csv(raw_momaartists_data, "inputs/data/raw_momaartists_data") 
#write_csv(raw_momaartworks_data, "inputs/data/raw_momaartworks_data") 