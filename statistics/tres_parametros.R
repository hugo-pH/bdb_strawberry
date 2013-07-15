## Código para importar datos a partir de una tabla con cuatro columnas (nombre de la línea, longitud, ancho y ratio), calcular medias y desviación típica de cada línea, escribir estos estadísticos en una tabla y generar un diagrama de cajas en formato png.
## Instalar, si no lo tienes, el paquete data.table que usaremos más adelante (solo necesario una vez por sistema)
install.packages("ggplot2")
## Cargar el paquete data.table (cada vez que se necesite, o se puede incluir como opción del sistema en R)
library("ggplot2")
## Importar los datos desde un archivo "filename.csv" en el directorio de trabajo y extraer los nombres de las variables.
data<-read.table("filename3.csv",header=TRUE, sep=",")
xlab<-names(data[1])
ylab_v1<-names(data[2])
ylab_v2<-names(data[3])
ylab_v3<-names(data[4])
## Escribe la estructura y un resumen de los datos en un archivo
capture.output(str(data),file="estadistica_filename3.txt")
capture.output(summary(data),file="estadistica_filename3.txt", append=TRUE)

## Rutina estadística
## Test de normalidad
## con un test Shapiro-Wilk test (si p-value > 0.05 podemos asumir normalidad)
normalidad_v1<-shapiro.test(data[,2])
normalidad_v2<-shapiro.test(data[,3])
normalidad_v3<-shapiro.test(data[,4])
capture.output(normalidad_v1,file="estadistica_filename3.txt", append=TRUE)
capture.output(normalidad_v2,file="estadistica_filename3.txt", append=TRUE)
capture.output(normalidad_v3,file="estadistica_filename3.txt", append=TRUE)
## con una Kolmogorov-Smirnov test frente a una distribución normal de igual media y desviación típica que nuestros datos-
## No hay diferencias significativas con una distribución normal si p-value > 0.05
normalidad2_v1<-ks.test(data[,2], "pnorm", mean=mean(data[,2]), sd=sd(data[,2]))
normalidad2_v2<-ks.test(data[,3], "pnorm", mean=mean(data[,3]), sd=sd(data[,3]))
normalidad2_v3<-ks.test(data[,4], "pnorm", mean=mean(data[,4]), sd=sd(data[,4]))
capture.output(normalidad2_v1,file="estadistica_filename3.txt", append=TRUE)
capture.output(normalidad2_v2,file="estadistica_filename3.txt", append=TRUE)
capture.output(normalidad2_v3,file="estadistica_filename3.txt", append=TRUE)

## Evaluamos ahora la homogeneidad de la varianza (donde "Y" es la variable dependiente y "A*B*C" las combinaciones de variables independientes).
## Bartlett's test
homogeneidad_v1<-bartlett.test(LENGTH_VALUE ~ NAME,data)
homogeneidad_v2<-bartlett.test(WIDTH_VALUE ~ NAME,data)
homogeneidad_v3<-bartlett.test(RATIO ~ NAME,data)
capture.output(homogeneidad_v1,file="estadistica_filename3.txt", append=TRUE)
capture.output(homogeneidad_v2,file="estadistica_filename3.txt", append=TRUE)
capture.output(homogeneidad_v3,file="estadistica_filename3.txt", append=TRUE)
## Fligner's test
homogeneidad2_v1<-fligner.test(LENGTH_VALUE ~ NAME, data)
homogeneidad2_v2<-fligner.test(WIDTH_VALUE ~ NAME, data)
homogeneidad2_v3<-fligner.test(RATIO ~ NAME, data)
capture.output(homogeneidad2_v1,file="estadistica_filename3.txt", append=TRUE)
capture.output(homogeneidad2_v2,file="estadistica_filename3.txt", append=TRUE)
capture.output(homogeneidad2_v3,file="estadistica_filename3.txt", append=TRUE)
## ANOVA
fit_length<- aov(LENGTH_VALUE~NAME, data=data)
fit_width<- aov(WIDTH_VALUE~NAME, data=data)
fit_ratio<- aov(RATIO~NAME, data=data)
capture.output(fit_length,file="estadistica_filename3.txt", append=TRUE)
capture.output(summary(fit_length),file="estadistica_filename3.txt", append=TRUE)
capture.output(fit_width,file="estadistica_filename3.txt", append=TRUE)
capture.output(summary(fit_width),file="estadistica_filename3.txt", append=TRUE)
capture.output(fit_ratio,file="estadistica_filename3.txt", append=TRUE)
capture.output(summary(fit_ratio),file="estadistica_filename3.txt", append=TRUE)
## Comparación múltiple por grupos
Tukey_length<-TukeyHSD(fit_length)
Tukey_width<-TukeyHSD(fit_width)
Tukey_ratio<-TukeyHSD(fit_ratio)
capture.output(Tukey_length,file="estadistica_filename3.txt", append=TRUE)
capture.output(Tukey_width,file="estadistica_filename3.txt", append=TRUE)
capture.output(Tukey_ratio,file="estadistica_filename3.txt", append=TRUE)

## Rutina gráfica. 
## Genera un archivo png con una figura tipo diagrama de cajas usando los datos y las etiquetas que hemos creado antes.
png(filename="scatterplot_filename3.png")
ggplot(data, aes(x=WIDTH_VALUE, y=LENGTH_VALUE, color=NAME)) + geom_point() + scale_colour_hue(l=50) + geom_smooth(method=lm, se=FALSE)
dev.off()
png(filename="boxplot_ratio_filename3.png")
boxplot(data$RATIO ~ data$NAME,ylab=ylab_v3,xlab=xlab)
dev.off()

## Por hacer, faltaría mejorar las etiquetas del plot final, con nombres de variables más elaborados pero que no dependan de la etiqueta de la columna.
## También mejorar el formato del archivo de texto que va agrupando los resultados estadísticos, quizas con encabezados de sección entre test y test, además de breves instrucciones para interpretar los resutlados.