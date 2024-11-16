report.html: code/03_render_report.R \
  report.Rmd table boxplot
	Rscript code/03_render_report.R

output/data_clean.rds: code/00_clean_data.R data/diabetic_data.csv 
	Rscript code/00_clean_data.R
	
table: code/01_make_table.R output/data_clean.rds
	Rscript code/01_make_table.R 

boxplot: code/02_make_boxplot.R output/data_clean.rds
	Rscript code/02_make_boxplot.R
		
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html
	
.PHONY:	install
install:
	Rscript -e "renv::restore(prompt = FALSE)"