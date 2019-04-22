---
title: "Quitter Paris, mais pour aller où ?"
author: "Paul Charlet"
output:
   html_document:
      self_contained: true
      keep_md: true
---



## Intro

Quelle est la meilleure ville pour s'installer en dehors de Paris ? Chacun a sa meilleure réponse, basée sur un certain nombre de critères comme la météo, l'emploi, l'éloignement, le coût de la vie, ...

Je propose dans cet essai d'aller récupérer ces données et de les visualiser.

## Quelles sont les plus grandes villes de France ?

Nous allons utiliser Wikidata pour récupérer les 20 plus grandes villes de France, puis nettoyer les coordonnées pour pouvoir les utiliser par la suite. On obtient le tableau ci-dessous (Paris est enregistrée séparément). Pour voir les fonctions utilisées, vous pouvez retrouver le fichier sur le repo.


```r
source("getCities.R")
cities <- getCities(2,21)
paris <- getCities(1,1)
kable(cities[1:6,-3],format="markdown")
```



|   |cityLabel  | population|       lon|      lat|
|:--|:----------|----------:|---------:|--------:|
|2  |Marseille  |     855393|  5.376389| 43.29667|
|3  |Lyon       |     506615|  4.841389| 45.75889|
|4  |Toulouse   |     471941|  1.443889| 43.60444|
|5  |Nice       |     342522|  7.268333| 43.70194|
|6  |Nantes     |     303382| -1.553889| 47.21722|
|7  |Strasbourg |     279284|  7.752222| 48.57333|

Soit, visuellement en utilisant le package leaflet.


```r
francemap <- leaflet() %>%
    addTiles() %>%
    addMarkers(lng = cities$lon, lat = cities$lat, popup = cities$cityLabel)
francemap
```

<!--html_preserve--><div id="htmlwidget-2f11539aacb8a909d85f" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-2f11539aacb8a909d85f">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[[43.296666666,45.758888888,43.604444444,43.701944444,47.217222222,48.573333333,43.610919444,44.837777777,50.631944444,48.114166666,49.265277777,49.494166666,45.433888888,43.125,45.186944444,47.323055555,47.472777777,43.836944444,48.891741666,45.766111111],[5.376388888,4.841388888,1.443888888,7.268333333,-1.553888888,7.752222222,3.877230555,-0.579444444,3.0575,-1.680833333,4.028611111,0.108055555,4.389722222,5.930555555,5.726388888,5.041944444,-0.555555555,4.36,2.240833333,4.879444444],null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["Marseille","Lyon","Toulouse","Nice","Nantes","Strasbourg","Montpellier","Bordeaux","Lille","Rennes","Reims","Le Havre","Saint-Étienne","Toulon","Grenoble","Dijon","Angers","Nîmes","La Défense","Villeurbanne"],null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[43.125,50.631944444],"lng":[-1.680833333,7.752222222]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

## Critère de distance

Nous allons commencer par calculer les distances entre chacune de ces villes et Paris. Nous commencerons par des distances à vol d'oiseau. Le contenu de la function `straightDistance()` est disponible dans le repo.


```r
source("straightDistance.R")
distanceToParis <- vector()
for (i in 1:length(cities[,1])){
    distanceToParis[i] <- straightDistance(cities$lon[i],cities$lat[i],paris$lon,paris$lat)
}
cities <- cbind(cities,distanceToParis)
kable(cities[1:6,c(1,6)], format = "markdown")
```



|   |cityLabel  | distanceToParis|
|:--|:----------|---------------:|
|2  |Marseille  |        660.6634|
|3  |Lyon       |        392.4328|
|4  |Toulouse   |        587.9788|
|5  |Nice       |        686.6020|
|6  |Nantes     |        343.5289|
|7  |Strasbourg |        398.5680|

## Critère d'activité culturelle

On trouve sur data.gouv.fr un agenda de l'offre culturelle par ville. Malheureusement, ces données datent de 2015 et il n'y a pas de jeu de données plus récent. Récupérons le nombre d'événements culturels.


```r
# "https://www.data.gouv.fr/s/resources/agenda-de-l-offre-culturelle/community/20150724-153623/Agenda24072015.csv"
```

Nous pouvons le mettre en rapport avec le nombre de musées par ville, cette statistique étant plus récente.


```r
# "https://www.data.gouv.fr/s/resources/liste-et-localisation-des-musees-de-france/20180605-165759/R_Coordonnees_musees_de_France_2018_data.xlsx"
```
