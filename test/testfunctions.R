

# install from git ---------------------------------------------------------
devtools::install_git('git@github.com:tayoso2/awapi.git',
                      credentials = git2r::cred_ssh_key())


# load library ----------------------------------------------------------
library(awapi)

# install package from CRAN only if not installed, and load the library
if (!require(testthat)) install.packages('testthat')
library(testthat)

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


# unit testing --------------------------------------------------------------

test_that("is_api_key_set?", {
  expect_true(aw_is_api_key_set())
})

# test temperature converter
test_that("temp_converter", {
  expect_equal(round(F_to_C(85)),29)
  expect_equal(round(C_to_F(29.44444)),85)
})

test_that("test that results are not empty", {
  expect_output(print(hourly), NULL)
  expect_output(print(daily), NULL)
  expect_output(print(historical), NULL)
})

