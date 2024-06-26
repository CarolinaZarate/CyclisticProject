# CASO PRÁCTICO: CYCLISTIC

Certificado Profesional de Análisis de datos de Google y Coursera

Práctica desarrollada por: Carolina Zárate Saldarriaga

Febrero/2024

## TABLA DE CONTENIDO

[1. INTRODUCCIÓN](#1-INTRODUCCIÓN)

[2. ESCENARIO](#2-ESCENARIO)

   [2.1. Acerca de la empresa](#21-acerca-de-la-empresa)
      
   [2.2. Hipótesis](#22-hipótesis)
      
   [2.3. Objetivo](#23-objetivo)
        
   [2.4. Interesados](#24-interesados)

[3. DATOS](#3-DATOS)

[4. PROCESAMIENTO DE DATOS](#4-PROCESAMIENTO-DE-DATOS)

[5. LIMPIEZA DE DATOS](#5-LIMPIEZA-DE-DATOS)

[6. ANÁLISIS Y VISUALIZACIÓN DE DATOS](#6-ANÁLISIS-Y-VISUALIZACIÓN-DE-DATOS)

[7. CONCLUSIONES](#7-CONCLUSIONES)

[8. RECOMENDACIONES](#8-RECOMENDACIONES)

   [8.1. De usuarios ocasionales a usuarios anuales](#81-De-usuarios-ocasionales-a-usuarios-anuales)

   [8.2. Acerca de los datos](#82-Acerca-de-los-datos)

## 1. INTRODUCCIÓN

El curso final del programa de Análisis de Datos de Google y Coursera presenta a los estudiantes un caso práctico que plantea situaciones reales a las que se enfrenta un analista de datos. Este caso, titulado ¿Cómo lograr el éxito rápido de un negocio de bicicletas compartidas?, está enfocado en el análisis de datos de Cyclistic, una empresa ficticia de alquiler de bicicletas.

Cyclistic atiende tanto a miembros anuales como a usuarios ocasionales. El equipo de marketing sostiene la hipótesis de que el futuro éxito de la empresa radica en maximizar el número de membresías anuales, dado el valor estratégico que representan para el crecimiento del negocio. Por lo tanto, buscan desarrollar estrategias basadas en datos para convertir a los usuarios ocasionales en miembros anuales.

El propósito de esta práctica es extraer conocimientos significativos de los datos de Cyclistic del año 2023 para proporcionar recomendaciones concretas al equipo de marketing. Utilizaremos el lenguaje de programación R para analizar las bases de datos y ofrecer insights accionables que impulsen la competitividad de la empresa.

## 2. ESCENARIO

### 2.1. Acerca de la empresa

En 2016, Cyclistic lanzó una exitosa oferta de bicicletas compartidas en Chicago. Las bicicletas se pueden desbloquear desde una estación y devolverse en cualquier otra estación del sistema en cualquier momento.

Hasta ahora, la estrategia de marketing de Cyclistic se basaba en la construcción de un reconocimiento de marca general y en atraer a amplios segmentos de consumidores. Uno de los enfoques que ayudó a hacer esto posible fue la flexibilidad de sus planes de precios: pases de un solo viaje, pases de un día completo y membresías anuales. A los clientes que compran pases de un solo viaje o pases de un día completo se los llama ciclistas ocasionales. Los clientes que compran membresías anuales se llaman miembros de Cyclistic.

Los analistas financieros de Cyclistic llegaron a la conclusión de que los miembros anuales son mucho más rentables que los ciclistas ocasionales. Aunque la flexibilidad de precios ayuda a Cyclistic a atraer más clientes, la directora de marketing cree que maximizar el número de miembros anuales será clave para el crecimiento futuro. En lugar de crear una campaña de marketing que apunte a todos los clientes nuevos, la directora de marketing cree que hay muchas posibilidades de convertir a los ciclistas ocasionales en miembros. Ella señala que los ciclistas ocasionales ya conocen el programa de Cyclistic y han elegido a Cyclistic para sus necesidades de movilidad.

El equipo de marketing estableció una meta clara: Diseñar estrategias de marketing orientadas a convertir a los ciclistas ocasionales en miembros anuales. Sin embargo, para hacer eso, el equipo de analistas de marketing necesita entender mejor cómo difieren los miembros anuales y los ciclistas ocasionales, por qué los ciclistas ocasionales comprarían una membresía y cómo los medios digitales podrían afectar sus tácticas de marketing.

### 2.2. Hipótesis

La directora de marketing de Cyclistic, cree que el éxito futuro de la empresa depende de maximizar la cantidad de membresías anuales. 

### 2.3. Objetivo

Identificar patrones de comportamiento entre miembros anuales y ciclistas ocasionales  que permitan establecer razones que podrían motivar a los ciclistas ocasionales a convertirse en miembros anuales, y en ese sentido que el equipo de Marketing pueda explorar cómo los medios digitales pueden ser utilizados para influenciar esta conversión. 

### 2.4. Interesados

El equipo de Marketing

## 3. DATOS

Se usarán los datos históricos de los viajes de Cyclistic entre enero y diciembre del año 2023 que se pueden descargar [aquí ](https://divvy-tripdata.s3.amazonaws.com/index.html)en formato CSV.

Cyclistic es una empresa ficticia y los datos han sido proporcionados, según información del curso, por Motivate International Inc. bajo esta  [licencia](https://www.divvybikes.com/data-license-agreement). Estos son datos públicos, sin embargo, hay que tener en cuenta que por cuestión de privacidad de los datos, se prohíbe el uso de información de identificación personal de los ciclistas. 

Al no haber identificación única para los usuarios se limita el análisis en los siguientes puntos: 

- No se podrá identificar si algún ciclista ocasional ya ha cambiado a ser miembro anual o viceversa.
- En caso de que algún ciclista ocasional haya cambiado a ser miembro anual, no se podrá identificar cuántos viajes realizó antes de hacer el cambio de tipo de membresía. 
- No se puede identificar cuántos pases compran por día los ciclistas ocasionales

Los datos tienen la siguiente información de los viajes:

_Tabla 1. Variables_

| Variable  | Tipo de variable | Descripción |
| ------------- | ------------- | ------------- |
| ride_id  | String  | Identificador único del viaje |
| rideable_type | String | Categoría del tipo de bicicleta usada en el viaje|
| started_at | Timestamp | Fecha y hora de inicio del viaje |
| ended_at | Timestamp | Fecha y hora de fin del viaje |
| start_station_name | String | Nombre de la estación de inicio del viaje | 
| start_station_id | String | Identificador único de la estación de inicio de viaje |
| end_station_name | String | Nombre de la estación de fin de viaje |
| end_station_id | String | Identificador único de la estación de fin de viaje |
| start_lat | Float | Latitud de la estación de inicio de viaje|
| start_lng | Float | Longitud de la estación de inicio de viaje | 
| end_lat | Float | Latitud de la estación de fin de viaje|
| end_lng | Float | Longitud de la estación de fin de viaje | 
| member_casual| String | Categoría del tipo de usuario del viaje|

Para claridad se indican las categorías para las siguientes variables: 

1. Rideable_type: Tiene tres posibles valores: 
- "classic_bike" : Para bicicletas clásicas que deben ser bloqueadas en una estación. 
- "docked_bike" : Para bicicletas clásicas que deben ser bloqueadas en una estación. 
- "electric_bike": Para bicicletas eléctricas que pueden ser bloqueadas en un rack público o en una estación. 

2. Member_casual: Tiene dos posibles valores: 
- "casual" : Usuarios ocasionales.
- "member" : Usuarios con membresía anual.

## 4. PROCESAMIENTO DE DATOS

En esta etapa, evaluamos la calidad de la información, para lo cual utilizamos el lenguaje de programación R.

**Ver notebook**

## 5. LIMPIEZA DE DATOS

En esta etapa, garantizamos la integridad de la información, para lo cual utilizamos el lenguaje de programación R.

## 6. ANÁLISIS Y VISUALIZACIÓN DE DATOS

El análisis se centrará en identificar patrones que puedan revelar los factores que motivan a los ciclistas ocasionales a adquirir una membresía anual. 
El objetivo es proporcionar insights significativos al equipo de marketing para apoyar la toma de decisiones estratégicas.

**Ver notebook**

Adicionalmente, se utilizó Power BI para generar un dashboard que facilite la comprensión de la información por parte de los interesados. Power BI ofrece varias ventajas que mejoran la capacidad del equipo de marketing para tomar decisiones informadas y basadas en datos, optimizando sus estrategias para convertir los ciclistas ocasionales en miembros anuales. 

**Ver enlace POWER BI**

## 7. CONCLUSIONES
Determine a los clientes casuales que tienden a utilizar el servicio para viajes de trabajo y presénteles la membresía, ya que estos tienen mayores posibilidades de registrarse.


## 8. RECOMENDACIONES

### 8.1. De usuarios ocasionales a usuarios anuales

Para maximizar la cantidad de membresías anuales, a partir de la conversión de usuarios ocasionales a usuarios anuales se tienen las siguientes recomendaciones:
- ón.
  
### 8.2. Acerca de los datos

Para enriquecer los insights y lograr un impacto más significativo en las decisiones del equipo de marketing,sería de gran utilidad contar con la siguiente información: 
- Identificación única para los usuarios, manteniendo las políticas de privacidad.
- Medio por donde se enteró y/o registró el usuario a Cyclistic.
- Valoraciones del servicio de cyclistic.
- Integración con otros modos de transporte.

Esta información permitiría, entre otros: 
- Identificar frecuencias de viaje.
- Evaluar la tasa de cambio del tipo de membresia.
- Analizar el comportamiento digital de los usuarios.
- Determinar rutas habituales.
- Planificar rutas más eficientes.
- Identificar áreas donde se puedan agregar más estaciones.
- Diseñar convenios con otros modos de transporte que sirvan de integración para los usuarios Cyclistic.


