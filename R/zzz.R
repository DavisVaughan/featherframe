# Global
# PY_PANDAS <- NULL
PY_FEATHER <- NULL

.onLoad <- function(libname, pkgname) {

    #PY_PANDAS  <<- reticulate::import("pandas", delay_load = TRUE)
    PY_FEATHER <<- reticulate::import("feather", delay_load = TRUE)

}
