# Mental Health in Tech: Investigacion exploratoria centrada en la salud mental en el trabajo

Esta simulacion analiza la prevalencia y los determinantes de la salud mental, específicamente la depresión, en trabajadores del sector IT, utilizando el dataset de OSMI. El objetivo es transformar datos crudos en informacion para la gestión de Recursos Humanos.

---

## Tecnologías y Metodologías

* **Lenguaje:** R (tidyverse, ggplot2, vcd, stats).
* **Estadística Inferencial:** Test de Chi-cuadrado de Pearson, Test Exacto de Fisher, Coeficiente V de Cramer.
* **Modelado:** Regresión Logística Binomial para predicción de riesgo.
* **Visualización:** Mapas de calor (Heatmaps) de asociación y Boxplots de comorbilidad normalizados.

---

## Hallazgos Clave 

### 1. Brecha de Género
Se confirmó una asociación significativa (**p < 0.001**) entre el género y la depresión. Las mujeres presentan una mayor carga diagnóstica.
 
🔗 **Dashboard:** [Análisis de Inferencia Chi2](https://jotabusconi.shinyapps.io/inferencia_chi2/)

### 2. Predictores de Comportamiento en mujeres
La búsqueda de tratamiento resultó ser un predictor más robusto de salud mental que el diagnóstico profesional formal, sugiriendo que la proactividad del empleado es un síntoma crítico.

| Variable | Coeficiente (Estimate) | P-value | Significancia |
| :--- | :---: | :---: | :--- |
| Búsqueda de Tratamiento | 1.15 | 0.00035 | Alta (***) |
| Diagnóstico Profesional | 0.17 | 0.58540 | No significativa |

* **busco_tratamiento Si:** p value 0.000351 - Significa que la accion de buscar ayuda es un predictor real de que la persona considera estar atravesando una depresion.
* **diagnostico_profesionalyes:** p value 0.585403 - tener un diagnostico profesional no es un predictor real de que la persona considere estar atravesando una depresion.

🔗 **Dashboard:** [Modelo GLM Kramer](https://jotabusconi.shinyapps.io/mental_health_glm_kramer/)

---

## Por qué la Búsqueda de Tratamiento es un predictor más robusto? 

Mientras que el diagnóstico profesional no resultó significativo en el modelo (**p > 0.05**), la búsqueda activa de tratamiento mostró una relación poderosa. Esto indica que la conducta de pedir ayuda es el síntoma más sensible y el predictor más temprano de un cuadro depresivo, incluso antes de que el sistema de salud formalice la patología.

---

## El análisis permite al area de Recursos Humanos:

* **Identificación de grupos vulnerables:** Los datos indican que las mujeres dentro de la organización presentan una carga diagnóstica significativamente mayor. Esto permite a RR.HH. dejar de aplicar políticas de bienestar "genéricas" y empezar a diseñar intervenciones de Salud Mental con Perspectiva de Género, enfocadas en los factores de riesgo que afectan desproporcionadamente a este grupo (como la doble carga horaria o el techo de cristal).

* **Gestión Preventiva:** El hecho de que la búsqueda de tratamiento (**p < 0.001**) supere al Diagnóstico Profesional como predictor de depresión permite al área de Capital Humano evolucionar hacia un modelo de gestión preventiva:
    * **Identificación de la "Demanda Oculta":** Los datos sugieren que existe un segmento de la población que reconoce su malestar y actúa en consecuencia antes de obtener un diagnóstico formal. RR.HH. debe dejar de considerar el diagnóstico como la "puerta de entrada" para el apoyo y empezar a valorar la intención de búsqueda de ayuda como el indicador crítico de intervención.
    * **Reducción de barreras culturales:** Dado que la proactividad del empleado es el síntoma más sensible, la estrategia debe centrarse en la Alfabetización en Salud Mental. Si el empleado no se siente seguro para buscar ayuda (por estigma o miedo a represalias), perdemos el predictor más potente para gestionar el riesgo psicosocial.
    * **Optimización de programas de asistencia al empleado:** En lugar de políticas reactivas basadas en licencias médicas, el foco debe estar en facilitar canales de consulta rápida. El análisis de regresión muestra que cuando un empleado "levanta la mano", la probabilidad de que exista un cuadro depresivo subyecente es estadísticamente altísima, independientemente de si ya pasó por un psiquiatra o no.
    * **Sustento para políticas de género:** Al confirmar que las mujeres presentan una mayor carga diagnóstica y que su comportamiento de búsqueda es un predictor robusto, RR.HH. puede justificar la implementación de programas de bienestar con perspectiva de género, enfocados en la detección temprana y la flexibilidad laboral.

---

### Conclusión estratégica
> **No necesitamos esperar el diagnóstico para saber que hay un problema; la conducta de búsqueda de ayuda ya nos está dando la señal de alerta con una confianza estadística del 99.9%.**
