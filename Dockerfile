FROM rocker/rstudio:4.4.1 AS base

WORKDIR /home/rstudio/project

RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libxml2-dev \
  libssl-dev

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir -p renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN R -e "renv::restore()"

RUN mkdir -p /home/rstudio/project/code /home/rstudio/project/output /home/rstudio/project/data
COPY code/ /home/rstudio/project/code
COPY data/ /home/rstudio/project/data
COPY output/ /home/rstudio/project/output
COPY report/ /home/rstudio/project/report
COPY makefile report.Rmd /home/rstudio/project/

RUN apt-get update && apt-get install -y \
    pandoc \
    pandoc-citeproc \
    && apt-get clean

CMD ["make", "report.html"]