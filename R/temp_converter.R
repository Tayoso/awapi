#' Converts temperature from one unit to another
#'
#' @param temp Temperature in Fahrenheit
#'
#' @return R object or list to be converted to Kelvin
#' @export
#'
F_to_K <- function(temp) {
  out <- ((temp - 32) * (5 / 9)) + 273.15
  out
}


#' Converts temperature from one unit to another
#'
#' @param temp Temperature in Kelvin.
#'
#' @return R object or list to be converted to Celsius
#' @export
#'
K_to_C <- function(temp) {
  out <- temp - 273.15
  out
}

#' Converts temperature from one unit to another
#'
#' @param temp Temperature in Fahrenheit
#'
#' @return R object or list to be converted to Celsius
#' @export
#'
F_to_C <- function(temp) {
  out <- ((temp - 32) * (5 / 9))
  out
}

#' Converts temperature from one unit to another
#'
#' @param temp Temperature in Celsius
#'
#' @return R object or list to be converted to Fahrenheit
#' @export
#'
C_to_F <- function(temp) {
  out <- (((9 / 5) * temp) + 32)
  out
}

