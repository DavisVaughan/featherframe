
<!-- README.md is generated from README.Rmd. Please edit that file -->
featherframe
============

Sometimes with `reticulate` you import Python libraries that require using Pandas DataFrame and Series objects. Currently there is support for Numpy Arrays in `reticulate`, but no support for these other objects.

`feather` is a great package that allows you to write R `tibble`s to disk, and read them into Python as `DataFrames`, and vice versa, with type support. Combining `reticulate` and `feather` results in a way to more easily convert R objects to Pandas DataFrame and Series objects for use with other libraries you might import with `reticulate`. It is actually surprisingly fast too!

Installation
------------

You can install `featherframe` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("DavisVaughan/featherframe")
```

Note that you will have to ensure that any Python library you want to use (like in the examples below) is installed on your machine. You also will need to ensure that `reticulate` is finding the correct version of Python, and how to do all of that is nicely outlined for you in their [vignette](https://rstudio.github.io/reticulate/articles/versions.html). Personally I have set the `RETICULATE_PYTHON` environment variable.

Example - Conversion
--------------------

`tibble` to `Pandas DataFrame` and back.

``` r
library(dplyr)
library(featherframe)
data("iris")

# data.frame to tibble
iris <- iris %>%
  as_tibble()

# tibble to Pandas DataFrame
iris_pd <- iris %>%
  as_pandas_DataFrame()

iris_pd
#>      Sepal.Length  Sepal.Width  Petal.Length  Petal.Width    Species
#> 0             5.1          3.5           1.4          0.2     setosa
#> 1             4.9          3.0           1.4          0.2     setosa
#> 2             4.7          3.2           1.3          0.2     setosa
#> 3             4.6          3.1           1.5          0.2     setosa
#> 4             5.0          3.6           1.4          0.2     setosa
#> 5             5.4          3.9           1.7          0.4     setosa
#> 6             4.6          3.4           1.4          0.3     setosa
#> 7             5.0          3.4           1.5          0.2     setosa
#> 8             4.4          2.9           1.4          0.2     setosa
#> 9             4.9          3.1           1.5          0.1     setosa
#> 10            5.4          3.7           1.5          0.2     setosa
#> 11            4.8          3.4           1.6          0.2     setosa
#> 12            4.8          3.0           1.4          0.1     setosa
#> 13            4.3          3.0           1.1          0.1     setosa
#> 14            5.8          4.0           1.2          0.2     setosa
#> 15            5.7          4.4           1.5          0.4     setosa
#> 16            5.4          3.9           1.3          0.4     setosa
#> 17            5.1          3.5           1.4          0.3     setosa
#> 18            5.7          3.8           1.7          0.3     setosa
#> 19            5.1          3.8           1.5          0.3     setosa
#> 20            5.4          3.4           1.7          0.2     setosa
#> 21            5.1          3.7           1.5          0.4     setosa
#> 22            4.6          3.6           1.0          0.2     setosa
#> 23            5.1          3.3           1.7          0.5     setosa
#> 24            4.8          3.4           1.9          0.2     setosa
#> 25            5.0          3.0           1.6          0.2     setosa
#> 26            5.0          3.4           1.6          0.4     setosa
#> 27            5.2          3.5           1.5          0.2     setosa
#> 28            5.2          3.4           1.4          0.2     setosa
#> 29            4.7          3.2           1.6          0.2     setosa
#> ..            ...          ...           ...          ...        ...
#> 120           6.9          3.2           5.7          2.3  virginica
#> 121           5.6          2.8           4.9          2.0  virginica
#> 122           7.7          2.8           6.7          2.0  virginica
#> 123           6.3          2.7           4.9          1.8  virginica
#> 124           6.7          3.3           5.7          2.1  virginica
#> 125           7.2          3.2           6.0          1.8  virginica
#> 126           6.2          2.8           4.8          1.8  virginica
#> 127           6.1          3.0           4.9          1.8  virginica
#> 128           6.4          2.8           5.6          2.1  virginica
#> 129           7.2          3.0           5.8          1.6  virginica
#> 130           7.4          2.8           6.1          1.9  virginica
#> 131           7.9          3.8           6.4          2.0  virginica
#> 132           6.4          2.8           5.6          2.2  virginica
#> 133           6.3          2.8           5.1          1.5  virginica
#> 134           6.1          2.6           5.6          1.4  virginica
#> 135           7.7          3.0           6.1          2.3  virginica
#> 136           6.3          3.4           5.6          2.4  virginica
#> 137           6.4          3.1           5.5          1.8  virginica
#> 138           6.0          3.0           4.8          1.8  virginica
#> 139           6.9          3.1           5.4          2.1  virginica
#> 140           6.7          3.1           5.6          2.4  virginica
#> 141           6.9          3.1           5.1          2.3  virginica
#> 142           5.8          2.7           5.1          1.9  virginica
#> 143           6.8          3.2           5.9          2.3  virginica
#> 144           6.7          3.3           5.7          2.5  virginica
#> 145           6.7          3.0           5.2          2.3  virginica
#> 146           6.3          2.5           5.0          1.9  virginica
#> 147           6.5          3.0           5.2          2.0  virginica
#> 148           6.2          3.4           5.4          2.3  virginica
#> 149           5.9          3.0           5.1          1.8  virginica
#> 
#> [150 rows x 5 columns]

# Pandas DataFrame to tibble
iris_tib <- iris_pd %>%
  as_tibble()

iris_tib
#> # A tibble: 150 x 5
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1         5.10        3.50         1.40       0.200 setosa 
#>  2         4.90        3.00         1.40       0.200 setosa 
#>  3         4.70        3.20         1.30       0.200 setosa 
#>  4         4.60        3.10         1.50       0.200 setosa 
#>  5         5.00        3.60         1.40       0.200 setosa 
#>  6         5.40        3.90         1.70       0.400 setosa 
#>  7         4.60        3.40         1.40       0.300 setosa 
#>  8         5.00        3.40         1.50       0.200 setosa 
#>  9         4.40        2.90         1.40       0.200 setosa 
#> 10         4.90        3.10         1.50       0.100 setosa 
#> # ... with 140 more rows

# It works!
identical(iris, iris_tib)
#> [1] TRUE
```

Example - The Python pyfolio library
------------------------------------

The original motivation for creating this mini-package is to use to [pyfolio](https://github.com/quantopian/pyfolio) library from Quantopian right from R. It provides some neat financial analysis functions I was interested in testing, but requires you to pass in Pandas Series and DataFrame objects.

Specifically, I am going to demonstrate some functionality that requires a Pandas Series of daily returns.

``` r
library(reticulate)
library(featherframe)
library(tibbletime) # just for a test data set
library(lubridate)
library(dplyr)

# Use reticulate to import pyfolio
pyfolio <- import("pyfolio")

# Get the FB stock dataset from tibbletime
data(FB)
FB
#> # A tibble: 1,008 x 8
#>    symbol date        open  high   low close    volume adjusted
#>    <chr>  <date>     <dbl> <dbl> <dbl> <dbl>     <dbl>    <dbl>
#>  1 FB     2013-01-02  27.4  28.2  27.4  28.0  69846400     28.0
#>  2 FB     2013-01-03  27.9  28.5  27.6  27.8  63140600     27.8
#>  3 FB     2013-01-04  28.0  28.9  27.8  28.8  72715400     28.8
#>  4 FB     2013-01-07  28.7  29.8  28.6  29.4  83781800     29.4
#>  5 FB     2013-01-08  29.5  29.6  28.9  29.1  45871300     29.1
#>  6 FB     2013-01-09  29.7  30.6  29.5  30.6 104787700     30.6
#>  7 FB     2013-01-10  30.6  31.5  30.3  31.3  95316400     31.3
#>  8 FB     2013-01-11  31.3  32.0  31.1  31.7  89598000     31.7
#>  9 FB     2013-01-14  32.1  32.2  30.6  31.0  98892800     31.0
#> 10 FB     2013-01-15  30.6  31.7  29.9  30.1 173242600     30.1
#> # ... with 998 more rows

# There is an issue with Dates becoming POSIXct so let's avoid that
FB <- mutate(FB, date = as_datetime(date))

# Calculate returns
FB_returns <- FB %>%
  mutate(returns = adjusted / lag(adjusted) - 1) %>%
  select(date, returns) %>%
  na.omit()

# Convert to Pandas Series, specifying the index column
FB_returns_pd <- FB_returns %>%
  as_pandas_Series(index = date)

FB_returns_pd
#> date
#> 2013-01-03 00:00:00+00:00   -0.008214
#> 2013-01-04 00:00:00+00:00    0.035650
#> 2013-01-07 00:00:00+00:00    0.022949
#> 2013-01-08 00:00:00+00:00   -0.012237
#> 2013-01-09 00:00:00+00:00    0.052650
#> 2013-01-10 00:00:00+00:00    0.023210
#> 2013-01-11 00:00:00+00:00    0.013419
#> 2013-01-14 00:00:00+00:00   -0.024275
#> 2013-01-15 00:00:00+00:00   -0.027464
#> 2013-01-16 00:00:00+00:00   -0.008306
#> 2013-01-17 00:00:00+00:00    0.009715
#> 2013-01-18 00:00:00+00:00   -0.015926
#> 2013-01-22 00:00:00+00:00    0.036076
#> 2013-01-23 00:00:00+00:00    0.002929
#> 2013-01-24 00:00:00+00:00    0.008436
#> 2013-01-25 00:00:00+00:00    0.014801
#> 2013-01-28 00:00:00+00:00    0.029486
#> 2013-01-29 00:00:00+00:00   -0.051740
#> 2013-01-30 00:00:00+00:00    0.014615
#> 2013-01-31 00:00:00+00:00   -0.008323
#> 2013-02-01 00:00:00+00:00   -0.040349
#> 2013-02-04 00:00:00+00:00   -0.054490
#> 2013-02-05 00:00:00+00:00    0.018854
#> 2013-02-06 00:00:00+00:00    0.014316
#> 2013-02-07 00:00:00+00:00   -0.013769
#> 2013-02-08 00:00:00+00:00   -0.003490
#> 2013-02-11 00:00:00+00:00   -0.010158
#> 2013-02-12 00:00:00+00:00   -0.031493
#> 2013-02-13 00:00:00+00:00    0.019730
#> 2013-02-14 00:00:00+00:00    0.021139
#>                                ...   
#> 2016-11-17 00:00:00+00:00    0.012464
#> 2016-11-18 00:00:00+00:00   -0.006537
#> 2016-11-21 00:00:00+00:00    0.040591
#> 2016-11-22 00:00:00+00:00   -0.002464
#> 2016-11-23 00:00:00+00:00   -0.005187
#> 2016-11-25 00:00:00+00:00   -0.003807
#> 2016-11-28 00:00:00+00:00    0.000249
#> 2016-11-29 00:00:00+00:00    0.003820
#> 2016-11-30 00:00:00+00:00   -0.020270
#> 2016-12-01 00:00:00+00:00   -0.028036
#> 2016-12-02 00:00:00+00:00    0.002606
#> 2016-12-05 00:00:00+00:00    0.017591
#> 2016-12-06 00:00:00+00:00   -0.001022
#> 2016-12-07 00:00:00+00:00    0.005456
#> 2016-12-08 00:00:00+00:00    0.008139
#> 2016-12-09 00:00:00+00:00    0.006475
#> 2016-12-12 00:00:00+00:00   -0.015959
#> 2016-12-13 00:00:00+00:00    0.021567
#> 2016-12-14 00:00:00+00:00   -0.000831
#> 2016-12-15 00:00:00+00:00    0.002995
#> 2016-12-16 00:00:00+00:00   -0.005806
#> 2016-12-19 00:00:00+00:00   -0.005256
#> 2016-12-20 00:00:00+00:00   -0.001258
#> 2016-12-21 00:00:00+00:00   -0.000420
#> 2016-12-22 00:00:00+00:00   -0.013777
#> 2016-12-23 00:00:00+00:00   -0.001107
#> 2016-12-27 00:00:00+00:00    0.006310
#> 2016-12-28 00:00:00+00:00   -0.009237
#> 2016-12-29 00:00:00+00:00   -0.004875
#> 2016-12-30 00:00:00+00:00   -0.011173
#> Name: returns, Length: 1007, dtype: float64

# Use the rolling_volatility function from the current pip version of pyfolio
rolling_vol_pd <- pyfolio$timeseries$rolling_volatility(FB_returns_pd, rolling_vol_window = 10L)
rolling_vol_pd
#> date
#> 2013-01-03 00:00:00+00:00         NaN
#> 2013-01-04 00:00:00+00:00         NaN
#> 2013-01-07 00:00:00+00:00         NaN
#> 2013-01-08 00:00:00+00:00         NaN
#> 2013-01-09 00:00:00+00:00         NaN
#> 2013-01-10 00:00:00+00:00         NaN
#> 2013-01-11 00:00:00+00:00         NaN
#> 2013-01-14 00:00:00+00:00         NaN
#> 2013-01-15 00:00:00+00:00         NaN
#> 2013-01-16 00:00:00+00:00    0.425432
#> 2013-01-17 00:00:00+00:00    0.417229
#> 2013-01-18 00:00:00+00:00    0.403469
#> 2013-01-22 00:00:00+00:00    0.426051
#> 2013-01-23 00:00:00+00:00    0.415865
#> 2013-01-24 00:00:00+00:00    0.327421
#> 2013-01-25 00:00:00+00:00    0.314476
#> 2013-01-28 00:00:00+00:00    0.341510
#> 2013-01-29 00:00:00+00:00    0.420585
#> 2013-01-30 00:00:00+00:00    0.396567
#> 2013-01-31 00:00:00+00:00    0.396582
#> 2013-02-01 00:00:00+00:00    0.452145
#> 2013-02-04 00:00:00+00:00    0.523592
#> 2013-02-05 00:00:00+00:00    0.492085
#> 2013-02-06 00:00:00+00:00    0.501475
#> 2013-02-07 00:00:00+00:00    0.496638
#> 2013-02-08 00:00:00+00:00    0.481741
#> 2013-02-11 00:00:00+00:00    0.430293
#> 2013-02-12 00:00:00+00:00    0.389964
#> 2013-02-13 00:00:00+00:00    0.400238
#> 2013-02-14 00:00:00+00:00    0.431677
#>                                ...   
#> 2016-11-17 00:00:00+00:00    0.276783
#> 2016-11-18 00:00:00+00:00    0.273903
#> 2016-11-21 00:00:00+00:00    0.346276
#> 2016-11-22 00:00:00+00:00    0.332978
#> 2016-11-23 00:00:00+00:00    0.331663
#> 2016-11-25 00:00:00+00:00    0.317450
#> 2016-11-28 00:00:00+00:00    0.306937
#> 2016-11-29 00:00:00+00:00    0.239519
#> 2016-11-30 00:00:00+00:00    0.257021
#> 2016-12-01 00:00:00+00:00    0.294442
#> 2016-12-02 00:00:00+00:00    0.285935
#> 2016-12-05 00:00:00+00:00    0.300280
#> 2016-12-06 00:00:00+00:00    0.201002
#> 2016-12-07 00:00:00+00:00    0.206177
#> 2016-12-08 00:00:00+00:00    0.212715
#> 2016-12-09 00:00:00+00:00    0.215868
#> 2016-12-12 00:00:00+00:00    0.229217
#> 2016-12-13 00:00:00+00:00    0.257645
#> 2016-12-14 00:00:00+00:00    0.232839
#> 2016-12-15 00:00:00+00:00    0.164264
#> 2016-12-16 00:00:00+00:00    0.172491
#> 2016-12-19 00:00:00+00:00    0.159185
#> 2016-12-20 00:00:00+00:00    0.159297
#> 2016-12-21 00:00:00+00:00    0.157991
#> 2016-12-22 00:00:00+00:00    0.168107
#> 2016-12-23 00:00:00+00:00    0.162598
#> 2016-12-27 00:00:00+00:00    0.146658
#> 2016-12-28 00:00:00+00:00    0.092915
#> 2016-12-29 00:00:00+00:00    0.092686
#> 2016-12-30 00:00:00+00:00    0.093274
#> Name: returns, Length: 1007, dtype: float64

# Go back to R now
rolling_vol_pd %>%
  as_tibble() %>%
  rename(returns_rolling_vol = returns)
#> # A tibble: 1,007 x 2
#>    date                returns_rolling_vol
#>    <dttm>                            <dbl>
#>  1 2013-01-03 00:00:00              NA    
#>  2 2013-01-04 00:00:00              NA    
#>  3 2013-01-07 00:00:00              NA    
#>  4 2013-01-08 00:00:00              NA    
#>  5 2013-01-09 00:00:00              NA    
#>  6 2013-01-10 00:00:00              NA    
#>  7 2013-01-11 00:00:00              NA    
#>  8 2013-01-14 00:00:00              NA    
#>  9 2013-01-15 00:00:00              NA    
#> 10 2013-01-16 00:00:00               0.425
#> # ... with 997 more rows
```

The idea is that we can wrap these functions up to take care of all the conversion for us. I believe this is essentially what the `keras` package does with the Python `keras` library, but in a more efficient way than using `feather`.

``` r
pyfolio_rolling_volatility <- function(x, rolling_vol_window, ...) {
  pyfolio <- import("pyfolio")
  stopifnot(is.integer(rolling_vol_window))
  
  as_pandas_Series(x, ...) %>%
    pyfolio$timeseries$rolling_volatility(rolling_vol_window) %>%
    as_tibble()
}

pyfolio_rolling_volatility(FB_returns, 10L, index = date)
#> # A tibble: 1,007 x 2
#>    date                returns
#>    <dttm>                <dbl>
#>  1 2013-01-03 00:00:00  NA    
#>  2 2013-01-04 00:00:00  NA    
#>  3 2013-01-07 00:00:00  NA    
#>  4 2013-01-08 00:00:00  NA    
#>  5 2013-01-09 00:00:00  NA    
#>  6 2013-01-10 00:00:00  NA    
#>  7 2013-01-11 00:00:00  NA    
#>  8 2013-01-14 00:00:00  NA    
#>  9 2013-01-15 00:00:00  NA    
#> 10 2013-01-16 00:00:00   0.425
#> # ... with 997 more rows
```

Known issues
------------

Currently `Date` columns are translated to `datetime64[ns]` and then back as `POSIXct` with a local-specific timezone. This is...undesirable and should be fixed on the `feather` side of things.

``` r
ex <- tibble(date_col = as.Date("2018-01-01"))
ex_pd <- as_pandas_DataFrame(ex)
ex_pd
#>     date_col
#> 0 2018-01-01

as_tibble(ex_pd)
#> # A tibble: 1 x 1
#>   date_col           
#>   <dttm>             
#> 1 2017-12-31 19:00:00
```

Ordered factors do not stay ordered (but remain factors) when going back and forth.

``` r
ex_ordered_fac <- tibble(fct = factor(c("low", "high", "med"), 
                                      levels = c("low", "med", "high"), 
                                      ordered = TRUE))
ex_ordered_fac
#> # A tibble: 3 x 1
#>   fct  
#>   <ord>
#> 1 low  
#> 2 high 
#> 3 med

as_tibble(as_pandas_DataFrame(ex_ordered_fac))
#> # A tibble: 3 x 1
#>   fct  
#>   <fct>
#> 1 low  
#> 2 high 
#> 3 med
```

Integer columns with `NA` values are coerced to numeric (double) column because Pandas does not have support for `NaN` values in integer columns.

``` r
ex_int <- tibble(int_col = c(1L, 2L, 3L))
ex_int
#> # A tibble: 3 x 1
#>   int_col
#>     <int>
#> 1       1
#> 2       2
#> 3       3

ex_int_NA <- tibble(int_col = c(1L, 2L, 3L, NA))
ex_int_NA
#> # A tibble: 4 x 1
#>   int_col
#>     <int>
#> 1       1
#> 2       2
#> 3       3
#> 4      NA

as_tibble(as_pandas_DataFrame(ex_int))
#> # A tibble: 3 x 1
#>   int_col
#>     <int>
#> 1       1
#> 2       2
#> 3       3
as_tibble(as_pandas_DataFrame(ex_int_NA))
#> # A tibble: 4 x 1
#>   int_col
#>     <dbl>
#> 1    1.00
#> 2    2.00
#> 3    3.00
#> 4   NA
```

Rownames are not preserved in the translation from R to Python.
