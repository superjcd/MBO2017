#' @title  Return a dataframe with douban rating
#' @description return a dataframe with douban rating during a specific time
#' @param start a numeric number that you chose to use as start
#' @param end a numeric number that you chose to use as last
#' @details Because the douban Api limit the request rate,so in a time you can
#' only  request a part of data,so the largest year range you can use should be
#' less than 4,for intance when you choose 2008(default) as
#' your start year, then you must choose a end year less than 2011(default).
#' @return the dataframe containning both douban ranting and CBO data.
#' @examples
#' #good one
#' BO_with_rate()
#' BO_with_rate(start=2010,end=2013)
#'
#' #bad one
#' BO_with_rate(start=2010,end=2017)#exceeded the permitted range
BO_with_rate<-function(start=2008,end=2011){
  stopifnot(end-start <= 3)
  data<-BOF()
  data_with_year<-dplyr::mutate(data,Year=lubridate::year(lubridate::ymd(`上映日期`)))
  data_filter<-dplyr::filter(data_with_year,Year>=start & Year<=end)
  data2<-tidyr::separate(data_filter,`排名：影片名`,c("排名","影片名"),sep = '\\.')
  data3<-dplyr::mutate(data2,rating=purrr::map_dbl(data2$`影片名`,
                                                   purrr::possibly(query_rate,NA_real_)))
  data3
}
