# Server
library(tidyverse)

taxes <- read_csv('../data/taxdata.csv')

server <- function(input, output) {
### Plot first chart
#  output$chart1 <- renderPlotly({
#    return()
#  })

### Plot second chartinput$first_state_chart_2
  taxes <- taxes %>% 
    mutate(Adjusted.Size.Gross.Income.Category = 
                              case_when(Adjusted.Size.Gross.Income.Category == "under $25,000" ~ "1. Under $25K",
                                        Adjusted.Size.Gross.Income.Category == "$25,000 to $50,000" ~ "2. $25K to $50K",
                                        Adjusted.Size.Gross.Income.Category == "$50,000 to $75,000" ~ "3. $50K to $75K",
                                        Adjusted.Size.Gross.Income.Category == "$75,000 to $100,000" ~ "4. $75K to $100K",
                                        Adjusted.Size.Gross.Income.Category == "$100,000 to $200,000" ~ "5. $100K to $200K",
                                        Adjusted.Size.Gross.Income.Category == "$200,000 or more" ~ "6. $200K or more")) %>% 
    rename("Income.Category" = "Adjusted.Size.Gross.Income.Category")
  output$chart2 <- renderPlotly({
    state1 = (state.abb[match(input$first_state_chart_2, state.name)])
    state2 = (state.abb[match(input$second_state_chart_2, state.name)])
    tax_chart2 <- taxes %>% 
      filter(State %in% c(state1, state2)) %>% 
      group_by(State, Income.Category) %>% 
      summarise(Tax_percent_of_income = 100 * sum(Total.tax.payments.amount)/sum(Total.Income.Amount))
    plot <- ggplot(data = tax_chart2, 
                   mapping = 
                     aes(x = Income.Category, 
                         y = Tax_percent_of_income,
                         fill = State)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      labs(
        x = "Income Category",
        y = "% of Total Income Due in Taxes",
        title = "Tax Payments as a Percentage of Income",
      )
    plot
  })
  
### Plot third chart
#  output$chart2 <- renderPlotly({
#    return()
#  })  
}
