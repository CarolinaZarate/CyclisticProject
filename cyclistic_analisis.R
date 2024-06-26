#ANÁLISIS DE DATOS

#INSTALAR Y CARGAR PAQUETES

#Instalar paquetes
install.packages("readr")
install.packages("lubridate")
install.packages("summarytools")
install.packages("dplyr")
install.packages("ggplot2")

#Cargar paquetes
library(readr)
library(lubridate)
library(summarytools)
library(dplyr)
library(ggplot2)

#1. IMPORTAR DATOS

datos_2023_V2 <- read_csv("C:/Users/FERNEY/Documents/Carolina/Estudio/GoogleCertificate/8casoPractico/cyclistic/csv/datos_2023_V2.csv")

#2. ANÁLISIS DE DATOS

#2.1. CANTIDAD DE VIAJES POR TIPO DE USUARIO

conteo_ride_id <- datos_2023_V2 %>%
  group_by(member_casual) %>%
  summarise(cantidad_ride_id = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_id / sum(cantidad_ride_id) * 100)

#Gráfica 1 - Cantidad de viajes por tipo de usuario

ggplot(conteo_ride_id, aes(x = member_casual, y = cantidad_ride_id, fill = member_casual)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(breaks = seq(0, 3000000, 250000), labels = scales::comma) +
  labs(title = "Cantidad de viajes por tipo de usuario",
       subtitle = "Datos 2023",
       x = "Tipo de usuario",
       y = "Cantidad de viajes") +
  geom_text(aes(label = scales::comma ((cantidad_ride_id)), vjust = 4)) +
  geom_text(aes(label = paste0(round(cantidad_ride_id/nrow(datos_2023_V2)*100,2), "%"), vjust = 2))+
  theme_minimal()

#2.2. CANTIDAD DE VIAJES POR TIPO DE BICICLETA

conteo_ride_bicicleta <- datos_2023_V2 %>%
  group_by(rideable_type) %>%
  summarise(cantidad_ride_bicicleta = n())%>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_bicicleta / sum(cantidad_ride_bicicleta) * 100)

#Gráfica 2 - Cantidad de viajes por tipo de bicicleta

ggplot(conteo_ride_bicicleta, aes(x = rideable_type, y = cantidad_ride_bicicleta, fill = rideable_type)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(breaks = seq(0, 2500000, 250000), labels = scales::comma) +
  labs(title = "Cantidad de viajes por tipo de bicicleta",
       subtitle = "Datos 2023",
       x = "Tipo de bicicleta",
       y = "Cantidad de viajes") +
  geom_text(aes(label = paste0(scales::comma(cantidad_ride_bicicleta), "\n(", round(porcentaje, 2), "%)")), 
           position = position_dodge(width = 0.9), vjust = 2) +
  theme_minimal()

#2.3. CANTIDAD DE VIAJES POR TIPO DE USUARIO Y TIPO DE BICICLETA

viajes_usuario_bicicleta <- datos_2023_V2 %>%
  group_by(member_casual, rideable_type) %>%
  summarise(cantidad_ride_id = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_id / sum(cantidad_ride_id) * 100)

#Gráfica 3 - Cantidad de viajes por tipo de usuario y tipo de bicicleta

ggplot(viajes_usuario_bicicleta, aes(x = member_casual, y = cantidad_ride_id, fill = rideable_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(scales::comma(cantidad_ride_id), "\n(", round(porcentaje, 2), "%)")), 
            position = position_dodge(width = 0.9), vjust = 2) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Tipo de Usuario",
    y = "Cantidad de Viajes",
    fill = "Tipo de Bicicleta",
    title = "Cantidad de viajes por tipo de usuario y tipo de bicicleta",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()

#2.4. PROMEDIO DE DURACION DE VIAJES POR TIPO DE USUARIO

duracion_usuario <- datos_2023_V2 %>%
  group_by(member_casual) %>%
  summarise(promedio_duracion = mean(ride_length)) %>%
  ungroup()

#Gráfica 4 - Duración promedio de viajes por tipo de usuario

ggplot(duracion_usuario, aes(x = member_casual, y = promedio_duracion, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(scales::comma(promedio_duracion))), 
            position = position_dodge(width = 0.9), vjust = 2) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Tipo de Usuario",
    y = "Promedio duración de viaje (min)",
    fill = "Tipo de Usuario",
    title = "Duración promedio de viajes en minutos por tipo de usuario.",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()

#2.5. CANTIDAD DE VIAJES MENSUALES POR TIPO DE USUARIO

conteo_ride_month <- datos_2023_V2 %>%
  group_by(member_casual, ride_month) %>%
  summarise(cantidad_ride_month = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_month / sum(cantidad_ride_month) * 100)


#Gráfica 5 - Cantidad de viajes mensuales por tipo de usuario

ggplot(conteo_ride_month, aes(x = ride_month, y = cantidad_ride_month, color = member_casual, group = member_casual)) +
  geom_line(size=1) +
  geom_point(size=3) +
  scale_y_continuous(breaks = seq(0, 400000, 50000), labels = scales::comma) +
  scale_x_discrete(labels = c ("Ene.", "Feb.", "Mar.", "Ab.", "May.", "Jun.", "Jul.", "Agt.", "Sept.", "Oct.", "Nov.", "Dic.")) +
  labs(
    x = "Mes de viaje",
    y = "Cantidad de viajes",
    color = "Tipo de Usuario",
    title = "Cantidad de viajes mensuales por tipo de usuario",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()

#2.6. CANTIDAD DE VIAJES POR TIPO DE USUARIO Y TIPO DE DIA

conteo_ride_day_type <- datos_2023_V2 %>%
  group_by(member_casual, ride_day_type) %>%
  summarise(cantidad_ride_day_type = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_day_type / sum(cantidad_ride_day_type) * 100)


#Gráfica 6 - Cantidad de viajes por tipo de usuario y por tipo de día

ggplot(conteo_ride_day_type, aes(x = ride_day_type, y = cantidad_ride_day_type, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(scales::comma(cantidad_ride_day_type), "\n(", round(porcentaje, 2), "%)")), 
            position = position_dodge(width = 0.9), vjust = 2) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Tipo de día",
    y = "Cantidad de viajes",
    fill = "Tipo de Usuario",
    title = "Cantidad de viajes por tipo de usuario y por tipo de día",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()


#2.7. CANTIDAD DE VIAJES MENSUALES POR TIPO DE USUARIO Y POR TIPO DE DIA

conteo_ride_month_day_type <- datos_2023_V2 %>%
  group_by(member_casual, ride_month, ride_day_type) %>%
  summarise(cantidad_ride_day_type = n(), cantidad_ride_month = n()) %>%
  ungroup() %>%

#Gráfica 7 - Cantidad de viajes mensuales por tipo de usuario y por tipo de dia

ggplot(conteo_ride_month_day_type, aes(x = ride_month, y = cantidad_ride_day_type, color = interaction(member_casual, ride_day_type), group = interaction(member_casual, ride_day_type))) +
  geom_line(size=1) +
  geom_point(size=3) +
  scale_y_continuous(breaks = seq(0, 400000, 50000), labels = scales::comma) +
  scale_x_discrete(labels = c ("Ene.", "Feb.", "Mar.", "Ab.", "May.", "Jun.", "Jul.", "Agt.", "Sept.", "Oct.", "Nov.", "Dic.")) +
  labs(
    x = "Mes de viaje",
    y = "Cantidad de viajes",
    color = "Tipo de Usuario/Tipo de Día",
    title = "Cantidad de viajes mensuales por tipo de usuario y tipo de día",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()

#2.8. PROMEDIO DE DURACION DE VIAJES POR TIPO DE USUARIO Y TIPO DE DIA

duracion_usuario_tipo_dia <- datos_2023_V2 %>%
  group_by(member_casual, ride_day_type) %>%
  summarise(promedio_duracion = mean(ride_length)) %>%
  ungroup()

#Gráfica 8 - Duración promedio de viajes por tipo de usuario

ggplot(duracion_usuario_tipo_dia, aes(x = ride_day_type, y = promedio_duracion, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(scales::comma(promedio_duracion))), 
            position = position_dodge(width = 0.9), vjust = 2) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Tipo de Día",
    y = "Promedio duración de viaje (min)",
    fill = "Tipo de Usuario",
    title = "Duración promedio de viajes en minutos por tipo de usuario y tipo de día.",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()


#2.9. DURACIÓN PROMEDIO DE VIAJES MENSUALES POR TIPO DE USUARIO Y POR TIPO DE DIA

duracion_usuario_mes <- datos_2023_V2 %>%
  group_by(member_casual, ride_month, ride_day_type) %>%
  summarise(promedio_duracion_ensayo = mean(ride_length)) %>%
  ungroup()
  
#Gráfica 9 - Promedio de duración de viajes mensuales por tipo de usuario y por tipo de dia
  
  ggplot(ensayito, aes(x = ride_month, y = promedio_duracion_ensayo, color = interaction(member_casual, ride_day_type), group = interaction(member_casual, ride_day_type))) +
  geom_line(size=1) +
  geom_point(size=3) +
  scale_y_continuous(breaks = seq(0, 30, 5), labels = scales::comma) +
  scale_x_discrete(labels = c ("Ene.", "Feb.", "Mar.", "Ab.", "May.", "Jun.", "Jul.", "Agt.", "Sept.", "Oct.", "Nov.", "Dic.")) +
  labs(
    x = "Mes de viaje",
    y = "Promedio de viaje (min)",
    color = "Tipo de Usuario/Tipo de Día",
    title = "Promedio de duración de viajes mensuales por tipo de usuario y tipo de día",
    subtitle = "Datos 2023"
  ) +
  theme_minimal()
  
#2.10. TOP 10 ESTACIÓN MÁS UTILIZADA POR TIPO DE USUARIO Y DÍA PARA INICIAR EL VIAJE

#Tehiendo en cuenta que las estaciones presentan muchos datos nulos
#Se filtran los datos nulos
  
datos_2023_V3_sin_nulos <- datos_2023_V2 %>%
    filter(!is.na(start_station_name), !is.na(end_station_name))
  
#TOP 10
top_10_start_stations <- datos_2023_V3_sin_nulos %>%
  group_by(start_station_name) %>%
  summarise(total_rides = n()) %>%
  arrange(desc(total_rides)) %>%
  slice_head(n = 10) %>%
  pull(start_station_name)

datos_top_10_start_stations <- datos_2023_V3_sin_nulos %>%
  filter(start_station_name %in% top_10_start_stations)

estacion_inicio_usuario_dia <- datos_top_10_start_stations %>%
  group_by(member_casual, start_station_name, ride_day_type) %>%
  summarise(cantidad_ride_day_type = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_day_type / sum(cantidad_ride_day_type) * 100)
  
#Gráfica 10. Top 10 estación más utilizada por tipo de usuario para iniciar el viaje

ggplot(estacion_inicio_usuario_dia, aes(x = cantidad_ride_day_type, y = start_station_name, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_continuous(labels = scales::comma) +
  labs(
    x = "Cantidad de viajes",
    y = "Estación de inicio",
    fill = "Tipo de Usuario",
    title = "Top 10 estaciones más utilizadas para iniciar el viaje por tipo de usuario.",    subtitle = "Datos 2023"
  ) +
  theme_minimal()


#2.11. TOP 10 ESTACIÓN MÁS UTILIZADA POR TIPO DE USUARIO Y DÍA PARA FINALIZAR EL VIAJE

#Tehiendo en cuenta que las estaciones presentan muchos datos nulos
#Se filtran los datos nulos

datos_2023_V3_sin_nulos <- datos_2023_V2 %>%
  filter(!is.na(start_station_name), !is.na(end_station_name))

#TOP 10
top_10_end_stations <- datos_2023_V3_sin_nulos %>%
  group_by(end_station_name) %>%
  summarise(total_rides = n()) %>%
  arrange(desc(total_rides)) %>%
  slice_head(n = 10) %>%
  pull(end_station_name)

datos_top_10_end_stations <- datos_2023_V3_sin_nulos %>%
  filter(end_station_name %in% top_10_end_stations)

estacion_fin_usuario_dia <- datos_top_10_end_stations %>%
  group_by(member_casual, end_station_name, ride_day_type) %>%
  summarise(cantidad_ride_day_type = n()) %>%
  ungroup() %>%
  mutate(porcentaje = cantidad_ride_day_type / sum(cantidad_ride_day_type) * 100)

#Gráfica 11. Top 10 estación más utilizada por tipo de usuario para finalizar el viaje

ggplot(estacion_fin_usuario_dia, aes(x = cantidad_ride_day_type, y = end_station_name, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_x_continuous(labels = scales::comma) +
  labs(
    x = "Cantidad de viajes",
    y = "Estación de fin",
    fill = "Tipo de Usuario",
    title = "Top 10 estaciones más utilizadas para finalizar el viaje por tipo de usuario.",    subtitle = "Datos 2023"
  ) +
  theme_minimal()