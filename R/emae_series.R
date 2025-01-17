#' @title Series del indicaro EMAE
#'
#' @description El EMAE es un indicador que refleja la evolución mensual de la actividad económica del conjunto de los
#'              sectores productivos a nivel nacional para Argentina, para mas detalles consultar \href{https://www.indec.gob.ar/indec/web/Nivel4-Tema-3-9-48}{EMAE indicador}.
#'              Se obtuvieron datos de todas las series de EMAE sectorial, desde Enero 2004 hasta Octubre 2020, los datos
#'              fueron extraidos desde \href{https://datos.gob.ar/dataset/jgm_3/archivo/jgm_3.13}{Series de Tiempo (API)} del Gobierno de la Ciudad de Buenos Aires.
#'
#' @format Un data frame con 3104 filas y 3 columnas, la variable "date" representa la fecha mensual, "value" el valor mensual del indicador y
#'         la columna sector indica el id o sector económico de las series.
#'
#' @source \url{https://datos.gob.ar/dataset/jgm_3/archivo/jgm_3.13}
"emae_series"
