
### Fuente de Datos
- Shapefile geoespacial: `sanrafa_airbnb_rest_final.shp`
- Variables analizadas:
  - `Cantidad_A`: Número de propiedades Airbnb por unidad espacial
  - `Rest_BuenE`: Número de restaurantes con alta evaluación por unidad espacial

### Técnicas Estadísticas
- **LISA Bivariante** (Local Moran's I Bivariante)
- **Definición de vecindarios:** K-nearest neighbors (k=10)
- **Significancia estadística:** Corrección por FDR (False Discovery Rate)

### Librerías Utilizadas
```r
library(spdep)      # Análisis de dependencia espacial
library(bispdep)    # LISA bivariante
library(sf)         # Datos espaciales
library(rgeoda)     # Análisis geoespacial avanzado
```

## Código Principal

```r
# Carga y preparación de datos espaciales
datos <- st_read("sanrafa_airbnb_rest_final.shp")

# Definición de matriz de vecindarios (10 vecinos más cercanos)
sr.nb <- knn2nb(knearneigh(coords, k=10))

# Análisis LISA bivariante
bilisa_result <- localmoran.bi(datos$Cantidad_A, datos$Rest_BuenE, sr.nb,
                               zero.policy = TRUE, na.action = na.omit)

# Corrección de significancia estadística
fdr <- lisa_fdr(lisa, 0.05)
```

## Resultados e Interpretación

### Tipos de Clusters Identificados
| Cluster | Interpretación | Implicaciones |
|---------|----------------|---------------|
| **Alto-Alto** | Alta densidad Airbnb + Alta concentración restaurantes | Zonas de gentrificación turística consolidada |
| **Alto-Bajo** | Alta densidad Airbnb + Baja concentración restaurantes | Oportunidad para desarrollo gastronómico |
| **Bajo-Alto** | Baja densidad Airbnb + Alta concentración restaurantes | Potencial para desarrollo de hospedaje |
| **Bajo-Bajo** | Baja densidad Airbnb + Baja concentración restaurantes | Zonas fuera del circuito turístico |

### Visualización
```r
# Mapa de clusters LISA
plot(st_geometry(datos), 
     col = sapply(lisa_clusters, function(x){return(lisa_colors[[x+1]])}), 
     border = "#333333", lwd = 0.2)
title(main = "LISA Bivariante: Airbnb vs Restaurantes")
legend('bottomleft', legend = lisa_labels, fill = lisa_colors)
```

##  Estructura del Proyecto
```
analisis-espacial/
├── data/
│   └── sanrafa_airbnb_rest_final.shp
├── scripts/
│   ├── 01_preprocesamiento.R
│   ├── 02_analisis_espacial.R    # Código principal
│   └── 03_visualizacion.R
├── outputs/
│   ├── mapas/                    # Visualizaciones geoespaciales
│   ├── tablas/                   # Resultados estadísticos
│   └── reporte_analisis.pdf
└── README.md
```

##  Aplicaciones y Hallazgos

### Aportes a la Investigación Urbana
- Identificación de **patrones de gentrificación turística**
- **Planificación estratégica** de desarrollo comercial
- **Análisis de mercados** para inversión en hospitality

### Hallazgos Esperados
- Clusters significativos de correlación espacial entre turismo y gastronomía
- Patrones territoriales que explican dinámicas de desarrollo urbano
- Identificación de áreas de oportunidad para desarrollo económico

##  Próximos Pasos
- [ ] Análisis temporal (evolución de clusters)
- [ ] Incorporación de variables socioeconómicas adicionales
- [ ] Modelización de factores explicativos de los clusters
- [ ] Desarrollo de dashboard interactivo

