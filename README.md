# awapi

## Summary

awapi (AccuWeather.com API) is an R package providing convenient access to the [AccuWeather.com API](https://developer.accuweather.com). You can use it to get historical weather conditions, hourly and daily forecasts for any location.

The [AccuWeather API](https://developer.accuweather.com) offers a free limited trial package (limited to 50 API calls a day).


### Installation

There are a variety of methods for installing packages directly from github. You may want to research these and find the most appropriate for you. 

```R
# install devtools libraries from cran
install.packages("devtools")

# install awapi package
devtools::install_github("tayoso2/awapi")
```


Alternatively, you could clone the entire repo and build manually.

### Getting Started

library(awapi)
    
You will need an API key to use AccuWeather API. You can register for an API key at [https://developer.accuweather.com](https://developer.accuweather.com).
    

## Unit testing

### Pre-requisites

R must be installed and `Rscript` should be in the search path.

### Running the tests

- open RStudio
- change your working directory to this directory
- call `testthat::test_dir('test')`



## Project Information

### **Authors**
* Tayo Ososanya

### **Core components**
* awapi.R - daily forecast, hourly forecast, historical condition, temperature unit converter.

### **Requirements**
* R installation

### **Tags**
R, weather, API, AccuWeather, elevation, postcode

--------------------------------------------------------------------------------------

