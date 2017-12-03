#! /usr/bin/env Rscript
#
# download_mv_data.R
# 
# Bradley Pick Nov. 2017
#
# This script downloads 8 datasets from the Government
# of BC data catalogue and writes to folder provided
#
# Usage Rscript download_mv_data.R 
#
# Depends on `tidyverse` being installed

library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
output_folder <- args[1]


# define main function
main <- function() {
  
  injury_by_user <- read_csv("https://catalogue.data.gov.bc.ca/dataset/aa55daf2-34f3-4f67-bcdb-d0ca57e0c5c4/resource/c0ffaff2-01f8-4d99-a534-98c7f00a3ea5/download/motor-vehicle-serious-injuries-by-road-user-type.csv")
  fatality_by_user <- read_csv("https://catalogue.data.gov.bc.ca/dataset/546debd7-1f13-40fb-9153-07b25b3cc01b/resource/834a8f81-9ac4-4ab9-9b1b-0c76452afe70/download/motor-vehicle-fatalities-by-road-user-type.csv")
  
  injury_distract <- read_csv("https://catalogue.data.gov.bc.ca/dataset/91d4f3e3-3c16-4f22-bb09-aafd0350659f/resource/00039030-21fb-4441-986c-03cb35d2f852/download/motor-vehicle-serious-injuries-with-distraction-involvement.csv")
  fatality_distract <- read_csv("https://catalogue.data.gov.bc.ca/dataset/bf653fa6-4651-416b-8991-045fb8a3da49/resource/18d1772b-3596-490b-9079-7ef4f565a8c3/download/motor-vehicle-fatalities-with-distraction-involvement.csv")
  
  injury_speed <- read_csv("https://catalogue.data.gov.bc.ca/dataset/eb4e998f-3d1b-4257-a591-91e863344f0d/resource/9036364a-bce3-4d11-8ff2-a640ff533df6/download/motor-vehicle-serious-injuries-with-speeding-involvement.csv")
  fatality_speed <- read_csv("https://catalogue.data.gov.bc.ca/dataset/23937c1c-f1e0-497c-a34f-c2c6ce15e775/resource/de1b175c-2725-403a-ba33-6b57f868f38e/download/motor-vehicle-fatalities-with-speeding-involvement.csv")
  
  injury_drug <- read_csv("https://catalogue.data.gov.bc.ca/dataset/e87b3585-c195-4ee4-b531-a919262816ce/resource/28076ae1-0db2-48c3-a750-75498fe0357f/download/motor-vehicle-serious-injuries-with-alcohol-and-or-drug-involvement.csv")
  fatality_drug <- read_csv("https://catalogue.data.gov.bc.ca/dataset/459c4ded-4687-485e-aa10-f957fabefdd1/resource/b7d71c80-81d3-4c6f-a913-9d68f3c49d8e/download/motor-vehicle-fatalities-with-alcohol-and-or-drug-involvement.csv")
  
  write_csv(injury_by_user, str_c(output_folder, "injury_by_user.csv", sep = "/"))
  write_csv(fatality_by_user, str_c(output_folder, "fatality_by_user.csv",sep = "/"))
  
  write_csv(injury_distract, str_c(output_folder, "injury_distract.csv", sep = "/"))
  write_csv(fatality_distract, str_c(output_folder, "fatality_distract.csv",sep = "/"))
  
  write_csv(injury_speed, str_c(output_folder, "injury_speed.csv", sep = "/"))
  write_csv(fatality_speed, str_c(output_folder, "fatality_speed.csv",sep = "/"))
  
  write_csv(injury_drug, str_c(output_folder, "injury_drug.csv", sep = "/"))
  write_csv(fatality_drug, str_c(output_folder, "fatality_drug.csv",sep = "/"))
  
}

# call main function
main()
