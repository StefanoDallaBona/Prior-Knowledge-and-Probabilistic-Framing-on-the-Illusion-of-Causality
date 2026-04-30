rm(list=ls())
##############################################


library(shiny)
library(readr)
library(dplyr)
#INSERT NAME OF THE DATASET TO ANALYZE

#DATAEXP1.csv
#or
#DATAEXP2.csv
sentences <- read_csv("DATAEXP1.csv", show_col_types = FALSE)
if (!"R" %in% names(sentences)) stop("No 'R'") # either "x" or "R" depending on the name of the first column in the file
sentences <- sentences %>%
  mutate(id = row_number(),
         text = R) %>%
  select(id, text)
ui <- fluidPage(
  titlePanel("Participant Reasoning Annotation"),
  fluidRow(
    column(width = 6,
           h3("Current Response"),
           wellPanel(
             textOutput("sentence_text"),
             br(),
             textOutput("progress")
           )
    ),
    column(width = 6,
           h4("Annotation Questions"),
           radioButtons("use_info", 
                        ##############################################
                        "1. Does the participant use information from the trials section?",
                        choices = c("Yes", "No")),
           conditionalPanel(
             condition = "input.use_info == 'Yes'",
             checkboxGroupInput("info_type",
                                "Which information participant use?:",
                                choices = c("a", "b", "c", "d", "Not clear (de-select other options)"))
           ),
           radioButtons("predict_dual",
                        ##############################################
                        "2. Is it possible to predict the Y/N final answer?",
                        choices = c("Yes", "No")),
           conditionalPanel(
             condition = "input.predict_dual == 'Yes'",
             radioButtons("prediction_value",
                          "Prediction:",
                          choices = c("1 (Y)", "0 (N)"))
           ),
           
           radioButtons("deduce_context",
                        ##############################################
                        "3. Is it possible to deduce the cover story used in the task?",
                        choices = c("Yes", "No")),
           
           conditionalPanel(
             condition = "input.deduce_context == 'Yes'",
             radioButtons("context_type",
                          "Specify which one:",
                          choices = c("Medicine condition",
                                      "Alien condition",
                                      "Lever condition"))
           ),
           
           br(),
           actionButton("prev_btn", "← Previous", 
                        class = "btn-warning"),
           actionButton("next_btn", "Next →", 
                        class = "btn-primary"),
           br(), br(),
           actionButton("save_btn", 
                        "Save & Export Data", 
                        class = "btn-success")
    )
  )
)

server <- function(input, output, session) {
    rv <- reactiveValues(
    index = 1,
    results = data.frame(
      id = sentences$id,
      sentence = sentences$text,
      use_info = rep(NA_character_, nrow(sentences)),
      info_type = rep(NA_character_, nrow(sentences)),
      predict_dual = rep(NA_character_, nrow(sentences)),
      prediction_value = rep(NA_character_, nrow(sentences)),
      deduce_context = rep(NA_character_, nrow(sentences)),
      context_type = rep(NA_character_, nrow(sentences)),
      stringsAsFactors = FALSE
    )
  )
  observe({
    if(file.exists("annotation_results.csv")) {
      prev <- read_csv("annotation_results.csv", show_col_types = FALSE)
      cols <- intersect(names(prev), names(rv$results))
      isolate({
        rv$results[cols] <- prev[cols]
      })
    }
  })
    output$sentence_text <- renderText({
    sentences$text[rv$index]
  })
  
  output$progress <- renderText({
    paste("Response", rv$index, "of", nrow(sentences))
  })
    loadCurrent <- function() {
    idx <- rv$index
        use_info_val <- rv$results$use_info[idx]
    if (is.na(use_info_val) || identical(use_info_val, "")) use_info_val <- character(0)
    
    predict_dual_val <- rv$results$predict_dual[idx]
    if (is.na(predict_dual_val) || identical(predict_dual_val, "")) predict_dual_val <- character(0)
    
    deduce_context_val <- rv$results$deduce_context[idx]
    if (is.na(deduce_context_val) || identical(deduce_context_val, "")) deduce_context_val <- character(0)
    
    info_type_val <- character(0)
    if (length(use_info_val) && use_info_val == "Yes" && 
        !is.na(rv$results$info_type[idx]) && rv$results$info_type[idx] != "") {
      info_type_val <- unlist(strsplit(rv$results$info_type[idx], "; "))
    }
    
    prediction_value_val <- character(0)
    if (length(predict_dual_val) && predict_dual_val == "Yes" && 
        !is.na(rv$results$prediction_value[idx]) && rv$results$prediction_value[idx] != "") {
      prediction_value_val <- rv$results$prediction_value[idx]
    }
    
    context_type_val <- character(0)
    if (length(deduce_context_val) && deduce_context_val == "Yes" && 
        !is.na(rv$results$context_type[idx]) && rv$results$context_type[idx] != "") {
      context_type_val <- rv$results$context_type[idx]
    }
    
    updateRadioButtons(session, "use_info", selected = use_info_val)
    updateCheckboxGroupInput(session, "info_type", selected = info_type_val)
    updateRadioButtons(session, "predict_dual", selected = predict_dual_val)
    updateRadioButtons(session, "prediction_value", selected = prediction_value_val)
    updateRadioButtons(session, "deduce_context", selected = deduce_context_val)
    updateRadioButtons(session, "context_type", selected = context_type_val)
  }
  
  saveCurrent <- function() {
    idx <- rv$index
    rv$results$use_info[idx] <- ifelse(is.null(input$use_info), NA_character_, input$use_info)
    rv$results$info_type[idx] <- ifelse(is.null(input$info_type), NA_character_, paste(input$info_type, collapse = "; "))
    rv$results$predict_dual[idx] <- ifelse(is.null(input$predict_dual), NA_character_, input$predict_dual)
    rv$results$prediction_value[idx] <- ifelse(is.null(input$prediction_value), NA_character_, input$prediction_value)
    rv$results$deduce_context[idx] <- ifelse(is.null(input$deduce_context), NA_character_, input$deduce_context)
    rv$results$context_type[idx] <- ifelse(is.null(input$context_type), NA_character_, input$context_type)
    
    write_csv(rv$results, "annotation_results.csv")
  }
  
  observeEvent(input$next_btn, {
    saveCurrent()
    if (rv$index < nrow(sentences)) {
      rv$index <- rv$index + 1
      loadCurrent()
    } else {
      showModal(modalDialog("All responses annotated!", easyClose = TRUE))
    }
  })
  
  observeEvent(input$prev_btn, {
    saveCurrent()
    if (rv$index > 1) {
      rv$index <- rv$index - 1
      loadCurrent()
    }
  })
  
  # salv.manu
  observeEvent(input$save_btn, {
    saveCurrent()
    showModal(modalDialog("Results saved to 'annotation_results.csv'!", easyClose = TRUE))
  })
  
  observe({
    loadCurrent()
  })
}

##############################################
shinyApp(ui, server)
