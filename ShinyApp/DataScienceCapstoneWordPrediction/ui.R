#
# title: "Capstone Project"
# author: "Amal"
## date: "March 05, 2019"


library(shinythemes)
library(shiny)
library(tm)
library(stringr)
library(markdown)
library(stylo)
  
  
shinyUI(navbarPage("Coursera Data Science Capstone", 
       
       theme = shinytheme("united"),
       
       ## Tab 1 - Prediction
       
       tabPanel("Word Prediction",
                
                tags$head(),
                
                fluidRow(
                  
                  column(3),
                  column(6,
                         tags$div(textInput("inputText", 
                                            label = h3("Enter your text here:"),
                                            value = ),
                                  tags$span(style="color:grey",("Only English words are supported.")),
                                  br(),
                                  tags$hr(),
                                  h4("The predicted next word:"),
                                  tags$span(style="color:darkblue",
                                            tags$strong(tags$h3(textOutput("prediction")))),
                                  tags$span(style="color:grey",textOutput("sentence2")),
                                  br(),
                                  tags$hr(),
                                  h4("What you have entered:"),
                                  tags$em(tags$h4(textOutput("sentence1"))),
                                  align="center")
                  ),
                  column(3)
                )
       ),
       
           ## Tab 2 - About 
       
       tabPanel("About",
                fluidRow(
                  column(2,
                         p("")),
                  column(8,
                         includeMarkdown("About.md")),
                  column(2,
                         p(""))
                )
       )
       
)
)