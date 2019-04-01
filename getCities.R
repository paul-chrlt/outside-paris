library(WikidataQueryServiceR)
library(stringi)

# This function will get the top 101 cities from France from wikidata, to get the top 100 + Paris itself. It will then be filtered using function parameters. It will also clean the gps coordinates

getCities <- function(from = 1, to = 21) {
    citiesQuery <- 'SELECT DISTINCT ?cityLabel ?population ?gps ?city WHERE {
      ?city (wdt:P31/(wdt:P279*)) wd:Q515;
        wdt:P1082 ?population;
        wdt:P625 ?gps.
      SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
      ?city wdt:P17 wd:Q142.
    }
    ORDER BY DESC (?population)
    LIMIT 101'
    
    cities <- query_wikidata(citiesQuery)
    
    coords <- stri_extract(cities$gps,regex = "[0-9|-].*",mode = "first")
    coords <- gsub('.$','',coords)
    coords <- stri_split(coords,regex = " ",simplify=TRUE)
    
    cities <- cbind(cities[,-3],coords)
    names(cities)[c(4,5)]<- c("lon","lat")
    cities[from:to,]
}
