Análisis Exploratorio de Afecciones Mentales en el Trabajo
Mental Health in Tech: Investigacion exploratoria centrada en la salud mental en el trabajo

Esta simulacion analiza la prevalencia y los determinantes de la salud mental (específicamente la depresión) en trabajadores del sector IT, utilizando el dataset de OSMI. El objetivo es transformar datos crudos en insights accionables para la gestión de Recursos Humanos.
Tecnologías y Metodologías

    Lenguaje: R (tidyverse, ggplot2, vcd, stats).

    Estadística Inferencial: Test de Chi-cuadrado de Pearson, Test Exacto de Fisher, Coeficiente V de Cramer.

    Modelado: Regresión Logística Binomial para predicción de riesgo.

    Visualización: Mapas de calor (Heatmaps) de asociación y Boxplots de comorbilidad normalizados.

Hallazgos Clave (hasta el momento)

    Brecha de Género: Se confirmó una asociación significativa (p<0.001) entre el género y la depresión. Las mujeres presentan una mayor carga diagnóstica.
	
    
    

    Predictores de Comportamiento: La búsqueda de tratamiento resultó ser un predictor más robusto de salud mental que el diagnóstico profesional formal, sugiriendo que la proactividad del empleado es un síntoma crítico.

                 Variable	Coeficiente (Estimate)	P-value	Significancia
                 Búsqueda de Tratamiento	1.15	0.00035	Alta ()*
                 Diagnóstico Profesional	0.17	0.58540	No significativa



Por qué la Búsqueda de Tratamiento es un predictor más robusto? 
Mientras que el diagnóstico profesional no resultó significativo en el modelo (p>0.05), la búsqueda activa de tratamiento mostró una relación poderosa. 
Esto indica que la conducta de pedir ayuda es el síntoma más sensible y el predictor más temprano de un cuadro depresivo, incluso antes de que el sistema de salud formalice la patología.

El análisis permite al area de Recursos Humanos:

    Diseñar programas de asistencia con foco en la depresion y con perspectiva de género.

    Validar que la salud mental es un fenómeno sistémico del sector y no derivado únicamente del tipo de contrato (independiente vs en relacion de dependencia)

Por otra parte, la asociacion entre genero y ansiedad presentó un (p>0.05) demostrando que no existe una asociacion significativa entre estas variables.