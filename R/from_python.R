# -----------------------------------------------------------------------------
# Reexport as_tibble()

#' @importFrom tibble as_tibble
#' @export
tibble::as_tibble

# -----------------------------------------------------------------------------
# From Pandas DataFrame

#' @export
as_tibble.pandas.core.frame.DataFrame <- function(x, ...) {
  feather_switch_py_to_r(x)
}

#' @export
as.data.frame.pandas.core.frame.DataFrame <- function(x, ...) {
  as.data.frame(as_tibble(x))
}

# -----------------------------------------------------------------------------
# From Pandas Series

#' @export
as_tibble.pandas.core.series.Series <- function(x, ...) {
  x_DataFrame <- x$to_frame()$reset_index()
  as_tibble(x_DataFrame)
}

#' @export
as.data.frame.pandas.core.series.Series <- function(x, ...) {
  as.data.frame(as_tibble(x))
}
