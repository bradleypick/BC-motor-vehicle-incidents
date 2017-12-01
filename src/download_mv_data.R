#! /usr/bin/env Rscript
#
# download_mv_data.R
# 
# Bradley Pick Nov. 2017
#
# This script downloads 9 datasets from the Government
# of BC data catalogue, merges them and writes two 
# .csv files to the locations of the users choice
#
# Usage Rscript download_mv_data.R /dataset1.csv /dataset1.csv
#
# Depends on `tidyverse` being installed

library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
output_file1 <- args[1]
output_file2 <- args[2]

# define main function
main <- function() {
  
  injury_by_road_user <- read_csv("https://catalogue.data.gov.bc.ca/dataset/aa55daf2-34f3-4f67-bcdb-d0ca57e0c5c4/resource/c0ffaff2-01f8-4d99-a534-98c7f00a3ea5/download/motor-vehicle-serious-injuries-by-road-user-type.csv",
                                  col_names = c("year", "type", "count"), skip = 1)
  fatality_by_road_user <- read_csv("https://catalogue.data.gov.bc.ca/dataset/546debd7-1f13-40fb-9153-07b25b3cc01b/resource/834a8f81-9ac4-4ab9-9b1b-0c76452afe70/download/motor-vehicle-fatalities-by-road-user-type.csv",
                                    col_names = c("year", "type", "count"), skip = 1)
  
  injury_distract <- read_csv("https://catalogue.data.gov.bc.ca/dataset/91d4f3e3-3c16-4f22-bb09-aafd0350659f/resource/00039030-21fb-4441-986c-03cb35d2f852/download/motor-vehicle-serious-injuries-with-distraction-involvement.csv",
                              col_names = c("year", "distracted", "distracted_count"), skip = 1)
  fatality_distract <- read_csv("https://catalogue.data.gov.bc.ca/dataset/bf653fa6-4651-416b-8991-045fb8a3da49/resource/18d1772b-3596-490b-9079-7ef4f565a8c3/download/motor-vehicle-fatalities-with-distraction-involvement.csv",
                                col_names = c("year", "distracted", "distracted_count"), skip = 1)
  
  injury_speed <- read_csv("https://catalogue.data.gov.bc.ca/dataset/eb4e998f-3d1b-4257-a591-91e863344f0d/resource/9036364a-bce3-4d11-8ff2-a640ff533df6/download/motor-vehicle-serious-injuries-with-speeding-involvement.csv",
                           col_names = c("year", "speeding", "speeding_count"), skip = 1)
  fatality_speed <- read_csv("https://catalogue.data.gov.bc.ca/dataset/23937c1c-f1e0-497c-a34f-c2c6ce15e775/resource/de1b175c-2725-403a-ba33-6b57f868f38e/download/motor-vehicle-fatalities-with-speeding-involvement.csv",
                             col_names = c("year", "speeding", "speeding_count"), skip = 1)
  
  injury_drug <- read_csv("https://catalogue.data.gov.bc.ca/dataset/e87b3585-c195-4ee4-b531-a919262816ce/resource/28076ae1-0db2-48c3-a750-75498fe0357f/download/motor-vehicle-serious-injuries-with-alcohol-and-or-drug-involvement.csv",
                          col_names = c("year", "drug", "drug_count"), skip = 1)
  fatality_drug <- read_csv("https://catalogue.data.gov.bc.ca/dataset/459c4ded-4687-485e-aa10-f957fabefdd1/resource/b7d71c80-81d3-4c6f-a913-9d68f3c49d8e/download/motor-vehicle-fatalities-with-alcohol-and-or-drug-involvement.csv",
                            col_names = c("year", "drug", "drug_count"), skip = 1)
  
  injury_by_road_user <- spread(injury_by_road_user, key = 'type', value = 'count')
  fatality_by_road_user <- spread(fatality_by_road_user, key = 'type', value = 'count')
  colnames(injury_by_road_user) <- make.names(names(injury_by_road_user))
  colnames(fatality_by_road_user) <- make.names(names(fatality_by_road_user))
  
  injury_distract <- injury_distract %>% 
    filter(distracted == 'Y') %>% select(year, distracted_count)
  
  fatality_distract <- fatality_distract %>% 
    filter(distracted == 'Y') %>% select(year, distracted_count)
  
  injury_speed <- injury_speed %>% 
    filter(speeding == 'Y') %>% select(year, speeding_count)
  
  fatality_speed <- fatality_speed %>% 
    filter(speeding == 'Y') %>% select(year, speeding_count)
  
  injury_drug <- injury_drug %>% 
    filter(drug == 'Y') %>% select(year, drug_count)
  
  fatality_drug <- fatality_drug %>% 
    filter(drug == 'Y') %>% select(year, drug_count)
  
  fatality_by_road_user <- fatality_by_road_user %>% 
    filter(year %in% unique(fatality_distract$year))
  
  fatality_drug <- fatality_drug %>% 
    filter(year %in% unique(fatality_distract$year))
  
  fatality_speed <- fatality_speed %>% 
    filter(year %in% unique(fatality_distract$year))
  
  fatality <- bind_cols(fatality_by_road_user,
                        select(fatality_distract, distracted_count),
                        select(fatality_speed, speeding_count),
                        select(fatality_drug, drug_count))
  
  injury <- bind_cols(injury_by_road_user,
                      select(injury_distract, distracted_count),
                      select(injury_speed, speeding_count),
                      select(injury_drug, drug_count))
  
  write_csv(fatality, output_file1)
  write_csv(injury, output_file2)
  
}

# call main function
main()