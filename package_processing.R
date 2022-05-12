
library(jsonlite); library(dplyr)


packages <- read.csv("packages.csv") %>% filter(include == "TRUE") %>% 
  select(package, github) %>% rename(url = "github") %>% 
  mutate_all(., trimws, which = "both") %>% distinct()

#package_json <- toJSON(packages)
write_json(packages, "packages.json", pretty = TRUE)

