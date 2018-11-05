context("findGeneration")
library(testthat)
data(lacy1989Ped)
ped <- lacy1989Ped
ped$gen <- NULL
test_that("findGeneration labels generations correctly", {
            expect_equal(findGeneration(ped$id, ped$sire, ped$dam),
                         lacy1989Ped$gen)
          })