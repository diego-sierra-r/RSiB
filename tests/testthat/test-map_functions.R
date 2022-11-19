#### relevant_vars ####

test_that("relevant_vars function keeps just relevant vars",{
  expect_equal(object = ncol(relevant_vars(caiman_crocodilus)),
               expected = 10)
})

test_that("relevant_vars drop NAs with drop.na.coor argument",{
  expect_equal(object = nrow(relevant_vars(caiman_crocodilus,drop.coor.na = F)),
               expected = 4641)
  expect_equal(object = nrow(relevant_vars(caiman_crocodilus,drop.coor.na = T)),
               expected = 4599)
})

#### map_colombia ###


test_that("output  is tmap class", {
  expect_s3_class(object = map_colombia(caiman_crocodilus,column = "species"),
                  class = "tmap")
  expect_s3_class(object = map_depto(caiman_crocodilus,column = "species",depto = "La Guajira"),
                  class = "tmap")
  expect_s3_class(object = map_mun(caiman_crocodilus,column = "species",municipio =  "Barrancas"),
                  class = "tmap")
})
