#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(mc2d)

set.seed(1981)
# Define UI for application that draws a histogram
shinyUI(navbarPage("My Application",
                   tabPanel("Setup",
                            sidebarPanel(
                              sliderInput("bins",
                                        "Number of bins:",
                                        min = 1,
                                        max = 50,
                                        value = 30),
                              sliderInput("poiPhish_iter",
                                        "Years to Simulate",
                                        min = 1,
                                        max = 10000,
                                        value = 1000),
                              sliderInput("blendedRate",
                                        "Blended Labor Rate ($)",
                                        min = 50,
                                        max = 200,
                                        value = 111),
                              sliderInput("breachCost",
                                        "Cost per Breached Record ($)",
                                        min = 300,
                                        max = 500,
                                        value = 380)
                            )),
                            #mainPanel(
                            #  tableOutput("alePhishTable")
                            #)),
                   tabPanel("Phishing Frequency",
                            sidebarPanel(
                              sliderInput("poiPhish_mean",
                                          "Expected # Phishing Incidents",
                                          min = 1,
                                          max = 500,
                                          value = 250)
                              ),
                            mainPanel(
                              plotOutput("poiPhishPlot")
                            )),
                   tabPanel("Labor Hour Expectations",
                            sidebarPanel(
                              sliderInput("prtLabor_min",
                                          "Minimum Expected Labor Hours",
                                          min = 1,
                                          max = 100,
                                          value = 2),
                              sliderInput("prtLabor_mean",
                                          "Mean Expected Labor Hours",
                                          min = 2,
                                          max = 100,
                                          value = 8),
                              sliderInput("prtLabor_max",
                                          "Maximum Expected Labor Hours",
                                          min = 3,
                                          max = 100,
                                          value = 40),
                              sliderInput("prtLabor_con",
                                          "Labor Hour Estimate Confidence",
                                          min = 1,
                                          max = 10,
                                          value = 4)
                            ),
                            mainPanel(
                              plotOutput("prtLaborPlot")
                            )),
                   tabPanel("Breach Frequency",
                            sidebarPanel(
                              sliderInput("poiBreach_mean",
                                          "Expected Years Between Breaches",
                                          min = 1,
                                          max = 15,
                                          value = 10)
                            ),
                            mainPanel(
                              plotOutput("poiBreachPlot")
                            )),
                   tabPanel("Breach Expectations",
                            sidebarPanel(
                              sliderInput("prtBreach_min",
                                          "Minimum Expected Breach Records",
                                          min = 1,
                                          max = 5000,
                                          value = 500),
                              sliderInput("prtBreach_mean",
                                          "Mean Expected Breach Records",
                                          min = 2,
                                          max = 10000,
                                          value = 3118),
                              sliderInput("prtBreach_max",
                                          "Maximum Expected Breach Records",
                                          min = 3,
                                          max = 5000000,
                                          value = 50000),
                              sliderInput("prtBreach_con",
                                          "Breach Hour Estimate Confidence",
                                          min = 1,
                                          max = 10,
                                          value = 4)
                            ),
                            mainPanel(
                              plotOutput("prtBreachPlot")
                            )),
                   mainPanel(
                       tableOutput("alePhishTable")
                     )
))
