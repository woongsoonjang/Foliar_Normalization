library(shiny)
library(DT)
library(rmarkdown)

navbarPage(title = "Normalization of Laboratory Foliar Nutrient Data",
           tabPanel("Input", 
                    fluidRow(
                      column(3, 
                             wellPanel(
                               textInput("SampID","Sample ID:",NA),
                               textInput("BECID","BEC subzone:",NA),
                               textInput("SPP","Species:",NA),
                               textInput("Age","Stand age:",NA),
                               selectInput(inputId="Lab_type",label="Select Laboratory",
                                           choices = c("Pacific Soil Analysis Inc." =1, 
                                                       "Ministry of Environment" =2),
                                           selected = 1)
                              )
                      ),
                      column(3, 
                             wellPanel(
                               numericInput("N_cont", "N (%)", NA),
                               numericInput("P_cont", "P (%)", NA),
                               numericInput("K_cont", "K (%)", NA),
                               numericInput("Ca_cont", "Ca (%)", NA),
                               numericInput("Mg_cont", "Mg (%)", NA),
                               numericInput("S_cont", "S (%)", NA),
                               numericInput("SO4_cont", "SO4 (ppm)", NA),
                               numericInput("B_cont", "B (ppm)", NA),
                               numericInput("Cu_cont", "Cu (ppm)", NA),
                               numericInput("Zn_cont", "Zn (ppm)", NA),
                               numericInput("Fe_cont", "Fe (ppm)", NA),
                               numericInput("Mn_cont", "Mn (ppm)", NA)
                             )
                      ),
                      column(6, mainPanel(
                        DTOutput("Output")
                      ))
                    )),
           tabPanel("About",
                    fluidRow(
                             column(9,
                                      includeMarkdown("README.md")
                               )
                             )
                    )
           )

                      