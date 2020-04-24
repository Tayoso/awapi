# install from git
cred <- git2r::cred_user_pass(rstudioapi::askForPassword("username"),
                              rstudioapi::askForPassword("Password"))


devtools::install_git("https://gitlab.com/tayoso2/awapi.git",credentials = cred)
devtools::install_git("https://gitlab.com/arcadis-code-repository/arcadisgen/awapi.git",credentials = cred)

library(awapi)

# API Key -----------------------------------------------------------------
aw_set_api_key("UMGhuFhSoPE5japY8orbqC06F0oMZquv")
aw_is_api_key_set() # should yield TRUE else set key again

aw_check_status_code(lat = 53.362893,lon = -2.4247147)

# Hourly Forecast ---------------------------------------------------------

hourly <- aw_12_hrs_forecast(lat = 53.362893,lon = -2.4247147)
hourly

# Daily Forecast ----------------------------------------------------------

daily <- aw_5_days_forecast(lat = 53.362893,lon = -2.4247147)
daily


# Historical condition ------------------------------------------------------

historical <- aw_24_hrs_condition(lat = 53.362893,lon = -2.4247147)
historical


# test temperature converter

a <- F_to_C(85)
a

b <- C_to_F(29.44444)
b

