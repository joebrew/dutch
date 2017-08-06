#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyBS)
navbarPage("Michel Thomas Dutch Practice App",
           theme = shinythemes::shinytheme("flatly"),  
           # Main page
           tabPanel("Practice", 
                    fluidRow(
                      column(10,
                             align='center',
                             fluidRow(
                               actionButton("go", "New phrase"),
                               textOutput('counter_text'),
                               checkboxInput('show_answer', 'Show answer',
                                             value = FALSE)),
                             fluidRow(
                               column(6,
                                      align='left',
                                      h2(textOutput('question_text')),
                                      hr(),
                                      uiOutput("button"),
                                      hr(), br(),br(),br(), hr(), hr()),
                               column(6,
                                      align = 'left',
                                      h2(textOutput('answer_text')),
                                      br())
                             )
                      ),
                      column(2,
                             selectInput('to', 
                                         'Language',
                                          choices = c('English to Dutch' = 'nl',
                                                      'Dutch to English' = 'en')),
                             helpText('Leave the below blank for general practice.'),
                             checkboxGroupInput('disc_number',
                                                'Disc number',
                                                choices = 1:8),
                             sliderInput('track_number',
                                       'Track number',
                                       min = 0, max = 20, value = c(0, 20)))
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