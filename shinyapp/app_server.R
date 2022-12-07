# Server
library(tidyverse)
library(plotly)

taxes <- read_csv('../data/taxdata.csv')
zip_to_county <- read_csv('../data/zip_to_county.csv')
st_abbr_to_name <- read_csv('../data/state_abbr_to_name.csv')

# format data for map
taxes <- taxes %>% select(-c(...1, X.1, X))
zip_to_county <- zip_to_county %>%
  mutate(COUNTYNAME = str_to_lower(str_replace(COUNTYNAME,"[:space:]County", ""))) %>%
  select(ZIP, COUNTYNAME)
zip_to_county <- zip_to_county %>% mutate(ZIP = as.numeric(ZIP))
st_abbr_to_name <- st_abbr_to_name %>% mutate(State = str_to_lower(State)) %>%
  select(state_name = State, Code)

df <- taxes %>%
  left_join(zip_to_county, by = c("Zip.Code" = "ZIP")) %>%
  left_join(st_abbr_to_name, by = c("State" = "Code"))

totals_map_df <- df %>% 
  mutate(Total.number.of.returns = Number.of.Single.Returns + Number.of.Joint.Returns + Number.of.Head.of.Household.Returns,
         Income.not.from.wages.amount = Total.Income.Amount - Salaries.and.Wages.Amount) %>%
  group_by(COUNTYNAME, state_name) %>%
  summarise(state_name,
            COUNTYNAME,
            total.income.amount = sum(Total.Income.Amount, na.rm = T),
            total.tax.payments.amount = sum(Total.tax.payments.amount, na.rm = T),
            total.itemized.deductions.amount = sum(Total.itemized.deductions.amount, na.rm = T),
            total.number.of.returns = sum(Total.number.of.returns, na.rm = T),
            taxable.income.amount = sum(Taxable.income.amount, na.rm = T),
            income.not.from.wages.amount = sum(Income.not.from.wages.amount, na.rm = T),
            .groups = "keep") %>%
  distinct()

totals_map_df <- totals_map_df %>%
  mutate(proportion.of.income.taxed = total.tax.payments.amount / total.income.amount,
         proportion.of.taxable.income = taxable.income.amount / total.income.amount,
         proportion.of.income.not.from.wages = income.not.from.wages.amount / total.income.amount) %>%
  mutate(COUNTYNAME = str_replace(COUNTYNAME, "\\.", "")) %>%
  mutate(COUNTYNAME = str_replace(COUNTYNAME, "[:space:]parish", ""))

taxes_w_names <- taxes %>%
  left_join(st_abbr_to_name, by = c("State" = "Code")) %>%
  select(state_name, Total.Income.Amount, Total.itemized.deductions.amount)

# format data for scatterplot
temp_df <- taxes %>% left_join(st_abbr_to_name, by = c("State" = "Code"))

scatter_df <- temp_df %>%
  mutate(Total.number.of.returns = Number.of.Single.Returns + Number.of.Joint.Returns + Number.of.Head.of.Household.Returns,
         Income.not.from.wages.amount = Total.Income.Amount - Salaries.and.Wages.Amount,
         Proportion.of.income.taxed = Total.tax.payments.amount / Total.Income.Amount,
         Proportion.of.taxable.income = Taxable.income.amount / Total.Income.Amount,
         Proportion.of.income.not.from.wages = Income.not.from.wages.amount / Total.Income.Amount
         ) %>%
  select(state_name, 
         Zip.Code,
         Adjusted.Size.Gross.Income.Category,
         Total.Income.Amount,
         Total.itemized.deductions.amount,
         Total.number.of.returns, 
         Income.not.from.wages.amount,
         Proportion.of.income.taxed,
         Proportion.of.taxable.income,
         Proportion.of.income.not.from.wages)

scatter_df <- scatter_df %>%
  filter(Proportion.of.income.not.from.wages >= 0)

scatter_df <- scatter_df %>%
  mutate(Adjusted.Size.Gross.Income.Category = 
           case_when(Adjusted.Size.Gross.Income.Category == "under $25,000" ~ "1. Under $25,000",
                     Adjusted.Size.Gross.Income.Category == "$25,000 to $50,000" ~ "2. $25,000 - $50,000",
                     Adjusted.Size.Gross.Income.Category == "$50,000 to $75,000" ~ "3. $50,000 - $75,000",
                     Adjusted.Size.Gross.Income.Category == "$75,000 to $100,000" ~ "4. $75,000 - $100,000",
                     Adjusted.Size.Gross.Income.Category == "$100,000 to $200,000" ~ "5. $100,000 - $200,000",
                     Adjusted.Size.Gross.Income.Category == "$200,000 or more" ~ "6. $200,000 or more"))

server <- function(input, output) {
### Plot first chart
  output$chart1 <- renderPlotly({
    
    state_shape <- map_data("county") %>% 
      filter(region == input$map_state) %>%
      left_join(totals_map_df, by = c("region" = "state_name", "subregion" = "COUNTYNAME"))
    
    # define a minimalist theme
    blank_theme <- theme_bw() + 
      theme(
        axis.line = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank(), 
        axis.title = element_blank(), 
        plot.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.border = element_blank())
    
    p <- ggplot(state_shape) + geom_polygon(mapping = aes(x = long, 
                                                          y = lat, 
                                                          group = group, 
                                                          fill = !!as.symbol(input$map_val), 
                                                          text = paste0("County: ", str_to_title(subregion))), 
                                            color = "white",
                                            size = .1) +
      coord_map() +
      scale_fill_continuous(low = "#132B43", high = "Red") +
      labs(title = str_to_title(paste0(str_replace_all(input$map_val, "\\.", " "), " in ", input$map_state," by county")),
           fill = str_to_title(paste0(str_replace_all(input$map_val, "\\.", " ")))) +
      blank_theme
    
    pp <- ggplotly(p)
    return(pp)
  })

### Plot second chart
#  output$chart2 <- renderPlotly({
#    return()
#  })
  
### Plot third chart
  output$chart3 <- renderPlotly({
    scatter <- scatter_df %>%
      filter(state_name == input$plot_state)
    
    p <- ggplot(data = scatter, mapping = aes(x = Total.Income.Amount, 
                                              y = !!as.symbol(input$plot_var), 
                                              color = Adjusted.Size.Gross.Income.Category,
                                              text = paste0("Zipcode: ", as.character(Zip.Code)))) +
      geom_point(position="jitter") +
      labs(title = str_to_title(paste0(str_replace_all(input$plot_var, "\\.", ""), " in ", input$plot_state, "by zipcode")),
           x = "Total Income Amount",
           y = "",
           color = "Tax")
    
    pp <- ggplotly(p)
    return(pp)
  })  
}
