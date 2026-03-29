# 🧠 Mental Health in Tech
### *Investigación exploratoria sobre salud mental en el sector IT*

Esta investigación (simulacion) analiza la prevalencia y los determinantes de la salud mental —específicamente la **depresión**— en trabajadores tecnológicos, utilizando el dataset de **OSMI**. El objetivo es transformar datos crudos en *insights* accionables para una gestión de Recursos Humanos basada en evidencia.

---

## 🛠️ Tecnologías y Metodologías

* **Lenguaje:** `R` (tidyverse, ggplot2, vcd, stats).
* **Estadística Inferencial:** Test de Chi-cuadrado de Pearson, Test Exacto de Fisher, Coeficiente V de Cramer.
* **Modelado:** Regresión Logística Binomial para predicción de riesgo (GLM).
* **Visualización:** Mapas de calor (Heatmaps) de asociación y Boxplots de comorbilidad normalizados.

---

## 🚀 Hallazgos Clave

### 1. Brecha de Género Significativa
Se confirmó una asociación estadística robusta (**p < 0.001**) entre el género y la prevalencia de depresión. Los datos indican que las mujeres presentan una mayor carga diagnóstica en este entorno laboral.

🔗 **[Acceder al Dashboard de Inferencia](https://jotabusconi.shinyapps.io/inferencia_chi2/)**

### 2. La Proactividad como Síntoma Crítico
La **búsqueda de tratamiento** resultó ser un predictor más robusto de salud mental que el diagnóstico profesional formal. Esto sugiere que la acción voluntaria del empleado es la señal de alerta más temprana.

| Variable | Coeficiente (Estimate) | P-value | Significancia |
| :--- | :---: | :---: | :--- |
| **Búsqueda de Tratamiento** | 1.15 | 0.00035 | **Alta (***)** |
| **Diagnóstico Profesional** | 0.17 | 0.58540 | No significativa |

> **Interpretación:** La acción de buscar ayuda predice con alta confianza que la persona atraviesa un cuadro depresivo, mientras que el simple hecho de poseer un diagnóstico formal no garantiza que el empleado reconozca o esté transitando la patología en su rol actual.

🔗 **[Acceder al Dashboard del Modelo GLM](https://jotabusconi.shinyapps.io/mental_health_glm_kramer/)**

---

## 🔍 ¿Por qué la Búsqueda de Tratamiento es superior al Diagnóstico?

Mientras que el diagnóstico profesional no resultó significativo en el modelo ($p > 0.05$), la búsqueda activa mostró una relación poderosa. Esto indica que la conducta de pedir ayuda es el **síntoma más sensible**: el sistema formal suele llegar tarde, pero el comportamiento del empleado nos da la señal de alerta antes de que la patología se formalice.

---

## 🎯 Implicancias para Recursos Humanos

El análisis permite evolucionar de un enfoque reactivo a un **Modelo de Gestión Preventiva**:

* **📍 Identificación de Grupos Vulnerables:** Permite diseñar intervenciones de Salud Mental con **Perspectiva de Género**, enfocadas en mitigar riesgos específicos como la doble carga horaria o el techo de cristal.
* **👀 Detección de la "Demanda Oculta":** RR.HH. debe dejar de ver el diagnóstico como la "puerta de entrada" y empezar a valorar la **intención de búsqueda** como el indicador crítico para intervenir.
* **🗣️ Reducción de Barreras Culturales:** La estrategia debe centrarse en la **Alfabetización en Salud Mental**. Si el empleado no se siente seguro para buscar ayuda por miedo al estigma, perdemos nuestro predictor más potente.
* **📈 Optimización de Programas de Asistencia (EAP):** Fomentar canales de consulta rápida. Cuando un empleado "levanta la mano", la probabilidad de riesgo es estadísticamente altísima.

---

## 🏆 Conclusión Estratégica
> **No necesitamos esperar el diagnóstico para saber que hay un problema.** La conducta de búsqueda de ayuda nos brinda una señal de alerta con una **confianza estadística del 99.9%**.
