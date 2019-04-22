library(geosphere)

straightDistance <- function(lonfrom,latfrom,lonto,latto) {
    distGeo(p1=cbind(lonfrom,latfrom),p2=cbind(lonto,latto))/1000
}