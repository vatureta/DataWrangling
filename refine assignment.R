refine_original <- read.csv("refine_original.csv")
refine_original$company
tolower(refine_original$company)
view(refine_original)
refine_original$company_new = tolower(refine_original$company)
refine_original$company_new = NULL
names(refine_original)
refine_original$company = tolower(refine_original$company)
seperate(refine_original, Product.code...number, c("product_code","product_number"), sep = "-")
library(tidyr)
separate(refine_original, Product.code...number, c("product_code","product_number"), sep = "-")

unite(refine_original,"full_address", address, city, country, sep = ",")
