FROM rocker/rstudio AS base

WORKDIR /home/rstudio/project

RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libxml2-dev \
  libssl-dev

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir -p renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN R -e "renv::restore()"

COPY code/ code/
COPY data/ data/
COPY output/ output/
COPY report.Rmd report.Rmd
COPY makefile makefile

