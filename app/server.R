library(shiny)
library(bslib)

server <- function(input, output, session) {
  
  # Reactive: Datos para regresión lineal
  regression_data <- reactive({
    req(input$xvar, input$yvar)
    
    datos <- mtcars
    datos$x <- datos[[input$xvar]]
    datos$y <- datos[[input$yvar]]
    
    return(datos)
  })
  
  # Reactive: Modelo lineal
  linear_model <- reactive({
    datos <- regression_data()
    lm(y ~ x, data = datos)
  })
  
  # Output: Gráfico de regresión lineal
  output$lmPlot <- renderPlot({
    datos <- regression_data()
    modelo <- linear_model()
    
    # Configuración del gráfico
    par(mar = c(4, 4, 2, 1))
    
    # Gráfico base
    plot(
      datos$x, datos$y,
      main = paste("Regresión lineal:", input$yvar, "vs", input$xvar),
      xlab = input$xvar,
      ylab = input$yvar,
      pch = 19,
      col = input$pointColor,
      cex = input$pointSize,
      bg = "white"
    )
    
    # Línea de regresión
    if (input$showLine) {
      abline(modelo, col = "red", lwd = 2)
    }
    
    # Intervalo de confianza
    if (input$showConfidence) {
      newx <- seq(min(datos$x), max(datos$x), length.out = 100)
      pred <- predict(modelo, newdata = data.frame(x = newx), 
                     interval = "confidence")
      lines(newx, pred[, "lwr"], col = "orange", lty = 2)
      lines(newx, pred[, "upr"], col = "orange", lty = 2)
    }
    
    # Residuos
    if (input$showResiduals) {
      segments(datos$x, datos$y, datos$x, fitted(modelo), 
              col = "gray", lty = 2)
    }
    
    # Leyenda
    legend_items <- c("Datos")
    legend_colors <- c(input$pointColor)
    
    if (input$showLine) {
      legend_items <- c(legend_items, "Línea de regresión")
      legend_colors <- c(legend_colors, "red")
    }
    
    if (input$showConfidence) {
      legend_items <- c(legend_items, "Intervalo confianza")
      legend_colors <- c(legend_colors, "orange")
    }
    
    legend("topright", legend = legend_items, 
           col = legend_colors, pch = c(19, NA, NA), 
           lty = c(NA, 1, 2), bty = "n")
  })
  
  # Output: Resumen del modelo
  output$modelSummary <- renderPrint({
    modelo <- linear_model()
    summary(modelo)
  })
  
  # Output: Métricas del modelo
  output$modelMetrics <- renderTable({
    modelo <- linear_model()
    datos <- regression_data()
    
    r_squared <- summary(modelo)$r.squared
    adj_r_squared <- summary(modelo)$adj.r.squared
    rmse <- sqrt(mean(residuals(modelo)^2))
    
    data.frame(
      Métrica = c("R²", "R² Ajustado", "RMSE"),
      Valor = round(c(r_squared, adj_r_squared, rmse), 4)
    )
  }, bordered = TRUE, striped = TRUE)
  
  # Output: Tabla resumen en introducción
  output$tabla_resumen <- renderTable({
    data.frame(
      Característica = c("Número de observaciones", "Número de variables", 
                        "Año de recolección", "Origen"),
      Valor = c(nrow(mtcars), ncol(mtcars), "1974", "Motor Trend US")
    )
  }, bordered = TRUE)
}