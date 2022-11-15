### Find summary info for dynamic paragraph
library(tidyverse)
df <- read.csv("../data/taxdata.csv")
# tax_returns.R 
# A source file that takes in a dataset and returns a list of info about it:
tax_returns <- list()
tax_returns$num_observations <- nrow(df)
tax_returns$num_features <- ncol(df)
tax_returns$num_zipcodes <- unique(df$Zip.Code) %>% 
  length()
tax_returns$numstates <- unique(df$State) %>% 
  length()
tax_returns$numoftotalreturns <- sum(df$Number.of.Single.Returns) + 
  sum(df$Number.of.Head.of.Household.Returns) + 
  sum(df$Number.of.Joint.Returns)
