# -----------------------------------------------------------------------------
# to Pandas DataFrame

#' Convert from R to Pandas DataFrame using feather
#'
#' Convert any object coercible to a data.frame to a Pandas DataFrame.
#' Conversion is done using `feather`, which might not be the most efficient
#' way, but the type conversion supported by `feather` is inherited here.
#'
#' @param x An R object to convert to Pandas DataFrame
#' @param ... Currently unused
#'
#' @export
as_pandas_DataFrame <- function(x, ...) {
  UseMethod("as_pandas_DataFrame")
}

#' @export
as_pandas_DataFrame.default <- function(x, ...) {

  # Default converts to df then switches
  x  <- as.data.frame(x)

  # Convert
  feather_switch_r_to_py(x)
}

#' @export
as_pandas_DataFrame.data.frame <- function(x, ...) {
  feather_switch_r_to_py(x)
}

# -----------------------------------------------------------------------------
# To Pandas Series

#' Convert from R to Pandas Series using feather
#'
#' Convert R objects that are coercible to data.frames to Pandas Series.
#' These R objects must either have only 1 column, or must have 2 columns where
#' 1 of those columns is identified as the `index` for the Series.
#'
#' @param x A 1-D R object to convert to a Pandas Series
#' @param index A bare column name to use as the Series index if the R object
#' to convert has 2 columns.
#' @param ... Currently unused
#'
#' @export
as_pandas_Series <- function(x, ...) {
  UseMethod("as_pandas_Series")
}

#' @export
as_pandas_Series.default <- function(x, ...) {
  as_pandas_Series(as.data.frame(x))
}

#' @export
as_pandas_Series.data.frame <- function(x, index = NULL, ...) {

  index      <- rlang::enquo(index)
  index_char <- quo_name_safely(index)

  assert_1D(x, !!index)

  cols_x <- names(x)
  col_pd <- setdiff(cols_x, index_char)

  # Convert to DataFrame using feather, then to Series by
  # setting the index then using xs(). Cleaner way?
  x_pd_DataFrame <- as_pandas_DataFrame(x)

  if(!rlang::quo_is_null(index)) {
    x_pd_DataFrame <- x_pd_DataFrame$set_index(index_char)
  }

  x_pd_Series <- x_pd_DataFrame$xs(key = col_pd, axis = 1L)

  x_pd_Series
}

assert_1D <- function(x, index) {
  index <- rlang::enquo(index)
  ncol_allowed <- ifelse(rlang::quo_is_null(index), 1, 2)
  if(ncol(x) != ncol_allowed) {
    stop("The object to convert to a Series must have a) 1 column or b) 2 columns if an index column is specified", call. = FALSE)
  }
}


