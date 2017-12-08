#! /usr/bin/env Rscript
#
# plot_data.R
#
# Bradley Pick Dec. 2017
#
# This script reads in the merged datasets
# summarises and plots the data in an instructuve way.
# 
# Usage: Rscript plot_data.R input_file.csv output_folder
# 
# Depends on readr, ggplot2, and dplyr.

library(readr)
library(dplyr)
library(ggplot2)
library(stringr)


# define arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
out_folder <- args[2]

main <- function() {
  
  ## check which dataset is being read in
  fatal_not_injury <- str_detect(input_file, "fatality")
  
  if (fatal_not_injury) {
    title <- "Fatalities"
    axis <- "fatalities"
    file <- "fatal"
  } else {
    title <- "Injuries"
    axis <- "injuries"
    file <- "injury"
  }
  
  ## read in the dataset from source provided
  data <- read_csv(input_file)
  
  ## plot the incidents and the factors involved
  speed_plot <- data %>% 
    filter(distracted == 'N', drug == 'N') %>% 
    ggplot(aes(x=year)) +
    geom_col(aes(y=speeding_count, fill=speeding)) +
    scale_fill_manual("Speeding\n Involved", 
                      labels = c("No","Yes"), 
                      values = c("wheat4","sienna2")) +
    scale_x_continuous("Year",
                       breaks = 2004:2015) +
    scale_y_continuous(str_c("Number of ", axis)) +
    theme(axis.text.x=element_text(angle=90)) +
    ggtitle(str_c("Number of ", title, " by speed involvement"))
  
  distract_plot <- data %>% 
    filter(speeding == 'N', drug == 'N') %>% 
    ggplot(aes(x=year)) +
    geom_col(aes(y=distracted_count, fill=distracted)) +
    scale_fill_manual("Distraction\n Involved", 
                      labels = c("No","Yes"), 
                      values = c("wheat4","sienna2")) +
    scale_x_continuous("Year",
                       breaks = 2004:2015) +
    scale_y_continuous(str_c("Number of ", axis)) +
    theme(axis.text.x=element_text(angle=90)) +
    ggtitle(str_c("Number of ", title, " by distraction involvement"))
  
  drug_plot <- data %>% 
    filter(speeding == 'N', distracted == 'N') %>% 
    ggplot(aes(x=year)) +
    geom_col(aes(y=drug_count, fill=drug)) +
    scale_fill_manual("Drugs or \n Alcohol\n Involved", 
                      labels = c("No","Yes"), 
                      values = c("wheat4","sienna2")) +
    scale_x_continuous("Year",
                       breaks = 2004:2015) +
    scale_y_continuous(str_c("Number of ", axis)) +
    theme(axis.text.x=element_text(angle=90)) +
    ggtitle(str_c("Number of ", title, " by drug/alcohol involvement"))
  
  png(str_c(out_folder, "/", file, "-speed-plot.png"))
  speed_plot
  ggsave(filename = str_c(file, "-speed-plot.png"), 
         plot = speed_plot, 
         device = "png",
         path = out_folder)
  dev.off()
  png(str_c(out_folder, "/", file, "-distract-plot.png"))
  distract_plot
  ggsave(filename = str_c(file, "-distract-plot.png"), 
         plot = distract_plot, 
         device = "png",
         path = out_folder)
  dev.off()
  png(str_c(out_folder, "/", file, "-drug-plot.png"))
  drug_plot
  ggsave(filename = str_c(file, "-drug-plot.png"), 
         plot = drug_plot, 
         device = "png",
         path = out_folder)
  dev.off()
}

main()
