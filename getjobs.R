library(rvest)
library(stringr)
library(utf8)

baseUrl <- "https://www.indeed.fr/jobs?q=&l="
xpathresults <- '//*[@id="searchCount"]'
jobsNumber <- integer()

getJobs <- function(cities){
    for (city in 1:length(cities$cityLabel)){
        print(paste("beginning scrapping for",cities$cityLabel[city], city))
        searchParameter <- str_to_lower(cities$cityLabel[city])
        searchParameter <- str_replace_all(searchParameter," ","+")
        targetUrl <- paste0(baseUrl,searchParameter)
        
        #download.file(targetUrl, destfile = "scrapedpage.html", quiet=TRUE)
        #dom <- read_html("scrapedpage.html")
        
        #targetUrl <- utf8_encode(targetUrl)
        targetUrl <- iconv(targetUrl,"","ASCII//TRANSLIT","")
        dom <- read_html(targetUrl)
        rawNumber <- html_nodes(dom,xpath = xpathresults)
        print(rawNumber)
        rawNumber <- str_remove_all(rawNumber," ")
        print(rawNumber)
        rawNumber <- str_extract_all(rawNumber,"[0-9]{1,10}")
        print(rawNumber)
        rawNumber <- paste0(rawNumber[[1]][2],rawNumber[[1]][3])
        print(rawNumber)
        jobsNumber <- append(jobsNumber,as.integer(rawNumber))
        print(rawNumber)
        print(paste("jobs",cities$cityLabel[city],"done with",rawNumber,"jobs"))
    }
    jobsNumber
}