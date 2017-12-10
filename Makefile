# Makefile to generate the BC motor vehicle data analysis project
#
# Bradley Pick Dec 2017
#
# Usage: make all
#		(from the root directory of project)

all: doc/motor_vehicle_incident_analysis.md

## rules to download raw data
data/fatality_distract.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/bf653fa6-4651-416b-8991-045fb8a3da49/resource/18d1772b-3596-490b-9079-7ef4f565a8c3/download/motor-vehicle-fatalities-with-distraction-involvement.csv" ./data/fatality_distract.csv

data/fatality_speed.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/23937c1c-f1e0-497c-a34f-c2c6ce15e775/resource/de1b175c-2725-403a-ba33-6b57f868f38e/download/motor-vehicle-fatalities-with-speeding-involvement.csv" ./data/fatality_speed.csv

data/fatality_drug.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/459c4ded-4687-485e-aa10-f957fabefdd1/resource/b7d71c80-81d3-4c6f-a913-9d68f3c49d8e/download/motor-vehicle-fatalities-with-alcohol-and-or-drug-involvement.csv" ./data/fatality_drug.csv

data/injury_distract.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/91d4f3e3-3c16-4f22-bb09-aafd0350659f/resource/00039030-21fb-4441-986c-03cb35d2f852/download/motor-vehicle-serious-injuries-with-distraction-involvement.csv" ./data/injury_distract.csv

data/injury_speed.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/eb4e998f-3d1b-4257-a591-91e863344f0d/resource/9036364a-bce3-4d11-8ff2-a640ff533df6/download/motor-vehicle-serious-injuries-with-speeding-involvement.csv" ./data/injury_speed.csv

data/injury_drug.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/e87b3585-c195-4ee4-b531-a919262816ce/resource/28076ae1-0db2-48c3-a750-75498fe0357f/download/motor-vehicle-serious-injuries-with-alcohol-and-or-drug-involvement.csv" ./data/injury_drug.csv


# merge and write distract data into results/data folder
results/data/distract.csv: src/merge_data.R data/injury_distract.csv data/fatality_distract.csv
	Rscript src/merge_data.R data/injury_distract.csv data/fatality_distract.csv ./results/data/distract.csv

# merge and write speed data into results/data folder
results/data/speed.csv: src/merge_data.R data/injury_speed.csv data/fatality_speed.csv
	Rscript src/merge_data.R data/injury_speed.csv data/fatality_speed.csv ./results/data/speed.csv

# merge and write drug data into results/data folder
results/data/drug.csv: src/merge_data.R data/injury_drug.csv data/fatality_drug.csv
	Rscript src/merge_data.R data/injury_drug.csv data/fatality_drug.csv ./results/data/drug.csv


# plot the data grouped by factor involvement
results/img/distract-plot.png: src/plot_data.R results/data/distract.csv
	Rscript src/plot_data.R results/data/distract.csv ./results/img/distract-plot.png

results/img/speed-plot.png: src/plot_data.R results/data/speed.csv
	Rscript src/plot_data.R results/data/speed.csv ./results/img/speed-plot.png

results/img/drug-plot.png: src/plot_data.R results/data/drug.csv
	Rscript src/plot_data.R results/data/drug.csv ./results/img/drug-plot.png

# summarise data by factor involvement
results/data/distract_summary.csv: src/summarise_data.R results/data/distract.csv
	Rscript src/summarise_data.R results/data/distract.csv results/data/distract_summary.csv

results/data/speed_summary.csv: src/summarise_data.R results/data/speed.csv
	Rscript src/summarise_data.R results/data/speed.csv results/data/speed_summary.csv

results/data/drug_summary.csv: src/summarise_data.R results/data/drug.csv
	Rscript src/summarise_data.R results/data/drug.csv results/data/drug_summary.csv


doc/motor_vehicle_incident_analysis.md: src/motor_vehicle_incident_analysis.Rmd results/img/distract-plot.png results/img/speed-plot.png results/img/drug-plot.png results/data/distract_summary.csv results/data/speed_summary.csv results/data/drug_summary.csv results/data/speed.csv
	Rscript -e 'ezknitr::ezknit("src/motor_vehicle_incident_analysis.Rmd", out_dir = "doc")'


clean:
	rm -f results/*.csv
	rm -f results/data/*.csv
	rm -f results/img/*.png
	rm -f data/*.csv
	rm -f results/motor_vehicle_incident_analysis*
