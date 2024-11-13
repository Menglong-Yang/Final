library(tidyr)
library(dplyr)

here::i_am(
  "code/01_make_table.R"
)

dat_clean <- readRDS(
  here::here("output/dat_clean.rds")
)

summary_table <- dat_clean %>%
  summarise(
    `Age` = paste0(round(mean(age_numeric, na.rm = TRUE), 2), " (", round(sd(age_numeric, na.rm = TRUE), 2), ")"),
    `Length of Stay` = paste0(round(mean(time_in_hospital, na.rm = TRUE), 2), " (", round(sd(time_in_hospital, na.rm = TRUE), 2), ")"),
    `Number of Medications` = paste0(round(mean(num_medications, na.rm = TRUE), 2), " (", round(sd(num_medications, na.rm = TRUE), 2), ")"),
    `Number of Procedures` = paste0(round(mean(num_procedures, na.rm = TRUE), 2), " (", round(sd(num_procedures, na.rm = TRUE), 2), ")"),
    
    # Gender frequency and percentage
    `Gender` = paste0(' '),
    `Male` = paste0(sum(gender == "Male", na.rm = TRUE), " (", round(sum(gender == "Male", na.rm = TRUE) / n() * 100, 2), "%)"),
    `Female` = paste0(sum(gender == "Female", na.rm = TRUE), " (", round(sum(gender == "Female", na.rm = TRUE) / n() * 100, 2), "%)"),
    
    # Race frequency and percentage
    `Race` = paste0(' '),
    `Caucasian` = paste0(sum(race == "Caucasian", na.rm = TRUE), " (", round(sum(race == "Caucasian", na.rm = TRUE) / n() * 100, 2), "%)"),
    `African American` = paste0(sum(race == "AfricanAmerican", na.rm = TRUE), " (", round(sum(race == "AfricanAmerican", na.rm = TRUE) / n() * 100, 2), "%)"),
    `Hispanic` = paste0(sum(race == "Hispanic", na.rm = TRUE), " (", round(sum(race == "Hispanic", na.rm = TRUE) / n() * 100, 2), "%)"),
    `Asian` = paste0(sum(race == "Asian", na.rm = TRUE), " (", round(sum(race == "Asian", na.rm = TRUE) / n() * 100, 2), "%)"),
    `Other` = paste0(sum(race == "Other", na.rm = TRUE), " (", round(sum(race == "Other", na.rm = TRUE) / n() * 100, 2), "%)")
  )

# Convert table to portrait format
table1 <- summary_table %>%
  pivot_longer(cols = everything(), names_to = "Demographics", values_to = "Value")

saveRDS(
  table1,
  file = here::here("output", "table1.rds")
)
