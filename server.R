
library(shiny)

option_price <- function(u_p,x_p,v,i_r,d,t_e){
         
        v <- v/100     
        i_r <- i_r/100
        d <- d/100
        t_e <- t_e/365
        
        ln_ratio        <- log(u_p/x_p)
        
        numerator_1     <- (i_r - d + v^2/2)*t_e
        denominator_1   <- v * sqrt(t_e)
        
        formula_1       <- (ln_ratio+numerator_1)/denominator_1
        formula_2       <- formula_1- denominator_1
        
        norm_d1         <- pnorm(formula_1,0,1)
        norm_d2         <- pnorm(formula_2,0,1)
        
        norm_neg_d1     <- pnorm(-formula_1,0,1)
        norm_neg_d2     <- pnorm(-formula_2,0,1)
        
        exponents_1_2   <- exp(-i_r*t_e)
        
        X_e_rt          <- x_p * exponents_1_2
        e_qt            <- exp(-d*t_e)
        S0_e_qt         <- u_p*e_qt
        
        Call_option_price       <- round(S0_e_qt * norm_d1 - X_e_rt * norm_d2,digits = 2)
        Put_option_price        <- round(X_e_rt*norm_neg_d2-S0_e_qt*norm_neg_d1, digits = 2)
        option_price            <- c(Call_option_price,Put_option_price)
        return(option_price )
}


function(input, output, session) {
        
        # Return the requested dataset
        newData <- reactive({
                
                c_label <- input$control_label
                
                if (input$submit > 0) {
               myData <- data.frame( 
                       
                 Values = c( 
                          "",
                        input$u_p ,
                        input$x_p,
                        input$v,
                        input$i_r,
                        input$d,
                        input$t_e  ,
                 option_price(input$u_p,input$x_p,input$v,input$i_r,input$d,input$t_e )[1],
                 option_price(input$u_p,input$x_p,input$v,input$i_r,input$d,input$t_e )[2]),
                 Units = c( "", "USD", "USD"," % ", "Annual %", "Annual %", "Days","USD","USD"),
                 
                 row.names = c(c_label,"Underlying Price","Strike Price",
                               "Volitility","Intrest Rate",
                               "Divdend","Experation Date", "Call Price","Put Price"))
              
        
               return(list(myData=myData))
                }

                
        })
        
        
        output$tbl <- renderTable({
                if (is.null(newData())) {return()}
                print(newData()$myData)
               
        },'include.rownames' = TRUE
        , 'include.colnames' = TRUE
        , 'sanitize.text.function' = function(x){x}
        ) 


}
        


