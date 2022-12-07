# UI
library(shiny)
library(plotly)
library(shinythemes)

### HOME PAGE
home_panel <- tabPanel(
  title = "Home",
  titlePanel("An Analysis of Taxes in the US"),
  fluidPage(
    img("", src = "https://s.yimg.com/ny/api/res/1.2/1AVjgz.Y0ksYNJ0FYvN91w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTM2MA--/https://media.zenfs.com/en/gobankingrates_644/ec702bc1147bfe76112ce7f39f871388"),
    p(uiOutput('introduction')),
  )
)

### CHART 1 - map of one state with highlightable counties or entire US with states highlighted 
### (info: Name of county, total # returns, total tax payments issued, total income)
# Chart 1 sidebar content - choose a state
chart1_sidebar_content <- sidebarPanel(selectInput(inputId = "map_state",
                                                   label = "Choose a state",
                                                   choices = list("Alabama" = "alabama",
                                                                 "Arizona" = "arizona",
                                                                 "Arkansas" = "arkansas",
                                                                 "California" = "california",
                                                                 "Colorado" = "colorado",
                                                                 "Connecticut" = "connecticut",
                                                                 "Delaware" = "delaware",
                                                                 "Florida" = "florida",
                                                                 "Georgia" = "georgia",
                                                                 "Idaho" = "idaho",
                                                                 "Illinois" = "illinois",
                                                                 "Indiana" = "indiana",
                                                                 "Iowa" = "iowa",
                                                                 "Kansas" = "kansas",
                                                                 "Kentucky" = "kentucky",
                                                                 "Louisiana" = "louisiana",
                                                                 "Maine" = "maine",
                                                                 "Maryland" = "maryland",
                                                                 "Massachusetts" = "massachusetts",
                                                                 "Michigan" = "michigan",
                                                                 "Minnesota" = "minnesota",
                                                                 "Mississippi" = "mississippi",
                                                                 "Missouri" = "missouri",
                                                                 "Montana" = "montana",
                                                                 "Nebraska" = "nebraska",
                                                                 "Nevada" = "nevada",
                                                                 "New Hampshire" = "new hampshire",
                                                                 "New Jersey" = "new jersey",
                                                                 "New Mexico" = "new mexico",
                                                                 "New York" = "new york",
                                                                 "North Carolina" = "north carolina",
                                                                 "North Dakota" = "north dakota",
                                                                 "Ohio" = "ohio",
                                                                 "Oklahoma" = "oklahoma",
                                                                 "Oregon" = "oregon",
                                                                 "Pennsylvania" = "pennsylvania",
                                                                 "Rhode Island" = "rhode island",
                                                                 "South Carolina" = "south carolina",
                                                                 "South Dakota" = "south dakota",
                                                                 "Tennessee" = "tennessee",
                                                                 "Texas" = "texas",
                                                                 "Utah" = "utah",
                                                                 "Vermont" = "vermont",
                                                                 "Virginia" = "virginia",
                                                                 "Washington" = "washington",
                                                                 "West Virginia" = "west virginia",
                                                                 "Wisconsin" = "wisconsin",
                                                                 "Wyoming" = "wyoming"),
                                                   selected = "washington"),
                                       selectInput(inputId = "map_val",
                                                   label = "Choose a quantity",
                                                   choices = list("Total income" = "total.income.amount",
                                                                  "Total itemized deductions" = "total.itemized.deductions.amount",
                                                                  "Number of returns" = "total.number.of.returns",
                                                                  "Proportion of income taxed" = "proportion.of.income.taxed",
                                                                  "Proportion of taxable income" = "proportion.of.taxable.income",
                                                                  "Proportion of income not from wages" = "proportion.of.income.not.from.wages"),
                                                   selected = "total.income.amount"))
# Chart 1 main content
chart1_main_content <- mainPanel(plotlyOutput("chart1"))

# Chart 1 page
chart1_panel <- tabPanel(
  title = "State Map",
  titlePanel("Choropleth Map of State Tax Information by County"),
  p("Write summary paragraph. Lorem ipsum dolor 
     sit amet, consectetur adipiscing elit, sed do 
     eiusmod tempor incididunt ut labore et dolore 
     magna aliqua. Ut enim ad minim veniam, quis 
     nostrud exercitation ullamco laboris nisi ut 
     aliquip ex ea commodo consequat. Duis aute 
     irure dolor in reprehenderit in voluptate velit 
     esse cillum dolore eu fugiat nulla pariatur. 
     Excepteur sint occaecat cupidatat non proident, 
     sunt in culpa qui officia deserunt mollit anim 
     id est laborum."),
  sidebarLayout(
    chart1_sidebar_content,
    chart1_main_content
  )
)

### CHART 2 - bar chart to compare taxes paid per bracket 
# Chart 2 sidebar content. select two states to compare or select "USA"
chart2_sidebar_content <- sidebarPanel(
  selectInput(inputId = "first_state_chart_2",
              label = "Choose a State",
              selected = "Louisiana",
              choice = state.name),
  selectInput(inputId = "second_state_chart_2",
              label = "Choose Another State",
              selected = "Washington",
              choice = state.name))
# Chart 2 main content
chart2_main_content <- mainPanel(plotlyOutput("chart2"),
                                 p("This visualization looks at the amount of tax that 
                                   the IRS charges to different tax brackets in 
                                   different states. We can easily compare any two
                                   states with this graph. 
                                   
                                   We believe that those
                                   in the lowest tax bracket should not be subject
                                   to high tax rates. As tax bracket increases,
                                   earners should pay more percent of their income
                                   in taxes. This is a fundamental rule of tax 
                                   brackets and is the reason why federal income
                                   tax rates increase as income increases. However,
                                   this is not how taxes in the US seem to be distributed
                                   in practice. The lower tax bracket should be charged 
                                   the least percent of their income, but those earners actually have
                                   almost the same tax burden as the top earners in some states. "))

# Chart 2 page
chart2_panel <- tabPanel(
  title = "Taxes by Bracket",
  titlePanel("Assessment of Taxes by Bracket in US States"),
  sidebarLayout(
    chart2_sidebar_content,
    chart2_main_content
  )
)

### CHART 3 - income on the x axis and deductions on the y axis
# Chart 3 sidebar content - choose income range, choose a state?
chart3_sidebar_content <- sidebarPanel(selectInput(inputId = "plot_state",
                                                   label = "Choose a state",
                                                   choices = list("Alabama" = "alabama",
                                                                  "Arizona" = "arizona",
                                                                  "Arkansas" = "arkansas",
                                                                  "California" = "california",
                                                                  "Colorado" = "colorado",
                                                                  "Connecticut" = "connecticut",
                                                                  "Delaware" = "delaware",
                                                                  "Florida" = "florida",
                                                                  "Georgia" = "georgia",
                                                                  "Idaho" = "idaho",
                                                                  "Illinois" = "illinois",
                                                                  "Indiana" = "indiana",
                                                                  "Iowa" = "iowa",
                                                                  "Kansas" = "kansas",
                                                                  "Kentucky" = "kentucky",
                                                                  "Louisiana" = "louisiana",
                                                                  "Maine" = "maine",
                                                                  "Maryland" = "maryland",
                                                                  "Massachusetts" = "massachusetts",
                                                                  "Michigan" = "michigan",
                                                                  "Minnesota" = "minnesota",
                                                                  "Mississippi" = "mississippi",
                                                                  "Missouri" = "missouri",
                                                                  "Montana" = "montana",
                                                                  "Nebraska" = "nebraska",
                                                                  "Nevada" = "nevada",
                                                                  "New Hampshire" = "new hampshire",
                                                                  "New Jersey" = "new jersey",
                                                                  "New Mexico" = "new mexico",
                                                                  "New York" = "new york",
                                                                  "North Carolina" = "north carolina",
                                                                  "North Dakota" = "north dakota",
                                                                  "Ohio" = "ohio",
                                                                  "Oklahoma" = "oklahoma",
                                                                  "Oregon" = "oregon",
                                                                  "Pennsylvania" = "pennsylvania",
                                                                  "Rhode Island" = "rhode island",
                                                                  "South Carolina" = "south carolina",
                                                                  "South Dakota" = "south dakota",
                                                                  "Tennessee" = "tennessee",
                                                                  "Texas" = "texas",
                                                                  "Utah" = "utah",
                                                                  "Vermont" = "vermont",
                                                                  "Virginia" = "virginia",
                                                                  "Washington" = "washington",
                                                                  "West Virginia" = "west virginia",
                                                                  "Wisconsin" = "wisconsin",
                                                                  "Wyoming" = "wyoming"),
                                                   selected = "washington"),
                                       selectInput(inputId = "plot_var",
                                                   label = "Choose a quantity",
                                                   choices = list("Total itemized deductions" = "Total.itemized.deductions.amount",
                                                                  "Number of returns" = "Total.number.of.returns",
                                                                  "Income not from wages" = "Income.not.from.wages.amount",
                                                                  "Proportion of income taxed" = "Proportion.of.income.taxed",
                                                                  "Proportion of taxable income" = "Proportion.of.taxable.income",
                                                                  "Proportion of income not from wages" = "Proportion.of.income.not.from.wages")))
# Chart 3 main content
chart3_main_content <- mainPanel(plotlyOutput("chart3"))

# Chart 3 page
chart3_panel <- tabPanel(
  title = "Scatter Plot",
  titlePanel("Scatter Plot by Total Income"),
  p("Write summary paragraph. Lorem ipsum dolor 
     sit amet, consectetur adipiscing elit, sed do 
     eiusmod tempor incididunt ut labore et dolore 
     magna aliqua. Ut enim ad minim veniam, quis 
     nostrud exercitation ullamco laboris nisi ut 
     aliquip ex ea commodo consequat. Duis aute 
     irure dolor in reprehenderit in voluptate velit 
     esse cillum dolore eu fugiat nulla pariatur. 
     Excepteur sint occaecat cupidatat non proident, 
     sunt in culpa qui officia deserunt mollit anim 
     id est laborum."),
  sidebarLayout(
    chart3_sidebar_content,
    chart3_main_content
  )
)

### SUMMARY PAGE
summary_panel <- tabPanel(
  title = "Summary",
  titlePanel("Our Findings"),
  fluidPage(
    p("We find that high earners are using the capital gains 
      tax laws to pay less tax on their income. This law is much more exploitable for high earners
      who have the capital to fund portfolio investments. This is one of the most significant ways 
      that wealthy individuals continue to become wealthier. This is an extremely relevant topic right now, 
      as Joe Biden has proposed to raise the maximum capital gains tax from 20% to 39.6%. Therefore, for the highest bracket, 
      capital gains will be effectively taxed as ordinary income. This will decrease the efficacy of 
      this tax evasion strategy and promote equal paying of taxes."),
    p("We also conclude that the tax system in the US does not provide enough benefits to the lower
      class and furthers the cycle of poverty. The majority of the US is filing with income under $25,000, 
      highlighting the high number of low earners in the US. Next, we look at total adjusted gross income. 
      This is a metric that the IRS uses to calculate taxes by making slight adjustments to the total gross income. 
      Interestingly, the AGI from tax bracket 2 is more than 3 and 4, suggesting that the middle class is shrinking. 
      Unsurpsiringly, high earners in tax bracket 5 make up 37.09% of the total income in the US, while the lowest 
      earners in bracket 1 (which make up almost 6x more returns) only account for 5.19% of income. 
      Another statistic we can look at is tax payments. High earners (bracket 5) are paying upwards of 52.83% of total US taxes, 
      almost 1 trillion US dollars. While the lowest earners only comprise 5.28% of total tax payments, they are still burdened 
      with a 15.79% effective tax rate.")
  )
)

### REPORT PAGE
report_panel <- tabPanel(
  title = "Report",
  titlePanel("Report"),
  fluidPage(
    p(
      uiOutput('report')
)
  )
)

ui <- navbarPage("Taxes",
                  home_panel,
                  chart1_panel,
                  chart2_panel,
                  chart3_panel,
                  summary_panel,
                  report_panel,
                  theme = shinytheme("yeti")) # temporary theme