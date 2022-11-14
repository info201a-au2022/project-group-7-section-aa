### Use group_by() to create table of aggregate info
data <- read.csv("taxdata.csv")
total_income <- sum(select(data, Adjusted.Gross.Income))
total_taxes <- sum(select(data, Total.taxes.paid.amount))
summary <- data %>% 
  group_by(Adjusted.Size.Gross.Income.Category) %>% 
  summarize("Total Adjusted Gross Income" = 
              sum(Adjusted.Gross.Income),
            "Total Number of Returns Filed" = 
              sum(Number.of.Single.Returns) + 
              sum(Number.of.Head.of.Household.Returns) +
              sum(Number.of.Joint.Returns),
            "Total Taxes Paid" =
              sum(Total.taxes.paid.amount),
            "Percent of Total Adjusted Gross Income Paid in Taxes" =
              (sum(Total.taxes.paid.amount))/(sum(Adjusted.Gross.Income)),
            "Tax Bracket Percent of Overall Total Income" =
              sum(Adjusted.Gross.Income)/total_income)

              
              
