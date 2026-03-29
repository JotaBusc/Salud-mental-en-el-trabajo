#data_curated 1
library(tidyverse)
library(readr)
library(dplyr)
library(labelled)
library(ggplot2)
mental_heath_in_tech_2016_20161114 <- read_csv("mental-heath-in-tech-2016_20161114.csv")
View(mental_heath_in_tech_2016_20161114)

glimpse(mental_heath_in_tech_2016_20161114)


# 1. Renombramos y asignamos etiquetas en un solo flujo ----
df_mental_health <- mental_heath_in_tech_2016_20161114 %>%
  
  # A. Primero cambiamos los nombres de las columnas a un formato limpio
  rename(
    independiente = `Are you self-employed?`,
    tamano_empresa = `How many employees does your company or organization have?`,
    empresa_tech = `Is your employer primarily a tech company/organization?`,
    rol_tech = `Is your primary role within your company related to tech/IT?`,
    beneficios_salud_mental = `Does your employer provide mental health benefits as part of healthcare coverage?`,
    conoce_opciones_cobertura = `Do you know the options for mental health care available under your employer-provided coverage?`,
    discusion_formal_empleador = `Has your employer ever formally discussed mental health (for example, as part of a wellness campaign or other official communication)?`,
    recursos_aprendizaje = `Does your employer offer resources to learn more about mental health concerns and options for seeking help?`,
    anonimato_protegido = `Is your anonymity protected if you choose to take advantage of mental health or substance abuse treatment resources provided by your employer?`,
    dificultad_licencia_medica = `If a mental health issue prompted you to request a medical leave from work, asking for that leave would be:`,
    consecuencia_negativa_empleador = `Do you think that discussing a mental health disorder with your employer would have negative consequences?`,
    consecuencia_negativa_fisica_empleador = `Do you think that discussing a physical health issue with your employer would have negative consequences?`,
    comodidad_companeros = `Would you feel comfortable discussing a mental health disorder with your coworkers?`,
    comodidad_supervisor = `Would you feel comfortable discussing a mental health disorder with your direct supervisor(s)?`,
    empleador_toma_enserio = `Do you feel that your employer takes mental health as seriously as physical health?`,
    observo_consecuencias_companeros = `Have you heard of or observed negative consequences for co-workers who have been open about mental health issues in your workplace?`,
    conoce_recursos_locales = `Do you know local or online resources to seek help for a mental health disorder?`,
    revela_clientes = `If you have been diagnosed or treated for a mental health disorder, do you ever reveal this to clients or business contacts?`,
    impacto_negativo_clientes = `If you have revealed a mental health issue to a client or business contact, do you believe this has impacted you negatively?`,
    revela_companeros = `If you have been diagnosed or treated for a mental health disorder, do you ever reveal this to coworkers or employees?`,
    impacto_negativo_companeros = `If you have revealed a mental health issue to a coworker or employee, do you believe this has impacted you negatively?`,
    productividad_afectada = `Do you believe your productivity is ever affected by a mental health issue?`,
    porcentaje_tiempo_afectado = `If yes, what percentage of your work time (time performing primary or secondary job functions) is affected by a mental health issue?`,
    empleadores_previos = `Do you have previous employers?`,
    beneficios_previos = `Have your previous employers provided mental health benefits?`,
    conoce_opciones_previas = `Were you aware of the options for mental health care provided by your previous employers?`,
    discusion_formal_previo = `Did your previous employers ever formally discuss mental health (as part of a wellness campaign or other official communication)?`,
    recursos_aprendizaje_previo = `Did your previous employers provide resources to learn more about mental health issues and how to seek help?`,
    anonimato_protegido_previo = `Was your anonymity protected if you chose to take advantage of mental health or substance abuse treatment resources with previous employers?`,
    consecuencia_negativa_previo = `Do you think that discussing a mental health disorder with previous employers would have negative consequences?`,
    consecuencia_negativa_fisica_previo = `Do you think that discussing a physical health issue with previous employers would have negative consequences?`,
    comodidad_companeros_previo = `Would you have been willing to discuss a mental health issue with your previous co-workers?`,
    comodidad_supervisor_previo = `Would you have been willing to discuss a mental health issue with your direct supervisor(s)?`,
    empleador_previo_toma_enserio = `Did you feel that your previous employers took mental health as seriously as physical health?`,
    observo_consecuencias_previo = `Did you hear of or observe negative consequences for co-workers with mental health issues in your previous workplaces?`,
    entrevista_salud_fisica = `Would you be willing to bring up a physical health issue with a potential employer in an interview?`,
    motivo_entrevista_fisica = `Why or why not?...38`,
    entrevista_salud_mental = `Would you bring up a mental health issue with a potential employer in an interview?`,
    motivo_entrevista_mental = `Why or why not?...40`,
    perjudica_carrera = `Do you feel that being identified as a person with a mental health issue would hurt your career?`,
    percepcion_negativa_equipo = `Do you think that team members/co-workers would view you more negatively if they knew you suffered from a mental health issue?`,
    compartir_familia_amigos = `How willing would you be to share with friends and family that you have a mental illness?`,
    mala_respuesta_lugar_trabajo = `Have you observed or experienced an unsupportive or badly handled response to a mental health issue in your current or previous workplace?`,
    observacion_desalentadora = `Have your observations of how another individual who discussed a mental health disorder made you less likely to reveal a mental health issue yourself in your current workplace?`,
    historia_familiar = `Do you have a family history of mental illness?`,
    trastorno_pasado = `Have you had a mental health disorder in the past?`,
    trastorno_actual = `Do you currently have a mental health disorder?`,
    condiciones_diagnosticadas = `If yes, what condition(s) have you been diagnosed with?`,
    condiciones_sospechadas = `If maybe, what condition(s) do you believe you have?`,
    diagnostico_profesional = `Have you been diagnosed with a mental health condition by a medical professional?`,
    condiciones_profesional = `If so, what condition(s) were you diagnosed with?`,
    busco_tratamiento = `Have you ever sought treatment for a mental health issue from a mental health professional?`,
    interferencia_con_tratamiento = `If you have a mental health issue, do you feel that it interferes with your work when being treated effectively?`,
    interferencia_sin_tratamiento = `If you have a mental health issue, do you feel that it interferes with your work when NOT being treated effectively?`,
    edad = `What is your age?`,
    genero = `What is your gender?`,
    pais_residencia = `What country do you live in?`,
    estado_residencia_us = `What US state or territory do you live in?`,
    pais_trabajo = `What country do you work in?`,
    estado_trabajo_us = `What US state or territory do you work in?`,
    posicion_trabajo = `Which of the following best describes your work position?`,
    trabajo_remoto = `Do you work remotely?`
  ) %>%
  
  # B. Luego asignamos la pregunta original como metadato oculto
  set_variable_labels(
    independiente = "Are you self-employed?",
    tamano_empresa = "How many employees does your company or organization have?",
    empresa_tech = "Is your employer primarily a tech company/organization?",
    rol_tech = "Is your primary role within your company related to tech/IT?",
    beneficios_salud_mental = "Does your employer provide mental health benefits as part of healthcare coverage?",
    conoce_opciones_cobertura = "Do you know the options for mental health care available under your employer-provided coverage?",
    discusion_formal_empleador = "Has your employer ever formally discussed mental health (for example, as part of a wellness campaign or other official communication)?",
    recursos_aprendizaje = "Does your employer offer resources to learn more about mental health concerns and options for seeking help?",
    anonimato_protegido = "Is your anonymity protected if you choose to take advantage of mental health or substance abuse treatment resources provided by your employer?",
    dificultad_licencia_medica = "If a mental health issue prompted you to request a medical leave from work, asking for that leave would be:",
    consecuencia_negativa_empleador = "Do you think that discussing a mental health disorder with your employer would have negative consequences?",
    consecuencia_negativa_fisica_empleador = "Do you think that discussing a physical health issue with your employer would have negative consequences?",
    comodidad_companeros = "Would you feel comfortable discussing a mental health disorder with your coworkers?",
    comodidad_supervisor = "Would you feel comfortable discussing a mental health disorder with your direct supervisor(s)?",
    empleador_toma_enserio = "Do you feel that your employer takes mental health as seriously as physical health?",
    observo_consecuencias_companeros = "Have you heard of or observed negative consequences for co-workers who have been open about mental health issues in your workplace?",
    conoce_recursos_locales = "Do you know local or online resources to seek help for a mental health disorder?",
    revela_clientes = "If you have been diagnosed or treated for a mental health disorder, do you ever reveal this to clients or business contacts?",
    impacto_negativo_clientes = "If you have revealed a mental health issue to a client or business contact, do you believe this has impacted you negatively?",
    revela_companeros = "If you have been diagnosed or treated for a mental health disorder, do you ever reveal this to coworkers or employees?",
    impacto_negativo_companeros = "If you have revealed a mental health issue to a coworker or employee, do you believe this has impacted you negatively?",
    productividad_afectada = "Do you believe your productivity is ever affected by a mental health issue?",
    porcentaje_tiempo_afectado = "If yes, what percentage of your work time (time performing primary or secondary job functions) is affected by a mental health issue?",
    empleadores_previos = "Do you have previous employers?",
    beneficios_previos = "Have your previous employers provided mental health benefits?",
    conoce_opciones_previas = "Were you aware of the options for mental health care provided by your previous employers?",
    discusion_formal_previo = "Did your previous employers ever formally discuss mental health (as part of a wellness campaign or other official communication)?",
    recursos_aprendizaje_previo = "Did your previous employers provide resources to learn more about mental health issues and how to seek help?",
    anonimato_protegido_previo = "Was your anonymity protected if you chose to take advantage of mental health or substance abuse treatment resources with previous employers?",
    consecuencia_negativa_previo = "Do you think that discussing a mental health disorder with previous employers would have negative consequences?",
    consecuencia_negativa_fisica_previo = "Do you think that discussing a physical health issue with previous employers would have negative consequences?",
    comodidad_companeros_previo = "Would you have been willing to discuss a mental health issue with your previous co-workers?",
    comodidad_supervisor_previo = "Would you have been willing to discuss a mental health issue with your direct supervisor(s)?",
    empleador_previo_toma_enserio = "Did you feel that your previous employers took mental health as seriously as physical health?",
    observo_consecuencias_previo = "Did you hear of or observe negative consequences for co-workers with mental health issues in your previous workplaces?",
    entrevista_salud_fisica = "Would you be willing to bring up a physical health issue with a potential employer in an interview?",
    motivo_entrevista_fisica = "Why or why not?...38",
    entrevista_salud_mental = "Would you bring up a mental health issue with a potential employer in an interview?",
    motivo_entrevista_mental = "Why or why not?...40",
    perjudica_carrera = "Do you feel that being identified as a person with a mental health issue would hurt your career?",
    percepcion_negativa_equipo = "Do you think that team members/co-workers would view you more negatively if they knew you suffered from a mental health issue?",
    compartir_familia_amigos = "How willing would you be to share with friends and family that you have a mental illness?",
    mala_respuesta_lugar_trabajo = "Have you observed or experienced an unsupportive or badly handled response to a mental health issue in your current or previous workplace?",
    observacion_desalentadora = "Have your observations of how another individual who discussed a mental health disorder made you less likely to reveal a mental health issue yourself in your current workplace?",
    historia_familiar = "Do you have a family history of mental illness?",
    trastorno_pasado = "Have you had a mental health disorder in the past?",
    trastorno_actual = "Do you currently have a mental health disorder?",
    condiciones_diagnosticadas = "If yes, what condition(s) have you been diagnosed with?",
    condiciones_sospechadas = "If maybe, what condition(s) do you believe you have?",
    diagnostico_profesional = "Have you been diagnosed with a mental health condition by a medical professional?",
    condiciones_profesional = "If so, what condition(s) were you diagnosed with?",
    busco_tratamiento = "Have you ever sought treatment for a mental health issue from a mental health professional?",
    interferencia_con_tratamiento = "If you have a mental health issue, do you feel that it interferes with your work when being treated effectively?",
    interferencia_sin_tratamiento = "If you have a mental health issue, do you feel that it interferes with your work when NOT being treated effectively?",
    edad = "What is your age?",
    genero = "What is your gender?",
    pais_residencia = "What country do you live in?",
    estado_residencia_us = "What US state or territory do you live in?",
    pais_trabajo = "What country do you work in?",
    estado_trabajo_us = "What US state or territory do you work in?",
    posicion_trabajo = "Which of the following best describes your work position?",
    trabajo_remoto = "Do you work remotely?"
  )

glimpse(df_mental_health)

#Creamos subset (con su respectivo data wrangling) con las variables que conforman estos 3 aspectos:
#  Características de la persona (Demografía y Background)
# Enfermedad o condición mental (Estado Clínico)
# Preocupación, Estigma e Impacto en la Carrera



#1.1. Subset: Características de la persona (Demografía y Background) -----


# Ideal para entender el perfil sociodemográfico de la muestra 
df_demografia <- df_mental_health %>%
  select(
    independiente,
    edad, 
    genero, 
    pais_residencia, 
    estado_residencia_us, 
    pais_trabajo, 
    estado_trabajo_us
  )
#Data Wrangling - se normaliza la variable genero.
df_demografia %>%
  count(genero) %>%
  arrange(desc(n)) %>%
  print(n = Inf)
df_demografia <- df_demografia %>%
  # 2. Normalización de Género
  mutate(genero_norm = str_to_lower(genero), # Pasamos todo a minúsculas para facilitar
         genero_norm = str_trim(genero_norm)) %>% # Quitamos espacios en blanco extra
  mutate(genero_norm = case_when(
    # Patrón para Hombres (incluye male, man, dude, cis male, mail, etc.)
    str_detect(genero_norm, "^m$|^m\\||^mail|^malr|^man|^dude|^male|^cis male|^cis man|^cisdude|^sex is male") ~ "Hombre",
    # Patrón para Mujeres (incluye female, woman, femme, cis female, etc.)
    str_detect(genero_norm, "^f$|^f\\.|^fem|^woman|^female|^cis female|^cis-woman|^cisgender female|^i identify as female") ~ "Mujer",
    # Patrón para No-binarios y Diversidad (NB, trans, fluid, agender, queer)
    str_detect(genero_norm, "non-binary|nonbinary|nb|enby|genderfluid|genderqueer|agender|fluid|bigender|queer|trans|mtf|ftm|transitioned|afab|androgynous") ~ "No-binario",
    # Casos imposibles, bromas o NA (Unicorn, Human, N/A, etc.)
    str_detect(genero_norm, "unicorn|human|none of your business|n/a|na") ~ "No especificado",
    is.na(genero_norm) ~ "No especificado",
    # Todo lo que quede afuera (por si se nos escapó algo raro)
    TRUE ~ "No-binario"
  ))

# Verificamos cómo quedó la nueva distribución
table(df_demografia$genero_norm)


#1.2. Subset: Enfermedad o condición mental (Estado Clínico) ----
df_estado_clinico <- df_mental_health %>%
  select(
    historia_familiar,
    trastorno_pasado,
    trastorno_actual,
    condiciones_diagnosticadas,
    condiciones_sospechadas,
    diagnostico_profesional,
    condiciones_profesional,
    busco_tratamiento
  )
# Creamos una columna para cada transtorno y una ultima columna para la variable Comorbilidad, es decir cuantos transtornos reporta

df_estado_clinico <- df_estado_clinico %>%
  mutate(
    # 1. Creamos variables binarias (Dummy variables) para las más frecuentes
    # Usamos str_detect para buscar la palabra clave sin importar el resto de la celda
    tiene_ansiedad = ifelse(str_detect(condiciones_diagnosticadas, "Anxiety"), "Si", "No"),
    tiene_depresion = ifelse(str_detect(condiciones_diagnosticadas, "Mood|Depression"), "Si", "No"),
    tiene_tdah = ifelse(str_detect(condiciones_diagnosticadas, "ADHD|Attention Deficit"), "Si", "No"),
    tiene_estres_pt = ifelse(str_detect(condiciones_diagnosticadas, "Post-traumatic|PTSD"), "Si", "No"),
    
    # 2. Variable de Comorbilidad: ¿Cuántos trastornos reporta?
    # Contamos los separadores "|" y sumamos 1. Si es NA, ponemos 0.
    n_trastornos = ifelse(is.na(condiciones_diagnosticadas), 0, 
                          str_count(condiciones_diagnosticadas, "\\|") + 1)
  )

# Verificamos cómo quedó
df_estado_clinico %>% 
  select(condiciones_diagnosticadas, tiene_ansiedad, tiene_depresion, n_trastornos) %>% 
  head(10)


#1.3. Subset: Preocupación, Estigma e Impacto en la Carrera ----
df_estigma_carrera <- df_mental_health %>%
  select(
    consecuencia_negativa_empleador,
    consecuencia_negativa_fisica_empleador,
    observo_consecuencias_companeros,
    impacto_negativo_clientes,
    impacto_negativo_companeros,
    consecuencia_negativa_previo,
    consecuencia_negativa_fisica_previo,
    observo_consecuencias_previo,
    perjudica_carrera,
    percepcion_negativa_equipo,
    mala_respuesta_lugar_trabajo,
    observacion_desalentadora
  )

df_estigma_carrera <- df_estigma_carrera %>%
  mutate(perjudica_carrera_norm = case_when(
    # Agrupamos los "No" (Tanto opinión como experiencia)
    perjudica_carrera %in% c("No, I don't think it would", "No, it has not") ~ "No",
    
    # El "Maybe" queda igual
    perjudica_carrera == "Maybe" ~ "Tal vez",
    
    # Agrupamos los "Sí" (Tanto opinión como experiencia)
    perjudica_carrera %in% c("Yes, I think it would", "Yes, it has") ~ "Sí",
    
    TRUE ~ NA_character_
  )) %>%
  # Lo convertimos en factor con orden lógico para los gráficos
  mutate(perjudica_carrera_norm = factor(perjudica_carrera_norm, levels = c("No", "Tal vez", "Sí")))

# Verificamos la limpieza
table(df_estigma_carrera$perjudica_carrera_norm)



# 1. Transformamos la variable en la base original
df_mental_health <- df_mental_health %>%
  mutate(
    # Pasamos de 1/0 a SI/NO y lo convertimos en Factor
    independiente = ifelse(independiente == 1, "SI", "NO"),
    independiente = factor(independiente, levels = c("NO", "SI"))
  )

# 1. Asegurate de que la variable esté en la base original limpia
# Si no la habías seleccionado antes, hacelo ahora:

columna_independiente <- df_mental_health$independiente 

#Agregamos la columna directamente a cada subset
df_demografia$independiente <- columna_independiente
df_estado_clinico$independiente <- columna_independiente
df_estigma_carrera$independiente <- columna_independiente


#2.1  Unimos los 3 subsets en uno solo llamado df_master ----
# Usamos las columnas comunes para asegurar que las filas encajen perfecto
df_master <- df_demografia %>%
  bind_cols(
    df_estado_clinico %>% select(-any_of(names(df_demografia))),
    df_estigma_carrera %>% select(-any_of(names(df_demografia)))
  )

# Verificamos que ahora sí sea un solo bloque
glimpse(df_master)

#Aplicamos filtro de edad

df_master <- df_master %>%
  # Nos aseguramos de que sea numérica (por si quedó como character)
  mutate(edad = as.numeric(edad)) %>%
  # Filtramos el rango de la población activa (18-60)
  filter(edad >= 18 & edad <= 60) %>%
  # Eliminamos cualquier NA que haya quedado en edad
  filter(!is.na(edad))

# 2. Verificamos cuántos registros quedaron al final
nrow(df_master)

# 3. Un vistazo rápido para confirmar que las variables están ahí
glimpse(df_master)



# Recalculamos n_trastornos basándonos SOLO en tus 4 variables normalizadas
df_master <- df_master %>%
  rowwise() %>% 
  mutate(n_trastornos = sum(
    c(tiene_ansiedad, tiene_depresion, tiene_tdah, tiene_estres_pt) == "Si", 
    na.rm = TRUE
  )) %>%
  ungroup()
