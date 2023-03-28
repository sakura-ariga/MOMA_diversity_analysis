#### Workspace setup #### 
library(tidyverse)
library(dplyr)
library(tidyr)
library(knitr)
library(kableExtra)


#### Import data ####
# Import cleaned data from the outputs folder, originally imported via the 02-data_cleaning.R file
cleaned_momaexhibit_data <- read.csv(here::here("outputs/data/cleaned_momaexhibit_data"))
cleaned_momadirectors_data <- read.csv(here::here("outputs/data/cleaned_momadirectors_data"))
cleaned_momaartists_data <- read.csv(here::here("outputs/data/cleaned_momaartists_data"))
cleaned_momaartworks_data <- read.csv(here::here("outputs/data/cleaned_momaartworks_data"))


#### Visualize data (drafts) ####
# Bar graph showing gender distribution of artists displayed in the MoMA
cleaned_momaartists_data |>
  ggplot(mapping = aes(x = Gender)) + 
  geom_bar(position = "dodge2")+
  labs(x = "Gender", y = "Count of Artists in the MoMA") 

# Bar graph showing nationality distribution of artists displayed in the MoMA
cleaned_momaartists_data |>
  ggplot(mapping = aes(x = Nationality)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  geom_bar(position = "dodge2")+
  labs(x = "Nationality", y = "Count of Artists in the MoMA") 

## Bar graph showing age distribution of artworks displayed in the MoMA (TOO BIG DATASET, TAKES TOO LONG)
#cleaned_momaartworks_data |>
#  ggplot(mapping = aes(x = Date)) +
#  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
#  geom_bar(position = "dodge2")+
#  labs(x = "Date", y = "Count of Artworks in the MoMA") 

# Bar graph showing nationality distribution of constituents MoMA exhibits
cleaned_momaexhibit_data |>
  ggplot(mapping = aes(x = Nationality)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  geom_bar(position = "dodge2")+
  labs(x = "Nationality", y = "Count of Constituents in MoMA Exhibits") 

# Bar graph showing gender distribution of constituents MoMA exhibits
cleaned_momaexhibit_data |>
  ggplot(mapping = aes(x = Gender)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  geom_bar(position = "dodge2")+
  labs(x = "Gender", y = "Count of Constituents in MoMA Exhibits") 

# Bar graph showing nationality distribution of MoMA directors and department heads 
cleaned_momadirectors_data |>
  ggplot(mapping = aes(x = Nationality)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  geom_bar(position = "dodge2")+
  labs(x = "Nationality", y = "Count of MoMA Directors and Department Heads") 

# Bar graph showing gender distribution of MoMA directors and department heads 
cleaned_momadirectors_data |>
  ggplot(mapping = aes(x = Gender)) +
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  geom_bar(position = "dodge2")+
  labs(x = "Gender", y = "Count of MoMA Directors and Department Heads")

