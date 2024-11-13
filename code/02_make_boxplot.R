library(here)
library(dplyr)
library(ggplot2)

here::i_am(
  "code/02_make_boxplot.R"
  )

dat_clean <- readRDS(
  here::here("output/dat_clean.rds")
)

# Create the boxplot
boxplot <- ggplot(dat_clean, aes(x = factor(age), y = time_in_hospital)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") + 
  labs(
    title = "Distribution of Length of Stay by Age Groups",
    x = "Age Group",
    y = "Length of Stay"
  ) +
  theme_minimal(base_size = 15) + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"), 
    axis.title.x = element_text(face = "bold"),  
    axis.title.y = element_text(face = "bold") 
  )

ggsave(
  filename = here::here("output/boxplot.png"),
  plot = boxplot,
  device = "png"
)
