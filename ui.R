#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
navbarPage("Michel Thomas Dutch Practice App",
           theme = shinythemes::shinytheme("flatly"),  
           # Main page
           tabPanel("Practice", 
                    fluidRow(
                      column(2,
                             selectInput('to', 
                                         'Language',
                                          choices = c('English to Dutch' = 'nl',
                                                      'Dutch to English' = 'en')),
                             helpText('Leave the below blank for general practice.'),
                             checkboxGroupInput('disc_number',
                                                'Disc number',
                                                choices = 1:8),
                             textInput('track_number',
                                       'Track number',
                                       value = NULL)),
                      column(10,
                             align='center',
                             fluidRow(
                               actionButton("go", "New phrase"),
                                      checkboxInput('show_answer', 'Show answer',
                                                    value = FALSE)),
                             fluidRow(
                               column(6,
                                      align='left',
                                      # h2(textOutput('delete_me')),
                                      h2(textOutput('question_text'))),
                               column(6,
                                      h2(textOutput('answer_text')))
                             )
                             )
                    )),
           # Other pages
           navbarMenu("More",
                      # Data page
                      tabPanel('Data',
                               fluidRow(
                                 p('Full downloadable dataset', 
                                   a('here', href = 'https://goo.gl/niIXW7')),
                                 tableOutput('all_data')
                               )),
                      # About page
                      tabPanel("About", 
                               "joebrew@gmail.com")
           )
)