#ANALISIS DESCRIPTIVO

#Analisis descriptivo de la muestra EDAD y GENERO ----
#HISTOGRAMA EDAD
ggplot(df_master, aes(x = edad)) +
  geom_histogram(aes(y = ..density..), bins = 20, 
                 fill = "steelblue", color = "white", alpha = 0.7) +
  geom_density(color = "blue", size = 1, linetype = "dashed")

#FRECUENCIAS ABSOLUTAS  GENERO 
ggplot(df_master, aes(x = genero_norm, fill = genero_norm)) +
  geom_bar() +
  # Agregamos los números. vjust = 1.5 lo mete un poco adentro de la barra
  stat_count(geom = "text", aes(label = ..count..), 
             vjust = -0.2, color = "black", fontface = "bold", size = 4) +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Composición por Género (Frecuencia Absoluta)",
       subtitle = "N de cada categoría en la muestra",
       x = "Género", y = "Cantidad de personas") +
  theme_minimal() +
  theme(legend.position = "none")

# Análisis del gráfico: Distribución de Edad por Género
# 1. Tendencia Central (Medianas y Medias):
# - La mediana de edad más alta corresponde al grupo "Hombre" (aprox. 33 años), 
#   seguida por "Mujer" (aprox. 32 años) y "No-binario" (aprox. 31 años).
# - El grupo "No especificado" presenta la mediana y media más bajas, en torno 
#   a los 25 años.
# - Los puntos negros (medias) se ubican por encima de la línea de la mediana 
#   en los grupos "Hombre" y "Mujer", indicando una asimetría positiva impulsada 
#   por edades mayores. En "No-binario", la media es levemente inferior a la mediana.
#
# 2. Dispersión (Rango Intercuartílico y Bigotes):
# - "Mujer" es la categoría con mayor amplitud en su caja, evidenciando la mayor 
#   dispersión etaria en el 50% central de la muestra (desde los 27 hasta los 39 años aprox).
# - "Hombre" y "No-binario" presentan niveles de dispersión intermedia en sus cajas.
# - "No especificado" exhibe una dispersión mínima; el rango intercuartílico es muy 
#   estrecho, concentrando casi la totalidad de sus observaciones entre los 24 y 26 años.
#
# 3. Valores Atípicos (Outliers - puntos rojos):
# - La categoría "Hombre" concentra una serie de valores atípicos en el extremo 
#   superior, que van desde aproximadamente los 52 hasta los 59 años.
# - La categoría "Mujer" registra un solo valor atípico visible, cercano a los 59 años.
# - Las categorías "No-binario" y "No especificado" no muestran valores atípicos 
#   en esta visualización.

#BOXPLOT - GENERO Y EDAD
ggplot(df_master, aes(x = genero_norm, y = edad, fill = genero_norm)) +
  geom_boxplot(alpha = 0.7, outlier.colour = "red") +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 3, color = "black") + # Punto para la media
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Distribución de Edad por Género",
    subtitle = "Comparativa de medianas y dispersión etaria",
    x = "Género",
    y = "Edad (años)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


#Analisis descriptivo de la muestra Modalidad de contratacion - INDEPENDIENTES VS CONTRATADOS ----
ggplot(df_master, aes(x = independiente, fill = independiente)) +
  geom_bar() +
  # Etiquetas de frecuencia absoluta arriba de las barras
  stat_count(geom = "text", aes(label = ..count..), vjust = -0.3, fontface = "bold") +
  scale_fill_manual(values = c("NO" = "#5DA5DA", "SI" = "#FAA43A")) +
  labs(title = "Distribución de la Muestra: Independientes vs. Dependientes",
       subtitle = "Frecuencias absolutas (N total)",
       x = "¿Trabaja de forma independiente?",
       y = "Cantidad de personas") +
  theme_minimal() +
  theme(legend.position = "none")

# Filtramos para que NO incluya ni "No especificado" ni "No-binario" (porque distorciona el grafico al tener frecuencias bajas)
ggplot(df_master %>% filter(!genero_norm %in% c("No especificado", "No-binario")), 
       aes(x = edad, fill = genero_norm)) +
  # Usamos densidad con transparencia
  geom_density(alpha = 0.5) +
  # Dividimos por modalidad de trabajo (Independiente SI/NO)
  facet_wrap(~independiente, labeller = label_both) +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Distribución Etaria por Género y Modalidad de Trabajo",
       subtitle = "Comparativa enfocada: Hombre vs. Mujer",
       x = "Edad",
       y = "Densidad",
       fill = "Género") +
  theme_minimal() +
  theme(strip.background = element_rect(fill = "gray90"),
        legend.position = "bottom")

# En este grafico solo incluimos las categorias No Binarios y No especificado 

ggplot(df_master %>% filter(!genero_norm %in% c("Hombre", "Mujer")), 
       aes(x = edad, fill = genero_norm)) +
  # Usamos densidad con transparencia
  geom_density(alpha = 0.5) +
  # Dividimos por modalidad de trabajo (Independiente SI/NO)
  facet_wrap(~independiente, labeller = label_both) +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Distribución Etaria por Género y Modalidad de Trabajo",
       subtitle = "Comparativa enfocada: Hombre vs. Mujer",
       x = "Edad",
       y = "Densidad",
       fill = "Género") +
  theme_minimal() +
  theme(strip.background = element_rect(fill = "gray90"),
        legend.position = "bottom")

# Boxplot: Edad por Género, segmentado por tipo de empleo
ggplot(df_master, aes(x = independiente, y = edad, fill = genero_norm)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red", outlier.shape = 16) +
  # Añadimos los puntos individuales (jitter) para ver la densidad real de personas
  geom_jitter(aes(color = genero_norm), alpha = 0.2, position = position_jitterdodge()) +
  labs(
    title = "Distribución de Edad: Independientes vs. Dependientes",
    subtitle = "Segmentado por identidad de género",
    x = "¿Trabaja de forma independiente?",
    y = "Edad (años)",
    fill = "Género",
    color = "Género"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# 1. Observación General:
# El gráfico muestra que el trabajo dependiente (categoría "NO") concentra a 
# personas de menor edad en comparación con el trabajo independiente (categoría "SI").
# En casi todas las identidades de género, las cajas (que representan el rango 
# intercuartílico) y sus respectivas medianas se ubican más abajo en el eje Y 
# para los trabajadores dependientes.
#
# 2. Detalle por Identidad de Género:
# - Hombres: La mediana de edad en dependientes es de aproximadamente 33 años,
#   mientras que en independientes asciende a los 35 años. La concentración de puntos
#   es notablemente más densa entre los 20 y 35 años en la modalidad dependiente.
# - Mujeres: Muestran la diferencia más pronunciada. La mediana pasa de unos 31 años
#   en dependientes a cerca de 38 años en independientes, y la caja se vuelve
#   significativamente más amplia y elevada en este último grupo.
# - No-binario: Sigue la tendencia general, con una mediana que sube de los 29 años
#   (dependientes) a los 31 años (independientes).
# - No especificado: Es el grupo con menor volumen de datos. Las medianas se
#   mantienen constantes en ambas modalidades, alrededor de los 25 años.
#
# 3. Dispersión y Concentración:
# La nube de puntos superpuesta evidencia una masa laboral joven (20 a 35 años)
# densamente agrupada en la columna de trabajo dependiente ("NO"). En la columna de
# trabajo independiente ("SI"), los puntos se dispersan y se distribuyen en mayor 
# medida hacia el segmento de 35 a 60 años.
#Analisis descriptivo de la muestra Estado clinico----
# Creamos un dataset largo para comparar trastornos
 df_cormorbilidad<- df_master %>%
  select(genero_norm, tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt) %>%
  pivot_longer(cols = starts_with("tiene"), 
               names_to = "trastorno", 
               values_to = "respuesta") %>%
  filter(respuesta == "Si") %>%
  mutate(trastorno = str_replace(trastorno, "tiene_", "")) # Limpiamos el nombre

# Gráfico de barras de frecuencias
ggplot(df_cormorbilidad, aes(x = reorder(trastorno, trastorno, function(x)-length(x)), fill = trastorno)) +
  geom_bar() +
  geom_text(stat='count', aes(label=..count..), vjust=-0.4) +
  labs(title = "Frecuencia de Padecimientos Reportados",
       subtitle = "Basado en diagnósticos y sospechas confirmadas",
       x = "Tipo de Trastorno",
       y = "Cantidad de Casos") +
  theme_minimal() +
  theme(legend.position = "none")

#BOX PLOT CORMOBILIDAD POR GENERO (excluyendo no binario y no especificado)
ggplot(df_master %>% filter(!genero_norm %in% c("No especificado", "No-binario")), 
       aes(x = genero_norm, y = n_trastornos, fill = genero_norm)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", shape = 20, size = 5, color = "red", fill = "red") +
  labs(title = "Índice de Comorbilidad por Género",
       subtitle = "Punto rojo indica el promedio de trastornos por persona",
       x = "Género",
       y = "Número de Trastornos Simultáneos") +
  theme_minimal()

# Análisis del gráfico: Índice de Comorbilidad por Género
#
# 1. Tendencia Central (Medianas y Promedios):
# - La mediana se mantiene constante respecto a los datos crudos: 1 para la 
#   categoría "Mujer" y 0 para "Hombre".
# - Al corregir el tope de trastornos a 4, el promedio (punto rojo) en el 
#   grupo "Mujer" ahora se alinea exactamente con la mediana (1 trastorno).
# - En el grupo "Hombre", el promedio se sitúa un poco por encima del 0.5, 
#   traccionado por la asimetría positiva de la distribución.
#
# 2. Dispersión (Rango Intercuartílico y Bigotes):
# - El grupo "Mujer" exhibe una mayor dispersión en su 50% central 
#   (caja de 0 a 2 trastornos). Su bigote superior se extiende hasta el 
#   límite máximo posible de 4 trastornos.
# - El grupo "Hombre" mantiene una gran concentración de observaciones en 
#   la base (caja de 0 a 1 trastorno), extendiendo su bigote superior solo 
#   hasta los 2 trastornos.
#
# 3. Valores Atípicos (Outliers):
#   Dado que la mayor parte de los hombres se concentra entre 
#   los 0 y 2 trastornos, los casos con 3 y 4 trastornos simultáneos se clasifican 
#   estadísticamente como atípicos (puntos negros por encima del bigote superior).

ggplot(df_master, aes(x = genero_norm, y = edad, fill = genero_norm)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red") +
  # Esto crea un gráfico distinto para cada trastorno:
  facet_wrap(~ trastorno) + 
  labs(title = "Distribución de Edad por Género y Tipo de Trastorno",
       x = "Género",
       y = "Edad (años)") +
  theme_minimal() +
  theme(legend.position = "none") # Podés ocultar la leyenda si el eje X ya lo explica


library(ggplot2)
library(dplyr)
library(tidyr)
library(scales) # Necesaria para formatear los porcentajes

# Análisis de Porcentajes Reales por Trastorno
df_master %>%
  select(genero_norm, n_trastornos, tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt) %>%
  filter(
    genero_norm %in% c("Hombre", "Mujer") # Filtro más limpio para quedarnos solo con estos dos
  ) %>%
  pivot_longer(
    cols = c(tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt), 
    names_to = "trastorno", 
    values_to = "presenta"
  ) %>%
  filter(presenta == "Si") %>% 
  
  # Calculamos el porcentaje de cada trastorno DENTRO de cada género
  group_by(genero_norm, trastorno) %>%
  summarise(cantidad = n(), .groups = "drop_last") %>%
  mutate(porcentaje = cantidad / sum(cantidad)) %>% # Esto da el % relativo por género
  
  ggplot(aes(x = genero_norm, y = porcentaje, fill = genero_norm)) +
  geom_col(color = "black", alpha = 0.8) +
  geom_text(aes(label = scales::percent(porcentaje, accuracy = 0.1)), 
            vjust = -0.5, size = 3, fontface = "bold") +
  facet_wrap(~ trastorno) +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1.1)) +
  labs(
    title = "Prevalencia de cada Trastorno por Género",
    subtitle = "Basado en pacientes con al menos 1 diagnóstico",
    x = "Género",
    y = "Proporción del total de diagnósticos"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Análisis del gráfico: Prevalencia de cada Trastorno por Género
#
# 1. Patrón General:
# El perfil de distribución de los trastornos es notablemente simétrico entre 
# hombres y mujeres. No hay sesgos extremos. En ambos grupos, aproximadamente 
# el 80% del total de los diagnósticos se concentra exclusivamente en dos 
# patologías: depresión y ansiedad.
#
# 2. Análisis por Trastorno:
# - Depresión (tiene_depresion): Es la condición predominante en la muestra. 
#   Acapara el 44.3% de los diagnósticos en mujeres y el 42.7% en hombres.
# - Ansiedad (tiene_ansiedad): Sigue de cerca en segundo lugar, con una 
#   prevalencia ligeramente mayor en hombres (37.4%) respecto a las mujeres (35.1%).
# - TDAH (tiene_tdah): Queda en tercer lugar con una proporción intermedia, 
#   representando el 13.6% en hombres y el 12.0% en mujeres.
# - Estrés / Estrés Postraumático (tiene_estres_pt): Es el diagnóstico menos 
#   frecuente, pero es el que presenta la mayor diferencia relativa a favor 
#   de las mujeres (8.6%) frente a los hombres (6.3%).
#
# 3. Conclusión de la visualización:
# La jerarquía de prevalencia (Depresión > Ansiedad > TDAH > Estrés) se mantiene 
# idéntica sin importar la identidad de género. Las variaciones porcentuales entre 
# géneros para un mismo trastorno son marginales, rondando apenas entre 1.5 y 
# 2.3 puntos de diferencia.