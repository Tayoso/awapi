# awapi

## Summary

awapi (AccuWeather.com API) is an R package providing convenient access to the [AccuWeather.com API](https://developer.accuweather.com). You can use it to get historical weather conditions, hourly and daily forecasts for any location.

The [AccuWeather API](https://developer.accuweather.com) offers a free limited trial package (limited to 50 API calls a day).


### Installation

There are a variety of methods for installing packages directly from gitlab. You may want to research these and find the most appropriate for you. 

You can try running the following code from within R Studio (assuming you know your gitlab username and password and your account has access to the repo):

    cred <- git2r::cred_user_pass(rstudioapi::askForPassword("Username"), 
                                  rstudioapi::askForPassword("Password"))
                                  
    devtools::install_git("https://gitlab.com/arcadis-code-repository/arcadisgen/awapi.git", 
                          credentials = cred)


Alternatively, you could clone the entire repo and build manually.

### Getting Started

library(awapi)
    
You will need an API key to use AccuWeather API. You can register for an API key at [https://developer.accuweather.com](https://developer.accuweather.com).
    
## Project information

### **Status**
`TESTING`

### **Authors**
* Tayo Ososanya (tayo.ososanya@arcadisgen.com)

### **Core components**
* awapi.R - daily forecast, hourly forecast, historical condition, temperature unit converter.

### **Requirements**
* R installation

### **Tags**
R, weather, API, AccuWeather, elevation, postcode

--------------------------------------------------------------------------------------

## Copyright and metadata 

### **Copyright** 
Copyright (c) 2020 Arcadis Nederland B.V. 

Without prior written consent of Arcadis Nederland B.V., this code may not be published or duplicated. 

