library(shiny)

shinyUI(navbarPage("Best Emergency Hospitals in Town",
    tabPanel('App',
        sidebarLayout(
            sidebarPanel(
                helpText("Enter your symptoms and area to find the best emergency hospitals."),
                selectInput("symptom", label = h3("Symptom"),
                    choices = list("Heart Attack" = "heart attack",
                        "Heart Failure" = "heart failure",
                            "Pneumonia" = "pneumonia"),selected = 1),
               selectInput("state", label = h3("State"),
                choices = setNames(state_names,state_names),
                selected = 1),
               uiOutput('cityControls')
        ),
            mainPanel(
                dataTableOutput('table')
            )
                            )),
    tabPanel('About',includeMarkdown('README.md'))

))
