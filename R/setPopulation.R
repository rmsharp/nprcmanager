#' Population designation function
#'
## Copyright(c) 2017-2020 R. Mark Sharp
## This file is part of nprcgenekeepr
#' Part of the pedigree filtering toolset.
#'
#' @return An updated pedigree with the \code{population} column added or
#' updated by being set to \code{TRUE} for the animal IDs in \code{ped$id} and
#' \code{FALSE} otherwise.
#'
#' @examples
#' \donttest{
#' examplePedigree <- nprcgenekeepr::examplePedigree
#' breederPed <- qcStudbook(examplePedigree, minParentAge = 2,
#'                          reportChanges = FALSE,
#'                          reportErrors = FALSE)
#' focalAnimals <- breederPed$id[!(is.na(breederPed$sire) &
#'                                   is.na(breederPed$dam)) &
#'                                 is.na(breederPed$exit)]
#' breederPed <- setPopulation(ped = breederPed, ids = focalAnimals)
#' nrow(breederPed[breederPed$population, ])
#' }
#'
#' @param ped datatable that is the `Pedigree`. It contains pedigree
#' information. The \code{id} column is required.
#' @param ids character vector of IDs to be flagged as part of the population
#' under consideration.
#' @export
setPopulation <- function(ped, ids) {
  ped$population <- FALSE

  if (length(ids) == 0) {
    ped$population <- TRUE
  } else {
    ped$population[ped$id %in% ids] <- TRUE
  }
  return(ped)
}
