#! /usr/bin/env Rscript
#
# merge_data.R
# 
# Bradley Pick Dec. 2017
#
# This script takes in 2 datasets containing information
# about motor vehicle incidents incoolving fatalities and injuries
# and aggregates the data, writing it to a location provided 
#
# Usage Rscript merge_data.R /injury.csv /fatality.csv /output.csv
# Depends on `readr`, `tidyr`, `dplyr`, `stringr` being installed

library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# define arguments
args <- commandArgs(trailingOnly = TRUE)

# input file locations ORDER SENSITIVE
injury_file <- args[1]
fatality_file <- args[2]

# location to write cleaned file
output_file <- args[3]


# define main function
main <- function() {
  
  # extract the filename being read in for column naming
  # injury_type <- str_extract(injury_file, pattern = "(?<=/)(.*)(?=\\.)")
  # fatality_type <- str_extract(fatality_file, pattern = "(?<=/)(.*)(?=\\.)")
  
  # read in 2 datasets from provided location
  injury <- read_csv(injury_file,
                     col_names = c("year", "injury_cause", "injury_count"), 
                     skip = 1)
  
  fatality <- read_csv(fatality_file,
                       col_names = c("year", "fatality_cause", "fatality_count"), 
                       skip = 1)
  
  # join injury and fatality datasets into one
  final_product <- injury %>% 
    inner_join(fatality, by = "year")
  
  # write aggregated dataset to location specified
  write_csv(final_product, output_file)
  
}

# call main function
main()

