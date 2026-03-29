library(shiny)
library(ggplot2)
library(bslib) # Para que se vea moderno sin esfuerzo
install.packages('rsconnect')
rsconnect::setAccountInfo(name='jotabusconi',
                          token='2BF357F3B929A1C29D2B67D2DA44A009',
                          secret='OqqqvH6Km4vtErraUcojwxldVcmXqanbohymSMpH')

# Interfaz de Usuario (UI)
ui <- page_sidebar(
  title = "Dashboard de Salud Mental y People Analytics",
  
  sidebar = sidebar(
    title = "Filtros de Análisis",
    selectInput("var_genero", "Seleccionar Género:", 
                choices = c("Todos", unique(as.character(df_master$genero_norm)))),
    helpText("Ajuste los parámetros para actualizar las visualizaciones.")
  ),
  
  # Diseño de tarjetas para los gráficos
  layout_column_wrap(
    width = 1/2, # Divide la pantalla en dos columnas
    card(
      card_header("Distribución Etaria"),
      plotOutput("plot_edad")
    ),
    card(
      card_header("Composición por Género"),
      plotOutput("plot_genero")
    )
  ),
  
  card(
    card_header("Análisis de Asociación (Depresión y Género)"),
    plotOutput("plot_boxplot")
  )
)

# Lógica del Servidor (Server)
server <- function(input, output) {
  
  # Filtrado de datos reactivo
  data_filtrada <- reactive({
    if (input$var_genero == "Todos") {
      df_master
    } else {
      df_master[df_master$genero_norm == input$var_genero, ]
    }
  })
  
  # Gráfico 1: Densidad de Edad
  output$plot_edad <- renderPlot({
    ggplot(data_filtrada(), aes(x = edad)) +
      geom_histogram(aes(y = ..density..), fill = "steelblue", color = "white", alpha = 0.7) +
      geom_density(color = "darkblue", size = 1) +
      theme_minimal() +
      labs(x = "Edad", y = "Densidad")
  })
  
  # Gráfico 2: Composición Género
  output$plot_genero <- renderPlot({
    ggplot(data_filtrada(), aes(x = genero_norm, fill = genero_norm)) +
      geom_bar() +
      scale_fill_manual(values = c("Varon" = "#87CEEB", "Mujer" = "#FFC0CB", 
                                   "No binario" = "#BA55D3", "Otro" = "#D3D3D3")) +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # Gráfico 3: Boxplot Edad por Género
  output$plot_boxplot <- renderPlot({
    ggplot(data_filtrada(), aes(x = genero_norm, y = edad, fill = genero_norm)) +
      geom_boxplot(alpha = 0.7) +
      scale_fill_manual(values = c("Varon" = "#87CEEB", "Mujer" = "#FFC0CB", 
                                   "No binario" = "#BA55D3", "Otro" = "#D3D3D3")) +
      theme_minimal() +
      theme(legend.position = "none")
  })
}

# Ejecutar la App
shinyApp(ui = ui, server = server)