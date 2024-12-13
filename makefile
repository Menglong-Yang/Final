.PHONY: docker-build
docker-build:
	docker build -t mlyang/finalmy .
	docker push mlyang/finalmy

.PHONY: docker-run
docker-run: output/data_clean.rds table boxplot
	docker run --rm -v "$$(pwd):/home/rstudio/project" mlyang/finalmy Rscript /home/rstudio/project/code/03_render_report.R

output/data_clean.rds: code/00_clean_data.R data/diabetic_data.csv
	docker run --rm -v "/$$(pwd):/home/rstudio/project" mlyang/finalmy Rscript /home/rstudio/project/code/00_clean_data.R

table: code/01_make_table.R output/data_clean.rds
	docker run --rm -v "/$$(pwd):/home/rstudio/project" mlyang/finalmy Rscript /home/rstudio/project/code/01_make_table.R

boxplot: code/02_make_boxplot.R output/data_clean.rds
	docker run --rm -v "/$$(pwd):/home/rstudio/project" mlyang/finalmy Rscript /home/rstudio/project/code/02_make_boxplot.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html
