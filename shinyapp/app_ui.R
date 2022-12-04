# UI
library(shiny)
library(plotly)
library(shinythemes)

### HOME PAGE
home_panel <- tabPanel(
  title = "Home",
  titlePanel("Home Title"),
  fluidPage(
    img("", src = "https://s.yimg.com/ny/api/res/1.2/1AVjgz.Y0ksYNJ0FYvN91w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTM2MA--/https://media.zenfs.com/en/gobankingrates_644/ec702bc1147bfe76112ce7f39f871388"),
    p(" "),
    p("-This page should provide a brief overview of your project: What major 
      questions are you seeking to answer and what data will you use to answer 
      those questions? You should include some \"additional flare\" on this 
      landing page, such as an image."),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
      tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
      eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
      sunt in culpa qui officia deserunt mollit anim id est laborum.")
  )
)

### CHART 1 - map of one state with highlightable counties or entire US with states highlighted 
### (info: Name of county, total # returns, total tax payments issued, total income)
# Chart 1 sidebar content - choose a state
chart1_sidebar_content <- sidebarPanel(selectInput(inputId = "input1",
                                                   label = "*insert text*",
                                                   choice = list("choice 1" = "var1",
                                                                 "choice 2" = "var2")))
# Chart 1 main content
chart1_main_content <- mainPanel(p("Put chart 1 here"),
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
                                   id est laborum."))

# Chart 1 page
chart1_panel <- tabPanel(
  title = "Chart 1",
  titlePanel("This is chart 1"),
  sidebarLayout(
    chart1_sidebar_content,
    chart1_main_content
  )
)

### CHART 2 - bar chart to compare taxes paid per bracket 
# Chart 2 sidebar content. select two states to compare or select "USA"
chart2_sidebar_content <- sidebarPanel(selectInput(inputId = "input2",
                                                   label = "*insert text*",
                                                   choice = list("choice 1" = "var1",
                                                                 "choice 2" = "var2")))
# Chart 2 main content
chart2_main_content <- mainPanel(p("Put chart 2 here"),
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
                                   id est laborum."))

# Chart 2 page
chart2_panel <- tabPanel(
  title = "Chart 2",
  titlePanel("This is chart 2"),
  sidebarLayout(
    chart2_sidebar_content,
    chart2_main_content
  )
)

### CHART 3 - income on the x axis and deductions on the y axis
# Chart 3 sidebar content - choose income range, choose a state?
chart3_sidebar_content <- sidebarPanel(selectInput(inputId = "input3",
                                                   label = "*insert text*",
                                                   choice = list("choice 1" = "var1",
                                                                 "choice 2" = "var2")))
# Chart 3 main content
chart3_main_content <- mainPanel(p("Put chart 3 here"),
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
                                   id est laborum."))

# Chart 3 page
chart3_panel <- tabPanel(
  title = "Chart 3",
  titlePanel("This is chart 3"),
  sidebarLayout(
    chart3_sidebar_content,
    chart3_main_content
  )
)

### SUMMARY PAGE
summary_panel <- tabPanel(
  title = "Summary",
  titlePanel("Summary Title"),
  fluidPage(
    p("-A page that hones in on at least 3 major takeaways from the project 
      (which should be related to a specific aspect of your analysis). Feel free 
      to incorporate tables, graphics, or other elements to convey these conclusions."),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
      tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
      eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
      sunt in culpa qui officia deserunt mollit anim id est laborum.")
  )
)

### REPORT PAGE
report_panel <- tabPanel(
  title = "Report",
  titlePanel("Report Title"),
  fluidPage(
    p("-Iterate on your P01 and P02 to present your final report. Includes 
      findings (new section), discussion  (new section), conclusion (new section), 
      and, if needed, appendices. See P3 rubric."),
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
      tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
      quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
      eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, 
      sunt in culpa qui officia deserunt mollit anim id est laborum.")
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