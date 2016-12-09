#
# 
#

library(shiny)
# Define UI for dataset viewer application
fluidPage(
        # Application title.
        titlePanel("Option Pricer"),
        sidebarLayout(
                sidebarPanel(
                        h4("Input Information"),
                        textInput("control_label", "Stock Name:", "Tesla"),
                                
                        numericInput("u_p", "Underlying Price: [USD]",
                                             min = 1, max = 500, value = 186.80, step = 0.10),
                        numericInput("x_p", "Option Strike Price:[USD}",
                                             min = .25, max = 500, value = 180, step = 0.25),
                       
                        sliderInput("v",
                                    "Volitility: % ",
                                    min = 0, max = 100, value = 15),
                        #numericInput("v", "Volitility: % ",
                        #                     min = 1, max = 100, value = 10.5100, step = 0.01),
                        
                        
                        numericInput("i_r", "Intrest Rate: % ",
                                             min = 0, max = 100, value = 1.0000, step = 0.01),
                        numericInput("d", "Dividend: % ",
                                             min = 0, max = 100, value = 1.0000, step = 0.01),
                        numericInput("t_e", "Time till Expire: [Days]",
                                     min = 1, max = 365, value = 30, step = 1),       
                        
                        actionButton("submit","Start"),
                        
                      #  dateInput("t_e", "Experation Date:", value = Sys.Date()+10),
                
                        helpText("Note: Press Start and move the slide bar to see the effects of volitility on Option Prices")
                      
                      
                        
                ),
                
                mainPanel(
                        
                       
                        uiOutput('tbl')
                       # DT::dataTableOutput('tbl')
                                        )  
        )
)
     
        
       


#########################################################################################
                
                