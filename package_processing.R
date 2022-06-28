
library(jsonlite); library(dplyr)


packages <- read.csv("packages.csv") %>% filter(include == "TRUE") %>% 
  select(package, github) %>% rename(url = "github") %>% 
  mutate_all(., trimws, which = "both") %>% distinct() %>% 
  filter(grepl("git", url)) 

pkg_no_cran <- filter(packages, !grepl("github.com/cran", url))

if(nrow(pkg_no_cran) > 100) {
  pkg100 <- slice_sample(pkg_no_cran, n=100, replace = FALSE)
  } else {pkg100 <- pkg_no_cran}


#package_json <- toJSON(packages)
write_json(pkg100, "packages.json", pretty = TRUE)

