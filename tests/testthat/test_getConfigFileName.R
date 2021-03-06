#' Copyright(c) 2017-2020 R. Mark Sharp
#' This file is part of nprcgenekeepr
context("getConfigFileName")
library(testthat)

## These are just stub values
sysInfoUnix <-
  c(sysname = "Darwin",
    release = "17.7.0",
    version = paste0("Darwin Kernel Version 17.7.0: Thu Jun 21 22:53:14 ",
                     "PDT 2018; root:xnu-4570.71.2~1/RELEASE_X86_64"),
    nodename = "prefect.local",
    machine = "x86_64",
    login = "msharp",
    user = "msharp", effective_user = "msharp")
sysInfoWindows <-
  c(sysname = "Windows",
    release = "17.7.0",
    version = "Darwin Kernel Version 17.7.0: Thu Jun 21 22:53:14 PDT 2018; ",
    "root:xnu-4570.71.2~1/RELEASE_X86_64",
    nodename = "prefect.local",
    machine = "x86_64",
    login = "msharp",
    user = "msharp",
    effective_user = "msharp")
test_that("getConfigFile got correct file name", {
  skip_if_not(Sys.info()[names(Sys.info()) == "user"] == "msharp")
  expect_equal(getConfigFileName(sysInfoWindows)[["configFile"]],
               "/Users/msharp/_nprcgenekeepr_config")
  expect_equal(getConfigFileName(sysInfoUnix)[["configFile"]],
               "~/.nprcgenekeepr_config")
  expect_equal(getConfigFileName(sysInfoWindows)[["homeDir"]],
               "/Users/msharp/")
  expect_equal(getConfigFileName(sysInfoUnix)[["homeDir"]],
               "~/")
})
