library(rvest)

baseUrl <- "https://www.indeed.fr/"
xpathresults <- ""
jobsNumber <- integer()

for (city in 1:length(cities$cityLabel)){
    searchParameter <- cities$cityLabel[city]
    targetUrl <- paste0(baseUrl,searchParameter)
    dom <- read_html(targetUrl)
    jobsNumber <- append(jobsNumber,html_node(dom,xpath = xpathresults))
}
