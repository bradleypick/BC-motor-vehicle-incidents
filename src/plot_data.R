#! /usr/bin/env Rscript
#
# plot_data.R
#
# Bradley Pick Dec. 2017
#
# This script reads in the merged datasets
# summarises and plots the data in an instructuve way.
# 
# Usage: Rscript plot_data.R input_file.csv output_file
# 
# Depends on readr, ggplot2, cowplot, stringr, and dplyr.

library(readr)
library(dplyr)
library(ggplot2)
library(cowplot)
library(stringr)
theme_set(theme_bw())


# define arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

main <- function() {
  
  ## extract the incident type for plotting annotation
  input_type <- str_extract(input_file, pattern = "(?<=data/)(.*)(?=\\.)")
  
  ## read in the dataset from source provided
  data <- read_csv(input_file)
  
  ## plot the incidents and the factors involved
  fatal_plot <- data %>% 
    filter(injury_cause == 'N') %>% 
    ggplot(aes(x=year)) +
    geom_col(aes(y=fatality_count, fill=fatality_cause)) +
    scale_fill_manual(str_c("Involved\n", input_type), 
                      labels = c("No","Yes"), 
                      values = c("wheat4","sienna2")) +
    scale_x_continuous("Year",
                       breaks = 2004:2015) +
    scale_y_continuous("Number of Fatalities") +
    theme(axis.text.x=element_text(angle=90)) +
    ggtitle(str_c("Number of Fatalities \nby ", input_type, " involvement"))
  
  injury_plot <- data %>% 
    filter(fatality_cause == 'N') %>% 
    ggplot(aes(x=year)) +
    geom_col(aes(y=injury_count, fill=injury_cause)) +
    scale_fill_manual(str_c("Involved\n", input_type), 
                      labels = c("No","Yes"), 
                      values = c("wheat4","sienna2")) +
    scale_x_continuous("Year",
                       breaks = 2004:2015) +
    scale_y_continuous("Number of Injuries") +
    theme(axis.text.x=element_text(angle=90)) +
    ggtitle(str_c("Number of Injuries \nby ", input_type, " involvement"))
  
  out_plot <- plot_grid(injury_plot, fatal_plot, nrow = 1)
  
  png(output_file)
  ggsave(filename = output_file, 
         plot = out_plot, 
         device = "png",
         width = 6, height = 4,
         dpi = 100)
  dev.off()
  
}

main()

