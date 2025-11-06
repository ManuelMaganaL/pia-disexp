# PIA - Diseño de experimentos

## Requisitos

- R >= 4.5. *(latest)*
- shiny 

## Ejecución

Ejecución desde la GUI de R (RGui)
```r
# Desde la RGui instala shiny
install.packages("shiny")

# Una vez instalado, importalo
library(shiny)

# Ejecuta la aplicación usando la ruta a la carpeta con app.R
runApp("C:/Users/manuel/Documentos/pia-disexp/app")
```

Ejecución desde la terminal (debes tener instalada la libreria shiny)
```sh
# Entrar al repositorio
cd pia-disexp

# Ejecutar la aplicación
Rscript ./init.R

# Abrir el enlace del output
http://127.0.0.1:5000
```