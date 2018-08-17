#' Converts date columns formatted as characters to be of type datetime
#'
#' Part of Pedigree Curation
#'
#' @param ped a dataframe of pedigree information that may contain birth,
#' death, departure, or exit dates. The fields are optional, but will be used
#' if present.(optional fields: birth, death, departure, and exit).
#' @param time.origin date object used by \code{as.Date} to set \code{origin}.
#' @return A dataframe with an updated table with date columns converted from
#' \code{character} data type to \code{Date} data type.
#' @importFrom rmsutilityr get_and_or_list
#' @importFrom rmsutilityr is_valid_date_str
#' @export
convertDate <- function(ped, time.origin = as.Date("1970-01-01")) {
  headers <-  tolower(names(ped))
  headers <- headers[headers %in% c("birth", "death", "departure", "exit")]
  format = "%Y-%m-%d"
  for (header in headers) {
    if (class(ped[[header]]) == "character" | class(ped[[header]]) == "factor")
      ped[[header]][ped[[header]] == ""] <- NA
    if (!all(is_valid_date_str(ped[[header]][!is.na(ped[[header]])],
                               format = format, optional = TRUE))) {
      rowNums <- get_and_or_list(seq_along(ped[[header]])[
        !is_valid_date_str(ped[[header]][!is.na(ped[[header]])],
                           format = format)], "and")
      stop(paste0("Column '", header, "' has invalid dates on row(s) ",
                  rowNums, "."))
    }

    ped[[header]] <- as.Date(ped[[header]], format = format,
                             origin = time.origin,, optional = TRUE)
  }
  return(ped)
}