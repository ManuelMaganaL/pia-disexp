library(shiny)
library(bslib)

# Definimos una página de tipo Navbar
ui <- navbarPage("PIA", selected = "Introducción",
  tabPanel("Introducción",
    tags$head(tags$meta(charset = "UTF-8")),  # Para acentos y ñ
    h2("Diseño de Experimento"),
    htmlOutput("tabla_html"),  # Aquí se renderiza la tabla    # Contenido de introducción
    p("Aqui podemos explicar brevemente los temas del PIA"),
    p("Si usamos un mismo dataset para los ejercicios podemos ponerlo aquí"),
  ),

  tabPanel("Regresión Lineal",
    # Contenido de regresión lineal
    page_sidebar(
      sidebar = sidebar(
        p("Elige que columnas de <mtcars> quieres como variables."),
        p("Prueba diferentes configuraciones para ver como cambia el gráfico"),
        selectInput("xvar", "Var X:", choices = names(mtcars), selected = "wt"),
        selectInput("yvar", "Var Y:", choices = names(mtcars), selected = "hp"),
        checkboxInput("showLine", "Mostrar línea de regresión", value = TRUE),
      ),

      # Output: Gráfico de regresión lineal
      card(
        plotOutput(outputId = "lmPlot"),
      ),
    ),
  ),

  tabPanel("Tema 2",
    # Contenido de Tema 2
    "Aquí pondriamos otro tema de la materia"
  ),

  # Podemos seguir agregando mas tabs para otros temas o secciones
  # IDEAS: Referencias, portada (al inicio)
)


# Logica del server
server <- function(input, output) {

   nombres_html <- c( #Agregado recuiente y tabla datos
    "Bustamante Proa Cristian Isaac",
    "Chaire Urbieta Montserrat",
    "Maga&ntilde;a L&oacute;pez Manuel",
    "Espinosa Almaguer Emmanuel Gerard"
  )
  matriculas <- c("1952302", "2121239", "2177988", "2043930")
  carreras <- c("ITS", "ITS", "ITS", "ITS")

  tabla_rows <- paste0(
    "<tr>",
      "<td>", carreras, "</td>",
      "<td>", matriculas, "</td>",
      "<td>", nombres_html, "</td>",
    "</tr>"
  )
  tabla_completa <- paste0(
    "<table border='1' style='border-collapse:collapse; width:60%'>",
      "<thead><tr><th>Carrera</th><th>Matricula</th><th>Nombre</th></tr></thead>",
      "<tbody>", paste(tabla_rows, collapse = ""), "</tbody>",
    "</table>"
  )
  output$tabla_html <- renderUI({
    HTML(tabla_completa)
  })


  # Render del gráfico de regresión lineal
  output$lmPlot <- renderPlot({
    # Variables elegidas
    xvar <- input$xvar
    yvar <- input$yvar

    # Crear dataframe temporal
    datos <- mtcars
    x <- datos[[xvar]]
    y <- datos[[yvar]]

    # Ajuste del modelo lineal
    modelo <- lm(y ~ x)

    # Crear gráfico base
    plot(
      x, y,
      main = paste("Regresión lineal de", yvar, "vs", xvar),
      xlab = xvar,
      ylab = yvar,
      pch = 19, col = "blue"
    )

    # Línea de regresión
    if (input$showLine) {
      abline(modelo, col = "red", lwd = 2)
    }
  })
}

shinyApp(ui = ui, server = server)
