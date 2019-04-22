getCultureEvents <- function(url,cities){
    if(!file.exists("culture.csv")){
        download.file(url,"culture.csv")
    }
    rawEvents <- read.csv2("culture.csv")
    library(data.table)
    coordEvents <- data.table(paste(rawEvents$adresseVoieTypeVoieLieu, rawEvents$adresseVoieNomVoieLieu, rawEvents$adresseCodePostalLieu, rawEvents$adresseCommuneLieu))
    colnames(coordEvents) <- "adresses"
    
    library(tmap)
    geocode_OSM(coordEvents$adresses[1:6])
    
    for (city in 1:length(cities$cityLabel)){
        coordEvents <- cbind(coordEvents,cities$cityLabel[city])
        
        
        straightDistance()
    }

}



url <- "https://www.data.gouv.fr/s/resources/agenda-de-l-offre-culturelle/community/20150724-153623/Agenda24072015.csv"
