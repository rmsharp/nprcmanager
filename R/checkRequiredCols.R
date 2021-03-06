#' Examines column names, \code{cols} for required column names
#'
## Copyright(c) 2017-2020 R. Mark Sharp
## This file is part of nprcgenekeepr
#'
#' @return NULL is returned if all required columns are present. See description
#' of \code{reportErrors} for return values when required columns are missing.
#'
#' @examples
#' \donttest{
#' library(nprcgenekeepr)
#' requiredCols <- getRequiredCols()
#' cols <-
#'   paste0("id,sire,siretype,dam,damtype,sex,numberofparentsknown,birth,",
#'          "arrivalatcenter,death,departure,status,ancestry,fromcenter?,",
#'          "origin")
#' all(requiredCols %in% checkRequiredCols(cols, reportErrors = TRUE))
#' }
#'
#' @param cols character vector of column names
#' @param reportErrors logical value when \code{TRUE} and missing columns are
#' found
#' the \code{errorLst} object is updated with the names of the missing
#' columns and returned and when \code{FALSE} and missing columns are found
#' the program is stopped.
## ## rmsutilityr str_detect_fixed_all
#' @export
checkRequiredCols <- function(cols, reportErrors) {
  requiredCols <- getRequiredCols()
  # Checking for the required fields (id, sire, dam, sex)
  if (!all(str_detect_fixed_all(cols, requiredCols)) |
      length(cols) < length(requiredCols)) {
    if (reportErrors) {
      missingColumns <-
        as.character(unlist(sapply(requiredCols, function(col) {
          if (!any(col == cols)) col})))

      if (length(missingColumns) > 0)
        return(missingColumns)
    } else {
      stop(paste0("Required field(s) missing: ", paste0(requiredCols[
        !str_detect_fixed_all(cols, requiredCols, ignore_na = TRUE)],
        collapse = ", "), "."))
    }
  }
  return(NULL)
}
