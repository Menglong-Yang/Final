library(dplyr)

here::i_am(
  "code/00_clean_data.R"
)

dat <- read.csv(
  here::here("data/diabetic_data.csv")
)

# Transform the age variable to a numeric form
dat_clean <- dat %>%
  mutate(age_numeric = case_when(
    age == "[0-10)" ~ 5,
    age == "[10-20)" ~ 15,
    age == "[20-30)" ~ 25,
    age == "[30-40)" ~ 35,
    age == "[40-50)" ~ 45,
    age == "[50-60)" ~ 55,
    age == "[60-70)" ~ 65,
    age == "[70-80)" ~ 75,
    age == "[80-90)" ~ 85,
    age == "[90-100)" ~ 95
  ))

saveRDS(
  dat_clean,
  file = here::here("output", "dat_clean.rds")
)