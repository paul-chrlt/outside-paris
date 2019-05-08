getScore <- function(criteria, maxScore=100,minScore=0){
    low <- min(criteria)
    hi <- max(criteria)
    score <- (criteria/(hi-low))*maxScore
    score
}
