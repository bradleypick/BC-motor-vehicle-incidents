# Makefile to generate the BC motor vehicle data analysis project
#
# Bradley Pick Dec 2017
#
# Usage: make all
#		(from the root directory of project)

all: results/motor_vehicle_incident_analysis.md results/data/fatality.csv results/data/injury.csv results/img/fatal-speed-plot.png results/img/fatal-distract-plot.png results/img/fatal-drug-plot.png results/img/injury-speed-plot.png results/img/injury-distract-plot.png results/img/injury-drug-plot.png

## rules to download raw data
data/fatality_by_user.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/546debd7-1f13-40fb-9153-07b25b3cc01b/resource/834a8f81-9ac4-4ab9-9b1b-0c76452afe70/download/motor-vehicle-fatalities-by-road-user-type.csv" ./data/fatality_by_user.csv

data/fatality_distract.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/bf653fa6-4651-416b-8991-045fb8a3da49/resource/18d1772b-3596-490b-9079-7ef4f565a8c3/download/motor-vehicle-fatalities-with-distraction-involvement.csv" ./data/fatality_distract.csv

data/fatality_speed.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/23937c1c-f1e0-497c-a34f-c2c6ce15e775/resource/de1b175c-2725-403a-ba33-6b57f868f38e/download/motor-vehicle-fatalities-with-speeding-involvement.csv" ./data/fatality_speed.csv

data/fatality_drug.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/459c4ded-4687-485e-aa10-f957fabefdd1/resource/b7d71c80-81d3-4c6f-a913-9d68f3c49d8e/download/motor-vehicle-fatalities-with-alcohol-and-or-drug-involvement.csv" ./data/fatality_drug.csv

data/injury_by_user.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/aa55daf2-34f3-4f67-bcdb-d0ca57e0c5c4/resource/c0ffaff2-01f8-4d99-a534-98c7f00a3ea5/download/motor-vehicle-serious-injuries-by-road-user-type.csv" ./data/injury_by_user.csv

data/injury_distract.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/91d4f3e3-3c16-4f22-bb09-aafd0350659f/resource/00039030-21fb-4441-986c-03cb35d2f852/download/motor-vehicle-serious-injuries-with-distraction-involvement.csv" ./data/injury_distract.csv

data/injury_speed.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/eb4e998f-3d1b-4257-a591-91e863344f0d/resource/9036364a-bce3-4d11-8ff2-a640ff533df6/download/motor-vehicle-serious-injuries-with-speeding-involvement.csv" ./data/injury_speed.csv

data/injury_drug.csv:
	Rscript src/download_data.R "https://catalogue.data.gov.bc.ca/dataset/e87b3585-c195-4ee4-b531-a919262816ce/resource/28076ae1-0db2-48c3-a750-75498fe0357f/download/motor-vehicle-serious-injuries-with-alcohol-and-or-drug-involvement.csv" ./data/injury_drug.csv


# merge and write fatality data into data folder
results/data/fatality.csv: src/merge_data.R data/fatality_by_user.csv data/fatality_distract.csv data/fatality_speed.csv data/fatality_drug.csv
	Rscript src/merge_data.R data/fatality_by_user.csv data/fatality_distract.csv data/fatality_speed.csv data/fatality_drug.csv ./results/data/fatality.csv

# merge and write injury data into data folder
results/data/injury.csv: src/merge_data.R data/injury_by_user.csv data/injury_distract.csv data/injury_speed.csv data/injury_drug.csv
	Rscript src/merge_data.R data/injury_by_user.csv data/injury_distract.csv data/injury_speed.csv data/injury_drug.csv ./results/data/injury.csv


# plot the fatality data
results/img/fatal-speed-plot.png: src/plot_data.R results/data/fatality.csv
	Rscript src/plot_data.R results/data/fatality.csv ./results/img

results/img/fatal-drug-plot.png: src/plot_data.R results/data/fatality.csv
	Rscript src/plot_data.R results/data/fatality.csv ./results/img

results/img/fatal-distract-plot.png: src/plot_data.R results/data/fatality.csv
	Rscript src/plot_data.R results/data/fatality.csv ./results/img


# plot the injury data
results/img/injury-speed-plot.png: src/plot_data.R results/data/injury.csv
	Rscript src/plot_data.R results/data/injury.csv ./results/img

results/img/injury-drug-plot.png: src/plot_data.R results/data/injury.csv
	Rscript src/plot_data.R results/data/injury.csv ./results/img

results/img/injury-distract-plot.png: src/plot_data.R results/data/injury.csv
	Rscript src/plot_data.R results/data/injury.csv ./results/img

results/motor_vehicle_incident_analysis.md: src/motor_vehicle_incident_analysis.Rmd results/img/injury-speed-plot.png results/img/injury-distract-plot.png results/img/injury-drug-plot.png results/img/fatal-speed-plot.png results/img/fatal-distract-plot.png results/img/fatal-drug-plot.png
	Rscript -e 'ezknitr::ezknit("src/motor_vehicle_incident_analysis.Rmd", out_dir = "results")'


clean:
	rm -f results/*.csv
	rm -f results/data/*.csv
	rm -f results/img/*.png
	rm -f data/*.csv
