FROM rocker/rstudio AS base

WORKDIR /home/rstudio/project

COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir -p renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN R -e "renv::restore()"

COPY data /home/rstudio/project/data/
COPY code /home/rstudio/project/code/
COPY report.Rmd /home/rstudio/project/
COPY makefile /home/rstudio/project/