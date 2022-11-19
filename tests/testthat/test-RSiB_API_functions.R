test_that("output is a dataframe", {
  expect_s3_class(
    object = get_specie_records(limit = 1, offset = 1, year = 2020,
      all.records = F, specieKey = 8953936),
    class = "data.frame",
    exact = T
  )
})

test_that("limit argument works properly", {
  expect_equal(nrow(
    get_specie_records(limit = 1, offset = 1, year = 2020,
                       all.records = F, specieKey = 8953936)), 1)
  expect_equal(nrow(
    get_specie_records(limit = 2, offset = 1, year = 2020,
                       all.records = F, specieKey = 8953936)), 2)

})

test_that("year argument works properly",{
  x <- get_specie_records(limit = 1, offset = 1, year = 2020,
                          all.records = F, specieKey = 8953936)
  expect_equal(x[["year"]][1], 2020)
})


test_that("specieKey argument works properly",{
  x <- get_specie_records(limit = 1, offset = 1, year = 2020,
                          all.records = F, specieKey = 8953936)
  expect_equal(x[["speciesKey"]][1], 8953936)
})
