
# sknifedatar <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->

[![made-with-R](https://img.shields.io/badge/Made%20with-R-1f425f.svg)](https://www.r-project.org/)
[![GitHub
license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/rafzamb/sknifedatar/blob/master/LICENSE)
<!-- badges: end -->

**Swiss Knife of Data for R**: Colección de funciones que facilitan el
desarrollo de las distintas etapas de un proyecto de ciencia de datos.

## Installation

Install the development version from GitHub with:

    # install.packages("devtools")
    devtools::install_github("rafzamb/sknifedatar")
    library(sknifedatar)

## Usage

``` r
library(sknifedatar)
library(dplyr)
```

### Función multieval

Para un conjunto de predicciones de distintos modelos, permite evaluar
múltiples métricas y devolver los resultados en un formato tabular que
facilita la comparación de las predicciones.

``` r
library(yardstick)
library(erer)

set.seed(123)
predictions =
  data.frame(truth = runif(100),
             predict_model_1 = rnorm(100, mean = 1,sd =2),
             predict_model_2 = rnorm(100, mean = 0,sd =2))

tibble(predictions)
#> # A tibble: 100 x 3
#>     truth predict_model_1 predict_model_2
#>     <dbl>           <dbl>           <dbl>
#>  1 0.288            1.51            1.58 
#>  2 0.788            0.943           1.54 
#>  3 0.409            0.914           0.664
#>  4 0.883            3.74           -2.02 
#>  5 0.940            0.548          -0.239
#>  6 0.0456           4.03           -0.561
#>  7 0.528           -2.10            1.13 
#>  8 0.892            2.17           -0.745
#>  9 0.551            1.25            1.95 
#> 10 0.457            1.43           -0.749
#> # … with 90 more rows
```

``` r
multieval(data = predictions,
          observed = "truth",
          predictions = c("predict_model_1","predict_model_2"),
          metrica = erer::listn(rmse, rsq, mae))
#> # A tibble: 6 x 4
#>   .metric .estimator .estimate model          
#>   <chr>   <chr>          <dbl> <chr>          
#> 1 mae     standard    1.59     predict_model_1
#> 2 mae     standard    1.61     predict_model_2
#> 3 rmse    standard    1.99     predict_model_1
#> 4 rmse    standard    1.95     predict_model_2
#> 5 rsq     standard    0.000704 predict_model_1
#> 6 rsq     standard    0.00115  predict_model_2
```

### Función pertenencia\_punto

Dado dos conjuntos de puntos geolocalizados, esta función permite
determinar para cada punto del primer conjunto de datos, cuál o cuáles
de los puntos del segundo conjunto de datos están dentro de un radio de
metros determinado.

-   Muestra de 100 crimenes ocurridos en CABA.

``` r
head(crimes)
#> # A tibble: 6 x 9
#>       id fecha      franja_horaria tipo_delito subtipo_delito comuna barrio
#>    <dbl> <date>              <dbl> <chr>       <chr>           <dbl> <chr> 
#> 1 341734 2018-08-29              0 Robo (con … <NA>                5 Boedo 
#> 2 257029 2018-09-17             15 Hurto (sin… <NA>                6 Cabal…
#> 3 307285 2018-03-16             18 Robo (con … <NA>               14 Paler…
#> 4 314525 2018-02-12             12 Robo (con … <NA>                3 Balva…
#> 5 347997 2018-06-15              9 Robo (con … <NA>                7 Parqu…
#> 6 240042 2017-12-12             14 Robo (con … <NA>               13 Nuñez 
#> # … with 2 more variables: lat <dbl>, long <dbl>
```

-   2023 esquinas de CABA uniformemente distribuidas sobre la ciudad.

``` r
head(intercepcion_calles)
#>   id      long       lat
#> 1  1 -58.47533 -34.53936
#> 2  2 -58.49107 -34.54576
#> 3  3 -58.46640 -34.53487
#> 4  4 -58.49474 -34.54741
#> 5  5 -58.39515 -34.57223
#> 6  6 -58.38185 -34.59158
```

-   Para cada delito, se determina la esquina que está dentro de un
    radio de cercanía inferior a 150 metros.

``` r
esquina = data.frame(pertenencia_esquina = pertenencia_punto(data = crimes, 
                                          referencia = intercepcion_calles,
                                          metros = 150) %>% 
                       unlist())
```

-   Data frame con los delitos y sus esquinas de cercaria.

``` r
crimes %>% 
  select(id) %>% 
  bind_cols(esquina)
#> # A tibble: 100 x 2
#>        id pertenencia_esquina
#>  *  <dbl>               <dbl>
#>  1 341734                1125
#>  2 257029                2086
#>  3 307285                 241
#>  4 314525                 331
#>  5 347997                2268
#>  6 240042                   0
#>  7 420664                 574
#>  8 304656                1355
#>  9 253948                 721
#> 10 265219                 783
#> # … with 90 more rows
```

### Función sliding\_window

Esta función permite aplicar una transformación de ventana deslizante
móvil mensual sobre un conjunto de datos. Se define el número de
pliegues y los tipos de variables a calcular. Para ver una explicación
detallada y un caso de uso de esta función con código R, consultar
[Predicción de ocurrencia de delitos /
sliding\_window](https://rafael-zambrano-blog-ds.netlify.app/posts/2020-12-22-prediccin-de-delitos-en-caba/#aplicaci%C3%B3n-de-ventanas-deslizantes).

``` r
pliegues = 1:13
names(pliegues) = pliegues

variables = c("delitos", "temperatura", "mm_agua", "lluvia", "viento")
names(variables) = variables

sliding_window(data = data_crime_clime %>% dplyr::select(-c(long,lat)),
               inicio = 13,
               pliegues = pliegues,
               variables = variables)
#> # A tibble: 26,299 x 32
#>    id    pliegue delitos_last_ye… delitos_last_12 delitos_last_6 delitos_last_3
#>    <chr>   <int>            <dbl>           <dbl>          <dbl>          <dbl>
#>  1 esqu…       1                1              73             41             20
#>  2 esqu…       1                5             106             47             19
#>  3 esqu…       1                4              25             11              4
#>  4 esqu…       1                0               4              1              1
#>  5 esqu…       1                0              31             16              7
#>  6 esqu…       1                1              11              6              3
#>  7 esqu…       1                1              16             11              4
#>  8 esqu…       1                1              19              8              5
#>  9 esqu…       1                0               9              6              4
#> 10 esqu…       1                3              27             14             10
#> # … with 26,289 more rows, and 26 more variables: delitos_last_1 <dbl>,
#> #   delitos <dbl>, temperatura_last_year <dbl>, temperatura_last_12 <dbl>,
#> #   temperatura_last_6 <dbl>, temperatura_last_3 <dbl>,
#> #   temperatura_last_1 <dbl>, temperatura <dbl>, mm_last_year <dbl>,
#> #   mm_last_12 <dbl>, mm_last_6 <dbl>, mm_last_3 <dbl>, mm_last_1 <dbl>,
#> #   mm <dbl>, dias_last_year <dbl>, dias_last_12 <dbl>, dias_last_6 <dbl>,
#> #   dias_last_3 <dbl>, dias_last_1 <dbl>, dias <dbl>, veloc_last_year <dbl>,
#> #   veloc_last_12 <dbl>, veloc_last_6 <dbl>, veloc_last_3 <dbl>,
#> #   veloc_last_1 <dbl>, veloc <dbl>
```

## Casos de Uso

Para visitar proyectos donde fue utilizado este paquete consultar:

-   [Blog Posts / Rafael
    Zambrano](https://rafael-zambrano-blog-ds.netlify.app/blog.html)