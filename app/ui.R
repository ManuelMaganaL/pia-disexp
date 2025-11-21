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
  "border-radius" = "0.8rem",
  "card-border-width" = "1px",
  "card-border-color" = "#dee2e6",
  "card-box-shadow" = "0 4px 6px rgba(0,0,0,0.1)"
)

ui <- navbarPage(
  title = div(
    style = "display: flex; align-items: center;",
    icon("rocket", class = "me-2", style = "color: #3498db;"),
    span("STATS EXPLORER", style = "font-weight: 700; color: #2c3e50;")
  ),
  theme = theme,
  selected = "Introducción",
  
  # Modo oscuro/claro
  input_dark_mode(id = "mode", mode = "light"),
  
  # Pestaña de Introducción - Mejorada
  tabPanel(
    "Introducción",
    icon = icon("house-user"),
    fluidRow(
      column(
        width = 10, offset = 1,
        # Card de bienvenida
        card(
          class = "text-center",
          card_header(
            "🚀 Bienvenido a STATS EXPLORER",
            style = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; font-size: 1.5em;"
          ),
          card_body(
            p(
              "Explora el poder del análisis estadístico con esta aplicación interactiva desarrollada en Shiny R.",
              style = "font-size: 1.2em; line-height: 1.6; color: #5a6c7d;"
            ),
            hr(style = "border-top: 2px solid #667eea; width: 50%; margin: 20px auto;"),
            # Features destacados
            fluidRow(
              column(4, div(icon("upload", class = "fa-2x mb-2", style = "color: #3498db;"), h5("Carga Datos"), p("CSV o datasets incluidos"))),
              column(4, div(icon("chart-line", class = "fa-2x mb-2", style = "color: #27ae60;"), h5("Regresión"), p("Análisis lineal completo"))),
              column(4, div(icon("chart-bar", class = "fa-2x mb-2", style = "color: #e67e22;"), h5("ANOVA"), p("Comparación de grupos")))
            )
          )
        ),
        
        # Card del equipo
        card(
          card_header(
            "👥 Nuestro Equipo",
            style = "background: linear-gradient(135deg, #2c3e50, #3498db); color: white;"
          ),
          card_body(
            tags$table(
              class = "table table-hover",
              style = "width: 100%; font-size: 1em;",
              tags$thead(
                tags$tr(
                  tags$th(style = "background-color: #34495e; color: white; padding: 15px; border-radius: 8px 0 0 0;", "Nombre"),
                  tags$th(style = "background-color: #34495e; color: white; padding: 15px;", "Matrícula"),
                  tags$th(style = "background-color: #34495e; color: white; padding: 15px; border-radius: 0 8px 0 0;", "P.E.")
                )
              ),
              tags$tbody(
                tags$tr(style = "transition: all 0.3s;", 
                  tags$td(style = "padding: 12px; border-left: 3px solid #3498db;", "Bustamante Proa Cristian Isaac"),
                  tags$td(style = "padding: 12px;", "1952302"),
                  tags$td(style = "padding: 12px;", tags$span("ITS", class = "badge", style = "background-color: #3498db; color: white; padding: 5px 10px; border-radius: 15px;"))
                ),
                tags$tr(style = "transition: all 0.3s;",
                  tags$td(style = "padding: 12px; border-left: 3px solid #e74c3c;", "Chaire Urbieta Montserrat"),
                  tags$td(style = "padding: 12px;", "2121239"),
                  tags$td(style = "padding: 12px;", tags$span("ITS", class = "badge", style = "background-color: #e74c3c; color: white; padding: 5px 10px; border-radius: 15px;"))
                ),
                tags$tr(style = "transition: all 0.3s;",
                  tags$td(style = "padding: 12px; border-left: 3px solid #27ae60;", "Magana Lopez Manuel"),
                  tags$td(style = "padding: 12px;", "2177988"),
                  tags$td(style = "padding: 12px;", tags$span("ITS", class = "badge", style = "background-color: #27ae60; color: white; padding: 5px 10px; border-radius: 15px;"))
                ),
                tags$tr(style = "transition: all 0.3s;",
                  tags$td(style = "padding: 12px; border-left: 3px solid #f39c12;", "Espinosa Almaguer Emmanuel Gerard"),
                  tags$td(style = "padding: 12px;", "2043930"),
                  tags$td(style = "padding: 12px;", tags$span("ITS", class = "badge", style = "background-color: #f39c12; color: white; padding: 5px 10px; border-radius: 15px;"))
                )
              )
            )
          )
        ),
        
        # Card de instrucciones
        card(
          style = "background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%); border: none;",
          card_body(
            h4("🎯 ¿Cómo empezar?", style = "color: #2c3e50;"),
            tags$ol(
              style = "font-size: 1.1em; color: #5a6c7d;",
              tags$li("Ve a la pestaña 'Carga de datos' para seleccionar tu dataset"),
              tags$li("Explora 'Regresión Lineal' para análisis de correlación"),
              tags$li("Usa 'ANOVA + Tukey' para comparar grupos estadísticamente"),
              tags$li("¡Experimenta con diferentes variables y configuraciones!")
            )
          )
        )
      )
    )
  ),
  
  # Pestaña de Carga de datos - Mejorada
  tabPanel(
    "Carga de datos",
    icon = icon("database"),
    page_sidebar(
      sidebar = sidebar(
        width = 350,
        style = "background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);",
        h4("📁 Fuente de Datos", 
           style = "color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 15px;"),
        
        # Selector de dataset con mejor diseño
        card(
          style = "background: white; border: 2px dashed #dee2e6;",
          card_body(
            checkboxInput("use_mtcars", 
                         label = div(icon("car"), " Usar dataset mtcars (por defecto)"), 
                         value = TRUE),
            conditionalPanel(
              condition = "input.use_mtcars == false",
              fileInput("file1", 
                        label = div(icon("file-upload"), " Subir archivo CSV"),
                        accept = c(".csv"),
                        buttonLabel = "Explorar...",
                        placeholder = "Ningún archivo seleccionado")
            )
          )
        ),
        
        # Información del dataset
        conditionalPanel(
          condition = "input.use_mtcars == true",
          card(
            style = "background: #e8f4f8; border-left: 4px solid #3498db;",
            card_body(
              h5("ℹ️ Dataset mtcars", style = "color: #2c3e50; margin-top: 0;"),
              tableOutput("tabla_resumen")
            )
          )
        )
      ),
      
      # Área principal
      card(
        card_header(
          div(icon("table"), " Vista Previa de Datos",
              style = "color: #2c3e50; font-weight: 600;"
          ),
          style = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;"
        ),
        card_body(
          div(style = "overflow-x: auto; border-radius: 8px;", 
              tableOutput("contents")),
          conditionalPanel(
            condition = "input.use_mtcars == false && output.contents",
            div(
              style = "margin-top: 15px; padding: 10px; background: #d4edda; border-radius: 5px; border: 1px solid #c3e6cb;",
              icon("check-circle"), " Archivo cargado exitosamente. Puedes proceder a los análisis."
            )
          )
        )
      )
    )
  ),
  
  # Pestaña de Regresión Lineal - Mejorada
  tabPanel(
    "Regresión Lineal",
    icon = icon("chart-line"),
    page_sidebar(
      sidebar = sidebar(
        width = 320,
        style = "background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);",
        h4("⚙️ Configuración del Modelo", 
           style = "color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 15px;"),
        
        # Selectores de variables
        card(
          style = "background: white;",
          card_body(
            selectInput("xvar", 
                        label = div(icon("arrow-right"), " Variable Predictora (X)"), 
                        choices = names(mtcars), 
                        selected = "wt"),
            selectInput("yvar", 
                        label = div(icon("arrow-left"), " Variable Respuesta (Y)"), 
                        choices = names(mtcars), 
                        selected = "mpg")
          )
        ),
        
        # Opciones de visualización
        card(
          style = "background: white; margin-top: 15px;",
          card_header("🎨 Personalizar Gráfico"),
          card_body(
            checkboxInput("showLine", "Línea de regresión", value = TRUE),
            checkboxInput("showConfidence", "Intervalo de confianza", value = FALSE),
            checkboxInput("showResiduals", "Mostrar residuos", value = FALSE),
            hr(),
            sliderInput("pointSize", "Tamaño de puntos:", 
                       min = 1, max = 5, value = 3, step = 0.5),
            selectInput("pointColor", "Color de puntos:",
                       choices = c("🔵 Azul" = "blue", 
                                  "🔴 Rojo" = "red", 
                                  "🟢 Verde" = "green", 
                                  "🟣 Morado" = "purple",
                                  "🟠 Naranja" = "orange"))
          )
        )
      ),
      
      # Área principal
      layout_columns(
        col_widths = c(12, 6, 6),
        # Gráfico principal
        card(
          height = 500,
          card_header(
            div(icon("scatter-chart"), " Análisis de Regresión Lineal",
                style = "color: white; font-weight: 600;"
            ),
            style = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);"
          ),
          card_body(
            plotOutput("lmPlot", height = "400px"),
            conditionalPanel(
              condition = "input.showConfidence == true",
              div(
                style = "margin-top: 10px; padding: 8px; background: #fff3cd; border-radius: 5px; font-size: 0.9em;",
                icon("info-circle"), " Intervalo de confianza al 95% mostrado"
              )
            )
          )
        ),
        
        # Resumen del modelo
        card(
          card_header(
            div(icon("calculator"), " Resumen del Modelo",
                style = "color: white;"
            ),
            style = "background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);"
          ),
          card_body(
            style = "max-height: 400px; overflow-y: auto;",
            verbatimTextOutput("modelSummary")
          )
        ),
        
        # Métricas del modelo
        card(
          card_header(
            div(icon("chart-bar"), " Métricas del Modelo",
                style = "color: white;"
            ),
            style = "background: linear-gradient(135deg, #27ae60 0%, #2c3e50 100%);"
          ),
          card_body(
            tableOutput("modelMetrics")
          )
        )
      )
    )
  ),
  
  # Pestaña de ANOVA + Tukey - Mejorada
  tabPanel(
    "ANOVA + Tukey",
    icon = icon("chart-bar"),
    page_sidebar(
      sidebar = sidebar(
        width = 320,
        style = "background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);",
        h4("📊 Configuración ANOVA", 
           style = "color: #2c3e50; border-bottom: 3px solid #e67e22; padding-bottom: 15px;"),
        
        card(
          style = "background: white;",
          card_body(
            selectInput("y_anova", 
                        label = div(icon("chart-line"), " Variable Respuesta (Y)"), 
                        choices = names(mtcars), 
                        selected = "mpg"),
            selectInput("factor_anova", 
                        label = div(icon("layer-group"), " Variable Factor (Grupos)"), 
                        choices = names(mtcars), 
                        selected = "cyl"),
            div(
              style = "margin-top: 15px; padding: 10px; background: #e8f4f8; border-radius: 5px;",
              icon("lightbulb"), " La variable factor será convertida a categoría automáticamente."
            )
          )
        )
      ),
      
      # Área principal
      layout_columns(
        col_widths = c(6, 6),
        # Resultados ANOVA
        card(
          card_header(
            div(icon("equals"), " Análisis de Varianza (ANOVA)",
                style = "color: white;"
            ),
            style = "background: linear-gradient(135deg, #1abc9c 0%, #16a085 100%);"
          ),
          card_body(
            style = "max-height: 400px; overflow-y: auto;",
            verbatimTextOutput("anovaSummary")
          )
        ),
        
        # Prueba Tukey
        card(
          card_header(
            div(icon("project-diagram"), " Comparaciones Múltiples (Tukey HSD)",
                style = "color: white;"
            ),
            style = "background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);"
          ),
          card_body(
            style = "max-height: 400px; overflow-y: auto;",
            verbatimTextOutput("tukeySummary")
          )
        )
      )
    )
  )
)