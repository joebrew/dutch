
library(shiny)

# Source global
source('global.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # Create a counter
  output$counter_text <- renderText({
    x <- input$go
    if(x > 0){
      paste('(',x,')')
    } else {
      ''
    }
    
  })
  
  observe({
    if(is.null(input$go)){
      runjs("
            var click = 0;
            Shiny.onInputChange('go', click)
            var dwnldBtn = document.getElementById('go')
            go.onclick = function() {click += 1; Shiny.onInputChange('go', click)};
            ")      
    }
  })
  # Create a reactive disc number
  disc_number <- reactive({
    # Make disc number include all if blank
    dn <- input$disc_number
    if(is.null(dn) | length(dn) == 0){
      dn <- 1:8
    }
    as.numeric(dn)
  })
  
  # Create a reactive track number
  track_number <- reactive({
    # Make disc number include all if blank
    tn <- input$track_number
    if(is.null(tn) | length(tn) == 0 | nchar(tn) == 0){
      tn <- 1:100
    }
    as.numeric(tn)
  })
  
  # Create a reactive dataset
  sub_data <- reactive({
    subset_data(data = mt,
                disc_number = disc_number(),
                track_number = track_number(),
                to = input$to)
  })
  
  # Create a reactive phrase
  phrase <- eventReactive(input$go, {
    sub_data() %>%
      sample_n(1)
  })
  
  # Create a reactive answer text
  # answer_text <- eventReactive(input$show, {
  #   phrase()$answer
  # })

  output$question_text <- renderText({
    x <- phrase()$question
    if(nchar(x) < 27){
      the_diff <- 27 - nchar(x)
      x <- paste0(x, paste0(rep(' ', the_diff), collapse = ''))
    }
    x
  })
  output$answer_text <- renderText({
    if(input$show_answer){
      x <- phrase()$answer
      if(nchar(x) < 27){
        the_diff <- 27 - nchar(x)
        x <- paste0(x, paste0(rep(' ', the_diff), collapse = ''))
      }
    } else {
      x <- ''
    }
    x
  })
  output$all_data <- renderTable({
    x <- sub_data()
    names(x) <- toupper(names(x))
    x
  })
  
})
