
library(jsonlite); library(dplyr)

packages <- read.csv("packages.csv") %>% arrange(package) %>% 
  filter(include == "TRUE") %>% 
  select(package, github, CRAN) %>% rename(url = "github") %>% 
  mutate_all(., trimws, which = "both") %>% distinct() %>% 
  filter(grepl("git", url)) 

pkg_no_cran_gh <- filter(packages, !grepl("github.com/cran", url))

pkg_keep1 <- dplyr::filter(pkg_no_cran_gh, CRAN == FALSE) %>% select(-CRAN)

n_max <- 100  # set by R-universe team (max number of packages in a universe)

if(nrow(pkg_no_cran_gh) > n_max) {
  pkg100 <- pkg_no_cran_gh %>% filter(CRAN == TRUE) %>% select(-CRAN) %>% 
   slice_sample(n = n_max - nrow(pkg_keep1), replace = FALSE) %>% bind_rows(pkg_keep1) %>% 
    arrange(package)
  } else {pkg100 <- pkg_no_cran}


#package_json <- toJSON(packages)
write_json(pkg100, "packages.json", pretty = TRUE)

