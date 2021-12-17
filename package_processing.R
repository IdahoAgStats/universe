
library(stringr); library(jsonlite)

packages <- read.csv("packages.txt")

packages$github <- ifelse(str_detect(packages$url, "github.com/"),
                               packages$url, 
                          file.path("http://github.com/cran", packages$package))

write.csv(packages, "packages.csv")

packages2 <- packages[,-2]
colnames(packages2)[2] <- "url"

#package_json <- toJSON(packages)
                          
write_json(packages2, "packages.json", pretty = TRUE)

