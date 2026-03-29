library(shiny)
library(ggplot2)
library(bslib)

# 1. Carga de datos
df_master <- read.csv("df_master.csv")

# 2. Interfaz de Usuario (UI)
ui <- page_sidebar(
  title = "Dashboard: Analisis descriptivo de la muestra",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
  # CSS para asegurar visibilidad y estilo premium
  tags$head(
    tags$style(HTML("
      .card {
        box-shadow: 0 4px 15px rgba(0,0,0,0.1) !important;
        border-radius: 12px !important;
        border: 1px solid #e0e0e0 !important;
        margin-bottom: 20px;
      }
      .card-header {
        font-weight: bold;
        background-color: #f8f9fa;
        border-bottom: 1px solid #e0e0e0;
      }
    "))
  ),
  
  sidebar = sidebar(
    title = "Filtros de Análisis",
    selectInput("var_genero", "Seleccionar Género:", 
                choices = c("Todos", unique(as.character(df_master$genero_norm))))
  ),
  
  # Contenedor principal
  layout_columns(
    col_widths = c(6, 6, 12), # Los de arriba 6 y 6, el de abajo 12
    
    card(
      card_header("Distribución Etaria General"),
      plotOutput("plot_edad", height = "300px")
    ),
    
    card(
      card_header("Frecuencias Absolutas por Género"),
      uiOutput("render_genero") 
    ),
    
    # El Boxplot ahora vive en una UI dinámica para controlar su ancho
    uiOutput("contenedor_boxplot")
  )
)

# 3. Servidor
server <- function(input, output) {
  
  data_filtrada <- reactive({
    if (input$var_genero == "Todos") {
      df_master
    } else {
      df_master[df_master$genero_norm == input$var_genero, ]
    }
  })
  
  colores_genero <- c(
    "Hombre"          = "#87CEEB", 
    "Mujer"           = "#FFC0CB", 
    "No-binario"      = "#BA55D3", 
    "No especificado" = "#D3D3D3"
  )
  
  # Gráfico 1: Edad
  output$plot_edad <- renderPlot({
    ggplot(data_filtrada(), aes(x = edad)) +
      geom_histogram(aes(y = after_stat(density)), fill = "steelblue", color = "white", alpha = 0.7) +
      geom_density(color = "darkblue", linewidth = 1) +
      theme_minimal() + labs(x = "Edad", y = "Densidad")
  })
  
  # Gráfico 2: Frecuencias
  output$render_genero <- renderUI({
    if (input$var_genero == "Todos") {
      plotOutput("plot_genero_bar", height = "350px")
    } else {
      div(style = "height: 350px; display: flex; align-items: center; justify-content: center; color: #95a5a6;",
          h5(paste0("Filtrado por: ", input$var_genero)))
    }
  })
  
  output$plot_genero_bar <- renderPlot({
    ggplot(df_master, aes(x = genero_norm, fill = genero_norm)) +
      geom_bar() +
      stat_count(geom = "text", aes(label = after_stat(count)), 
                 vjust = -0.0, size = 3, fontface = "bold") +
      scale_fill_manual(values = colores_genero) +
      theme_minimal() + theme(legend.position = "none") +
      labs(x = "Género", y = "Cantidad")
  })
  
  # Gráfico 3: Boxplot Centrado
  output$contenedor_boxplot <- renderUI({
    # Si es "Todos", ocupa el 100%. Si no, 60% y centrado.
    ancho_css <- if (input$var_genero == "Todos") "100%" else "60%"
    
    div(
      style = paste0("width: ", ancho_css, "; margin: 0 auto;"),
      card(
        card_header("Distribución de Edad (Boxplot)"),
        plotOutput("plot_boxplot_genero", height = "450px") 
      )
    )
  })
  
  output$plot_boxplot_genero <- renderPlot({
    ggplot(data_filtrada(), aes(x = genero_norm, y = edad, fill = genero_norm)) +
      geom_boxplot(alpha = 0.7, outlier.color = "red") +
      scale_fill_manual(values = colores_genero) +
      theme_minimal() + theme(legend.position = "none") +
      labs(x = "Género", y = "Edad (años)")
  })
}

shinyApp(ui, server)