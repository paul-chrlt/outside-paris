library(geosphere)

straightDistance <- function(lonfrom,latfrom,lonto,latto) {
    distGeo(p1=c(lonfrom,latfrom),p2=c(lonto,latto))/1000
}