install.packages ("rgeoda")
install.packages("spdep")
install.packages("bispdep")
library(spdep)
library(bispdep)
library (sf)
library(rgeoda)

datos <- st_read("sanrafa_airbnb_rest_final.shp")

coords <- st_distance(st_geometry(datos))
col.knn <- knearneigh(coords)
sr.nb <- knn2nb(knearneigh(coords, k=10))
summary (sr.nb, coords, longlat = TRUE, scale=0.5)

set.seed(11)
x=runif(100, -1, 1)
y=runif(100, -1, 1)
full=data.frame(x,y)
neighs_k <- knn2nb(knearneigh(as.matrix(listw), k = 10))  
neighs_mat_k <- nb2listw(neighs_k, style = "W",zero.policy=TRUE) 

bilisa_result <- localmoran.bi(datos$Cantidad_A, datos$Rest_BuenE, sr.nb,
                               zero.policy = TRUE, na.action = na.omit)

lisa <- localmoran.bi(varx, vary, neighs_k, zero.policy=NULL,na.action=na.fail,conditional=TRUE,
                      alternative="two.sided",mlvar=TRUE,spChk=NULL,adjust.x=FALSE)


( fdr <- lisa_fdr(lisa, 0.05) )

lisa_colors <- lisa_colors(lisa)
lisa_labels <- lisa_labels(lisa)
lisa_clusters <- lisa_clusters(lisa)

plot(st_geometry(datos), col=sapply(lisa_clusters, 
                                     function(x){return(lisa_colors[[x+1]])}), 
     border = "#333333", lwd=0.2)
title(main = "Univaraite Local Moran")
legend('bottomleft', legend = lisa_labels, fill = lisa_colors, 
       border = "#eeeeee")