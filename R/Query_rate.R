#' @title Query movie rating by using Douban API
#'
#'
#' @description Query movie rating by using \href{https://developers.douban.com/wiki/?title=movie_v2#simple-subject}{Douban API}
#' @param film_name the name of film to query
#' @return a average douban rating of the film
#'
#' @examples
#' query_rate("战狼2")

query_rate<-function(film_name){
  request_url<-paste0("https://api.douban.com/v2/movie/search?q=",film_name)
  R<-httr::content(httr::GET(request_url))
  rate<-R$subjects[[1]]$rating$average
  rate
}
