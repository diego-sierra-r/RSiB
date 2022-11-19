#### filter_if_match tests ####

test_that("filter_if_match return correct number of rows", {
  expect_equal(nrow(filter_if_match(iris,"Species","ica")), 50)
})

test_that("output is a dataframe",{
  expect_s3_class(
    object = filter_if_match(iris, "Species", "ica"),
    class = "data.frame",
    exact = T
  )
})

test_that("exclude argument works", {
  expect_equal(object = nrow(filter_if_match(iris, "Species", "ica", exclude = T)),
               expected = 100)
})

test_that("when a regex match all rows filter_if_match shouldn't do anything",{
  expect_warning(filter_if_match(iris, "Species", "i|e", exclude = F),
                 regexp = "All .+")
})

test_that("if a regex match all rows and exclude = TRUE must retrun an empty data.drame",{
  expect_message(x <-filter_if_match(iris, "Species", "i|e", exclude = T),
                 regexp = "Your terms excluded all rows")
  expect_length(x[1],n = 1)
  expect_equal(nrow(x),expected = 0)
})



#### slicer ####

test_that("throws an error if the input is not an data.frame",{
  expect_error(slicer(as.matrix(iris),slice = 1,wide = 1))
})
test_that("introduce NAs if slice is aou of index",{
  expect_warning( x <-slicer(iris,4,50), regexp = "slice out of index.+")
  expect_equal(is.na(x[[1]][1]), TRUE)
})
