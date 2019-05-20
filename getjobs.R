library(rvest)
library(stringr)

baseUrl <- "https://www.indeed.fr/jobs?q=&l="
xpathresults <- '//*[@id="searchCount"]'
jobsNumber <- integer()

getJobs <- function(cities){
    for (city in 1:length(cities$cityLabel)){
        searchParameter <- str_to_lower(cities$cityLabel[city])
        targetUrl <- paste0(baseUrl,searchParameter)
        dom <- read_html(targetUrl)
        rawNumber <- html_nodes(dom,xpath = xpathresults)
        rawNumber <- str_remove_all(rawNumber," ")
        rawNumber <- str_extract_all(rawNumber,"[0-9]{1,10}")
        rawNumber <- paste0(rawNumber[[1]][2],rawNumber[[1]][3])
        jobsNumber <- append(jobsNumber,as.integer(rawNumber))
    }
}