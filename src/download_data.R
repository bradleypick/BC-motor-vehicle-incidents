#! /usr/bin/env Rscript
#
# download_mv_data.R
# 
# Bradley Pick Nov. 2017
#
# This script downloads a dataset from the given url
# and writes to folder provided
#
# Usage Rscript download_mv_data.R url folder
#
# Depends on `readr` being installed

library(readr)

args <- commandArgs(trailingOnly = TRUE)
url <- args[1]
output_file <- args[2]


# define main function
main <- function() {
  
  data <- read_csv(url)
  write_csv(data, output_file)
  
}

# call main function
main()

