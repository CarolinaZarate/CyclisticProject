#LIMPIEZA

#INSTALAR Y CARGAR PAQUETES

#Instalar paquetes
install.packages("readr")
install.packages("lubridate")
install.packages("summarytools")
install.packages("dplyr")

#Cargar paquetes
library(readr)
library(lubridate)
library(summarytools)
library(dplyr)

#1. IMPORTAR DATOS

datos_2023_V1 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/datos_2023_V0.csv")


#2. LIMPIEZA DE DATOS

#2.1. rideable_type

# Tenemos que docked_bike == classic_bike, entonces vamos a reemplazar docked_bike con classic_bike

# Reemplazar 'docked_bike' por 'classic_bike' en la columna rideable_type

datos_2023_V1$rideable_type <- ifelse(datos_2023_V1$rideable_type == "docked_bike", "classic_bike", datos_2023_V1$rideable_type)

# Verificar los cambios
unique(datos_2023_V1$rideable_type)

# Frecuencia de cada valor en la columna rideable_type
frecuencia_rideable_type <- table(datos_2023_V1$rideable_type)
print("Frecuencia de cada valor en la columna rideable_type:")
print(frecuencia_rideable_type)

#2.2.started_at y ended_at

# Para el caso de estudio se tiene en cuenta lo siguiente: 
# - Se tendrá un tiempo máximo para el préstamo de bicicletas de 6 horas.
# - Los viajes se realizan en un único día
# - Todos los viajes son realizados en el año 2023

# En ese sentido:
# - A partir de la columna started_at se generan las columnas: ride_date, ride_day_num, ride_day_txt, ride_month, ride_day_type.
# - Se genera una columna ride_length
# - Se evalúa la duración de los viajes, y se eliminan viajes inferiores a 5 minutos y superiores a 360 minutos (6 horas)

# Columna ride_date

datos_2023_V1$ride_date <- as.Date(datos_2023_V1$started_at)

# Columna ride_day_num

datos_2023_V1$ride_day_num <- day(datos_2023_V1$started_at)

# Columna ride_day_txt

datos_2023_V1$ride_day_txt <- wday(datos_2023_V1$started_at, label = TRUE, abbr = FALSE)

# Columna ride_month

datos_2023_V1$ride_month <- month(datos_2023_V1$started_at, label = TRUE, abbr = FALSE)

# Columna ride_day_type, indica si es fin de semana o día de semana

datos_2023_V1$ride_day_type <- ifelse(wday(datos_2023_V1$started_at) %in% c(1, 7), "Weekend", "Weekday")
                                
# Columna ride_length

datos_2023_V1$ride_length <- round(difftime(datos_2023_V1$ended_at, datos_2023_V1$started_at, units = "mins"))

# Resumen columna ride_length

resumen_ride_length <- dfSummary(datos_2023_V1$ride_length)
print(resumen_ride_length)

# Guardar el dataframe datos_2023_V1 en un archivo CSV

write.csv(datos_2023_V1, "C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/datos_2023_V1.csv", row.names = FALSE)

# Se eliminan viajes inferiores a 5 minutos y superiores a 360 minutos (6 horas)

datos_2023_V2 <- subset(datos_2023_V1, ride_length >= 5 & ride_length <= 360)

# Determinar porcentaje de viajes eliminados

n_filas_datos_2023_V1 <- nrow(datos_2023_V1)
n_filas_datos_2023_V2 <- nrow(datos_2023_V2)

filas_eliminadas <- n_filas_datos_2023_V1 - n_filas_datos_2023_V2

porcentaje_eliminadas <- (filas_eliminadas / n_filas_datos_2023_V1) * 100
print(paste("Se eliminaron", round(porcentaje_eliminadas, 2), "% de los viajes registrados."))

#2.3.Información de las estaciones

# Ver datos nulos

datos_nulos_stations <- colSums(is.na(datos_2023_V2[c("start_station_id", "start_station_name", "start_lat", "start_lng", "end_station_id", "end_station_name", "end_lat","end_lng")]))

porcentaje_nulos_stations <- (datos_nulos_stations / n_filas_datos_2023_V2) * 100

resumen_nulos_stations <- data.frame(
  variable = c("start_station_id", "start_station_name", "start_lat", "start_lng", "end_station_id", "end_station_name", "end_lat", "end_lng"),
  nulos_stations = datos_nulos_stations,
  porcentaje_nulos_stations = porcentaje_nulos_stations
)

print(resumen_nulos_stations)

# Ver datos únicos

# Seleccionar las columnas de interés
columnas_interes <- c("start_station_id", "start_station_name", "start_lat", "start_lng", 
                      "end_station_id", "end_station_name", "end_lat", "end_lng")

# Contar valores únicos por cada columna
valores_unicos_por_columna <- sapply(datos_2023_V2[, columnas_interes], function(x) length(unique(x)))

# Mostrar el resumen
print(valores_unicos_por_columna)

# Tenemos entonces:
# - Los nombres y id de las estaciones tienen un porcentaje de valores nulos de aproximadamente 14% cada uno.
# - La geolocalización en la estación de inicio es precisa y no tiene datos nulos. 
# - La geolocalización en la estación de fin es precisa con 0.008% de datos nulos.
# - Hay multiples geolocalizaciones por estación. 
# - Hay mayor cantidad de nombres de estaciones que de ID

# Para la limpieza de estos datos se requiere una base de datos de las estaciones, con sus id correspondientes y la ubicación geográfica.
# Para efectos de este caso práctico se trabajara con estos datos como se encuentran en el dataset original

#3. RESUMEN DE LOS DATOS

resumen_2023_V2 <- dfSummary(datos_2023_V2)
view (resumen_2023_V2)

#Guardar el resumen en un archivo HTML

archivo_html_2023_V2 <- "C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/R/resumen_2023_V2.html"
print(resumen_2023_V2, file = archivo_html_2023_V2)

# Abrir el archivo HTML en el navegador
browseURL(archivo_html_2023_V2)

# Guardar el dataframe datos_2023_V2 en un archivo CSV

write.csv(datos_2023_V2, "C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/datos_2023_V2.csv", row.names = FALSE)


