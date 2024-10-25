library(shiny)
library(DT)
library(lubridate)
library(shinycssloaders)

source("keywords.R")
source("script.R")
source("global.R")

# Define UI for application that draws a table
ui <- fluidPage(
  # Application title
  titlePanel("Loughborough University Para/Disability Sport Research"),
  p(paste("Keywords used:", paste(keywords, collapse = ", ")), style = "font-size: 14px;"),
  
  p("To cite this item:"),
  p("Skelly, Lara (2024). Loughborough University Para/Disability Sport Research. Loughborough University. Online resource. ",
    a("https://doi.org/10.17028/rd.lboro.27302403", href = "https://doi.org/10.17028/rd.lboro.27302403", target = "_blank")
  ),
  

  # Input control for start date
  sidebarPanel(
    dateInput("start_date", "Start Date:", value = as.Date(paste0(format(Sys.Date(), "%Y"), "-01-01")), max = Sys.Date()),# Restrict date input
    dateInput("end_date", "End Date:", value = Sys.Date(), max = Sys.Date()),
    actionButton("go_button", "Go") # Add the Go button
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

server <- function(input, output, session) {
  # Define a reactive value to store the fetched data
  fetched_data <- reactiveVal(NULL)
  loading <- reactiveVal(FALSE)  # Reactive value to track loading state
  
  # Function to fetch API data when "Go" button is pressed
  observeEvent(input$go_button, {
    # Set loading to TRUE to show the spinner
    loading(TRUE)
    
    # Clear fetched_data to hide the table initially
    fetched_data(NULL)
    
    # Fetch data and update fetched_data when done
    start_date <- input$start_date
    end_date <- input$end_date
    fetched_data(fetch_api_data(start_date, end_date))
    
    # Set loading to FALSE to hide the spinner after data is fetched
    loading(FALSE)
  })
  
  # Render the table only when fetched_data is available
  output$citations_table <- renderDT({
    req(fetched_data())  # Show the table only if data is available
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
  
  # Show the spinner while loading
  outputOptions(output, "citations_table", suspendWhenHidden = FALSE)  # Prevents table from rendering while loading
}

# Run the application 
shinyApp(ui = ui, server = server)