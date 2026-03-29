library(shiny)
library(ggplot2)
library(bslib)
library(dplyr)
library(tidyr)
library(stringr)
library(scales)

# 1. CARGA DE DATOS
df_master <- read.csv("df_master.csv")

# Preparamos la base para el Gráfico 1 (Frecuencias Absolutas)
df_padecimientos_abs <- df_master %>%
  select(genero_norm, tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt) %>%
  pivot_longer(cols = starts_with("tiene"), 
               names_to = "trastorno", 
               values_to = "respuesta") %>%
  filter(respuesta == "Si") %>%
  mutate(trastorno = str_replace(trastorno, "tiene_", ""))

# 2. INTERFAZ DE USUARIO (UI)
ui <- page_sidebar(
  title = "Análisis Integral de Trastornos por Género",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
  tags$head(
    tags$style(HTML("
      .card { box-shadow: 0 4px 15px rgba(0,0,0,0.1) !important; border-radius: 12px !important; margin-bottom: 15px;}
      .card-header { font-weight: bold; background-color: #f8f9fa; }
    "))
  ),
  
  sidebar = sidebar(
    title = "Controles",
    selectInput("filtro_genero", "Seleccionar Género (Gráfico 1):", 
                choices = c("Todos", unique(as.character(df_padecimientos_abs$genero_norm)))),
    hr(),
    p(strong("Nota sobre Prevalencia:")),
    p("El gráfico inferior muestra todos los géneros para una comparativa total.")
  ),
  
  # Ajustamos col_widths para que el gráfico de abajo tenga espacio
  layout_columns(
    col_widths = c(12),
    
    card(
      card_header("Gráfico 1: Frecuencia Absoluta de Padecimientos Reportados"),
      plotOutput("plot_barras_abs", height = "350px"),
      full_screen = TRUE
    ),
    
    card(
      card_header("Gráfico 2: Prevalencia Relativa por Identidad de Género"),
      # Aumentamos el alto para que no se vea aplastado
      plotOutput("plot_prevalencia_pct", height = "600px"), 
      full_screen = TRUE
    )
  )
)

# 3. LÓGICA DEL SERVIDOR (SERVER)
server <- function(input, output) {
  
  colores_genero <- c(
    "Hombre" = "#87CEEB", 
    "Mujer" = "#FFC0CB", 
    "No-binario" = "#BA55D3", 
    "No especificado" = "#D3D3D3"
  )
  
  # Gráfico 1: Frecuencia Absoluta
  output$plot_barras_abs <- renderPlot({
    df_abs <- if (input$filtro_genero == "Todos") df_padecimientos_abs else df_padecimientos_abs %>% filter(genero_norm == input$filtro_genero)
    
    ggplot(df_abs, aes(x = reorder(trastorno, trastorno, function(x)-length(x)))) + 
      geom_bar(fill = "steelblue", alpha = 0.8) + 
      # vjust un poco más alto y expandimos el eje Y para que no se corten
      geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.8, size = 5, fontface = "bold") +
      scale_y_continuous(expand = expansion(mult = c(0, 0.15))) + # Da un 15% de espacio extra arriba
      labs(title = paste("Conteo de Casos -", input$filtro_genero), x = "Trastorno", y = "Cantidad") +
      theme_minimal() +
      theme(axis.text.x = element_text(size = 12, face = "bold"), panel.grid.major.x = element_blank())
  })
  
  # Gráfico 2: Prevalencia Porcentual (INCLUYENDO TODOS)
  output$plot_prevalencia_pct <- renderPlot({
    df_master %>%
      select(genero_norm, tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt) %>%
      pivot_longer(cols = starts_with("tiene"), names_to = "trastorno", values_to = "presenta") %>%
      mutate(trastorno = str_replace(trastorno, "tiene_", "")) %>%
      group_by(genero_norm, trastorno) %>%
      summarise(
        porcentaje = sum(presenta == "Si", na.rm = TRUE) / n(),
        .groups = "drop"
      ) %>% 
      ggplot(aes(x = genero_norm, y = porcentaje, fill = genero_norm)) +
      geom_col(color = "white", alpha = 0.9) +
      scale_fill_manual(values = colores_genero) +
      geom_text(aes(label = scales::percent(porcentaje, accuracy = 0.1)), 
                vjust = -0.5, size = 3.5, fontface = "bold") +
      # Usamos ncol = 2 para que los gráficos sean más altos y menos anchos
      facet_wrap(~ trastorno, ncol = 2) + 
      scale_y_continuous(labels = scales::percent, limits = c(0, 1.1), expand = expansion(mult = c(0, 0.1))) +
      labs(title = "Prevalencia por Trastorno y Género", x = NULL, y = "Proporción") +
      theme_minimal() +
      theme(
        legend.position = "none",
        strip.text = element_text(size = 12, face = "bold", color = "white"),
        strip.background = element_rect(fill = "#2c3e50"),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10, face = "bold")
      )
  })
}

shinyApp(ui, server)