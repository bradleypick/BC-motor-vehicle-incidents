#! /usr/bin/env Rscript
#
# merge_data.R
# 
# Bradley Pick Dec. 2017
#
# This script takes in a merged data set and summarises it into 
# a small table 
#
# Usage Rscript summarise_data.R /merged.csv /summarised.csv
# Depends on `readr`, `tidyr`, `dplyr` being installed

library(readr)
library(tidyr)
library(dplyr)

# define arguments
args <- commandArgs(trailingOnly = TRUE)

# input file location ORDER SENSITIVE
merged_file <- args[1]

# location to write summarised file
summary_file <- args[2]

# define main function
main <- function() {
  
  # read in merged data set from provided location
  merged <- read_csv(merged_file)
  
  # summarise data set
  summarised_table <- summary_table(merged)
  
  # write it out to provided location
  write_csv(summarised_table, summary_file)
  
}

# define summarise function
summary_table <- function(data) {
  out <- data %>% 
    group_by(injury_cause, fatality_cause) %>% 
    summarise(injury = last(injury_count, 
                            order_by = year) - first(injury_count, 
                                                     order_by = year),
              fatality = last(fatality_count, 
                              order_by = year) - first(fatality_count, 
                                                       order_by = year)) %>% 
    filter(injury_cause == 'Y', fatality_cause == 'Y') %>% 
    ungroup() %>% 
    select(injury, fatality)
  return(out)
}

# call main function
main()
