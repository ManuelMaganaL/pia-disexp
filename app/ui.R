library(shiny)
library(bslib)

theme <- bs_theme(
  version = 5,
  bg = "#f8f9fa",
  fg = "#212529",
  primary = "#2c3e50",
  secondary = "#3498db",
  success = "#27ae60",
  info = "#2980b9",
  warning = "#f39c12",
  danger = "#e74c3c",
  base_font = font_google("Inter"),
  heading_font = font_google("Roboto"),
  "border-radius" = "0.5rem",
  "card-border-width" = "1px",
  "card-border-color" = "#dee2e6"
)

ui <- navbarPage(
  title = div(
    style = "display: flex; align-items: center;",
    icon("chart-line", class = "me-2"),
    span("PIA Equipo #5", style = "font-weight: 600;")
  ),
  theme = theme,
  selected = "Introducción",
  
  tabPanel(
    "Introducción",
    icon = icon("house"),
    fluidRow(
      column(
        width = 8, offset = 2,
        card(
          card_header(
            "Aplicación de Análisis Estadístico",
            style = "background: linear-gradient(135deg, #2c3e50, #3498db); color: white;"
          ),
          div(
            style = "padding: 20px;",
            p(
              "Esta aplicación explora diferentes conceptos estadísticos utilizando el dataset mtcars de R.",
              style = "font-size: 1.1em; line-height: 1.6;"
            ),
            hr(style = "border-top: 2px solid #3498db;"),
            
            
            h4("Integrantes del Equipo", 
               style = "color: #2c3e50; margin-bottom: 15px;"),
            tags$table(
              class = "table table-bordered table-striped",
              style = "width: 100%; font-size: 1em; margin-bottom: 20px;",
              tags$thead(
                tags$tr(
                  tags$th(style = "background-color: #2c3e50; color: white; padding: 12px;", "Nombre"),
                  tags$th(style = "background-color: #2c3e50; color: white; padding: 12px;", "Matrícula"),
                  tags$th(style = "background-color: #2c3e50; color: white; padding: 12px;", "P.E.")
                )
              ),
              tags$tbody(
                tags$tr(
                  tags$td(style = "padding: 10px;", "Bustamante Proa Cristian Isaac"),
                  tags$td(style = "padding: 10px;", "1952302"),
                  tags$td(style = "padding: 10px;", "ITS")
                ),
                tags$tr(
                  tags$td(style = "padding: 10px;", "Chaire Urbieta Montserrat"),
                  tags$td(style = "padding: 10px;", "2121239"), 
                  tags$td(style = "padding: 10px;", "ITS")
                ),
                tags$tr(
                  tags$td(style = "padding: 10px;", "Magana Lopez Manuel"),
                  tags$td(style = "padding: 10px;", "2177988"),
                  tags$td(style = "padding: 10px;", "ITS")
                ),
                tags$tr(
                  tags$td(style = "padding: 10px;", "Espinosa Almaguer Emmanuel Gerard"),
                  tags$td(style = "padding: 10px;", "2043930"),
                  tags$td(style = "padding: 10px;", "ITS")
                )
              )
            ),
            
            h4("Características del dataset mtcars:", 
               style = "color: #2c3e50; margin-bottom: 15px;"),
            tableOutput("tabla_resumen"),
            hr(style = "border-top: 2px solid #3498db;"),
            div(
              style = "background: #e8f4fc; padding: 15px; border-radius: 8px; border-left: 4px solid #3498db;",
              p("Selecciona las diferentes pestañas para explorar los análisis disponibles.",
                style = "margin: 0; font-style: italic;")
            )
          )
        )
      )
    )
  ),
  
  tabPanel(
    "Regresión Lineal",
    icon = icon("chart-line"),
    page_sidebar(
      sidebar = sidebar(
        width = 300,
        style = "background-color: #f8f9fa;",
        h4("Configuración del Modelo", 
           style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;"),
        
        selectInput("xvar", "Variable Predictora (X):", 
                   choices = names(mtcars), 
                   selected = "wt"),
        
        selectInput("yvar", "Variable Respuesta (Y):", 
                   choices = names(mtcars), 
                   selected = "mpg"),
        
        hr(style = "border-top: 1px solid #dee2e6;"),
        
        h5("Opciones de Visualización", 
           style = "color: #2c3e50; margin-top: 15px;"),
        
        div(
          style = "background: white; padding: 10px; border-radius: 5px; border: 1px solid #dee2e6;",
          checkboxInput("showLine", "Línea de regresión", value = TRUE),
          checkboxInput("showConfidence", "Intervalo de confianza", value = FALSE),
          checkboxInput("showResiduals", "Mostrar residuos", value = FALSE)
        ),
        
        div(
          style = "margin-top: 15px;",
          sliderInput("pointSize", "Tamaño de puntos:", 
                     min = 1, max = 5, value = 3, step = 0.5),
          
          selectInput("pointColor", "Color de puntos:",
                     choices = c("🔵 Azul" = "blue", 
                                "🔴 Rojo" = "red", 
                                "🟢 Verde" = "green", 
                                "⚫ Negro" = "black"))
        )
      ),
      
      layout_columns(
        col_widths = c(8, 4, 4),
        card(
          card_header(
            "Gráfico de Regresión Lineal",
            style = "background-color: #2c3e50; color: white;"
          ),
          plotOutput("lmPlot", height = 400),
          style = "border: 1px solid #dee2e6; box-shadow: 0 2px 4px rgba(0,0,0,0.1);"
        ),
        
        card(
          card_header(
            "Resumen del Modelo",
            style = "background-color: #3498db; color: white;"
          ),
          verbatimTextOutput("modelSummary"),
          style = "border: 1px solid #dee2e6;"
        ),
        
        card(
          card_header(
            "Métricas del Modelo",
            style = "background-color: #27ae60; color: white;"
          ),
          tableOutput("modelMetrics"),
          style = "border: 1px solid #dee2e6;"
        )
      )
    )
  ),
  
  tabPanel(
    "Análisis Exploratorio",
    icon = icon("magnifying-glass-chart"),
    fluidRow(
      column(
        width = 10, offset = 1,
        card(
          card_header("Análisis Exploratorio de Datos"),
          div(
            style = "text-align: center; padding: 40px;",
            icon("gears", style = "font-size: 48px; color: #3498db; margin-bottom: 20px;"),
            h3("Próximamente...", style = "color: #2c3e50;"),
            p("Esta sección estará disponible en la próxima actualización",
              style = "font-size: 1.1em; color: #7f8c8d;")
          )
        )
      )
    )
  )
)