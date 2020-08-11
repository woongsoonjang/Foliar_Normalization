library(shiny)
library(DT)



function(input, output) {

N_norm <- reactive(ifelse (input$Lab_type==1, input$N_cont, 0.9584*input$N_cont)  )
P_norm <- reactive(ifelse (input$Lab_type==1, 0.9492*input$P_cont, input$P_cont)  )
K_norm <- reactive(ifelse (input$Lab_type==1, 0.1714*(input$K_cont*input$K_cont)+(0.8405*input$K_cont), input$K_cont))
Ca_norm <- reactive(ifelse (input$Lab_type==1, (0.3592*(input$Ca_cont*input$Ca_cont)+0.7346*input$Ca_cont), input$Ca_cont))
Mg_norm <- reactive(ifelse (input$Lab_type==1,(1.0249*input$Mg_cont), input$Mg_cont))
S_norm <- reactive(ifelse (input$Lab_type==1, input$S_cont, (0.9558*input$S_cont)-(0.6267*(input$S_cont*input$S_cont))))
SO4_norm <- reactive(ifelse (input$Lab_type==1, input$SO4_cont, (1.4164*input$SO4_cont)-(0.0008*(input$SO4_cont*input$SO4_cont))))
B_norm <- reactive(ifelse (input$Lab_type==1, input$B_cont, (0.8732*input$B_cont)-(0.0012*(input$B_cont*input$B_cont))))
Cu_norm <- reactive(input$Cu_cont)
Zn_norm <- reactive(input$Zn_cont)
Fe_norm <- reactive(ifelse (input$Lab_type==1, (1.1477*input$Fe_cont), input$Fe_cont))
Mn_norm <- reactive(input$Mn_cont)
SampID <- reactive(input$SampID)
BECID <- reactive(input$BECID)
SPP <- reactive(input$SPP)
Age <- reactive(input$Age)

output.table <- function (){
Norm.values <- round(c(N_norm(), P_norm(), K_norm(), Ca_norm(), Mg_norm(), S_norm(), SO4_norm(), 
                 B_norm(), Cu_norm(), Zn_norm(), Fe_norm(), Mn_norm() ), 3)
Norm.table <- data.frame( Element = c("N (%)", "P (%)", "K (%)", "Ca (%)", "Mg (%)", "S (%)",
                        "SO4 (ppm)", "B (ppm)", "Cu (ppm)", "Zn (ppm)", "Fe (ppm)", "Mn (ppm)"),
              value = Norm.values)
ratio.table <- data.frame (Element = c("N:S", "N:P", "N:K", "N:Ca", "N:Mg"),
                            value = round(c(N_norm()/S_norm(), N_norm()/P_norm(), N_norm()/K_norm(), N_norm()/Ca_norm(), N_norm()/Mg_norm()), 3))

rbind(Norm.table, ratio.table)
}
# 
# ratio.table <- data.frame (Ratios = c("N:S", "N:P", "N:K", "N:Ca", "N:Mg"),
#                            Norm.value = c(N_norm()/S_norm(), N_norm()/P_norm(), N_norm()/K_norm(), N_norm()/Ca_norm(), N_norm()/Mg_norm()))

normal.table <- function(){
  n.table <- 
  n.table
}


output$Output <- renderDT({
  gsth1 <- paste(c("Sample ID: ", SampID()), collapse="\t")
  gsth2 <- paste(c("BEC subzone: ", BECID()), collapse="\t")
  gsth3 <- paste(c("Species: ", SPP()), collapse="\t")
  gsth4 <- paste(c("Stand age: ", Age()), collapse="\t")
  gst.header = htmltools::withTags(table(
    class = 'display',
    thead(
      tr(
        th(colspan = 1, gsth1),
        th(colspan = 1, gsth2)
      ),
      tr(
        th(colspan = 1, gsth3),
        th(colspan = 1, gsth4)
      ),
      tr(
        lapply(c("Element", "Normalized data"), th)
      )  
    )
  )
  )

   datatable(output.table(),
            container =  gst.header , rownames = FALSE, 
            options = list(paging = FALSE, ordering=F, sDom  = '<"top">rt<"bottom">',
                           columnDefs=list(list(targets= '_all', class="dt-right", width = '200px')))
)
})

}
  
  
  
  