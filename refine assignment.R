#set working directory
setwd("~/R/DataWranglingTracked/DataWrangling")

#load packages: dplyr, tidyr, stringr
library(tidyr)
library(dplyr)
library(stringr)
#Load refine_original.csv into RStudio.
refine_original <- read.csv("refine_original.csv")
refine_clean <- read.csv("refine_original.csv")

#using mutate Clean up company column change all to lowercase and transform values to be philips, akzo, van houten and unilever
refine_clean <- refine_clean %>%
  mutate(company = tolower(company),
         company = ifelse(str_sub(company, 1, 1) %in% c('p','f'),'phillips',
                          ifelse(str_sub(company, 1, 1) == 'a', 'akzo',
                                 ifelse(str_sub(company, 1, 1) == 'v', 'van houten',
                                        ifelse(str_sub(company, 1, 1) == 'u', 'unilever', 'other'
                                        ))))
  )

#using separate to split 'Product.code...number' into product_code and product_number
refine_clean <- refine_clean %>%
  separate(Product.code...number, c("product_code","product_number"), sep = "-")


#create a data frame for products
product_code <- c('p','v','x','q')
product <- c('Smartphone', 'TV', 'Laptop', 'Tablet')
df_products <- data.frame(product_code, product)

#join the refine_original with df_product
refine_clean <- refine_clean %>% 
  merge(df_products, by="product_code")

#create new column with full address by using unite()
refine_clean <- unite(refine_clean, 'full_add', address, city, country, sep = ",")

#create new column with full address by using paste()
#refine_original <- refine_original %>%
#  mutate(Full_address = paste('address', 'city', 'country', sep = ","))


#using unite to create new column with full address
unite(refine_clean,"full_address", address, city, country, sep = ",")

#creating dummy binary variables for categorical variables 'company' and 'product'
refine_clean <- refine_clean %>%
  mutate(company_philips = ifelse(str_sub(company, 1,1)=='p',1,0),
         company_akzo = ifelse(str_sub(company, 1,1) == 'a',1,0),
         company_van_houten = ifelse(str_sub(company, 1,1) == 'v',1,0),
         company_unilever = ifelse(str_sub(company, 1,1) == 'u', 1,0),
         product_smartphone = ifelse(product_code =='p', 1,0),
         product_tv = ifelse(product_code =='v',1,0),
         product_laptop = ifelse(product_code =='x', 1,0),
         product_tablet = ifelse(product_code == 'q', 1,0)
  )