avjit_packages <- installed.packages()
load("//bhalla-desktop/Downloads/R Projects/general/home_packages.rda")
library(tidyverse)
setdiff(home_packages[, "Package"], avjit_packages[, "Package"]) %>% install.packages()


