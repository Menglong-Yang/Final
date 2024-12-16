docker-build:
	docker build -t mlyang/finalmy .

output/dat_clean.rds: code/00_clean_data.R data/diabetic_data.csv
	Rscript code/00_clean_data.R

output/table1.rds: code/01_make_table.R output/dat_clean.rds
	Rscript code/01_make_table.R

output/boxplot.png: code/02_make_boxplot.R output/dat_clean.rds
	Rscript code/02_make_boxplot.R
	
report.html: output/table1.rds output/boxplot.png report.Rmd
	Rscript code/03_render_report.R && mv report.html report

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f report/*.html

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

docker-run:
	docker run -v "/$$(pwd)"/report:/home/rstudio/project/report mlyang/finalmy