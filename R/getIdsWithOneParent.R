#' getIdsWithOneParent extracts IDs of animals pedigree without either a
#' sire or a dam
## Copyright(c) 2017-2020 R. Mark Sharp
## This file is part of nprcgenekeepr
#'
#' @return Character vector of all single parents
#'
#' @examples
#' \donttest{
#' examplePedigree <- nprcgenekeepr::examplePedigree
#' breederPed <- qcStudbook(examplePedigree, minParentAge = 2,
#'                          reportChanges = FALSE,
#'                          reportErrors = FALSE)
#' probands <- breederPed$id[!(is.na(breederPed$sire) &
#'                                is.na(breederPed$dam)) &
#'                                is.na(breederPed$exit)]
#' ped <- getProbandPedigree(probands, breederPed)
#' nrow(ped)
#' p <- removeUninformativeFounders(ped)
#' nrow(p)
#' p <- addBackSecondParents(p, ped)
#' nrow(p)
#' }
#' @param uPed a trimmed pedigree dataframe with uninformative founders removed.
#' @export
getIdsWithOneParent <- function(uPed) {
uPed$id[(is.na(uPed$sire) & !is.na(uPed$dam)) |
            (!is.na(uPed$sire) & is.na(uPed$dam))]
}
