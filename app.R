# this is the file which creates the Shiny app

source("libraries.R")
source("Prep_File.R")

# flatly theme chosen to create the desired clean look with no
# ugly drop shadows or unnecessary graphics

ui <- page_fluid(
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#2c3e50"),
  
  # Top Banner Image (Spans Full Width at Very Top)
  div(
    style = "margin: 0 -15px 20px -15px; padding: 0; overflow: hidden;",
    tags$img(
      src = "banner.jpg", 
      alt = "Fitbit Analytics Dashboard Banner",
      style = "width: 100%; height: auto; max-height: 200px; object-fit: cover; display: block;"
    )
  ),
  
  # Sidebar & Content Layout (Placed Underneath Banner)
  layout_sidebar(
    sidebar = sidebar(
      open = "always",
      selectInput(
        inputId = "selected_award",
        label = NULL,
        choices = c("Calorie Award", "Sleep Award", "Heart Award", "Steps Award"),
        selected = "Calorie Award"
      ),
      # Dynamic Trophy Image Display
      div(
        style = "text-align: center; margin-top: 15px; margin-bottom: 15px;",
        uiOutput("trophy_img")
      )
    ),
    
    
    
    # Main Content Area
    # Winner Announcement Callout
    div(
      # style = "background-color: #f8f9fa; border-left: 4px solid #2c3e50; border-radius: 4px; padding: 12px 20px; margin-bottom: 20px;",
      uiOutput("winner_summary")
    ),
    
    # Dynamic Plot Card
    card(
      style = "border: none; box-shadow: none;",
      # card_header("Performance vs. Dataset Average"),
      plotOutput("award_plot", height = "350px")
    )
  )
)

# ==========================================
# SERVER LOGIC
# ==========================================
server <- function(input, output, session) {
  
  # Reactive mapping for award category
  award_info <- reactive({
    req(input$selected_award)
    
    switch(input$selected_award,
           "Calorie Award" = list(
             id = furnace_id,
             metric = "avg_calories",
             title = "Calorie Award"
           ),
           "Sleep Award" = list(
             id = sleepy_id,
             metric = "avg_sleep_mins",
             title = "Sleep Award"
           ),
           "Heart Award" = list(
             id = lizard_id,
             metric = "min_hr",
             title = "Heart Award"
           ),
           "Steps Award" = list(
             id = ian_id,
             metric = "avg_steps",
             title = "Steps Award"
           )
    )
  })
  
  # Winner Summary Text Output
  output$winner_summary <- renderUI({
    info <- award_info()
    prof <- user_profiles %>% filter(Id == info$id)
    
    text_content <- switch(input$selected_award,
                           "Calorie Award" = sprintf(
                             "The winner of the Calorie Award is %s who burned an average of %s kcal per day across %d days of data.",
                             prof$FullName, format(round(prof$avg_calories, 0), big.mark = ","), prof$days_active
                           ),
                           "Sleep Award" = sprintf(
                             "The winner of the Sleep Award is %s who averaged %s hours of sleep per night across %d recorded nights.",
                             prof$FullName, round(prof$avg_sleep_mins / 60, 1), prof$days_slept
                           ),
                           "Heart Award" = sprintf(
                             "The winner of the Heart Award is %s who had a minimum recorded heart rate of %d bpm across %d hours of recorded data.",
                             prof$FullName, prof$min_hr, prof$total_hr_hours
                           ),
                           "Steps Award" = sprintf(
                             "The winner of the Steps Award is %s who achieved an average of %s steps per day across %d active days.",
                             prof$FullName, format(round(prof$avg_steps, 0), big.mark = ","), prof$days_active
                           )
    )
    
    tags$div(
      style = "font-size: 1.25rem; font-weight: 500; color: #2c3e50; padding: 10px;",
      text_content
    )
  })
  
  # Dynamic Trophy Image Output
  output$trophy_img <- renderUI({
    req(input$selected_award)
    
    img_file <- switch(input$selected_award,
                       "Calorie Award" = "trophy_calorie.png",
                       "Sleep Award"   = "trophy_sleep.png",
                       "Heart Award"   = "trophy_heart.png",
                       "Steps Award"   = "trophy_steps.png"
    )
    
    tags$img(
      src = img_file,
      alt = input$selected_award,
      style = "max-width: 180px; width: 100%; height: auto; display: block; margin: 0 auto;"
    )
  })
  
  # Dynamic ggplot output for each award. Colours selected to match trophy graphics
  output$award_plot <- renderPlot({
    info <- award_info()
    award <- input$selected_award
    
    if (award == "Calorie Award") {
      df <- daily_activity %>% filter(Id == info$id)
      
      ggplot(df, aes(x = Date, y = Calories)) +
        geom_line(color = "#e61ada", linewidth = 1) +
        geom_point(color = "#fe40f3", size = 2) +
        geom_hline(yintercept = global_avg_calories, linetype = "dashed", color = "#2c3e50", linewidth = 1) +
        annotate("text", x = min(df$Date), y = global_avg_calories, label = " Group Average", vjust = -0.7, hjust = 0, color = "#2c3e50", fontface = "bold") +
        theme_minimal(base_size = 14) +
        labs(title = NULL, x = NULL, y = "Calories (kcal)")
      
    } else if (award == "Sleep Award") {
      df <- sleep_day %>% filter(Id == info$id)
      
      ggplot(df, aes(x = Date, y = TotalMinutesAsleep / 60)) +
        geom_col(fill = "#3498db", alpha = 0.85) +
        geom_hline(yintercept = global_avg_sleep, linetype = "dashed", color = "#2c3e50", linewidth = 1) +
        annotate("text", x = min(df$Date), y = global_avg_sleep, label = " Group Average", vjust = -0.7, hjust = 0, color = "#2c3e50", fontface = "bold") +
        theme_minimal(base_size = 14) +
        labs(title = NULL, x = NULL, y = "Daily Sleep (Hours)")
      
    } else if (award == "Heart Award") {
      df <- hr_daily_min %>% filter(Id == info$id)
      
      # Determine a dynamic upper limit with extra padding above the max value/benchmark
      max_val <- max(c(df$daily_min_hr, global_avg_low_hr), na.rm = TRUE) + 10
      
      ggplot(df, aes(x = Date, y = daily_min_hr)) +
        geom_line(color = "#c02121", linewidth = 1) +
        geom_point(color = "#d61919", size = 2) +
        geom_hline(yintercept = global_avg_low_hr, linetype = "dashed", color = "#2c3e50", linewidth = 1) +
        annotate(
          "text", x = min(df$Date), y = global_avg_low_hr, 
          label = " Group Avg Low HR", vjust = -0.7, hjust = 0, 
          color = "#2c3e50", fontface = "bold"
        ) +
        expand_limits(y = max_val) + # <--- Extends Y-axis upward to create breathing room
        theme_minimal(base_size = 14) +
        theme(
          panel.border = element_blank(),
          legend.position = "none"
        ) +
        labs(
          title = NULL, 
          x = NULL, 
          y = "Daily Minimum Heart Rate (BPM)"
        )
      
    } else if (award == "Steps Award") {
      df <- daily_activity %>% filter(Id == info$id)
      
      ggplot(df, aes(x = Date, y = TotalSteps)) +
        geom_line(color = "#f08a1d", linewidth = 1) +
        geom_point(color = "#ff9d33", size = 2) +
        geom_hline(yintercept = global_avg_steps, linetype = "dashed", color = "#2c3e50", linewidth = 1) +
        annotate("text", x = min(df$Date), y = global_avg_steps, label = " Group Average", vjust = -0.7, hjust = 0, color = "#2c3e50", fontface = "bold") +
        theme_minimal(base_size = 14) +
        labs(title = NULL, x = NULL, y = "Daily Steps")
    }
  })
  
  # Audit table (not currently used but could be included if we want to bulk it out)
  output$audit_table <- renderTable({
    winners_audit
  })
}

shinyApp(ui = ui, server = server)