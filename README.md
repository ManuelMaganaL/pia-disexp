# PIA - Diseño de experimentos

## Requisitos

- R >= 4.5. *(latest)*
- shiny 

## Ejecución

Ejecución desde la GUI de R (RGui)
```r
# Desde la RGui instala shiny, bslib y readr (Requerimientos)
install.packages("shiny")
install.packages("bslib")
install.packages("readr")

# Una vez instalado, importalo
library(shiny)
library(bslib)
library(readr)

# Ejecuta la aplicación desde la terminal de R (debes tener instalados los requerimientos)
dentro de la carpeta del proyecto ejecuta la terminal de R
ejecuta el comando >source("app/app.R")
el intérprete ejecutará la aplicación y dará un output de enlace
  > http://127.0.0.1:5000

para seguir el link se puede copiar y pegar en un navegador o dependiendo el IDE usado se desplegará como una pestaña extra

