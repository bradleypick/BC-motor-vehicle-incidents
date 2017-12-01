# Makefile to generate the BC motor vehicle data analysis project
#
# Bradley Pick Dec 2017
#
# Usage: make all
#		(from the root directory of project)

all: results/fatality.csv results/injury.csv

# merge and write fatality data into data folder
results/fatality.csv: src/merge_data.R data/fatality_by_user.csv data/fatality_distract.csv data/fatality_speed.csv data/fatality_drug.csv
	Rscript src/merge_data.R data/fatality_by_user.csv data/fatality_distract.csv data/fatality_speed.csv data/fatality_drug.csv results/fatality.csv

# merge and write injury data into data folder
results/injury.csv: src/merge_data.R data/injury_by_user.csv data/injury_distract.csv data/injury_speed.csv data/injury_drug.csv
	Rscript src/merge_data.R data/injury_by_user.csv data/injury_distract.csv data/injury_speed.csv data/injury_drug.csv results/injury.csv


clean:
	rm -f results/*.csv
