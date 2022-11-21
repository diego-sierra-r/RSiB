
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RSiBCOL

<!-- badges: start -->

[![R-CMD-check](https://github.com/diego-sierra-r/RSiB/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/diego-sierra-r/RSiB/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `RSiBCOL` is to create queries and get data from SiB
databases, This packages helps you to pull data from GIBF API like
*location*, *coordinates*, *sex*, *dates* and relevant information
related with taxonomy for any specie record in Colombia using R syntax.
Furthermore, `RSiBCOL` can create basic maps to represent records on a
geographic context and those maps can be customized easily using `tmap`
if you need specific changes.

## Installation

You can install the development version of RSiBCOL from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("diego-sierra-r/RSiB")
```

## Example

Imagine you need to get all *Caiman cocodrilus* records for a specific
year in Colombia. With `RSiBCOL` the first thing you have to do to
accomplish this task is go to [GBIF Backbone
Taxonomy](https://www.gbif.org/species/search) and find the GBIF taxon
ID. In this case is 8953936.

Then, it’s possible to use get_specie_records() function to find all
records for *Caiman cocodrilus* registered in 2020.

    #> ℹ Loading RSiBCOL

``` r
library("RSiBCOL")
```

``` r
get_specie_records(year = 2020, all.records = TRUE,specieKey = 8953936)
```

If you want just some records you can use limit and offset arguments.

``` r
get_specie_records(limit = 5,
                   offset = 1,
                   year = 2020, 
                   all.records = FALSE,
                   specieKey = 8953936)
#> Processing  1 of 1 pages
#>          key                           datasetKey
#> 1 2542951052 50c9509d-22c7-4a22-a47d-8c48425ef4a7
#> 2 2574008785 50c9509d-22c7-4a22-a47d-8c48425ef4a7
#> 3 2574010805 50c9509d-22c7-4a22-a47d-8c48425ef4a7
#> 4 2574019045 50c9509d-22c7-4a22-a47d-8c48425ef4a7
#> 5 2574019111 50c9509d-22c7-4a22-a47d-8c48425ef4a7
#>                       publishingOrgKey                      installationKey
#> 1 28eb1a3f-1c15-4a95-931a-4af90ecb574d 997448a8-f762-11e1-a439-00145eb45e9a
#> 2 28eb1a3f-1c15-4a95-931a-4af90ecb574d 997448a8-f762-11e1-a439-00145eb45e9a
#> 3 28eb1a3f-1c15-4a95-931a-4af90ecb574d 997448a8-f762-11e1-a439-00145eb45e9a
#> 4 28eb1a3f-1c15-4a95-931a-4af90ecb574d 997448a8-f762-11e1-a439-00145eb45e9a
#> 5 28eb1a3f-1c15-4a95-931a-4af90ecb574d 997448a8-f762-11e1-a439-00145eb45e9a
#>   publishingCountry    protocol                   lastCrawled
#> 1                US DWC_ARCHIVE 2022-11-17T12:13:40.744+00:00
#> 2                CO DWC_ARCHIVE 2022-11-17T12:13:40.744+00:00
#> 3                CO DWC_ARCHIVE 2022-11-17T12:13:40.744+00:00
#> 4                US DWC_ARCHIVE 2022-11-17T12:13:40.744+00:00
#> 5                US DWC_ARCHIVE 2022-11-17T12:13:40.744+00:00
#>                      lastParsed crawlId               hostingOrganizationKey
#> 1 2022-11-17T16:53:44.668+00:00     325 28eb1a3f-1c15-4a95-931a-4af90ecb574d
#> 2 2022-11-17T16:53:46.269+00:00     325 28eb1a3f-1c15-4a95-931a-4af90ecb574d
#> 3 2022-11-17T16:53:46.822+00:00     325 28eb1a3f-1c15-4a95-931a-4af90ecb574d
#> 4 2022-11-17T16:58:33.115+00:00     325 28eb1a3f-1c15-4a95-931a-4af90ecb574d
#> 5 2022-11-17T16:58:39.816+00:00     325 28eb1a3f-1c15-4a95-931a-4af90ecb574d
#>       basisOfRecord occurrenceStatus lifeStage taxonKey kingdomKey phylumKey
#> 1 HUMAN_OBSERVATION          PRESENT     Adult  8953936          1        44
#> 2 HUMAN_OBSERVATION          PRESENT      <NA>  8953936          1        44
#> 3 HUMAN_OBSERVATION          PRESENT      <NA>  8953936          1        44
#> 4 HUMAN_OBSERVATION          PRESENT      <NA>  8953936          1        44
#> 5 HUMAN_OBSERVATION          PRESENT      <NA>  8953936          1        44
#>   classKey orderKey familyKey genusKey speciesKey acceptedTaxonKey
#> 1      358      704   3238603  5220195    8953936          8953936
#> 2      358      704   3238603  5220195    8953936          8953936
#> 3      358      704   3238603  5220195    8953936          8953936
#> 4      358      704   3238603  5220195    8953936          8953936
#> 5      358      704   3238603  5220195    8953936          8953936
#>                       scientificName             acceptedScientificName
#> 1 Caiman crocodilus (Linnaeus, 1758) Caiman crocodilus (Linnaeus, 1758)
#> 2 Caiman crocodilus (Linnaeus, 1758) Caiman crocodilus (Linnaeus, 1758)
#> 3 Caiman crocodilus (Linnaeus, 1758) Caiman crocodilus (Linnaeus, 1758)
#> 4 Caiman crocodilus (Linnaeus, 1758) Caiman crocodilus (Linnaeus, 1758)
#> 5 Caiman crocodilus (Linnaeus, 1758) Caiman crocodilus (Linnaeus, 1758)
#>    kingdom   phylum      order        family  genus           species
#> 1 Animalia Chordata Crocodylia Alligatoridae Caiman Caiman crocodilus
#> 2 Animalia Chordata Crocodylia Alligatoridae Caiman Caiman crocodilus
#> 3 Animalia Chordata Crocodylia Alligatoridae Caiman Caiman crocodilus
#> 4 Animalia Chordata Crocodylia Alligatoridae Caiman Caiman crocodilus
#> 5 Animalia Chordata Crocodylia Alligatoridae Caiman Caiman crocodilus
#>   genericName specificEpithet taxonRank taxonomicStatus iucnRedListCategory
#> 1      Caiman      crocodilus   SPECIES        ACCEPTED                  LC
#> 2      Caiman      crocodilus   SPECIES        ACCEPTED                  LC
#> 3      Caiman      crocodilus   SPECIES        ACCEPTED                  LC
#> 4      Caiman      crocodilus   SPECIES        ACCEPTED                  LC
#> 5      Caiman      crocodilus   SPECIES        ACCEPTED                  LC
#>        dateIdentified decimalLongitude decimalLatitude
#> 1 2020-01-03T01:42:18        -72.14619        4.837115
#> 2 2020-02-11T15:54:21        -73.71368        6.823660
#> 3 2020-02-11T15:54:20        -73.71475        6.824646
#> 4 2020-02-05T01:34:01        -74.72884       10.961455
#> 5 2020-02-05T19:59:57        -74.72892       10.961477
#>   coordinateUncertaintyInMeters stateProvince year month day
#> 1                           418      Casanare 2020     1   1
#> 2                           187     Santander 2020     1  23
#> 3                            55     Santander 2020     1  28
#> 4                            NA     Atlántico 2020     1  26
#> 5                            NA     Atlántico 2020     1  26
#>             eventDate             issues                      modified
#> 1 2020-01-01T15:29:00 COORDINATE_ROUNDED 2020-12-01T07:57:00.000+00:00
#> 2 2020-01-23T11:26:00 COORDINATE_ROUNDED 2021-03-11T20:38:02.000+00:00
#> 3 2020-01-28T10:10:00 COORDINATE_ROUNDED 2021-03-11T20:38:07.000+00:00
#> 4 2020-01-26T10:26:00 COORDINATE_ROUNDED 2021-03-11T20:38:26.000+00:00
#> 5 2020-01-26T07:26:00 COORDINATE_ROUNDED 2021-03-11T20:38:17.000+00:00
#>                 lastInterpreted
#> 1 2022-11-17T16:53:44.668+00:00
#> 2 2022-11-17T16:53:46.269+00:00
#> 3 2022-11-17T16:53:46.822+00:00
#> 4 2022-11-17T16:58:33.115+00:00
#> 5 2022-11-17T16:58:39.816+00:00
#>                                          references
#> 1 https://www.inaturalist.org/observations/37212491
#> 2 https://www.inaturalist.org/observations/38539059
#> 3 https://www.inaturalist.org/observations/38539058
#> 4 https://www.inaturalist.org/observations/38313664
#> 5 https://www.inaturalist.org/observations/38337091
#>                                                   license identifiers
#> 1    http://creativecommons.org/licenses/by/4.0/legalcode        NULL
#> 2 http://creativecommons.org/licenses/by-nc/4.0/legalcode        NULL
#> 3 http://creativecommons.org/licenses/by-nc/4.0/legalcode        NULL
#> 4 http://creativecommons.org/licenses/by-nc/4.0/legalcode        NULL
#> 5 http://creativecommons.org/licenses/by-nc/4.0/legalcode        NULL
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  media
#> 1                                                                                                                                                                                                                                                                           StillImage, image/jpeg, https://www.inaturalist.org/photos/58953918, 2020-01-01T23:29:06.000+00:00, Andrés Nicolás Ramírez, iNaturalist, http://creativecommons.org/licenses/by/4.0/, Andrés Nicolás Ramírez, https://inaturalist-open-data.s3.amazonaws.com/photos/58953918/original.jpeg
#> 2                                                                                                                                                                                                                                                                                                         StillImage, image/jpeg, https://www.inaturalist.org/photos/61262774, 2020-01-23T16:26:00.000+00:00, SGA VC, iNaturalist, http://creativecommons.org/licenses/by-nc/4.0/, SGA VC, https://inaturalist-open-data.s3.amazonaws.com/photos/61262774/original.jpg
#> 3                                                                                                                                                                                                                                                                                                         StillImage, image/jpeg, https://www.inaturalist.org/photos/61262771, 2020-01-28T15:10:00.000+00:00, SGA VC, iNaturalist, http://creativecommons.org/licenses/by-nc/4.0/, SGA VC, https://inaturalist-open-data.s3.amazonaws.com/photos/61262771/original.jpg
#> 4                                                                                                                                                                                                                                                                                            StillImage, image/jpeg, https://www.inaturalist.org/photos/60875148, 2020-01-26T18:26:38.000+00:00, guyincognito, iNaturalist, http://creativecommons.org/licenses/by-nc/4.0/, guyincognito, https://inaturalist-open-data.s3.amazonaws.com/photos/60875148/original.jpeg
#> 5 StillImage, StillImage, image/jpeg, image/jpeg, https://www.inaturalist.org/photos/60914102, https://www.inaturalist.org/photos/60914059, 2020-01-26T15:26:35.000+00:00, 2020-01-26T15:22:32.000+00:00, Michael Woodruff, Michael Woodruff, iNaturalist, iNaturalist, http://creativecommons.org/licenses/by-nc/4.0/, http://creativecommons.org/licenses/by-nc/4.0/, Michael Woodruff, Michael Woodruff, https://inaturalist-open-data.s3.amazonaws.com/photos/60914102/original.jpeg, https://inaturalist-open-data.s3.amazonaws.com/photos/60914059/original.jpeg
#>   facts relations isInCluster                             datasetName
#> 1  NULL      NULL       FALSE iNaturalist research-grade observations
#> 2  NULL      NULL       FALSE iNaturalist research-grade observations
#> 3  NULL      NULL       FALSE iNaturalist research-grade observations
#> 4  NULL      NULL       FALSE iNaturalist research-grade observations
#> 5  NULL      NULL       FALSE iNaturalist research-grade observations
#>               recordedBy           identifiedBy geodeticDatum    class
#> 1 Andrés Nicolás Ramírez Andrés Nicolás Ramírez         WGS84 Reptilia
#> 2                 SGA VC                 SGA VC         WGS84 Reptilia
#> 3                 SGA VC                 SGA VC         WGS84 Reptilia
#> 4           guyincognito           guyincognito         WGS84 Reptilia
#> 5       Michael Woodruff       Michael Woodruff         WGS84 Reptilia
#>   countryCode recordedByIDs identifiedByIDs  country           rightsHolder
#> 1          CO          NULL            NULL Colombia Andrés Nicolás Ramírez
#> 2          CO          NULL            NULL Colombia                 SGA VC
#> 3          CO          NULL            NULL Colombia                 SGA VC
#> 4          CO          NULL            NULL Colombia           guyincognito
#> 5          CO          NULL            NULL Colombia       Michael Woodruff
#>   identifier http://unknown.org/nick         verbatimEventDate collectionCode
#> 1   37212491                nicolasr  2020/01/01 3:29 PM -0500   Observations
#> 2   38539059              sga_palmas 2020/01/23 11:26 AM -0500   Observations
#> 3   38539058              sga_palmas 2020/01/28 10:10 AM -0500   Observations
#> 4   38313664            guyincognito   2020/01/26 10:26 AM PST   Observations
#> 5   38337091              nightjar09    2020/01/26 7:26 AM PST   Observations
#>       gbifID                                    verbatimLocality
#> 1 2542951052                            Maní, Casanare, Colombia
#> 2 2574008785         San Vicente de Chucurí, Santander, Colombia
#> 3 2574010805 Yarima, San Vicente de Chucurí, Santander, Colombia
#> 4 2574019045                   Barranquilla, Atlántico, Colombia
#> 5 2574019111                     Sitionuevo, Magdalena, Colombia
#>                                        occurrenceID taxonID catalogNumber
#> 1 https://www.inaturalist.org/observations/37212491  116517      37212491
#> 2 https://www.inaturalist.org/observations/38539059  116517      38539059
#> 3 https://www.inaturalist.org/observations/38539058  116517      38539058
#> 4 https://www.inaturalist.org/observations/38313664  116517      38313664
#> 5 https://www.inaturalist.org/observations/38337091  116517      38337091
#>   institutionCode      eventTime http://unknown.org/captive identificationID
#> 1     iNaturalist 15:29:00-05:00                       wild         82389441
#> 2     iNaturalist 11:26:00-05:00                       wild         86660042
#> 3     iNaturalist 10:10:00-05:00                       wild         86660040
#> 4     iNaturalist 10:26:00-08:00                       wild         85967324
#> 5     iNaturalist 07:26:00-08:00                       wild         86036484
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 extensions.http://rs.gbif.org/terms/1.0/Multimedia
#> 1                                                                                                                                                                                                                                                                                 http://creativecommons.org/licenses/by/4.0/, https://www.inaturalist.org/photos/58953918, Andrés Nicolás Ramírez, 58953918, 2020-01-01T15:29:06-08:00, iNaturalist, StillImage, Andrés Nicolás Ramírez, https://inaturalist-open-data.s3.amazonaws.com/photos/58953918/original.jpeg, image/jpeg
#> 2                                                                                                                                                                                                                                                                                                                    http://creativecommons.org/licenses/by-nc/4.0/, https://www.inaturalist.org/photos/61262774, SGA VC, 61262774, 2020-01-23T16:26:00Z, iNaturalist, StillImage, SGA VC, https://inaturalist-open-data.s3.amazonaws.com/photos/61262774/original.jpg, image/jpeg
#> 3                                                                                                                                                                                                                                                                                                                    http://creativecommons.org/licenses/by-nc/4.0/, https://www.inaturalist.org/photos/61262771, SGA VC, 61262771, 2020-01-28T15:10:00Z, iNaturalist, StillImage, SGA VC, https://inaturalist-open-data.s3.amazonaws.com/photos/61262771/original.jpg, image/jpeg
#> 4                                                                                                                                                                                                                                                                                                  http://creativecommons.org/licenses/by-nc/4.0/, https://www.inaturalist.org/photos/60875148, guyincognito, 60875148, 2020-01-26T10:26:38-08:00, iNaturalist, StillImage, guyincognito, https://inaturalist-open-data.s3.amazonaws.com/photos/60875148/original.jpeg, image/jpeg
#> 5 http://creativecommons.org/licenses/by-nc/4.0/, http://creativecommons.org/licenses/by-nc/4.0/, https://www.inaturalist.org/photos/60914102, https://www.inaturalist.org/photos/60914059, Michael Woodruff, Michael Woodruff, 60914102, 60914059, 2020-01-26T07:26:35-08:00, 2020-01-26T07:22:32-08:00, iNaturalist, iNaturalist, StillImage, StillImage, Michael Woodruff, Michael Woodruff, https://inaturalist-open-data.s3.amazonaws.com/photos/60914102/original.jpeg, https://inaturalist-open-data.s3.amazonaws.com/photos/60914059/original.jpeg, image/jpeg, image/jpeg
#>   gadm.level0.gid gadm.level0.name gadm.level1.gid gadm.level1.name
#> 1             COL         Colombia        COL.10_2         Casanare
#> 2             COL         Colombia        COL.28_2        Santander
#> 3             COL         Colombia        COL.28_2        Santander
#> 4             COL         Colombia        COL.20_2        Magdalena
#> 5             COL         Colombia        COL.20_2        Magdalena
#>   gadm.level2.gid       gadm.level2.name
#> 1      COL.10.5_2                   Maní
#> 2     COL.28.74_2 San Vicente de Chucurí
#> 3     COL.28.74_2 San Vicente de Chucurí
#> 4     COL.20.27_2             Sitionuevo
#> 5     COL.20.27_2             Sitionuevo
# when all.records = TRUE its overides limit and offset arguments
```

This function returns a data.frame with more than 100 columns that you
can use for your own purposes, but if you just need you some basic
taxonomic information, coordinates and dates relevant_vars() keep just
10 columns.

``` r
colnames(relevant_vars(caiman_crocodilus))
#>  [1] "speciesKey"       "scientificName"   "family"           "dateIdentified"  
#>  [5] "decimalLongitude" "decimalLatitude"  "stateProvince"    "year"            
#>  [9] "month"            "day"
```

Other handy functions to clean data generated by get_specie_records()
are slicer() and filter_if_match().

``` r
slicer(caiman_crocodilus,1,10)

filter_if_match(caiman_crocodilus,
                column = "scientificName",
                terms = "fuscus")
```

Finally, `RSiBCOL` can generate some basic plots to represent records
over a map. This objects can be customized an enhanced using `tmap`
packaged according to specific needs.

``` r
# whole map
map_colombia(caiman_crocodilus,column = "scientificName")
```

<img src="man/figures/README-unnamed-chunk-7-1.svg" width="100%" />

``` r
# Department map
map_depto(df = caiman_crocodilus,
          depto = "La Guajira",
          legend.show = F,
          column = "species")
```

<img src="man/figures/README-unnamed-chunk-8-1.svg" width="100%" />

``` r
map_mun(caiman_crocodilus,
        mun = "Barrancas",
        column = "species",
        legend.show = FALSE)
```

<img src="man/figures/README-unnamed-chunk-9-1.svg" width="100%" />
