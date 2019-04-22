getCultureEvents <- function(url,cities){
    if(!file.exists("culture.csv")){
        download.file(url,"culture.csv")
    }
    rawEvents <- read.csv2("culture.csv")
    library(data.table)
    coordEvents <- data.table(paste(rawEvents$adresseVoieTypeVoieLieu, rawEvents$adresseVoieNomVoieLieu, rawEvents$adresseCodePostalLieu, rawEvents$adresseCommuneLieu))
    colnames(coordEvents) <- "adresses"
    
#    library(tmaptools)
    if(!file.exists("coordinates.csv")){
        library(prettymapr)
        coordinates <- geocode(coordEvents$adresses,source="dsk", cache="geocache")
        coordinates <- coordinates[,c(5,6)]
        write.csv(coordEvents,"coordinates.csv")
    }
    else{coordEvents <- read.csv("coordinates.csv")}
    
    for (city in 1:length(cities$cityLabel)){
        cityname <- cities$cityLabel[city]
        coordinates$distance <- straightDistance(coordinates$lon,coordinates$lat,cities$lon[city],cities$lat[city])
        names(coordinates)[length(names(coordinates))] <- cityname
    }
    coordinates <- coordinates[!is.na(coordinates$lon),]
    eventsNumber <- 1:length(cities$cityLabel)
    names(eventsNumber) <- cities$cityLabel
    for(city in 3:length(cities[1,])){
        eventsNumber[city-2] <- sum(coordinates[,city]<10)
    }
    eventsNumber
}

coordinates %>% group

url <- "https://www.data.gouv.fr/s/resources/agenda-de-l-offre-culturelle/community/20150724-153623/Agenda24072015.csv"
