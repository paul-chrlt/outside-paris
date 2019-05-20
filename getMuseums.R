library(xlsx)
library(data.table)
library(prettymapr)

getMuseums <- function (museumsLink,citiesLabel) {
    # récupérer le fichier
    if(!file.exists("museums.xlsx")){download.file(museumsLink,"museums.xlsx")}
    library(officer)
    museumsSource <- read.xlsx("museums.xlsx",1)
    
    # calculer les coordonnées lat lon
    coordMuseums <- data.table(paste(museumsSource$ADR,museumsSource$CP,museumsSource$VILLE))
    colnames(coordMuseums) <- "adresses"
    if(!file.exists("coordinatesmuseums.csv")){
        coordinates <- geocode(coordMuseums$adresses,source="dsk", cache="geocache")
        coordinates <- coordinates[,c(5,6)]
        write.csv(coordinates,"coordinatesmuseums.csv")
    }
    else{coordinates <- read.csv("coordinatesmuseums.csv")}
    
    # calculer les distances par rapport aux villes
    for (city in 1:length(cities$cityLabel)){
        cityname <- cities$cityLabel[city]
        coordinates$distance <- straightDistance(coordinates$lon,coordinates$lat,cities$lon[city],cities$lat[city])
        names(coordinates)[length(names(coordinates))] <- cityname
    }
    coordinates <- coordinates[!is.na(coordinates$lon),]
    museumsNumber <- 1:length(cities$cityLabel)
    names(museumsNumber) <- cities$cityLabel
    for(city in 3:length(cities[1,])){
        museumsNumber[city-2] <- sum(coordinates[,city]<10)
    }
    museumsNumber
}
