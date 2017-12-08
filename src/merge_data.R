#! /usr/bin/env Rscript
#
# merge_data.R
# 
# Bradley Pick Dec. 2017
#
# This script takes in 4 datasets containing information
# about motor vehicle incidents and aggregates the data 
# writing it to a location provided 
#
# Usage Rscript merge_data.R /by_user.csv /distract.csv /speed.csv /drug.csv /output.csv
# Depends on `tidyverse` being installed

library(readr)
library(tidyr)
library(dplyr)

# define arguments
args <- commandArgs(trailingOnly = TRUE)

# input file locations ORDER SENSITIVE
by_user_file <- args[1]
distract_file <- args[2]
speed_file <- args[3]
drug_file <- args[4]

# location to write cleaned file
output_file <- args[5]


# define main function
main <- function() {
  
  # read in 4 datasets from provided location
  by_user <- read_csv(by_user_file,
                      col_names = c("year", "type", "count"), 
                      skip = 1)
  
  distract <- read_csv(distract_file,
                       col_names = c("year", "distracted", "distracted_count"), 
                       skip = 1)
  
  speed <- read_csv(speed_file,
                    col_names = c("year", "speeding", "speeding_count"), 
                    skip = 1)
  
  drug <- read_csv(drug_file,
                   col_names = c("year", "drug", "drug_count"), 
                   skip = 1)
  
  # tidy by_user and fix names
  by_user <- spread(by_user, key = 'type', value = 'count')
  colnames(by_user) <- make.names(names(by_user))

  # retain only rows with affirmative cases
  #distract <- distract %>% filter(distracted == 'Y') %>% select(year, distracted_count)
  #speed <- speed %>% filter(speeding == 'Y') %>% select(year, speeding_count)
  #drug <- drug %>% filter(drug == 'Y') %>% select(year, drug_count)
  
  # drop earlier years 
  by_user <- by_user %>% filter(year %in% unique(distract$year))
  drug <- drug %>% filter(year %in% unique(distract$year))
  speed <- speed %>% filter(year %in% unique(distract$year))
  
  #final_product <- bind_cols(distract, drug, speed)
  
  # join all preprocessed individual datasets into one
  final_product <- by_user %>% 
    inner_join(distract, by = "year") %>% 
    inner_join(drug, by = "year") %>% 
    inner_join(speed, by = "year")
  
  # write aggregated dataset to location specified
  write_csv(final_product, output_file)
  
}

# call main function
main()

