#  Análisis Geoespacial: Patrones de Gentrificación Turística en CDMX

##  Descripción
Análisis espacial avanzado que investiga la relación geográfica entre la distribución de propiedades Airbnb y la concentración de restaurantes bien evaluados en el barrio San Rafael, Ciudad de México. Utilizando el estadístico LISA Bivariante, este proyecto identifica clusters espaciales significativos que revelan patrones de gentrificación turística.

##  Objetivo de Investigación
**Pregunta central:** ¿Existen patrones espaciales significativos en la correlación entre la densidad de propiedades Airbnb y la concentración de restaurantes premium en el barrio San Rafael?

**Hipótesis:** La distribución de Airbnb y restaurantes de alta evaluación no es aleatoria, sino que forma clusters espaciales específicos que reflejan procesos de gentrificación turística.

##  Metodología

### Fuentes de Datos
- **Dataset geoespacial:** `sanrafa_airbnb_rest_final.shp`
- **Variables analizadas:**
  - `Cantidad_A`: Número de propiedades Airbnb por manzana/área
  - `Rest_BuenE`: Número de restaurantes con evaluaciones superiores a 4.5 estrellas

### Técnicas Estadísticas
- **LISA Bivariante (Local Indicators of Spatial Association)**
- **Matriz de vecindarios:** K-nearest neighbors (k=10)
- **Corrección de significancia:** False Discovery Rate (FDR)
- **Nivel de confianza:** 95% (α = 0.05)

### Stack Tecnológico
```r
library(spdep)    # Análisis de dependencia espacial
library(sf)       # Datos espaciales simples
library(rgeoda)   # Análisis geoespacial avanzado
library(ggplot2)  # Visualizaciones
