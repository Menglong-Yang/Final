DOCKER_USERNAME ?= mlyang
DOCKER_IMAGE_TAG ?= finalmy

WORKDIR = $(shell pwd)
REPORT_DIR = $(WORKDIR)/output

docker-build:
	docker build -t $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) .
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG)

docker-run: code/03_render_report.R report.Rmd table boxplot install
	docker run --rm -v $(WORKDIR):/home/rstudio/project $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) Rscript code/03_render_report.R

output/data_clean.rds: code/00_clean_data.R data/diabetic_data.csv
	docker run --rm -v $(WORKDIR):/home/rstudio/project $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) Rscript code/00_clean_data.R

table: code/01_make_table.R output/data_clean.rds
	docker run --rm -v $(WORKDIR):/home/rstudio/project $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) Rscript code/01_make_table.R 

boxplot: code/02_make_boxplot.R output/data_clean.rds
	docker run --rm -v $(WORKDIR):/home/rstudio/project $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) Rscript code/02_make_boxplot.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html

.PHONY: install
install:
	docker run --rm -v $(WORKDIR):/home/rstudio/project $(DOCKER_USERNAME)/$(DOCKER_IMAGE_TAG) Rscript -e "renv::restore(prompt = FALSE)"
