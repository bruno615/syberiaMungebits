context("datekeeper")
library(timeDate)

check_date <- function(date, expectation, mode="date") {
  df <- data.frame(x = date, y = 'bleh')
  mp <- mungebits:::mungeplane(df)
  mb <- mungebits:::mungebit(datekeeper)
  mb$run(mp, 1, mode=mode)
  eval(substitute(expect_equal(expectation, mp$data$x)))
}

test_that("it converts YYYY-MM-DD to date", { check_date('1991-12-11', as.Date('1991-12-11')) })
test_that("it converts YYYY/MM/DD to date", { check_date('1991/12/11', as.Date('1991/12/11')) })
test_that("it converts YYYY MM DD to date", { check_date('1991 12 11', as.Date('1991/12/11')) })
test_that("it converts MM-DD-YYYY to date", { check_date('12-11-1991', as.Date('1991/12/11')) })
test_that("it converts MM-DD-YY to date (20th century)", { check_date('12-11-91', as.Date('1991/12/11')) })
test_that("it converts MM-DD-YY to date (21st century)", { check_date('10-01-14', as.Date('2014/10/01')) })
test_that("it converts YYYY [Short Written Month] DD to date", { check_date('1991 Dec 11', as.Date('1991/12/11')) })
test_that("it converts YYYY [Long Written Month] DD to date", { check_date('1991 December 11', as.Date('1991/12/11')) })
test_that("it converts [Short Written Month] DD YYYY to date", { check_date('Dec 11 1991', as.Date('1991/12/11')) })
test_that("it converts [Short Written Month] DD YY to date", { check_date('Dec 11 91', as.Date('1991/12/11')) })
test_that("it converts DD [Short Written Month] YYYY to date", { check_date('11 Dec 1991', as.Date('1991/12/11')) })
test_that("it converts DD [Short Written Month] YY to date", { check_date('11 Dec 91', as.Date('1991/12/11')) })
test_that("it handles punctuation", { check_date("December 11, '91", as.Date('1991/12/11')) })
test_that("it converts 1000 to date", { check_date(1000, as.Date('1972/09/27')) })
test_that("it converts 19911211 to the proper date", { check_date(19911211, as.Date('1991/12/11')) })
test_that("it converts 1991dec11 to the proper date", { check_date('1991dec11', as.Date('1991/12/11')) })
test_that("it converts 11dec1991 to the proper date", { check_date('11dec1991', as.Date('1991/12/11')) })
test_that("it converts dec111991 to the proper date", { check_date('dec111991', as.Date('1991/12/11')) })
test_that("it converts garbage to NA", { check_date('garbage', 'NA') })
test_that("it converts to numeric date", { check_date('1991-12-11', 8014, 'numeric') })
test_that("it converts to TRUE in is weekend mode if weekend", { check_date('2014-10-04', TRUE, 'weekend') })
test_that("it converts to FALSE in is weekend mode if not weekend", { check_date('2014-09-30', FALSE, 'weekend') })
test_that("it converts to TRUE in is holiday mode if holiday", { check_date('2012-11-22', TRUE, 'holiday') })
test_that("it converts to FALSE in is holiday mode if not holiday", { check_date('2012-11-21', FALSE, 'holiday') })
