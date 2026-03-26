#INFERENCIA ESTADISTICA

# Asociacion variables GENERO - DEPRESION (Hombres y Mujeres solamente)----

#Hipótesis Nula (H0): No existe asociación. El género y la depresión son independientes.

#Hipótesis Alternativa (H1): Existe una asociación significativa. El género influye en la probabilidad de tener depresión.

# 1. Filtramos para quedarnos solo con Hombre y Mujer
df_binario <- df_master %>% 
  filter(genero_norm %in% c("Hombre", "Mujer")) %>%
  # Eliminamos filas donde 'tiene_depresion' sea NA para no falsear el test
  filter(!is.na(tiene_depresion))

# 2. Creamos la tabla de contingencia
tabla_depresion <- table(df_binario$genero_norm, df_binario$tiene_depresion)

# 3. Ejecutamos el Test de Chi-Cuadrado
resultado_chi2 <- chisq.test(tabla_depresion)

# 4. Mostramos los resultados
print(tabla_depresion)
print(resultado_chi2)

resultado_chi2$expected
resultado_chi2$observed

# # 
# ANÁLISIS DE ASOCIACIÓN: GÉNERO VS. DEPRESIÓN
# 
# TEST: Pearson's Chi-squared 
# RESULTADO: X-squared = 13.152, p-value = 0.0002873
# 
# CONCLUSIÓN ESTADÍSTICA: Se rechaza la hipótesis nula de independencia. 
# Existe evidencia altamente significativa (p < 0.001) para afirmar que el 
# género y la presencia de depresión están asociados.
# 
# Observacion: 
# Este hallazgo es crítico para la gestión de bienestar. Indica que los 
# factores de riesgo o la manifestación de la patología no se distribuyen 
# de forma equitativa. Esto nos obliga a abandonar 
# los enfoques de salud mental "universales" y diseñar estrategias de 
# prevención específicas y segmentadas por género, atendiendo a las 
# particularidades detectadas en la población [Mujer/Hombre].

mosaicplot(tabla_depresion, 
           main = "Asociación: Género y Depresión",
           xlab = "Género", 
           ylab = "¿Tiene Depresión?",
           color = c("#B2D7D0", "#E57373"), # colores suaves para No/Si
           shade = TRUE) # agrega color según los residuos 

# Análisis del gráfico de mosaico: Relación entre Género y Depresión
#
# 1. Ancho de las columnas (Tamaño de la muestra):
# La columna "Hombre" es notablemente más ancha que la columna "Mujer".
# hay una cantidad considerablemente mayor de hombres que de mujeres en la muestra.
#
# 2. Altura de las cajas (Proporción interna):
# Al observar la línea divisoria entre el "Sí" y el "No", se nota que
# no está a la misma altura en ambos géneros. En el grupo "Mujer", la
# caja correspondiente al "Sí" ocupa una proporción vertical
# mayor, indicando una mayor prevalencia relativa de depresión en mujeres.
#
# 3. Colores (Residuos estandarizados e Independencia estadística):
# - Cajas blancas: Indican que las frecuencias observadas coinciden con 
#   las esperadas si no hubiera relación entre género y depresión. Toda la 
#   columna de hombres y la caja "Mujer / Sí" caen en este rango.
# - Caja roja y punteada (Mujer / No): Indica un residuo estandarizado 
#   negativo (entre -2 y -4). Esto significa que hay significativamente menos 
#   mujeres SIN depresión de las que estadísticamente se esperaría encontrar 
#   si el género y la presencia de depresión fueran variables totalmente independientes.
#
# Conclusión:
# El gráfico evidencia una asociación estadística entre las variables. Específicamente,
# el grupo de mujeres presenta una escasez significativa de casos "sanos" (sin depresión)
# en comparación con el patrón basal del grupo de hombres.

#Considerando que la prescencia de depresion esta asociada al genero, centramos entonces el analisis
#en el genero femenino, realizamos una tabla de correlacion para variables categoricas 
#mediante el coeficiente V de Cramer, con el fin de identificar si existen factores del entorno laboral o personal 
#que actúen como catalizadores específicos de la patología en este grupo.

df_mujeres <- df_master %>%
  filter(genero_norm == "Mujer") %>%
  filter(!is.na(tiene_depresion)) %>%
  mutate(independiente = factor(independiente),
         tiene_depresion = factor(tiene_depresion))



library(vcd) # Para calcular V de Cramer
library(tidyverse)
library(vcd) # Para assocstats()

# 1. Limpieza y Factorización
# Creamos un dataframe específico para el análisis de asociación
df_asoc <- df_master %>%
  select(tiene_depresion, independiente, historia_familiar, 
         trastorno_pasado, 
         busco_tratamiento, diagnostico_profesional) %>%
  # Eliminamos filas donde la variable dependiente (depresion) sea NA
  drop_na(tiene_depresion) %>%
  mutate(
    # Convertimos todo a factor para que R lo entienda como categoría
    tiene_depresion = as.factor(tiene_depresion),
    independiente = as.factor(independiente),
    # Normalizamos busco_tratamiento de 0/1 a No/Si
    busco_tratamiento = factor(ifelse(busco_tratamiento == 1, "Si", "No")),
    # El resto de las categóricas
    historia_familiar = as.factor(historia_familiar),
    trastorno_pasado = as.factor(trastorno_pasado),
    diagnostico_profesional = as.factor(diagnostico_profesional)
  )

# 2. Función para calcular la matriz de V de Cramer
calcular_matrix_v <- function(datos) {
  n <- ncol(datos)
  m <- matrix(NA, n, n)
  colnames(m) <- rownames(m) <- colnames(datos)
  
  for (i in 1:n) {
    for (j in 1:n) {
      # Calculamos la asociación par por par
      tab <- table(datos[[i]], datos[[j]])
      m[i,j] <- assocstats(tab)$cramer
    }
  }
  return(m)
}

calcular_matrix_v


# 3. Ejecución y Formateo para ggplot
matriz_v <- calcular_matrix_v(df_asoc)
df_heatmap <- as.data.frame(as.table(matriz_v))

# 4. Gráfico del Mapa de Calor
ggplot(df_heatmap, aes(Var1, Var2, fill = Freq)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "#2C3E50") + # Color sobrio profesional
  geom_text(aes(label = round(Freq, 2)), color = "orange", fontface = "bold") +
  labs(title = "Matriz de Asociación (V de Cramer)",
       subtitle = "Fuerza de relación entre variables",
       x = "", y = "", fill = "Asociación") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#El hallazgo interesante es que no existe una variable que tenga mas fuerza como indicadora de depresion
#Lo que podemos observar es la asociacion que hay entre que busco tratamiento y tiene un diagnostico profesional
#si existiese colinealidad entre estas variables la fuerza de asociacion seria 0.9. pero un 0.45 nos indica una brecha
#Es posible uqe haya trabajadoras que busca tratamiento pero no recibe un diagnostico profesional y por el otro lado
#que tiene un diagnostico pero no busco tratamiento activamente.


# Analizamos el error standard y el VIF para asegurarnos de que no exista colinealidad y realizamos una regresion logistica
#para saber si existe una relacion entre estas dos variables y padecer depresion 
modelo_test <- glm(tiene_depresion ~ busco_tratamiento + diagnostico_profesional, 
                   data = df_asoc, family = binomial)

summary(modelo_test)

library(car)
vif(modelo_test)

#                             Estimate Std. Error z value Pr(>|z|)    
#(Intercept)                 -0.1902     0.3079  -0.618   0.536794    
#busco_tratamientoSi          1.1510     0.3220   3.574   0.000351 ***
#diagnostico_profesionalYes   0.1786     0.3274   0.546   0.585403    

# busco_tratamiento Si: p value  0.000351 - Significa que la accion de buscar ayuda es un predictor real de 
# que la persona considera estar atravesando una depresion.
# diagnostico_profesionalyes : p value  0.585403 - tener un diagnostico profesional no es un predictor real 
# de que la persona considere estar atravesando una depresion


# INFERENCIA ESTADÍSTICA: ANSIEDAD
# Asociación variables GÉNERO - ANSIEDAD (Hombres y Mujeres solamente) ----

# Hipótesis Nula (H0): No existe asociación. El género y la ansiedad son independientes.
# Hipótesis Alternativa (H1): Existe una asociación significativa. El género influye en la probabilidad de tener ansiedad.

# Filtramos la base
df_binario_ans <- df_master %>% 
  filter(genero_norm %in% c("Hombre", "Mujer")) %>%
  filter(!is.na(tiene_ansiedad))

# Creamos la tabla de contingencia
tabla_ansiedad <- table(df_binario_ans$genero_norm, df_binario_ans$tiene_ansiedad)

# Ejecutamos el Test de Chi-Cuadrado
resultado_chi2_ans <- chisq.test(tabla_ansiedad)

# Mostramos los resultados
print(tabla_ansiedad)
print(resultado_chi2_ans)

resultado_chi2_ans$expected
resultado_chi2_ans$observed

# Gráfico de Mosaico para Ansiedad
mosaicplot(tabla_ansiedad, 
           main = "Asociación: Género y Ansiedad",
           xlab = "Género", 
           ylab = "¿Tiene Ansiedad?",
           color = c("#B2D7D0", "#E57373"),
           shade = TRUE) 

## ANÁLISIS DE ASOCIACIÓN: GÉNERO VS. ANSIEDAD
# 
# TEST: Pearson's Chi-squared test (con corrección de Yates)
# RESULTADO: X-squared = 1.8739, p-value = 0.171
# 
# CONCLUSIÓN ESTADÍSTICA: No se rechaza la hipótesis nula. 
# El p-value (0.171) es mayor al nivel de significancia (0.05), lo que 
# indica que NO existe una asociación estadísticamente significativa 
# entre el género y la ansiedad en esta muestra.
# 
# OBSERVACIÓN PARA LA GESTIÓN (PEOPLE ANALYTICS):
# A diferencia de la depresión (que presentó una prevalencia significativamente 
# mayor en mujeres), la ansiedad se distribuye de manera transversal y 
# equitativa entre hombres y mujeres. 
#
# Impacto en la estrategia: Las iniciativas corporativas para mitigar el 
# estrés y la ansiedad deben diseñarse como políticas universales que 
# abarquen a toda la plantilla por igual, ya que el riesgo es transversal 
# a toda la organización sin distinciones de género.


