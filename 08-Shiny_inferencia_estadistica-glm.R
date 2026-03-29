
library(shiny)
library(ggplot2)
library(bslib)
library(dplyr)
library(tidyr)
library(vcd)
library(car) 

# 1. CARGA DE DATOS
df_asoc_raw <- read.csv("df_asociacion.csv")

# 2. UI
ui <- page_sidebar(
  title = "Análisis Avanzado de Salud Mental",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#2C3E50"),
  
  sidebar = sidebar(
    title = "Configuración",
    checkboxGroupInput("vars_sel", "Variables para el Heatmap:",
                       choices = colnames(df_asoc_raw),
                       selected = colnames(df_asoc_raw)),
    hr(),
    helpText("El modelo logístico analiza cómo el tratamiento y el diagnóstico predicen la depresión."),
    tags$small("Nota: Se eliminan filas con NA para los cálculos.")
  ),
  
  layout_columns(
    col_widths = c(12, 6, 6),
    
    # --- FILA 1: HEATMAP ---
    card(
      card_header("Asociación de Variables (V de Cramer)"),
      plotOutput("plot_heatmap", height = "500px"),
      full_screen = TRUE
    ),
    
    # --- FILA 2: MODELO LOGÍSTICO ---
    card(
      card_header("Resumen del Modelo Logístico (GLM)"),
      verbatimTextOutput("summary_model"),
      # CAMBIO AQUÍ: Agregamos tags$ antes de small
      tags$small("Fórmula: tiene_depresion ~ busco_tratamiento + diagnostico_profesional")
    ),
    
    # --- FILA 3: VIF (Multicolinealidad) ---
    card(
      card_header("Análisis de Colinealidad (VIF)"),
      tableOutput("tab_vif"),
      helpText("Valores de VIF cercanos a 1 indican que no hay correlación problemática entre las variables predictoras.")
    )
  )
)

# 3. SERVER
server <- function(input, output) {
  
  # Data procesada para cálculos
  df_clean <- reactive({
    df_asoc_raw %>%
      mutate(
        tiene_depresion = as.factor(tiene_depresion),
        busco_tratamiento = as.factor(busco_tratamiento),
        diagnostico_profesional = as.factor(diagnostico_profesional)
      ) %>%
      drop_na(tiene_depresion, busco_tratamiento, diagnostico_profesional)
  })
  
  # --- LÓGICA HEATMAP ---
  output$plot_heatmap <- renderPlot({
    req(length(input$vars_sel) > 1)
    
    datos <- df_asoc_raw %>% select(all_of(input$vars_sel)) %>% drop_na() %>% mutate(across(everything(), as.factor))
    n <- ncol(datos)
    m <- matrix(NA, n, n)
    colnames(m) <- rownames(m) <- colnames(datos)
    
    for (i in 1:n) {
      for (j in 1:n) {
        tab <- table(datos[[i]], datos[[j]])
        m[i,j] <- tryCatch(assocstats(tab)$cramer, error = function(e) 0)
      }
    }
    
    df_plot <- as.data.frame(as.table(m))
    
    ggplot(df_plot, aes(Var1, Var2, fill = Freq)) +
      geom_tile(color = "white") +
      scale_fill_gradient(low = "white", high = "#2C3E50") + 
      geom_text(aes(label = sprintf("%.2f", Freq)), color = ifelse(df_plot$Freq > 0.5, "white", "orange"), fontface = "bold") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(x = NULL, y = NULL, fill = "V de Cramer")
  })
  
  # --- LÓGICA MODELO GLM ---
  modelo <- reactive({
    # Usamos la familia binomial porque la variable dependiente es Si/No
    glm(tiene_depresion ~ busco_tratamiento + diagnostico_profesional, 
        data = df_clean(), family = binomial)
  })
  
  output$summary_model <- renderPrint({
    summary(modelo())
  })
  
  # --- LÓGICA VIF ---
  output$tab_vif <- renderTable({
    # Usamos car:: para forzar el llamado a la librería
    vif_res <- car::vif(modelo()) 
    
    # Convertimos a dataframe para que Shiny lo dibuje bien
    if (is.matrix(vif_res)) {
      # Si el VIF devuelve una matriz (pasa con variables de varios niveles)
      df_vif <- as.data.frame(vif_res)
      df_vif$Variable <- rownames(df_vif)
      df_vif <- df_vif[, c("Variable", "GVIF")] # Tomamos el GVIF que es el estándar
    } else {
      # Si devuelve un vector simple
      df_vif <- data.frame(Variable = names(vif_res), VIF = as.numeric(vif_res))
    }
    df_vif
  }, bordered = TRUE, align = 'c')

}

shinyApp(ui, server)
