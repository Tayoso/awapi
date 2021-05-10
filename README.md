# awapi

## Summary

awapi (AccuWeather.com API) is an R package providing convenient access to the [AccuWeather.com API](https://developer.accuweather.com). You can use it to get historical weather conditions, hourly and daily forecasts for any location.

The [AccuWeather API](https://developer.accuweather.com) offers a free limited trial package (limited to 50 API calls a day).


### Installation

There are a variety of methods for installing packages directly from github. You may want to research these and find the most appropriate for you. 

```R
devtools::install_git('git@github.com:tayoso2/awapi.git',
                      credentials = git2r::cred_ssh_key())
```


Alternatively, you could clone the entire repo and build manually.

### Getting Started

library(awapi)
    
You will need an API key to use AccuWeather API. You can register for an API key at [https://developer.accuweather.com](https://developer.accuweather.com).
    

## Unit testing

### Pre-requisites

R must be installed and `Rscript` should be in the search path.

### Installation

Change into this directory and call `install.sh` for installing the required package(s).

### Running the tests

- open RStudio
- change your working directory to this directory
- call `testthat::test_dir('test')`



## Project Information

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

