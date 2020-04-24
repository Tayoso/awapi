#' Sets the Accu Weather API Key.
#'
#' @param x Your AccuWeather API key.
#'
#' @return
#' @export
#'
#' @examples
aw_set_api_key <- function(x){
  Sys.setenv(awapi_key = x)
}

#' Check if the api key has been added to environment variables
#'
#' @return Returns TRUE if the api key has been set in the "ACCUWEATHERAPIKEY" environment variable, otherwise FALSE.
#' @export
#'
#' @examples
aw_is_api_key_set <- function(){
  Sys.getenv("awapi_key") != ""
}

#' Check the status code for your apikey
#'
#' @param lat Latitude of location.
#' @param lon Longitude of location.
#' @param apikey apikey needed to access data from the site.
#' 
#' @return message signifying status of api connection
#' @export
#'
#' @examples
aw_check_status_code <- function(lat, lon, apikey = Sys.getenv("awapi_key")){
  if(!aw_is_api_key_set()){
    stop("The api key has not be set to the 'awapi_key' environment variable. See ?aw_set_api_key.")
  }
  
  # get the location key
  my_url <- paste0("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=",apikey,"&q=",lat,"%2C",lon)
  raw <- httr::GET(my_url)
  stat <- httr::status_code(raw)
  stat <- as.numeric(stat)
  
  if(stat > 200){
    stop(paste0('Error ', stat, ':check response error code in "https://apidev.accuweather.com/developers/"'))
  }
  else{
    message("api key status is okay")
  }
}


#' Get 12 hour forecast for a given location. The first part of the function gets the location key and passes it through the url containing the data
#'
#' @param lat Latitude of location.
#' @param lon Longitude of location.
#' @param tz Default timezone is Europe/London. See http://www.timezoneconverter.com/cgi-bin/zoneinfo.tzc to find your timezone.
#' @param apikey apikey needed to access data from the site.
#' 
#' @return List of current and forecast weather for the location.
#' @export
#'
#' @examples
aw_12_hrs_forecast <- function(lat, lon, tz = "Europe/London", apikey = Sys.getenv("awapi_key")){
  if(!aw_is_api_key_set()){
    stop("The api key has not be set to the 'awapi_key' environment variable. See ?aw_set_api_key.")
  }
  
  # get the location key
  my_url <- paste0("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=",apikey,"&q=",lat,"%2C",lon)
  raw <- httr::GET(my_url)
  content <- httr::content(raw, as = 'text')
  content <- jsonlite::fromJSON(content, flatten = TRUE)
  locationkey <- content$Key
  
  # pass the location key into the url below
  my_url2 <- paste0("http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/",locationkey, "?apikey=",apikey,"&details=TRUE")
  raw2 <- httr::GET(my_url2)
  content2 <- httr::content(raw2, as = 'text')
  content2 <- jsonlite::fromJSON(content2, flatten = TRUE)
  HourlyForecasts <- content2
  HourlyForecasts <- HourlyForecasts %>% 
    dplyr::mutate(dt = as.POSIXct(EpochDateTime,origin="1970-01-01",tz=tz)) %>% 
    dplyr::select(- c(MobileLink, Link))
  
  # add new columns including elevation, admin area name, post code etc.
  Elevation.meters <- content$GeoPosition$Elevation$Metric$Value
  AdminArea_LocalizedName <- content$AdministrativeArea$LocalizedName
  CountryID <- content$Country$ID
  LocalizedName <- content$LocalizedName
  PrimaryPostalCode <- content$PrimaryPostalCode
  
  # bind the new columns to the daily forecast
  HourlyForecasts <- cbind(HourlyForecasts,Elevation.meters,AdminArea_LocalizedName,LocalizedName,PrimaryPostalCode,CountryID)
  return(HourlyForecasts)
}



#' Get 5 day forecast for a given location. The first part of the function gets the location key and passes it through the url containing the data
#'
#' @param lat Latitude of location.
#' @param lon Longitude of location.
#' @param tz Default timezone is Europe/London. See http://www.timezoneconverter.com/cgi-bin/zoneinfo.tzc to find your timezone.
#' @param apikey apikey needed to access data from the site.
#' 
#' @return A data frame of daily weather forecasts for the given location.
#' @export
#'
#' @examples
aw_5_days_forecast <- function(lat, lon, tz = "Europe/London", apikey = Sys.getenv("awapi_key")){
  if(!aw_is_api_key_set()){
    stop("The api key has not be set to the 'awapi_key' environment variable. See ?aw_set_api_key.")
  }
  
  # get the location key
  my_url <- paste0("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=",apikey,"&q=",lat,"%2C",lon)
  raw <- httr::GET(my_url)
  content <- httr::content(raw, as = 'text')
  content <- jsonlite::fromJSON(content, flatten = TRUE)
  locationkey <- content$Key
  
  # pass the location key into the url below
  my_url2 <- paste0("http://dataservice.accuweather.com/forecasts/v1/daily/5day/",locationkey, "?apikey=",apikey,"&details=TRUE")
  raw2 <- httr::GET(my_url2)
  content2 <- httr::content(raw2, as = 'text')
  content2 <- jsonlite::fromJSON(content2, flatten = TRUE)
  DailyForecasts <- content2[["DailyForecasts"]]
  DailyForecasts <- DailyForecasts %>% 
    dplyr::mutate(dt = as.POSIXct(EpochDate,origin="1970-01-01",tz=tz)) %>% 
    dplyr::select(- c(MobileLink, Link))
  
  # add new columns including elevation, admin area name, post code etc.
  Elevation.meters <- content$GeoPosition$Elevation$Metric$Value
  AdminArea_LocalizedName <- content$AdministrativeArea$LocalizedName
  CountryID <- content$Country$ID
  LocalizedName <- content$LocalizedName
  PrimaryPostalCode <- content$PrimaryPostalCode
  
  # bind the new columns to the daily forecast
  DailyForecasts <- cbind(DailyForecasts,Elevation.meters,AdminArea_LocalizedName,LocalizedName,PrimaryPostalCode,CountryID)
  return(DailyForecasts)
}



#' Get 24 hour current conditions for a given location. The first part of the function gets the location key and passes it through the url containing the data
#'
#' @param lat Latitude of location.
#' @param lon Longitude of location.
#' @param tz Default timezone is Europe/London. See http://www.timezoneconverter.com/cgi-bin/zoneinfo.tzc to find your timezone.
#' @param apikey apikey needed to access data from the site.
#' 
#' @return List of 24 hour current conditions for the location.
#' @export
#'
#' @examples
aw_24_hrs_condition <- function(lat, lon, tz = "Europe/London", apikey = Sys.getenv("awapi_key")){
  if(!aw_is_api_key_set()){
    stop("The api key has not be set to the 'awapi_key' environment variable. See ?aw_set_api_key.")
  }
  
  # get the location key
  my_url <- paste0("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=",apikey,"&q=",lat,"%2C",lon)
  raw <- httr::GET(my_url)
  content <- httr::content(raw, as = 'text')
  content <- jsonlite::fromJSON(content, flatten = TRUE)
  locationkey <- content$Key
  
  # pass the location key into the url below
  my_url2 <- paste0("http://dataservice.accuweather.com/currentconditions/v1/",locationkey,"/historical/24","?apikey=",apikey,"&details=TRUE")
  raw2 <- httr::GET(my_url2)
  content2 <- httr::content(raw2, as = 'text')
  content2 <- jsonlite::fromJSON(content2, flatten = TRUE)
  condition24 <- content2
  condition24 <- condition24 %>% 
    dplyr::mutate(dt = as.POSIXct(EpochTime,origin="1970-01-01",tz=tz)) %>% 
    dplyr::select(- c(MobileLink, Link))
  
  # add new columns including elevation, admin area name, post code etc.
  Elevation.meters <- content$GeoPosition$Elevation$Metric$Value
  AdminArea_LocalizedName <- content$AdministrativeArea$LocalizedName
  CountryID <- content$Country$ID
  LocalizedName <- content$LocalizedName
  PrimaryPostalCode <- content$PrimaryPostalCode
  
  # bind the new columns to the daily forecast
  condition24 <- cbind(condition24,Elevation.meters,AdminArea_LocalizedName,LocalizedName,PrimaryPostalCode,CountryID)
  return(condition24)
}




