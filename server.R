
library(shiny)
shinyServer(
    function(input, output){
        #Render cities
        output$cityControls <- renderUI({
            cities <- unique(df[df$State==input$state,'City'])
            selectInput("city", label = h3("City"),
                        choices = setNames(cities,cities),
                        selected = 1)
        })
        #Show Hospitals
        hospital<-reactive({
            rankhospital(input$city,input$state,input$symptom)
        })
        output$table <- renderDataTable(hospital(),
            options = list(
            pageLength = 5)
        )
    }
)
