
library(shiny)

# Source global
source('global.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
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
  
  # output$delete_me <- renderText({
  #   paste0('Disc number is ', paste0(disc_number(), collapse = ', '),
  #          '\n',
  #          'Track number is ', paste0(track_number(), collapse = ', '))
  # })
  
  output$question_text <- renderText({
    phrase()$question
  })
  output$answer_text <- renderText({
    if(input$show_answer){
      phrase()$answer
    } else {
      ''
    }
  })
  output$all_data <- renderTable({
    x <- sub_data()
    names(x) <- toupper(names(x))
    x
  })
  
})
