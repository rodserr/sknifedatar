% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_longer_crime.R
\docType{data}
\name{data_longer_crime}
\alias{data_longer_crime}
\title{Esquinas de la ciudad de Buenos Aires con factores meteorológicos y de entorno}
\format{
Un data frame con 2023 filas y 136 columnas, las variables esquina, long y lat, representan el ID de la esquina y la gelocalización de la misma. Para ver un proyecto de ciencia de datos aplicado sobre este dataset consultar \href{https://rafael-zambrano-blog-ds.netlify.app/posts}{Predicción de delitos en CABA}
}
\source{
\url{https://rafzamb.github.io/sknifedatar}
}
\usage{
data_longer_crime
}
\description{
Conjunto de datos que contiene 2023 esquinas de la ciudad de Buenos Aires, producto de la intercepción de
las principales calles y avenidas. Cada fila es una esquina,  las columnas representan factores climáticos,
elementos de entorno físico y recuentos de delitos ocurridos en las cercanías de cada esquina. Los datos originales fueron extraídos de los
repositorios \href{https://www.openstreetmap.org/}{Openstreetmap} y  \href{https://data.buenosaires.gob.ar/dataset/delitos/}{GCABA},
posteriormente fueron transformados hasta obtener la estructura tabular que acá se presenta.
}
\section{Variables de criminalidad}{

Para cada esquina se registra el número de delitos que ocurrieron en cada mes del periodo diciembre 2017 - diciembre-2019. En total son 25 columnas de criminalidad, que hacen referencia a los 25 meses del periodo de estudio. Los atributos están ordenados cronológicamente, pueden identificarse con el prefijo “delitos”, seguido del mes y año, por ejemplo: delitos_dec_2017.
}

\section{Variables climaticas}{

Se estudian 4 factores climáticos: temperatura promedio, velocidad del viento promedio, milímetros de agua y días de lluvia. Almacenando sus valores en 25 columnas para cada variable, en referencia a los 25 meses del periodo diciembre 2017 - diciembre-2019. Los atributos están ordenados cronológicamente, pueden identificarse con el prefijo del factor climático, seguido del mes y año, por ejemplo: dias_lluvia_feb_2018.
}

\section{Variables de entorno cercano}{

Para cada esquina se cuentan los elementos de entorno físico que estén dentro de un radio de 250 metros, por ejemplo el número de estaciones de metro, comisarías, universidades, locales gastronómicos, entre otros. En total son 38 atributos de entorno.
}

\keyword{datasets}
