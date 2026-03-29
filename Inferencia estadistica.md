
# 🔬 INFERENCIA ESTADÍSTICA Y MODELADO

Este módulo se centra en la validación de hipótesis y la identificación de predictores significativos para la salud mental en el entorno laboral.

---

### 📉 Análisis de Asociación (Chi-cuadrado de Pearson)
**Acceso al Dashboard:** [Ver Pruebas de Independencia](https://jotabusconi.shinyapps.io/inferencia_chi2/)

Se evaluó la relación entre las variables categóricas para determinar si la distribución de trastornos es independiente del perfil demográfico.

* **Hallazgo Principal:** Se confirmó una asociación significativa (**p < 0.001**) entre el **Género** y la **Depresión**. 
* **Interpretación:** La evidencia estadística permite rechazar la hipótesis nula ($H_0$), confirmando que el género es un factor determinante en la carga diagnóstica dentro de esta muestra.
* **Coeficiente de Efecto:** Se utilizó la **V de Cramer** para medir la intensidad de esta asociación, obteniendo un valor que refuerza la relevancia del hallazgo para el área de RR.HH.

---

### 🤖 Modelo de Regresión Logística (GLM)
**Acceso al Dashboard:** [Ver Modelo de Predicción](https://jotabusconi.shinyapps.io/mental_health_glm_kramer/)

Se implementó un modelo lineal generalizado (GLM) de la familia binomial para identificar qué factores predicen con mayor precisión si un empleado se considera en un estado depresivo.

#### Resultados del Modelo:

| Variable | Coeficiente (Estimate) | P-value | Significancia |
| :--- | :---: | :---: | :---: |
| **Búsqueda de Tratamiento** | 1.15 | 0.00035 | Alta (***) |
| **Diagnóstico Profesional** | 0.17 | 0.58540 | No significativa |

---

### 💡 Conclusiones Técnicas y de Negocio

1.  **La Paradoja del Diagnóstico:** El modelo revela que tener un diagnóstico profesional **no es un predictor significativo** de que la persona reconozca su estado actual de depresión ($p > 0.05$). Esto sugiere una brecha entre la etiqueta clínica y la autopercepción/funcionalidad del empleado.
2.  **Proactividad como Síntoma:** La **Búsqueda de Tratamiento** resultó ser el predictor más robusto ($p = 0.00035$). Esto indica que la acción de pedir ayuda es la señal más clara y temprana de un cuadro depresivo, incluso antes de que el sistema formal lo valide.
3.  **Acción para People Analytics:** RR.HH. debe enfocar sus esfuerzos en reducir las barreras de acceso al tratamiento. Si facilitamos que el empleado "levante la mano", estamos capturando el predictor más confiable de riesgo psicosocial en la organización.

---
