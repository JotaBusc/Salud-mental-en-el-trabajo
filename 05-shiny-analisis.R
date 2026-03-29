

library(shiny)
library(ggplot2)
library(bslib)
library(dplyr)

# 1. Carga de datos optimizada
df_binario <- readRDS("df_binario.rds")

# 2. UI con diseño profesional
ui <- page_sidebar(
  title = "Dashboard Estadístico: Género y Depresión",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
  sidebar = sidebar(
    title = "Prueba de Independencia",
    helpText("Este análisis utiliza el Test de Chi-Cuadrado para evaluar la relación entre variables categóricas."),
    hr(),
    uiOutput("alerta_significancia")
  ),
  
  # Estructura de visualización
  layout_columns(
    col_widths = c(6, 6),
    card(
      card_header("Frecuencias Observadas"),
      tableOutput("tabla_obs")
    ),
    card(
      card_header("Frecuencias Esperadas"),
      tableOutput("tabla_exp")
    )
  ),
  
  card(
    card_header("Análisis de Residuos y Test Técnico"),
    layout_columns(
      col_widths = c(4, 8),
      # Estadísticos rápidos
      div(
        h5("Resumen del Test:"),
        uiOutput("stats_texto")
      ),
      # Print técnico que querías mostrar
      verbatimTextOutput("print_tecnico")
    ),
    full_screen = TRUE
  )
)

# 3. Server
server <- function(input, output) {
  
  # Ejecutamos el test (se calcula una sola vez al cargar)
  res_chi <- chisq.test(table(df_binario$genero_norm, df_binario$tiene_depresion))
  
  # Tabla de Observados
  output$tabla_obs <- renderTable({
    as.data.frame.matrix(res_chi$observed)
  }, rownames = TRUE, bordered = TRUE, align = 'c', width = "100%")
  
  # Tabla de Esperados
  output$tabla_exp <- renderTable({
    as.data.frame.matrix(res_chi$expected)
  }, rownames = TRUE, bordered = TRUE, align = 'c', width = "100%")
  
  # Estadísticos en texto
  output$stats_texto <- renderUI({
    tagList(
      p(strong("X-squared: "), round(res_chi$statistic, 4)),
      p(strong("p-value: "), format.pval(res_chi$p.value, digits = 4)),
      p(strong("df: "), res_chi$parameter)
    )
  })
  
  # El print tal cual sale en la consola de R
  output$print_tecnico <- renderPrint({
    print(res_chi)
  })
  
  # Alerta visual en el sidebar según el p-value
  output$alerta_significancia <- renderUI({
    if(res_chi$p.value < 0.05) {
      div(style = "background-color: #d4edda; color: #155724; padding: 15px; border-radius: 10px; border: 1px solid #c3e6cb;",
          strong("✓ Significativo"), br(), "Existe una relación estadística comprobada.")
    } else {
      div(style = "background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 10px; border: 1px solid #f5c6cb;",
          strong("✗ No Significativo"), br(), "No hay evidencia suficiente para afirmar una relación.")
    }
  })
}

shinyApp(ui, server)