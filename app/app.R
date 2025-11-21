# app.R
require(shiny)
require(bslib)
require(readr)

# Cargar componentes
source("app/ui.R")
source("app/server.R")

# Ejecutar aplicación
runApp(shinyApp(ui = ui, server = server))