#load packages: dplyr, tidyr, stringr
if (!require(tidyr)) {
  install.packages("tidyr")
  library(tidyr)
}

if (!require(dplyr)) {
  install.packages("dplyr")
  library(dplyr)
}

#Load refine_original.csv into RStudio.
refine_original <- read.csv("refine_original.csv")
#change company to lowercase
tolower(refine_original$company)
#create a new column 'company_new' with the new lowercase values 
refine_original$company_new = tolower(refine_original$company)
#realized i didn't need the column, so deleted company_new
refine_original$company_new = NULL
#check the column names in refine_original
names(refine_original)

#using mutate Clean up company column change all to lowercase and transform values to be philips, akzo, van houten and unilever
refine_original <- refine_original %>%
  mutate(company = tolower(company),
         company = ifelse(str_sub(company, 1, 1) %in% c('p','f'),'phillips',
                           ifelse(str_sub(company, 1, 1) == 'a', 'akzo',
                                  ifelse(str_sub(company, 1, 1) == 'v', 'van houten',
                                         ifelse(str_sub(company, 1, 1) == 'u', 'unilever', 'other'
                                                ))))
           )

#using separate to split 'Product.code...number' into product_code and product_number
refine_original <- refine_original %>%
 separate(Product.code...number, c("product_code","product_number"), sep = "-")
   
  
#create a data frame for products
product_code <- c('p','v','x','q')
product <- c('Smartphone', 'TV', 'Laptop', 'Tablet')
df_products <- data.frame(product_code, product)

#join the refine_original with df_product
refine_original <- refine_original %>% 
  merge(df_products, by="product_code")

#create new column with full address by using unite()
refine_original <- unite(refine_original, 'full_add', address, city, country, sep = ",")

#create new column with full address by using paste()
#refine_original <- refine_original %>%
#  mutate(Full_address = paste('address', 'city', 'country', sep = ","))


#using unite to 
unite(refine_original,"full_address", address, city, country, sep = ",")
