library(shiny)
library(DT)
library(lubridate)
library(shinycssloaders)

source("script.R")
source("global.R")
print(keywords)

# Define UI for application that draws a table
ui <- fluidPage(
  # Application title
  titlePanel("Loughborough University Para/Disability Sport Research"),
  p(paste("Keywords used:", paste(keywords, collapse = ", ")), style = "font-size: 14px;"),
  p("Note that the end date will default to today or a year from the start date 
    if the start date is more than a year ago."),
  
  # Input control for start date
  sidebarPanel(
    dateInput("start_date", "Start Date:", value = Sys.Date() - days(366), max = Sys.Date()) # Restrict date input
  ),
  
  # CSS to set the background color and font size
  tags$head(
    tags$style(HTML("
      body {
        background-color: #FEFAF5;
        font-size: 16px;
      }
      h2 {
        color: #6F3092;
      }
      a {
        color: #6F3092;
      }
    "))
  ),
  
  # Show a table of the column with a spinner
  mainPanel(
    withSpinner(DTOutput("citations_table"), type = 3, color = "#6F3092", color.background = "#FEFAF5")
  )
)

# Define server logic
server <- function(input, output, session) {
  # Define a reactive value to store the fetched data
  fetched_data <- reactiveVal(NULL)
  
  # Function to fetch API data
  observeEvent(input$start_date, {
    start_date <- input$start_date
    fetched_data(fetch_api_data(start_date))
  })
  
  # Render the table when fetched_data is updated
  output$citations_table <- renderDT({
    fetched_df <- fetched_data()
    if (!is.null(fetched_df)) {
      df <- data.frame(Citation = paste0('<a href="', fetched_df$URL, '" target="_blank">', fetched_df$Citation, '</a>'))
      datatable(df, escape = FALSE, options = list(
        dom = 't',
        paging = FALSE,
        searching = FALSE,
        columnDefs = list(list(
          targets = 0,
          render = JS(
            'function(data, type, row, meta) {',
            'return type === "display" ? data : data;', # Prevent escaping HTML
            '}'
          )
        ))
      ))
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)