#PROCESAMIENTO

#INSTALAR Y CARGAR PAQUETES

#Instalar paquetes
install.packages("readr")
install.packages("dplyr")
install.packages("summarytools")

#Cargar paquetes
library(readr)
library(dplyr)
library(summarytools)

#1. IMPORTAR DATOS

enero_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202301-divvy-tripdata.csv")
febrero_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202302-divvy-tripdata.csv")
marzo_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202303-divvy-tripdata.csv")
abril_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202304-divvy-tripdata.csv")
mayo_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202305-divvy-tripdata.csv")
junio_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202306-divvy-tripdata.csv")
julio_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202307-divvy-tripdata.csv")
agosto_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202308-divvy-tripdata.csv")
septiembre_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202309-divvy-tripdata.csv")
octubre_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202310-divvy-tripdata.csv")
noviembre_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202311-divvy-tripdata.csv")
diciembre_2023 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/202312-divvy-tripdata.csv")

#2. VISTA PRELIMINAR DE LOS DATOS

#Se verifica que cada archivo contenga las mismas columnas y tipos de variables

str(enero_2023)
str(febrero_2023)
str(marzo_2023)
str(abril_2023)
str(mayo_2023)
str(junio_2023)
str(julio_2023)
str(agosto_2023)
str(septiembre_2023)
str(octubre_2023)
str(noviembre_2023)
str(diciembre_2023)

#3. DATAFRAME PARA LIMPIEZA DE DATOS

#Una vez confirmado que todos los archivos CSV contienen las mimas columnas y tipos de variables, se procede a juntarlos para tener un solo dataframe

datos_2023_V0 <- bind_rows(
  enero_2023, 
  febrero_2023, 
  marzo_2023, 
  abril_2023, 
  mayo_2023, 
  junio_2023, 
  julio_2023, 
  agosto_2023, 
  septiembre_2023,
  octubre_2023,
  noviembre_2023,
  diciembre_2023
)

#4. RESUMEN DE LOS DATOS

resumen_2023_V0 <- dfSummary(datos_2023_V0)
view (resumen_2023_V0)

#Guardar el resumen en un archivo HTML

archivo_html_2023_V0 <- "C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/R/resumen_2023_V0.html"
print(resumen_2023_V0, file = archivo_html_2023_V0)

# Abrir el archivo HTML en el navegador
browseURL(archivo_html_2023_V0)

#Del resumen se puede identificar:
#- Hay un total de 5.719.877 filas y 13 columnas
#- No hay duplicados ni valores nulos en la variable ride_id
#- En la variable rideable_type están los tres posibles valores "classic_bike", "docked_bike" y "electric_bike". 
#- Los datos de inicio y fin de viaje contienen tanto la fecha como la hora en una sola columna
#- Falta el 15.3% de los datos de nombre y id de las estaciones de inicio
#- Falta el 16.2% de los datos de nombre y id de las estaciones de fin

# Guardar el dataframe datos_2023_V0 en un archivo CSV

write.csv(datos_2023_V0, "C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/datos_2023_V0.csv", row.names = FALSE)
