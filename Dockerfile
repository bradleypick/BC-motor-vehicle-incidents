# Docker file for BC-motor-vehicle-incidents
# Bradley Pick, Dec. 2017

# Use rocker/tidyverse as a base image
FROM rocker/tidyverse

# Install ezknitr
RUN Rscript -e "install.packages('ezknitr', repos = 'http://cran.us.r-project.org')"

# Install cowplot
RUN Rscript -e "install.packages('cowplot', repos = 'http://cran.us.r-project.org')"

# Install packrat
RUN Rscript -e "install.packages('packrat', repos = 'http://cran.us.r-project.org')"

# Grab the project off git
# RUN git clone "https://github.com/bradleypick/BC-motor-vehicle-incidents.git"
