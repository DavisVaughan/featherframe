## Import from

#' @importFrom rlang !!
#'
NULL


temp_feather <- function(x) {
  tempfile(fileext = "feather")
}

feather_switch_r_to_py <- function(x) {

  tf <- temp_feather()

  # Write R to feather
  feather::write_feather(x, tf)

  # Read feather to Python
  PY_FEATHER$read_dataframe(tf)
}



feather_switch_py_to_r <- function(x) {

  tf <- temp_feather()

  # Write Python to feather
  PY_FEATHER$write_dataframe(x, tf)

  # Read feather to R
  feather::read_feather(tf)
}



# Ripped safely to always return `otherwise` on failure and not report errors
safely <- function (.f, otherwise = NULL) {
  .f <- rlang::as_function(.f)

  capture_error <- function (code, otherwise = NULL) {
    tryCatch(code,
             error = function(e) {
               otherwise
             },
             interrupt = function(e) {
                stop("Terminated by user", call. = FALSE)
             })
  }

  function(...) capture_error(.f(...), otherwise)
}



# Return the character quo or just "NULL"
quo_name_safely <- safely(rlang::quo_name, "NULL")
